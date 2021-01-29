import 'package:petland/services/graphql_helper.dart';
import 'package:petland/services/record_srv.dart';

class RecordRepo {
  Future getListVaccineRecord(String petId) async {
    final res =
        await VaccineSrv().getList(limit: 50, filter: '{petId: "$petId"}');
    return res;
  }

  Future getListVaccineType(String raceType) async {
    final res = await VaccineTypeSrv()
        .getList(limit: 50, filter: '{raceType: "$raceType"}');
    return res;
  }

  Future getListBirthdayRecord(String petId) async {
    final res =
        await BirthdaySrv().getList(limit: 50, filter: '{petId: "$petId"}');
    return res;
  }

  Future deleteBirthdayEvent({String eventId}) async {
    final res = await BirthdaySrv().delete(eventId);
    return res;
  }


  Future deleteVaccineEvent({String eventId}) async {
    final res = await BirthdaySrv().delete(eventId);
    return res;
  }

  Future createBirthdayRecord(
      String petId,
      List<String> listImage,
      List<String> listVideo,
      String date,
      bool publicity,
      String content) async {
    final res = await BirthdaySrv().add('''
petId: "$petId"
images: ${GraphqlHelper.listStringToGraphqlString(listImage)}
videos:  ${GraphqlHelper.listStringToGraphqlString(listVideo)}
date: "$date"
publicity: ${publicity.toString()}
content: "$content"
    ''', fragment: '''
    id: String
petId: String
images: [String]
videos: [String]
date: DateTime
publicity: Boolean
pet {
  id
}
createdAt: DateTime
updatedAt: DateTime
    ''');
    return res;
  }

  Future createVaccineRecord(
      String vaccineTypeId,
      String petId,
      List<String> listImage,
      List<String> listVideo,
      String date,
      bool publicity,
      bool remider,
      String content) async {
    final res = await VaccineSrv().add('''
vaccineTypeId: "$vaccineTypeId"
petId: "$petId"
images: ${GraphqlHelper.listStringToGraphqlString(listImage)}
videos:  ${GraphqlHelper.listStringToGraphqlString(listVideo)}
date: "$date"
publicity: ${publicity.toString()}
    ''', fragment: '''
vaccineTypeId: String
vaccineType {
  id: String
name: String
raceType: String
createdAt: DateTime
updatedAt: DateTime
}
petId: String
images: [String]
videos: [String]
date: DateTime
publicity: Boolean
remider: Boolean
content: String
    ''');
    return res;
  }
}
