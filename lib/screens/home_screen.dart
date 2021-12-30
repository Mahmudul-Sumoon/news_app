import 'package:flutter/material.dart';
import 'package:news_api_use/constants.dart';
import 'package:news_api_use/screens/web_screen.dart';
import 'package:news_api_use/model/news_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  News? mappedData;
  int articleNumber = 1;
  getData() async {
    //print(_controller.text.trim());
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&pageSize=100&category=business&apiKey=$apiKey'));
    //print(x.body.toString());
    setState(() {
      mappedData = newsFromJson(response.body);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mappedData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 220.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(mappedData!
                                .articles![articleNumber].urlToImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Text(mappedData.toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 75.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (articleNumber >= 2) articleNumber--;
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              iconSize: 30.0,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (articleNumber <
                                      mappedData!.totalResults! - 1) {
                                    articleNumber++;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios),
                              color: Colors.white,
                              iconSize: 35.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Authour",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            mappedData!.articles![articleNumber].author!,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Published At",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            mappedData!.articles![articleNumber].publishedAt!
                                .toLocal()
                                .toString(),
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mappedData!.articles![articleNumber].source!.name!,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Flexible(
                    child: Text(
                      mappedData!.articles![articleNumber].title!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Flexible(
                    child: Text(
                      mappedData!.articles![articleNumber].description!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                  const Text(
                    'Content',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Flexible(
                    child: Text(
                      mappedData!.articles![articleNumber].content!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebScreen(
                              url: mappedData!.articles![articleNumber].url!,
                            ),
                          ),
                        ),
                        child: Text(
                          'Detailed News',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amberAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
