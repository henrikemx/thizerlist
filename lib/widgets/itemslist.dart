import 'package:flutter/material.dart';

class ItemsList extends StatefulWidget {

  final List<Map> items;

  const ItemsList({Key key, this.items}) : super(key: key);
  
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}