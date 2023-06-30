import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/count_down_timer_controller.dart';

class CountDownTimerView extends GetView<CountDownTimerController> {
  const CountDownTimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Timer Task'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.addTimer();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Obx(() {
              return controller.timerList.isNotEmpty
                  ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                        "Note: If timer is started, \"Initial Time in Seconds\" will be disabled to avoid confusion, it will be enabled once the timer is completed"),
                  )
                  : const SizedBox.shrink();
            }),
            Obx(() {
              return controller.timerList.isNotEmpty
                  ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.timerList.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var timerItem = controller.timerList.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        index == 0 ? const Text("Initial Time in Seconds", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),) : const SizedBox.shrink(),
                                        index == 0 ? const SizedBox(height: 10,) : const SizedBox.shrink(),
                                        SizedBox(
                                          height: 45,
                                          child: Obx(() {
                                            return TextField(
                                              controller:
                                              controller.secondsController[index],
                                              keyboardType: TextInputType.number,
                                              enabled:
                                              timerItem.status?.value == "start",
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9]'))
                                              ],
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  hintText: "Seconds",
                                                  hintStyle: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                  fillColor: Colors.white70),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Obx(() {
                                    return Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            index == 0 ? const Text("Seconds in HH:mm:ss", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),) : const SizedBox.shrink(),
                                            index == 0 ? const SizedBox(height: 10,) : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 45,
                                              child: Center(
                                                child: Text(
                                                  timerItem.countDownSecondsInString
                                                          ?.value ??
                                                      "HH:MM:SS",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Obx(() {
                                    return Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          index == 0 ? const Text("Initially: START, PAUSE, RESUME", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),) : const SizedBox.shrink(),
                                          index == 0 ? const SizedBox(height: 10,) : const SizedBox.shrink(),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                minimumSize:
                                                    const Size.fromHeight(45)),
                                            onPressed: () {
                                              controller.startTimer(index);
                                            },
                                            child: Text(
                                              timerItem.status!.value.toUpperCase(),
                                              style: const TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                  : const Expanded(
                      child: Center(
                      child: Text(
                        "Timer list is empty. \n Please Click Add Icon to Add (+) Timer.",
                        textAlign: TextAlign.center,
                      ),
                    ));
            }),
          ],
        ));
  }
}
