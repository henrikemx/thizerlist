import 'package:flutter/material.dart';
import 'package:thizerlist/application.dart';
import 'dart:async';
import 'package:thizerlist/widgets/itemslist.dart';
import 'package:thizerlist/models/item.dart';
import 'package:thizerlist/layout.dart';
import 'item-add.dart';

class ItemsPage extends StatefulWidget {
  static final tag = 'items-page';

  static int pkList;
  static String nameList;

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final ItemsListBloc itemsListBloc = ItemsListBloc();

  String filterText = '';

  @override
  void dispose() {
    itemsListBloc.dispose();
    super.dispose();
  }

  // void refresher() {
  //   setState(() {
  //     this.itemsListBloc.getList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              'Lista: ' + ItemsPage.nameList,
              style: TextStyle(fontSize: 16, color: Layout.primary(), height: 2),
            ),
          ),
          Container(
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        filterText = text;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Layout.info(),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ItemAddPage.tag);
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width - 20,
            child: StreamBuilder<List<Map>>(
              stream: itemsListBloc.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: Text('Carregando...'),
                    );
                    break;
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {
                      print('====================================');
                      print('widget.items.ItemsList = ${snapshot.data}');
                      print('====================================');

                      return ItemsList(
                          items: snapshot.data, 
                          filter: filterText, 
                          itemsListBloc: this.itemsListBloc
                          );
                    }
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(100, 150, 255, 0.3),
                  Color.fromRGBO(255, 150, 240, 0.3),
                ],
              ),
            ),
            height: 60,
            child: StreamBuilder<List<Map>>(
              stream: itemsListBloc.lists,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: Text('Carregando...'),
                    );
                    break;
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {
                      print('====================================');
                      print('widget.items.ItemsList = ${snapshot.data}');
                      print('====================================');

                      List<Map> items = snapshot.data;

                      int qtdeTotal = items.length;

                      int qtdeChecked = 0;

                      double subTotal = 0.0;
                      double vlrTotal = 0.0;

                      for (Map item in items){
                        double vlr = currencyToFloat(item['valor']) * item['qtde'];
                        subTotal += vlr;

                        if(item['checked'] == 1){
                          qtdeChecked++;
                          vlrTotal += vlr;
                        }
                      }

                      bool isClosed = (subTotal == vlrTotal);
                       
                      return Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Itens'),
                                    Text(qtdeTotal.toString(), textScaleFactor: 1.2)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Carrinho'),
                                    Text(qtdeChecked.toString(), textScaleFactor: 1.2)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Faltando'),
                                    Text((qtdeTotal - qtdeChecked).toString(), textScaleFactor: 1.2)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Subt.: ' + doubleToCurrency(subTotal),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Layout.dark(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Total: ' + doubleToCurrency(vlrTotal),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isClosed ? Layout.success() : Layout.info(),
                                    fontWeight: FontWeight.bold, 
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );

    return Layout.getContent(context, content, false);
  }
}

class ItemsListBloc {
  ItemsListBloc() {
    getList();
  }

  ModelItem itemBo = ModelItem();

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dispose() {
    _controller.close();
  }

  getList() async {
    _controller.sink.add(await itemBo.itemsByList(ItemsPage.pkList));
  }
}
