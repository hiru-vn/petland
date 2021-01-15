class RaceModel {
  String id;
  String image;
  String name;
  String type;

  RaceModel({this.id, this.image, this.name, this.type});

  RaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
