import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thizerlist/application.dart';
import '../layout.dart';

class ItemsList extends StatefulWidget {
  final List<Map> items;

  const ItemsList({Key key, this.items}) : super(key: key);

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    // Item default
    if (widget.items.isEmpty) {
      return ListView(children: <Widget>[
        ListTile(
          leading: Icon(Icons.check_box_outline_blank, size: 32),
          title: Text('Nenhum item a ser exibido'),
        )
      ]);
    }

    return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int i) {
          Map item = widget.items[i];
          double realVal = currencyToDouble(item['valor']);
          String valTotal = doubleToCurrency(realVal * item['qtde']);
          return Slidable(
            delegate: SlidableDrawerDelegate(),
            actionExtentRatio: 0.2,
            closeOnScroll: true,
            child: ListTile(
              leading: GestureDetector(
                  child: Icon(Icons.check_box_outline_blank, color: Layout.secondary(), size: 32)),
              title: Text(item['name']),
              subtitle: Text('${item['qtde']} * R\$ ${item['valor']} = R\$ $valTotal'),
              onTap: () {
                print('Marcar como adquirido');
              },
            ),
          );
        });
  }
}
