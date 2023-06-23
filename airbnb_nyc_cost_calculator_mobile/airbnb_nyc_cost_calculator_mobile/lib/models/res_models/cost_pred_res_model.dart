// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class CostPredResModel {
  Pred? pred;

  CostPredResModel({
    required this.pred,
  });

  factory CostPredResModel.fromRawJson(String str) =>
      CostPredResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CostPredResModel.fromJson(Map<String, dynamic> json) =>
      CostPredResModel(
        pred: Pred.fromJson(json["pred"]),
      );

  Map<String, dynamic> toJson() => {
        "pred": pred?.toJson(),
      };
}

class Pred {
  double max;
  double min;

  Pred({
    required this.max,
    required this.min,
  });

  factory Pred.fromRawJson(String str) => Pred.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pred.fromJson(Map<String, dynamic> json) => Pred(
        max: json["max"]?.toDouble(),
        min: json["min"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
      };
}
