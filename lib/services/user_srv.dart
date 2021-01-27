
import 'base_graphql.dart';

class UserSrv extends BaseService {
  UserSrv()  : super(module: 'User', fragment: ''' 
id: String
uid: String
name: String
email: String
phone: String
avatar: String
description: String
nickName: String
backgroundimage: String
follows: [String]
gender: String
birthday: DateTime
country: String
createdAt: DateTime
updatedAt: DateTime
  ''');
}