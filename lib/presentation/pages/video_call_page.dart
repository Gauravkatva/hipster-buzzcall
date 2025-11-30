import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Video call screen with Agora SDK integration
class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  RtcEngine? _engine;
  int? _remoteUid;
  bool _isJoined = false;
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isScreenSharing = false;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    // Request permissions
    await [Permission.camera, Permission.microphone].request();

    // Create Agora engine
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(
      RtcEngineContext(
        appId: AppConstants.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // Register event handlers
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              setState(() {
                _remoteUid = null;
              });
            },
      ),
    );

    await _engine!.enableVideo();
    await _engine!.startPreview();
  }

  Future<void> _joinChannel() async {
    if (_engine == null) return;

    final options = ChannelMediaOptions(
      channelProfile: ChannelProfileType.channelProfileCommunication,
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      publishCameraTrack: true,
      publishMicrophoneTrack: true,
    );

    await _engine!.joinChannel(
      token: AppConstants.agoraToken ?? '',
      channelId: AppConstants.agoraChannelName,
      uid: 0,
      options: options,
    );

    setState(() {
      _isJoined = true;
    });
  }

  Future<void> _leaveChannel() async {
    await _engine?.leaveChannel();
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
        actions: [
          if (_isJoined)
            IconButton(
              icon: const Icon(Icons.call_end, color: Colors.red),
              onPressed: _leaveChannel,
              tooltip: 'End Call',
            ),
        ],
      ),
      body: Stack(
        children: [
          // Main video view
          Center(
            child: _remoteUid != null
                ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine!,
                      canvas: VideoCanvas(uid: _remoteUid),
                      connection: RtcConnection(
                        channelId: AppConstants.agoraChannelName,
                      ),
                    ),
                  )
                : _buildWaitingView(),
          ),

          // Local preview (Picture-in-Picture)
          if (_isJoined)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.buzzYellow, width: 2),
                  color: _isVideoOff ? AppTheme.buzzBlack : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _isVideoOff
                      ? Center(
                          child: Icon(
                            Icons.videocam_off,
                            color: AppTheme.buzzWhite.withOpacity(0.5),
                            size: 40,
                          ),
                        )
                      : AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine!,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        ),
                ),
              ),
            ),

          // Controls at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingView() {
    return Container(
      color: AppTheme.buzzBlack,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videocam_off,
              size: 80,
              color: AppTheme.buzzWhite.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              _isJoined
                  ? 'Waiting for others to join...'
                  : 'Ready to start call',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppTheme.buzzWhite),
            ),
            const SizedBox(height: 32),
            if (!_isJoined)
              FilledButton.icon(
                onPressed: _joinChannel,
                icon: const Icon(Icons.video_call),
                label: const Text('Join Call'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Mute/Unmute
          _buildControlButton(
            icon: _isMuted ? Icons.mic_off : Icons.mic,
            label: _isMuted ? 'Unmute' : 'Mute',
            onPressed: () async {
              if (_engine != null) {
                // Use enableLocalAudio for proper muting
                await _engine!.enableLocalAudio(_isMuted);
                setState(() {
                  _isMuted = !_isMuted;
                });
              }
            },
            color: _isMuted ? Colors.red : AppTheme.buzzYellow,
          ),

          // Video On/Off
          _buildControlButton(
            icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
            label: _isVideoOff ? 'Video On' : 'Video Off',
            onPressed: () async {
              if (_engine != null) {
                if (_isVideoOff) {
                  // Turn video back on
                  await _engine!.enableLocalVideo(true);
                  await _engine!.startPreview();
                } else {
                  // Turn video off
                  await _engine!.enableLocalVideo(false);
                  await _engine!.stopPreview();
                }
                setState(() {
                  _isVideoOff = !_isVideoOff;
                });
              }
            },
            color: _isVideoOff ? Colors.red : AppTheme.buzzYellow,
          ),

          // Switch Camera
          _buildControlButton(
            icon: Icons.flip_camera_ios,
            label: 'Switch',
            onPressed: () async {
              await _engine?.switchCamera();
            },
            color: AppTheme.buzzYellow,
          ),

          // Screen Share
          _buildControlButton(
            icon: _isScreenSharing ? Icons.stop_screen_share : Icons.screen_share,
            label: _isScreenSharing ? 'Stop' : 'Share',
            onPressed: () async {
              if (_engine != null) {
                if (_isScreenSharing) {
                  // Stop screen sharing
                  await _engine!.stopScreenCapture();
                  await _engine!.startPreview();
                  setState(() {
                    _isScreenSharing = false;
                  });
                } else {
                  // Start screen sharing
                  await _engine!.stopPreview();
                  await _engine!.startScreenCapture(
                    const ScreenCaptureParameters2(
                      captureVideo: true,
                      captureAudio: true,
                    ),
                  );
                  setState(() {
                    _isScreenSharing = true;
                  });
                }
              }
            },
            color: _isScreenSharing ? Colors.green : AppTheme.buzzYellow,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: AppTheme.buzzBlack),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppTheme.buzzWhite),
        ),
      ],
    );
  }
}
