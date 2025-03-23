import 'package:flutter/material.dart';
import 'package:voice_record/viewmodel/recordingviewmodel.dart';
import 'package:voice_record/widgets/audio_wave.dart';
import 'package:voice_record/widgets/background_widget.dart';
import 'package:voice_record/widgets/wave_effect_widget.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen>
    with SingleTickerProviderStateMixin {
  late RecordingViewModel _viewModel;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _glowAnimation;
  bool _isFirstRecordingComplete = false;

  @override
  void initState() {
    super.initState();
    _viewModel = RecordingViewModel();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    await _viewModel.startRecording();
    _controller.repeat(reverse: true);
    setState(() {});
  }

  Future<void> _stopRecording() async {
    await _viewModel.stopRecording();
    _controller.stop();
    setState(() {
      _isFirstRecordingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/Logo.png"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/men.png"),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            SizedBox(
              width: 350,
              height: 170 ,
              child: !_isFirstRecordingComplete
                  ? GestureDetector(
                      onTap: _viewModel.isRecording ? _stopRecording : _startRecording,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_viewModel.isRecording)
                            WaveEffect(
                              animation: _animation,
                              color: Colors.lightBlueAccent,
                            ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: _viewModel.isRecording
                                  ? [
                                      BoxShadow(
                                        color: Colors.blueAccent.withOpacity(
                                          _glowAnimation.value,
                                        ),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: CircleAvatar(
                              backgroundColor: const Color.fromARGB(255, 24, 36, 45),
                              radius: 60,
                              child: Icon(Icons.mic, size: 80, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Hello my name is Jhon, this is the dummy transcript that will appear after the recording is complete.\nThe transcription of the recorded audio should play when the mic turns off",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            if (!_isFirstRecordingComplete)
              Text("Tap to record", style: TextStyle(color: Colors.blue)) else  Text("Playing recording", style: TextStyle(color: Colors.blue)),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 15, 23, 52),
                    Color.fromARGB(255, 9, 6, 23),
                  ],
                  tileMode: TileMode.repeated,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              child: !_isFirstRecordingComplete
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "English",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.compare_arrows, color: Colors.white),
                        Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "German ▼",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : AudioWaveform(),
            ),
          ],
        ),
      ),
    );
  }
}
