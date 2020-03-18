import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../models/item.dart';
import '../application.dart';
import '../layout.dart';
import 'items.dart';

class ItemEditPage extends StatefulWidget {

  static String tag = 'page-item-edit';
  static Map item;

  @override
  _ItemEditPageState createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cQtde = TextEditingController();
  final MoneyMaskedTextController _cValor =
      MoneyMaskedTextController(thousandSeparator: '.', decimalSeparator: ',', leftSymbol: 'R\$ ');

  @override
  Widget build(BuildContext context) {

    _cName.text = ItemEditPage.item['name'];

    final inputName = TextFormField(
      controller: _cName,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Nome do item',
        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return '';
      },
    );

    _cQtde.text = ItemEditPage.item['qtde'].toString();

    final inputQuantidade = TextFormField(
      controller: _cQtde,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Qtde',
        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) {
        if (int.parse(value) < 1) {
          return 'Informe um valor positivo';
        }
        return '';
      },
    );

    _cValor.text = ItemEditPage.item['valor'];

    final inputValor = TextFormField(
      controller: _cValor,
      autofocus: true,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: 'Valor R\$ ',
        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) {
        if (currencyToDouble(value) < 0.0) {
          return 'Obrigatório';
        }
        return '';
      },
    );

    Container content = Container(
        child: Form(
      key: _formkey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(
            "Editando: " + ItemEditPage.item['name'].toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 20),
          inputName,
          SizedBox(height: 20),
          inputQuantidade,
          SizedBox(height: 20),
          inputValor,
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                color: Layout.secondary(),
                child: Text('Cancelar', style: TextStyle(color: Layout.light())),
                padding: EdgeInsets.only(left: 50, right: 50),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                  color: Layout.primary(),
                  child: Text('Salvar', style: TextStyle(color: Layout.light())),
                  padding: EdgeInsets.only(left: 50, right: 50),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      // Instancia Model
                      ModelItem itemBo = ModelItem();

                      // Adicionado dados ao BD
                      itemBo.update(
                        {
                        // 'fk_lista': ItemsPage.pkList,
                        'name': _cName.text,
                        'qtde': _cQtde.text,
                        'valor': _cValor.text,
                        'created': DateTime.now().toString()
                      },
                      ItemEditPage.item['pk_item']
                      ).then((saved) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(ItemsPage.tag);
                        print('=================================');
                        print('ItemsPage.pkList = ${ItemsPage.pkList}');
                        print('Nome: ${_cName.text}, , ');
                        print('Valor: ${_cValor.text}');
                        print('Qtde: ${_cQtde.text}');
                        print('=================================');
                      });
                    }
                  }),
            ],
          )
        ],
      ),
    ));

    return Layout.getContent(context, content, false);
  }
}
