import 'package:equatable/equatable.dart';

abstract class VideoCallState extends Equatable {
  const VideoCallState();

  @override
  List<Object?> get props => [];
}

class VideoCallInitial extends VideoCallState {
  const VideoCallInitial();
}

class VideoCallLoading extends VideoCallState {
  const VideoCallLoading();
}

class VideoCallJoined extends VideoCallState {
  final bool isAudioMuted;
  final bool isVideoDisabled;
  final bool isScreenSharing;
  final List<int> remoteUids;

  const VideoCallJoined({
    this.isAudioMuted = false,
    this.isVideoDisabled = false,
    this.isScreenSharing = false,
    this.remoteUids = const [],
  });

  VideoCallJoined copyWith({
    bool? isAudioMuted,
    bool? isVideoDisabled,
    bool? isScreenSharing,
    List<int>? remoteUids,
  }) {
    return VideoCallJoined(
      isAudioMuted: isAudioMuted ?? this.isAudioMuted,
      isVideoDisabled: isVideoDisabled ?? this.isVideoDisabled,
      isScreenSharing: isScreenSharing ?? this.isScreenSharing,
      remoteUids: remoteUids ?? this.remoteUids,
    );
  }

  @override
  List<Object?> get props => [
    isAudioMuted,
    isVideoDisabled,
    isScreenSharing,
    remoteUids,
  ];
}

class VideoCallError extends VideoCallState {
  final String message;

  const VideoCallError({required this.message});

  @override
  List<Object?> get props => [message];
}

class VideoCallEnded extends VideoCallState {
  const VideoCallEnded();
}
