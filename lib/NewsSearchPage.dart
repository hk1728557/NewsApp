import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/ReadMoreNews.dart';
import 'package:news_app/model/NewsModel.dart';

class NewsSearchPage extends StatefulWidget {
  final String query;

  const NewsSearchPage({Key? key, required this.query}) : super(key: key);

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  TextEditingController searchController = TextEditingController();
  List<NewsModel> newsQueryList = [];

  bool isLoading = true;

  Future<List<NewsModel>> getNewsByQuery(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=$query&apiKey=10a66ab2cdf9422ea05c003b0db5be36";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      final articles = data["articles"] as List<dynamic>;
      for (Map<String, dynamic> article in articles) {
        newsQueryList.add(NewsModel.fromAPItoAPP(article));
      }
      return newsQueryList;
    } else {
      return newsQueryList;
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsByQuery(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 22, 22, 22),
        title: const Text(
          "NEWS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                final query = searchController.text.trim();
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsSearchPage(query: query),
                    ),
                  );
                }
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 215, 234, 242),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        // textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                          hintText: "Search country Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child:
            FutureBuilder(
              future: getNewsByQuery(widget.query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 650,
                    child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: newsQueryList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(newsQueryList[index].imgUrl,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      newsQueryList[index].newsHead.length > 45
                                          ? "${newsQueryList[index].newsHead.substring(0, 45)}..."
                                          : newsQueryList[index].newsHead,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      newsQueryList[index].newsDes.length > 70
                                          ? "${newsQueryList[index].newsDes.substring(0, 70)}..."
                                          : newsQueryList[index].newsDes,
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black38),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      newsQueryList[index].newsCnt != "--"
                                          ? newsQueryList[index]
                                                      .newsCnt
                                                      .length >
                                                  250
                                              ? newsQueryList[index]
                                                  .newsCnt
                                                  .substring(0, 300)
                                              : "${newsQueryList[index].newsCnt.toString().substring(0, newsQueryList[index].newsCnt.length - 15)}...."
                                          : newsQueryList[index].newsCnt,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.lightBlueAccent,
                                          elevation: 4),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReadMoreNews(
                                                newsUrl: newsQueryList[index]
                                                    .newsUrl),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Read More",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
