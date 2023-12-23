class FavoriteDataBaseModel {
  int quoteId;
  String quoteCategory;
  String quote;
  String quoteAuthor;
  String quoteImage;

  FavoriteDataBaseModel({
    required this.quoteId,
    required this.quoteCategory,
    required this.quote,
    required this.quoteAuthor,
    required this.quoteImage,
  });

  factory FavoriteDataBaseModel.fromMap({required Map data}) {
    return FavoriteDataBaseModel(
      quoteId: data['quote_id'],
      quoteCategory: data['quote_category'],
      quote: data['quote'],
      quoteAuthor: data['author'],
      quoteImage: String.fromCharCodes(data['quote_image']),
    );
  }
}
