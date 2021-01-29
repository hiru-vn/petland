class VaccineTypeModel {
  String id;
  String raceType;
  String name;
  String createdAt;
  String updatedAt;

  VaccineTypeModel(
      {this.id, this.raceType, this.name, this.createdAt, this.updatedAt});

  VaccineTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    raceType = json['raceType'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['raceType'] = this.raceType;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}