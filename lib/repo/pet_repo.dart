import 'package:petland/services/pet_srv.dart';

class PetRepo {
  Future getAll({String userId}) async {
    final res = await PetSrv().getList(filter: '{userId: "$userId"}');
    return res;
  }
}
