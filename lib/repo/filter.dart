class GraphqlFilter {
  int limit;
  int page;
  String filter;
  String search;
  String order;
  int offset;
  GraphqlFilter(
      {this.limit,
      this.filter,
      this.search,
      this.order,
      this.offset,
      this.page = 1});
      
  GraphqlFilter copyWith({
    int limit,
    String filter,
    String search,
    String order,
    int offset,
    int page,
  }) {
    return GraphqlFilter(
        limit: limit ?? this.limit,
        filter: filter ?? this.filter,
        search: search ?? this.search,
        order: order ?? this.order,
        offset: offset ?? this.offset,
        page: page ?? this.page);
  }
}
