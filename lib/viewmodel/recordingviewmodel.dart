import 'dart:io';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordingViewModel {
  FlutterSoundRecorder? _recorder;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _recordedFilePath;

  bool get isRecording => _isRecording;
  String? get recordedFilePath => _recordedFilePath;

  RecordingViewModel() {
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
    await Permission.microphone.request();
  }

  Future<void> startRecording() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String filePath = '${tempDir.path}/recording.aac';
    await _recorder!.startRecorder(toFile: filePath);

    _isRecording = true;
    _recordedFilePath = filePath;
  }

  Future<void> stopRecording() async {
    await _recorder!.stopRecorder();
    _isRecording = false;

    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
    }
  }

  void dispose() {
    _recorder?.closeRecorder();
    _audioPlayer.dispose();
  }
}