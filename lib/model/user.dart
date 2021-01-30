class UserModel {
  String id;
  String uid;
  String name;
  String email;
  String phone;
  String avatar;
  String description;
  String nickName;
  String backgroundimage;
  List<String> follows;
  String createdAt;
  String updatedAt;
  String gender;
  String country;
  List<UserModel> followingUser = [];

  UserModel(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.description,
      this.nickName,
      this.backgroundimage,
      this.follows,
      this.createdAt,
      this.updatedAt,
      this.gender,
      this.country});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    description = json['description'];
    nickName = json['nickName'];
    backgroundimage = json['backgroundimage'];
    follows = json['follows'] == null ? [] : json['follows'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    gender = json['gender'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    data['nickName'] = this.nickName;
    data['backgroundimage'] = this.backgroundimage;
    data['follows'] = this.follows;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['gender'] = this.gender;
    data['country'] = this.country;
    return data;
  }
}
