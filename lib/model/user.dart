class UserModel {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String phone;

  UserModel(this.id, this.uid, this.name, this.email, this.phone);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(map['id'], map['uid'], map['name'], map['email'], map['phone']);
  }
}
