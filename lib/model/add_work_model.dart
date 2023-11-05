// import 'dart:convert';

// AddWorkModel userDataFromJson(String str) => AddWorkModel.fromJson(json.decode(str));

// String userDataToJson(AddWorkModel data) => json.encode(data.toJson());

class AddWorkModel {
  int vacancy;
  String teamName;
  String siteLocation;
  String siteTime;
  String workType;
  int boysCount;
  String date;
  String? id;
  String code;
  String locationMap;

  AddWorkModel(
      {
      this.id,
      required this.vacancy,
      required this.locationMap,
      required this.code,
      required this.boysCount,
      required this.date,
      required this.siteLocation,
      required this.siteTime,
      required this.teamName,
      required this.workType});

  factory AddWorkModel.fromJson(Map<String, dynamic> json,String id) => AddWorkModel(
      id: id,
      code: json['code'],
      boysCount: json['boysCount'],
      vacancy: json['vacancy'],
      date: json['date'],
      siteLocation: json['siteLocation'],
      siteTime: json['siteTime'],
      teamName: json['teamName'],
      workType: json['workType'],
      locationMap: json['locationMap']
      );

      Map<String, dynamic> toJson() => {
        "vacancy":vacancy,
        "locationMap":locationMap,
        "code":code,
        "boysCount":boysCount,
        "date":date,
        "siteLocation":siteLocation,
        "siteTime":siteTime,
        "teamName":teamName,
        "workType":workType,
      };
}
