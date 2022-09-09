import 'package:http/http.dart' as http;
import 'package:news_app_api/models/article.dart';
import 'dart:convert';

import 'package:news_app_api/secret.dart';

class News {

  List<Article> news  = [];

  Future<void> getNews() async{

    String url = "http://newsapi.org/v2/top-headlines?country=tr&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }

  static Future<List<Article>> getNewsForCategory(String category) async{
    List<Article> news  = [];
    String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";
    //String url = "https://api.collectapi.com/news/getNews?country=tr&tag=general";
    //String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}";


    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
    return news;
  }
}


class NewsForCategorie {

  List<Article> news  = []; //****************************************

  Future<void> getNewsForCategory(String category) async{

    String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";
    //String url = "https://api.collectapi.com/news/getNews?country=tr&tag=general";
    //String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";
    //String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";


    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}

