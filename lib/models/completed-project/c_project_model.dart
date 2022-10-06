import 'package:cloud_firestore/cloud_firestore.dart';

class CProjectInfo {
  String? projectName;
  String? description;
  String? place;
  String? finishedTime;
  int? servePeople;
  GeoPoint? location;
  String? imageURL;
  String? status;

  CProjectInfo({
    required this.projectName,
    required this.description,
    required this.place,
    required this.servePeople,
    required this.location,
    required this.imageURL,
    required this.finishedTime,
    required this.status,
  });

  factory CProjectInfo.fromMap(Map<String, dynamic> map) {
    return CProjectInfo(
      projectName: map['projectName'] as String,
      description: map['description'] as String,
      finishedTime: map['finishedTime'] as String,
      place: map['place'] as String,
      servePeople: map['servePeople'] as int,
      location: map['location'] as GeoPoint,
      imageURL: map['image'] as String,
      status: map['status'] as String,
    );
  }
}
