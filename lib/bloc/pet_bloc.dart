import 'package:petland/model/pet.dart';
import 'package:petland/repo/pet_repo.dart';
import 'package:petland/services/base_response.dart';
import 'package:petland/share/import.dart';

class PetBloc extends ChangeNotifier {
  PetBloc._privateConstructor();
  static final PetBloc instance = PetBloc._privateConstructor();

  List<PetModel> pets = [];

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
}
