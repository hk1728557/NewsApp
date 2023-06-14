import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:news_app/ReadMoreNews.dart';
import 'package:news_app/model/NewsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> newsDataList = [];

  Future<List<NewsModel>> getData() async {
    final response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=10a66ab2cdf9422ea05c003b0db5be36"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      final articles = data["articles"] as List<dynamic>;
      for (Map<String, dynamic> article in articles) {
        newsDataList.add(NewsModel.fromAPItoAPP(article));
      }
      return newsDataList;
    } else {
      return newsDataList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(221, 22, 22, 22),
        title: Text(
          "NEWS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Handle search bar onTap event
              print('Search bar tapped!');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlueAccent,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: newsDataList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(newsDataList[index].imgUrl,
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
                                    newsDataList[index].newsHead.length > 45
                                        ? "${newsDataList[index].newsHead.substring(0, 45)}..."
                                        : newsDataList[index].newsHead,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    newsDataList[index].newsDes.length > 70
                                        ? "${newsDataList[index].newsDes.substring(0, 70)}..."
                                        : newsDataList[index].newsDes,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.black38),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    newsDataList[index].newsCnt != "--"
                                        ? newsDataList[index].newsCnt.length >
                                                250
                                            ? newsDataList[index]
                                                .newsCnt
                                                .substring(0, 300)
                                            : "${newsDataList[index].newsCnt.toString().substring(0, newsDataList[index].newsCnt.length - 15)}...."
                                        : newsDataList[index].newsCnt,
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
                                        backgroundColor: Colors.lightBlueAccent,
                                        elevation: 4),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReadMoreNews(
                                              newsUrl:
                                                  newsDataList[index].newsUrl),
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
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
