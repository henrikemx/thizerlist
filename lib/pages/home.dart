import 'package:flutter/material.dart';
import 'package:thizerlist/layout.dart';
import 'about.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Olá, Mundo !!',
          style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold
          )),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text('Sobre'),
            onPressed: (){
              Navigator.of(context).pushNamed(AboutPage.tag);
            },
          )
        ], 
        ),
    );

    return Layout.getContent(context, content);
  }
}
