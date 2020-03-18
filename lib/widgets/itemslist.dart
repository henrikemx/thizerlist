import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thizerlist/application.dart';
import 'package:thizerlist/models/item.dart';
import 'package:thizerlist/pages/item-edit.dart';
import 'package:thizerlist/pages/items.dart';
import '../layout.dart';

class ItemsList extends StatefulWidget {
  final List<Map> items;
  final String filter;
  final Function refresher;

  const ItemsList({Key key, this.items, this.filter, this.refresher}) : super(key: key);

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

    if (filteredList.isEmpty) {
      return ListView(
        children: <Widget>[
          ListTile(
            title: Text('Nenhum item encontrado...'),
          )
        ],
      );
    }

    ModelItem itemBo = ModelItem();

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
                  child: Icon(
                    ((item['checked'] == 1) ? Icons.check_box : Icons.check_box_outline_blank), 
                    color: ((item['cecked'] == 0) ? Layout.info() : Layout.success()),
                    size: 32)),
              title: Text(item['name']),
              subtitle: Text('${item['qtde']} * R\$ ${item['valor']} = R\$ $valTotal'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                itemBo.update({'checked': !(item['checked'] == 1)}, item['pk_item']).then(
                    (bool updated) {
                  if (updated){
                    widget.refresher();
                  }
                });
              },
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                icon: Icons.edit,
                color: Colors.black45,
                onTap: () {
                  itemBo.getItem(item['pk_item']).then((Map i) {
                    ItemEditPage.item = i;
                    Navigator.of(context).pushNamed(ItemEditPage.tag);
                  });
                },
              ),
              IconSlideAction(
                caption: 'Excluir',
                icon: Icons.delete,
                color: Colors.red,
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text("Tem certeza ??"),
                          content: Text('Esta ação não pode ser desfeita !!'),
                          actions: <Widget>[
                            RaisedButton(
                                color: Layout.secondary(),
                                child: Text('Cancelar', style: TextStyle(color: Layout.light())),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            RaisedButton(
                                color: Layout.danger(),
                                child: Text('Excluir', style: TextStyle(color: Layout.light())),
                                onPressed: () {
                                  itemBo.delete(item['pk_item']);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(ItemsPage.tag);
                                }),
                          ],
                        );
                      });
                },
              ),
            ],
          );
        });
  }
}
