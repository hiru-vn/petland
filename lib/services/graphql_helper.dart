class GraphqlHelper {
  static String mapToGraphqlString(Map<String, dynamic> map) {
    String result = "";
    map.forEach((key, value) {
      if (value is String) {
        result = result + key + " : " + '"' + value + '",';
      }
      if (value is bool || value is int || value is double) {
        result = result + key + " : " + value.toString() + ' ,';
      }
    });
    return result;
  }

  static String listStringToGraphqlString(List list) {
    if (list == null) return '[]';
    String result = "[";
    list.forEach((value) {
      result += '"${value.toString()}",';
    });
    result += "]";
    return result;
  }

  static String listMapToGraphqlString(List list) {
    if (list == null) return '[]';
    String result = "[";
    list.forEach((value) {
      result += '${mapToGraphqlString(value)},';
    });
    result += "]";
    return result;
  }

  static String dynamicToGraphqlString(dynamic val) {
    //input: dynamic
    //output: return String in grapql base on it's type
    if (val == null) return null;
    if (val is String) return '"$val"';
    if (val is bool || val is int || val is double) return '$val';
    if (val is Map) return mapToGraphqlString(val);
    if (val is List<String>) return listStringToGraphqlString(val);
    if (val is List<Map>) return listMapToGraphqlString(val);
    return null;
  }
}