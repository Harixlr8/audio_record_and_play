import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 11, 10, 33),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft, 
                  radius: 0.8,
                  colors: [
                    Color(0xFF1A1D2A), 
                    Colors.transparent, 
                  ],
                  stops: [0.1, 1.0], 
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight, 
                  radius: 0.8,
                  colors: [
                    Color(0xFF1A1D2A), 
                    Colors.transparent, 
                  ],
                  stops: [0.1, 1.0], 
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center, 
                  radius: 1,
                  colors: [
                    Color(0xFF1A1D2A), 
                    Colors.transparent, 
                  ],
                  stops: [0, 2], 
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomLeft,
                  radius: 1,
                  colors: [
                    Color(0xFF1A1D2A), 
                    Colors.transparent, 
                  ],
                  stops: [0.05, 1], 
                ),
              ),
            ),
            child
          ],
        ),
      );
  }
}