class Category {
  String? id;
  String name;
  String? parentCategoryId;
  DateTime createTime;
  DateTime updateTime;

  Category(this.id, this.name, this.parentCategoryId, this.createTime, this.updateTime);

  factory Category.def(String name) {
    return Category(null, name, null, DateTime.now(), DateTime.now());
  }
}