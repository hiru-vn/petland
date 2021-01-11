class UserModel {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String avatar;

  UserModel(this.id, this.uid, this.name, this.email, this.phone, this.avatar);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(map['id'], map['uid'], map['name'], map['email'], map['phone'], map['avatar']);
  }
}
