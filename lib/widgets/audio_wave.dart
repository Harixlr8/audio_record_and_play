import 'package:flutter/material.dart';

class AudioWaveform extends StatelessWidget {
  const AudioWaveform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: SizedBox(

          height: 20,
          width: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 30, // Number of bars
            itemBuilder: (context, index) {

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 6,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade300,
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
