class QuoteModel {
  int id;
  String category;
  String quote;
  String author;
  int isFavorite;

  QuoteModel({
    required this.id,
    required this.category,
    required this.quote,
    required this.author,
    required this.isFavorite,
  });

  factory QuoteModel.fromMap(Map<String, dynamic> data) => QuoteModel(
        id: data["id"],
        category: data["category"],
        quote: data["quote"],
        author: data["author"],
        isFavorite: data["favorite"],
      );
}
