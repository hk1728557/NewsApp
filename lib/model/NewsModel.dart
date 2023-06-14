class NewsModel {
  String imgUrl;
  String newsHead;
  String newsDes;
  String newsCnt;
  String newsUrl;

  //create constructor NewsModel
  NewsModel(
      {required this.imgUrl,
      required this.newsHead,
      required this.newsDes,
      required this.newsCnt,
      required this.newsUrl});

  //ctrate method recive api data and deliver to arrenged format
  static NewsModel fromAPItoAPP(Map<String, dynamic> article) {
    return NewsModel(
        imgUrl: article["urlToImage"] ??
            "https://img.freepik.com/free-vector/breaking-news-concept_23-2148514216.jpg?w=2000",
        newsHead: article["title"] ?? "--",
        newsDes: article["description"] ?? "--",
        newsCnt: article["content"] ?? "--",
        newsUrl: article["url"] ??
            "https://news.google.com/home?hl=en-IN&gl=IN&ceid=IN:en");
  }
}
