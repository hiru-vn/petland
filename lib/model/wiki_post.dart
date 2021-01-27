class WikiPostModel {
  String id;
  String title;
  String content;
  int like;
  int seen;
  int share;
  String link;
  String wikiCategoryId;
  Null avatarWritter;
  Null nameWritter;
  Null image;
  String createdAt;
  String updatedAt;

  WikiPostModel(
      {this.id,
      this.title,
      this.content,
      this.like,
      this.seen,
      this.share,
      this.link,
      this.wikiCategoryId,
      this.avatarWritter,
      this.nameWritter,
      this.image,
      this.createdAt,
      this.updatedAt});

  WikiPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    like = json['like'];
    seen = json['seen'];
    share = json['share'];
    link = json['link'];
    wikiCategoryId = json['wikiCategoryId'];
    avatarWritter = json['avatarWritter'];
    nameWritter = json['nameWritter'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['like'] = this.like;
    data['seen'] = this.seen;
    data['share'] = this.share;
    data['link'] = this.link;
    data['wikiCategoryId'] = this.wikiCategoryId;
    data['avatarWritter'] = this.avatarWritter;
    data['nameWritter'] = this.nameWritter;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}