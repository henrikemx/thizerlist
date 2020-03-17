import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thizerlist/application.dart';
import '../layout.dart';

class ItemsList extends StatefulWidget {
  final List<Map> items;
  final String filter;

  const ItemsList({Key key, this.items, this.filter}) : super(key: key);

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
          title: Text('Nenhum item a ser exibido', textAlign: TextAlign.center),
        )
      ]);
    }

    List<Map> filteredList = List<Map>();

    if (widget.filter.isNotEmpty) {
      for (dynamic item in widget.items) {
        String name = item['name'].toString().toLowerCase();
        if (name.contains(widget.filter.toLowerCase())) {
          filteredList.add(item);
        }
      }
    } else {
      filteredList.addAll(widget.items);
    }

    if (filteredList.isEmpty){
      return ListView(
        children: <Widget>[
          ListTile(
            title: Text('Nenhum item encontrado...'),
          )
        ],
      );
    }


    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int i) {
          Map item = filteredList[i];
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
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print('Marcar como adquirido');
              },
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                icon: Icons.edit,
                color: Colors.black45,
                onTap: () {
                  print('Editar');
                },
              ),
              IconSlideAction(
                caption: 'Excluir',
                icon: Icons.delete,
                color: Colors.red,
                onTap: () {
                  print('Excluir');
                },
              ),
            ],
          );
        });
  }
}
