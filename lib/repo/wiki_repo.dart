import 'package:petland/services/wiki_srv.dart';

class WikiRepo {
  Future getListWikiCategory() async {
    final res = await WikiCategorySrv().getList(limit: 50);
    return res;
  }

  Future getAllTypeOfWiki() async {
    final res = await TypeWikiSrv().getList(limit: 50);
    return res;
  }

  Future getListWikiPost(String wikiCategoryId) async {
    final res = await WikiPostSrv()
        .getList(limit: 50, filter: '{wikiCategoryId: "$wikiCategoryId"}');
    return res;
  }
}
