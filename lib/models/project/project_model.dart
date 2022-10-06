import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectInfo {
  String? projectName;
  String? summary;
  String? country;
  String? detail;
  int? servePeople;
  int? raisedMoney;
  int? needMoney;
  GeoPoint? location;
  String? imageURL;

  ProjectInfo({
    required this.projectName,
    required this.summary,
    required this.country,
    required this.detail,
    required this.servePeople,
    required this.raisedMoney,
    required this.needMoney,
    required this.location,
    required this.imageURL,
  });

  factory ProjectInfo.fromMap(Map<String, dynamic> map) {
    return ProjectInfo(
      projectName: map['projectName'] as String,
      summary: map['summary'] as String,
      country: map['country'] as String,
      detail: map['detail'] as String,
      servePeople: map['servePeople'] as int,
      raisedMoney: map['raisedMoney'] as int,
      needMoney: map['needMoney'] as int,
      location: map['location'] as GeoPoint,
      imageURL: map['image'] as String,
    );
  }
}
