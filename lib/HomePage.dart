import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2021/03/breaking-1615599304.jpg",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Breaking News, March 13",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "IndiaTV News provides you all the breaking news, latest news, breaking story videos,.",
                      style: TextStyle(fontSize: 20, color: Colors.black38),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "IndiaTV News provides you all thetDaily dose of news plays a very important role in our daily life. For some people, the morning is incomplete without knowing what's happening across the world. Some digital-savvy people have a habit of consuming news even ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         DetailviewScreen(newsUrl: newsUrl),
                    //   ),
                    // );
                  },
                  child: Text("Read More"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
