import 'package:petland/services/user_srv.dart';

class UserRepo {
  Future register({String name, String email, String password}) async {
    final res = await UserSrv().mutate(
        'register',
        '''
data:
{
name: "$name"
email: "$email"
password: "$password"
}
    ''',
        fragment: 'token user { id uid name email phone avatar}');
    return res['register'];
  }

  Future login({String idToken}) async {
    final res = await UserSrv().mutate(
        'loginEmail',
        '''
idToken: "$idToken"
    ''',
        fragment: 'token user { id uid name email phone avatar}');
    return res['loginEmail'];
  }

  Future getOneUser({String id}) async {
    final res = await UserSrv().getItem(id);
    return res;
  }
}
