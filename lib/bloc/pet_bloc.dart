import 'package:petland/model/pet.dart';
import 'package:petland/model/race.dart';
import 'package:petland/repo/pet_repo.dart';
import 'package:petland/services/base_response.dart';
import 'package:petland/share/import.dart';

class PetBloc extends ChangeNotifier {
  PetBloc._privateConstructor();
  static final PetBloc instance = PetBloc._privateConstructor();

  List<PetModel> pets = [];
  List<RaceModel> races = [];

  Future<BaseResponse> getAllPet() async {
    try {
      final String id = await SPref.instance.get('id');
      final res = await PetRepo().getAll(userId: id);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => PetModel.fromJson(e)).toList();
      pets = list;
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> updatePet(PetModel pet) async {
    try {
      final res = await PetRepo().update(pet: pet);
      pets[pets.indexWhere((element) => element.id == pet.id)] = pet;
      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> createPet(PetModel pet) async {
    try {
      final String id = await SPref.instance.get('id');
      pet.userId = id;
      final res = await PetRepo().create(pet: pet);
      pets.add(PetModel.fromJson(res));
      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> deletePet(String petId) async {
    try {
      final res = await PetRepo().delete(petId: petId);
      pets.removeWhere((element) => element.id == petId);
      return BaseResponse.success(res);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> getAllPetRace(String type) async {
    try {
      final res = await RaceRepo().getAll(type: type);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => RaceModel.fromJson(e)).toList();
      races = list;
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }
}
