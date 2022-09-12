import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timer_simple/widgets/button_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 98, 99),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Timer'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimer(),
          const SizedBox(
            height: 80,
          ),
          buildButtons(),
        ],
      )),
    );
  }

  Widget buildTimer() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              strokeWidth: 15,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.greenAccent,
            ),
            Center(
              child: buildTime(),
            ),
          ],
        ),
      );

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(
        Icons.done,
        color: Colors.greenAccent,
        size: 100,
      );
    } else {
      return Text(
        '$seconds',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isComplated = seconds == maxSeconds || seconds == 0;
    return isRunning || !isComplated
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'Resume' : 'Pause',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ButtonWidget(
                text: 'Cancel',
                onClicked: () {
                  stopTimer(reset: true);
                },
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            textColor: Colors.black,
            backgroundColor: Colors.white70,
            onClicked: () {
              startTimer();
            },
          );
  }
}
