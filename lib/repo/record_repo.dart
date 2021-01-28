import 'package:petland/services/graphql_helper.dart';
import 'package:petland/services/record_srv.dart';
import 'package:petland/services/wiki_srv.dart';

class RecordRepo {
  Future getListVaccineRecord() async {
    final res = await VaccineSrv().getList(limit: 50);
    return res;
  }

  Future getListBirthdayRecord() async {
    final res = await BirthdaySrv().getList(limit: 50);
    return res;
  }

  Future createBirthdayRecord(String petId, List<String> listImage, List<String> listVideo,
      String date, bool publicity) async {
    final res = await BirthdaySrv().add('''
petId: "$petId"
images: ${GraphqlHelper.listStringToGraphqlString(listImage)}
videos:  ${GraphqlHelper.listStringToGraphqlString(listVideo)}
date: "$date"
publicity: ${publicity.toString()}
    ''',
    fragment: 'id');
    return res;
  }
}
