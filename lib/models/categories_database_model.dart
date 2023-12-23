class CategoryDatabaseModel {
  int categoryId;
  String categoryName;
  String categoryIcon;
  String categoryImage;

  CategoryDatabaseModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryImage,
  });

  factory CategoryDatabaseModel.formMap({required Map data}) {
    return CategoryDatabaseModel(
      categoryId: data['category_id'],
      categoryName: data['category_name'],
      categoryIcon: String.fromCharCodes(data['category_icon']),
      categoryImage: String.fromCharCodes(data['category_image']),
    );
  }
}
