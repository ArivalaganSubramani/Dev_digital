// To parse this JSON data, do
//
//     final timerModel = timerModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<TimerModel> timerModelFromJson(String str) => List<TimerModel>.from(json.decode(str).map((x) => TimerModel.fromJson(x)));

String timerModelToJson(List<TimerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimerModel {
  String? id;
  RxInt? initialSeconds;
  RxInt? countDownSeconds;
  RxString? countDownSecondsInString;
  RxString? status;

  TimerModel({
    this.id,
    this.initialSeconds,
    this.countDownSeconds,
    this.countDownSecondsInString,
    this.status,
  });

  factory TimerModel.fromJson(Map<String, dynamic> json) => TimerModel(
    id: json["id"],
    initialSeconds: json["initialSeconds"],
    countDownSeconds: json["countDownSeconds"],
    countDownSecondsInString: json["countDownSecondsInString"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "initialSeconds": initialSeconds,
    "countDownSeconds": countDownSeconds,
    "countDownSecondsInString": countDownSecondsInString,
    "status": status,
  };
}
