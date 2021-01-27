import 'package:petland/model/type_wiki.dart';
import 'package:petland/model/wiki_category.dart';
import 'package:petland/model/wiki_post.dart';
import 'package:petland/repo/wiki_repo.dart';
import 'package:petland/services/base_response.dart';
import 'package:petland/share/import.dart';

class WikiBloc extends ChangeNotifier {
  WikiBloc._privateConstructor() {
    //init();
  }
  static final WikiBloc instance = WikiBloc._privateConstructor();

  List<WikiCategoryModel> categories;
  List<TypeOfWikiModel> wikiTypes;

  void reload() {
    notifyListeners();
  }

  Future<BaseResponse> init() async {
    try {
      await Future.wait([getListCategory(), getListWikiType()]);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<BaseResponse> getListCategory() async {
    try {
      final res = await WikiRepo().getListWikiCategory();
      final List listRaw = res['data'];
      final list = listRaw.map((e) => WikiCategoryModel.fromJson(e)).toList();
      categories = list;
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {}
  }

  Future<BaseResponse> getListWikiType() async {
    try {
      final res = await WikiRepo().getAllTypeOfWiki();
      final List listRaw = res['data'];
      final list = listRaw.map((e) => TypeOfWikiModel.fromJson(e)).toList();
      wikiTypes = list;
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {}
  }

  Future<BaseResponse> getListWikiPost(String wikiCategoryId) async {
    try {
      final res = await WikiRepo().getListWikiPost(wikiCategoryId);
      final List listRaw = res['data'];
      final list = listRaw.map((e) => WikiPostModel.fromJson(e)).toList();
      return BaseResponse.success(list);
    } catch (e) {
      return BaseResponse.fail(e.message?.toString());
    } finally {}
  }
}
