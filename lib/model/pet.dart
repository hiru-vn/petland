import 'race.dart';

class PetModel {
  String id;
  String name;
  String raceId;
  String birthday;
  String gender;
  List<String> character;
  String userId;
  String avatar;
  String coverImage;
  RaceModel race;
  String createdAt;
  String updatedAt;

  PetModel({
    this.id,
    this.name,
    this.raceId,
    this.birthday,
    this.gender,
    this.character,
    this.userId,
    this.avatar,
    this.coverImage,
    this.race,
    this.createdAt,
    this.updatedAt,
  });

  PetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    raceId = json['raceId'];
    birthday = json['birthday'];
    gender = json['gender'];
    character = json['character'].cast<String>();
    userId = json['userId'];
    avatar = json['avatar'];
    coverImage = json['coverImage'];
    race = json['race'] != null ? new RaceModel.fromJson(json['race']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['raceId'] = this.raceId;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['character'] = this.character;
    data['userId'] = this.userId;
    data['avatar'] = this.avatar;
    data['coverImage'] = this.coverImage;
    if (this.race != null) {
      data['race'] = this.race.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    
    return data;
  }
}
