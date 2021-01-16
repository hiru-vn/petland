import 'package:petland/model/pet.dart';
import 'package:petland/services/graphql_helper.dart';
import 'package:petland/services/pet_srv.dart';

class PetRepo {
  Future getAll({String userId}) async {
    final res = await PetSrv().getList(filter: '{userId: "$userId"}');
    return res;
  }

  Future update({PetModel pet}) async {
    final res = await PetSrv().update(id: pet.id, data: '''
    name : "${pet.name}"
    raceId : "${pet.raceId}"
    birthday: "${pet.birthday}"
    gender: "${pet.gender}"
    character: ${GraphqlHelper.listStringToGraphqlString(pet.character)}
    avatar: "${pet.avatar}"
  	coverImage: "${pet.coverImage}"
    ''');
    return res;
  }

  Future delete({String petId}) async {
    final res = await PetSrv().delete(petId);
    return res;
  }
}

class RaceRepo {
  Future getAll({String type}) async {
    final res = await RaceSrv().getList(filter: '{type: "$type"}');
    return res;
  }
}