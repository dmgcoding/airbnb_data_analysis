import 'dart:convert';

class CostPredReqModel {
  String neighbourhoodGroup;
  String neighbourhood;
  String roomType;
  int nights;

  CostPredReqModel({
    required this.neighbourhoodGroup,
    required this.neighbourhood,
    required this.roomType,
    required this.nights,
  });

  factory CostPredReqModel.fromRawJson(String str) =>
      CostPredReqModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CostPredReqModel.fromJson(Map<String, dynamic> json) =>
      CostPredReqModel(
        neighbourhoodGroup: json["neighbourhood_group"],
        neighbourhood: json["neighbourhood"],
        roomType: json["room_type"],
        nights: json["nights"],
      );

  Map<String, dynamic> toJson() => {
        "neighbourhood_group": neighbourhoodGroup,
        "neighbourhood": neighbourhood,
        "room_type": roomType,
        "nights": nights,
      };
}
