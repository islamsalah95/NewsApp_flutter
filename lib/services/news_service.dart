import 'package:dio/dio.dart';
import 'package:login/Models/article_model.dart';

class NewsService {
  Future<List<ArticleModel>> getArticles(String categorie) async {
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&category=${categorie}&apiKey=d7793082d8424b6aa238ab372eaab846');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = response.data['articles'];

      List<ArticleModel> artecles = [];

      for (var element in articles) {
        ArticleModel model = ArticleModel(
          title: element['title'] ?? "No tititletle",
          description: element['description'] ?? "No description",
          image: element['urlToImage'] ??
              "https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
          author: element['author'] ?? "No author",
          data: element['publishedAt'] ?? "No date",
        );

        artecles.add(model);
      }
      return artecles;
    } catch (e) {
      throw Exception(e.toString);
    }
  }
}
