import 'package:flutter/material.dart';
import 'package:thizerlist/layout.dart';

class ListPage extends StatefulWidget {
  static final tag = 'list-page';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Pesquisar'),
            ),
          ),
          Container(
            color: Colors.yellowAccent[100],
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.adjust),
                  title: Text('Nome do Item'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.deepOrange,
            height: 80,
          ),
        ],
      ),
    );

    return Layout.getContent(context, content, false);
  }
}
