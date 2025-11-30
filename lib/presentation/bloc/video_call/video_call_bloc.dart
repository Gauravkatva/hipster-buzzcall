import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/start_video_call.dart';
import 'video_call_event.dart';
import 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  final StartVideoCall startVideoCall;

  VideoCallBloc({required this.startVideoCall})
    : super(const VideoCallInitial()) {
    on<JoinCallEvent>(_onJoinCall);
    on<LeaveCallEvent>(_onLeaveCall);
    on<ToggleAudioEvent>(_onToggleAudio);
    on<ToggleVideoEvent>(_onToggleVideo);
    on<SwitchCameraEvent>(_onSwitchCamera);
    on<StartScreenShareEvent>(_onStartScreenShare);
    on<StopScreenShareEvent>(_onStopScreenShare);
    on<UserJoinedEvent>(_onUserJoined);
    on<UserLeftEvent>(_onUserLeft);
  }

  Future<void> _onJoinCall(
    JoinCallEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    emit(const VideoCallLoading());

    final result = await startVideoCall(
      VideoCallParams(
        appId: event.appId,
        channelName: event.channelName,
        token: event.token,
        uid: event.uid,
      ),
    );

    result.fold(
      (failure) => emit(VideoCallError(message: failure.message)),
      (_) => emit(const VideoCallJoined()),
    );
  }

  Future<void> _onLeaveCall(
    LeaveCallEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    emit(const VideoCallEnded());
  }

  Future<void> _onToggleAudio(
    ToggleAudioEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      emit(currentState.copyWith(isAudioMuted: !currentState.isAudioMuted));
    }
  }

  Future<void> _onToggleVideo(
    ToggleVideoEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      emit(
        currentState.copyWith(isVideoDisabled: !currentState.isVideoDisabled),
      );
    }
  }

  Future<void> _onSwitchCamera(
    SwitchCameraEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    // Camera switching handled by repository
  }

  Future<void> _onStartScreenShare(
    StartScreenShareEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      emit(currentState.copyWith(isScreenSharing: true));
    }
  }

  Future<void> _onStopScreenShare(
    StopScreenShareEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      emit(currentState.copyWith(isScreenSharing: false));
    }
  }

  Future<void> _onUserJoined(
    UserJoinedEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      final updatedUids = List<int>.from(currentState.remoteUids)
        ..add(event.uid);
      emit(currentState.copyWith(remoteUids: updatedUids));
    }
  }

  Future<void> _onUserLeft(
    UserLeftEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    if (state is VideoCallJoined) {
      final currentState = state as VideoCallJoined;
      final updatedUids = List<int>.from(currentState.remoteUids)
        ..remove(event.uid);
      emit(currentState.copyWith(remoteUids: updatedUids));
    }
  }
}
