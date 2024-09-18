import 'package:flutter/material.dart';
import 'package:login/Cache/cache_helper.dart';
import 'package:login/Screens/article_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await CacheHelper.initial(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 178, 166, 166), 
        ),
        home:const ArticleView(),
      );
  }
}
