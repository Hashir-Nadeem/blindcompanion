import 'package:flutter/material.dart';
import 'dart:async';

class MyOTP extends StatefulWidget {
  @override
  _MyOTPState createState() => _MyOTPState();
}

class _MyOTPState extends State<MyOTP> {
  Timer? _timer;
  int _secondsRemaining = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          timer.cancel();
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final screenSquare = screenHeight * screenWidth;

    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            SizedBox(
              height: screenHeight * 0.075,
              width: screenWidth * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.075,
              width: screenWidth * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.075,
              width: screenWidth * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            SizedBox(
              height: screenHeight * 0.075,
              width: screenWidth * 0.1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        SizedBox(
          height: screenHeight * 0.05,
          width: screenWidth * 0.3,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'Resend',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Text(
          formatDuration(Duration(seconds: _secondsRemaining)),
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }
}
