import 'package:petland/services/base_graphql.dart';

class UserSrv extends BaseService {
  UserSrv()  : super(module: 'User', fragment: ''' 
id: String
uid: String
name: String
email: String
phone: String
createdAt: DateTime
updatedAt: DateTime
  ''');
}