import 'package:petland/model/birthday_event_model.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/model/vaccince_event_model.dart';
import 'package:petland/model/vaccine_type_model.dart';
import 'package:petland/repo/record_repo.dart';
import 'package:petland/services/base_response.dart';
import 'package:petland/share/import.dart';

class RecordBloc extends ChangeNotifier {
  RecordBloc._privateConstructor() {
    //init();
  }
  static final RecordBloc instance = RecordBloc._privateConstructor();

  // List<RecordCategoryModel> categories;
  // List<TypeOfRecordModel> wikiTypes;

  void reload() {
    notifyListeners();
  }

  Future<BaseResponse> init() async {
    try {} catch (e) {} finally {}
  }

  Future<BaseResponse> getListVaccineRecord(String petId) async {
    try {
      final res = await RecordRepo().getListVaccineRecord(petId);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => VaccineEventModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {}
  }

  Future<BaseResponse> getListVaccineType(String raceType) async {
    try {
      final res = await RecordRepo().getListVaccineType(raceType);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => VaccineTypeModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {}
  }

  Future<BaseResponse> deleteBirthdayEvent(String eventId) async {
    try {
      final res = await RecordRepo().deleteBirthdayEvent(eventId: eventId);

      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> deleteVaccineEvent(String eventId) async {
    try {
      final res = await RecordRepo().deleteVaccineEvent(eventId: eventId);

      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }


  Future<BaseResponse> getListBirthdayRecord(String petId) async {
    try {
      final res = await RecordRepo().getListBirthdayRecord(petId);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => BirthdayEventModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> createBirthdayRecord(
      String petId,
      List<String> listImage,
      List<String> listVideo,
      String date,
      bool publicity,
      String content) async {
    try {
      final res = await RecordRepo().createBirthdayRecord(
          petId, listImage, listVideo, date, publicity, content);
      return BaseResponse.success(BirthdayEventModel.fromJson(res));
    } catch (e) {
      return BaseResponse.fail(e?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> createVaccineRecord(
      String vaccineTypeId,
      String petId,
      List<String> listImage,
      List<String> listVideo,
      String date,
      bool publicity,
      bool reminder,
      String content) async {
    try {
      final res = await RecordRepo().createVaccineRecord(vaccineTypeId, petId, listImage,
          listVideo, date, publicity, reminder, content);
      return BaseResponse.success(VaccineEventModel.fromJson(res));
    } catch (e) {
      return BaseResponse.fail(e?.toString());
    } finally {
      notifyListeners();
    }
  }
}
