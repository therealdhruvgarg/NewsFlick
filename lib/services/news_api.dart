import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'package:news_app/models/article_category.dart';
import 'dart:convert';

class NewsAPI {
  const NewsAPI();
  static const baseURL ="https://newsapi.org/v2";
  static const apiKey = '';

  Future<List<Article>> fetchArticles(ArticleCategory category) async {
    var url = NewsAPI.baseURL;
    url += '/top-headlines';
    url += '?apikey=$apiKey';
    url += '&language=en';
    url += '&category=${categoryQueryParamValue(category)}';

    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      if(json['status'] == 'ok'){
          final dynamic artcilesJson = json['articles'] ?? [];
          final List<Article> articles = artcilesJson.map<Article>((e)=> Article.fromJson(e)).toList();
        return articles;
        } else{
          throw Exception(json['message']??"Failed to load articles");
        }
        
      }else{
         throw Exception("Failed to load articles (bad response)");
      }
  }

  String categoryQueryParamValue(ArticleCategory category){
    switch(category){
      case ArticleCategory.general:
      return "general";
      case ArticleCategory.business:
      return "business";
      case ArticleCategory.technology:
      return "technology";
      case ArticleCategory.entertainment:
      return "entertainment";
      case ArticleCategory.sports:
      return "sports";
      case ArticleCategory.science:
      return "science";
      case ArticleCategory.health:
      return "health";
      default:
      return "general"; 
    }
  }
} 