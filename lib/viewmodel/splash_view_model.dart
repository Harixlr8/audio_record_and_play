import 'package:flutter/material.dart';
import 'dart:async';
import 'package:voice_record/views/home/login_screen.dart';

class SplashViewModel extends ChangeNotifier {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  AnimationController get controller => _controller;
  Animation<Offset> get slideAnimation => _slideAnimation;
  Animation<double> get opacityAnimation => _opacityAnimation;

  void initialize(TickerProvider ticker, BuildContext context) {
    _controller = AnimationController(
      vsync: ticker,
      duration: const Duration(seconds: 3),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 5.5),
      end: const Offset(0.0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });

    notifyListeners();
  }

  void disposeViewModel() {
    _controller.dispose();
  }
}
