import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:login/Models/article_model.dart';
import 'package:login/services/news_service.dart';
import 'package:login/widgets/article_card.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  List<ArticleModel> articles = [];
  List<String> categories = [
    "general",
    "health",
    "science",
    "sports",
    "technology",
    "business",
    "entertainment",
  ];
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: BottomNavigationBar(
            backgroundColor: Colors
                .black, // Set the background color of the BottomNavigationBar
            unselectedItemColor:
                const Color.fromARGB(255, 171, 31, 31), // Set the color of the unselected items
            selectedItemColor:
                const Color.fromARGB(255, 30, 187, 45), // Set the color of the selected item
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.public), label: "General"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Health"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: "Science"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_baseball), label: "Sports"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.devices), label: "Technology"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: "Business"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie), label: "Entertainment"),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "News App",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: NewsService().getArticles(categories[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ArticleCard(article: snapshot.data![i]);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
