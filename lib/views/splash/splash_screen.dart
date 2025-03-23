import 'package:flutter/material.dart';
import 'package:voice_record/viewmodel/splash_view_model.dart';
import 'package:voice_record/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SplashViewModel();
    viewModel.initialize(this, context);
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              SlideTransition(
                position: viewModel.slideAnimation,
                child: FadeTransition(
                  opacity: viewModel.opacityAnimation,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      children: const [
                        Text(
                          'A A V A A Z',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Bringing the Patient\'s Voice to Life',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
