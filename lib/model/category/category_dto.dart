class CategoryDTO {
  int id;
  String name;
  String? parentCategoryId;
  DateTime createTime;
  DateTime updateTime;

  CategoryDTO({
    required this.id,
    required this.name,
    this.parentCategoryId,
    required this.createTime,
    required this.updateTime
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    if (parentCategoryId != null) {
      map['parentCategoryId'] = parentCategoryId;
    }
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;

    return map;
  }
}