import 'package:flutter/material.dart';
import 'package:news_app/model/model_news.dart';
import 'package:news_app/services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ModelNews> _modelNews;

  @override
  void initState() {
    _modelNews = API_MANAGER().getNews();
    print("getData");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: Container(
        child: FutureBuilder<ModelNews>(
            future: _modelNews,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.articles.length,
                      itemBuilder: (context, index) {
                        var articles = snapshot.data.articles[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 100,
                          child: Row(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    articles.urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Card(
                                  child: Column(
                                    children: [
                                      Text(
                                        articles.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        articles.description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    );
  }
}
