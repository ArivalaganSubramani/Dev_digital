import 'dart:async';

import 'package:dev_digital/app/modules/CountDownTimer/models/timerModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountDownTimerController extends GetxController {

  var timerList = List<TimerModel>.empty(growable: true).obs;
  final List<TextEditingController> secondsController = [];

  @override
  void onInit() {
    super.onInit();
    timerList.clear();
    secondsController.clear();
  }

  @override
  void dispose() {
    for (var controller in secondsController) {
      controller.dispose();
    }
    super.dispose();
  }

  void startTimer(int index) {
    if(secondsController[index].text.isEmpty){
      Get.dialog(
        AlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(fontSize: 17),
          ),
          contentPadding: const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 0),
          content:
              Text(
                  "Please Enter Seconds to start the Timer at ${index + 1} position",
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
          contentTextStyle:
          const TextStyle(fontWeight: FontWeight.w500),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if(timerList[index].status?.value == "pause"){
      pauseTimer(index);
    } else{
      //Start Timer
      startItemTimer(index);
    }
  }


  void addTimer() {
    TimerModel newTimer = TimerModel();
    newTimer.id = timerList.length.toString();
    newTimer.status = "start".obs;
    newTimer.countDownSecondsInString = "00:00:00".obs;
    newTimer.countDownSeconds = 0.obs;
    newTimer.initialSeconds = 0.obs;
    secondsController.add(TextEditingController());
    timerList.add(newTimer);
  }

  void startItemTimer(int index) {
    debugPrint("starting timer");
    String formattedTime;
    TimerModel timerModel = timerList[index];
    if(timerModel.status!.value == "start") {
      formattedTime = formatSeconds(int.parse(secondsController[index].text));
      timerModel.countDownSeconds!(int.parse(secondsController[index].text));
    }else{
      formattedTime = formatSeconds(timerModel.countDownSeconds!.value);
    }
    timerModel.countDownSecondsInString!(formattedTime);
    timerModel.status!("pause");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      debugPrint("count down timer");
      debugPrint("timer value ${timerModel.countDownSeconds}");
      debugPrint("timer value ${timerModel.status}");
      debugPrint("timer value ${timerModel.countDownSecondsInString}");
      if (timerModel.countDownSeconds!.value > 0 && timerModel.status!.value == "pause") {
        timerModel.countDownSeconds?.value--;
        timerModel.countDownSecondsInString!(formatSeconds(timerModel.countDownSeconds!.value));
      } else if(timerModel.status!.value == "resume"){
        timer.cancel();
      } else {
        debugPrint("completed timer");
        timer.cancel();
        timerModel.status!("start");
      }
    });
  }

  String formatSeconds(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  void pauseTimer(int index) {
    debugPrint("pause timer");
    TimerModel timerModel = timerList[index];
    timerModel.status!("resume");
  }

}
