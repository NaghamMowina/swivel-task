import 'package:cloud_firestore/cloud_firestore.dart';

class ResultModel {
  String? name;
  int? score;
  DateTime? createdAt;
  String? qIds;
  ResultModel({this.name, this.score, this.createdAt, this.qIds});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      name: json['name'],
      score: json['score'],
      qIds: json['qIds'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['score'] = score;
    data['qIds'] = qIds;
    data['createdAt'] = createdAt;

    return data;
  }
}
