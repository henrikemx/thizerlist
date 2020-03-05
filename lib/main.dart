import 'package:flutter/material.dart';
import 'package:thizerlist/layout.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/settings.dart';

void main() => runApp(ThizerList());

class ThizerList extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    SettingPage.tag: (context) => SettingPage(),
    AboutPage.tag: (context) => AboutPage()
  };
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThizerList',
      theme: ThemeData(
        primaryColor: Layout.primary(),
        accentColor: Layout.secondary(),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Layout.info()),
          body1: TextStyle(fontSize: 14)
        ),
      ),
      home:  HomePage(),
      routes: routes,
    );
  }
}
