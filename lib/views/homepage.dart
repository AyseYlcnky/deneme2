import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/data.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:news_app_api/models/article.dart';
import 'package:news_app_api/models/categorie_model.dart';
import 'package:news_app_api/views/categorie_news.dart';
import 'package:news_app_api/views/side_menu.dart';
import 'package:provider/provider.dart';
import '../helper/change_theme_button_widget.dart';
import '../helper/custom_search.dart';
import '../helper/news.dart';
import '../helper/theme_provider.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  final String title2;

  const HomePage({Key key, this.title2}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffold =
      GlobalKey<ScaffoldState>(); //scaffold için
/*  var color_degisken1 = Colors.black;
  var color_degisken2 = Colors.white;
  var color_degisken3 = Colors.pink;
  */
  void dispose() {
    darkNotifier.dispose();
    super.dispose();
  }

  ScrollController listScrollController = ScrollController();
  bool _loading;
  Future<List<Article>> newslist;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    //print("hi");
    await news.getNews();
    //print("hi");
    //newslist = News.getNewsForCategory('general'); //**************************************
    //print("hi");
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    newslist = News.getNewsForCategory('general');
    getNews();
  }

  Future<void> refreshReportList() async {
/* reportContainer(Article article){
    print(article.title);
    print(article.urlToImage);
    print(article.description);
    print(article.content);
    print(article.articleUrl);
    return Container(
      child: NewsTile(
        imgUrl: ,
      )
      */ /*Text("${article.title}"
          " ${article.urlToImage} "
          "${article.description} "
          "${article.content} "
          "${article.articleUrl}"),*/ /*

    );
  }*/
  }

  @override
  Widget build(BuildContext context) {
/*    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';*/

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffold.currentState
                .openDrawer(); //side_menuyu açabilmek için kay tanımladık yukarda
          },
          tooltip: 'Open The Side Menu',
        ),
        title: Container(
          child: Image.asset('assets/yan_logo2.png'),
        ),
        actions: <Widget>[
          //ChangeThemeButtonWidget(), //????????????????????????????*
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),

                      /// News Article
                      FutureBuilder<List<Article>>(
                          future: newslist,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if ((snapshot.data).isNotEmpty) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  controller: listScrollController,
                                  itemCount: (snapshot.data).length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return //reportContainer(snapshot.data[index]);
                                        NewsTile(
                                      imgUrl:
                                          snapshot.data[index].urlToImage ?? "",
                                      title: snapshot.data[index].title ?? "",
                                      desc: snapshot.data[index].description ??
                                          "",
                                      content:
                                          snapshot.data[index].content ?? "",
                                      posturl:
                                          snapshot.data[index].articleUrl ?? "",
                                    );
                                  },
                                );
                              } else {}
                            } else if (snapshot.hasError) {}
                            return const Text('Hata');
                          }),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue.withOpacity(0.60),
        child: Icon(Icons.cloud),
      ),
      drawer: sideMenu(),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
