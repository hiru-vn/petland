import 'package:petland/model/vaccine_type_model.dart';

class VaccineEventModel {
  String id;
  String petId;
  String vaccineTypeId;
  List<String> images;
  List<String> videos;
  String date;
  bool publicity;
  bool remider;
  Null content;
  VaccineTypeModel vaccineType;
  String createdAt;
  String updatedAt;

  VaccineEventModel(
      {this.id,
      this.petId,
      this.vaccineTypeId,
      this.images,
      this.videos,
      this.date,
      this.publicity,
      this.remider,
      this.content,
      this.vaccineType,
      this.createdAt,
      this.updatedAt});

  VaccineEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petId = json['petId'];
    vaccineTypeId = json['vaccineTypeId'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    date = json['date'];
    publicity = json['publicity'];
    remider = json['remider'];
    content = json['content'];
    vaccineType = json['vaccineType'] != null
        ? new VaccineTypeModel.fromJson(json['vaccineType'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petId'] = this.petId;
    data['vaccineTypeId'] = this.vaccineTypeId;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['date'] = this.date;
    data['publicity'] = this.publicity;
    data['remider'] = this.remider;
    data['content'] = this.content;
    if (this.vaccineType != null) {
      data['vaccineType'] = this.vaccineType.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}