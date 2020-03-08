import 'package:flutter/material.dart';
import 'package:thizerlist/models/Lista.dart';
import 'package:intl/intl.dart';

class HomeList extends StatefulWidget {

  final List<Map> items;

  HomeList({this.items}) : super();

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  List<Widget> values = List<Widget>();

  Lista listaBo = Lista();

  @override
  Widget build(BuildContext context) {
    // Item default
    if (widget.items.length == 0){
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Nenhuma lista cadastrada ainda...'),
          ),
        ],
      );
    }

    DateFormat df = DateFormat('dd/MM/yyyy HH:mm');
 
    List<Widget> value = List<Widget>();

  return ListView.builder(
    shrinkWrap: true,
    itemCount: widget.items.length,
    itemBuilder: (BuildContext context, int index){
      Map item = widget.items[index];
      DateTime created = DateTime.tryParse(item['created']);
      return ListTile(
        leading: Icon(Icons.pages),
        title: Text(item['nome']),
        subtitle: Text('created'),
        //trailing: PopupMenuButton<>{},
      );    
    },
  );

  }

}
