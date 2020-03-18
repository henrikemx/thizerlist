import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../layout.dart';
import '../models/item.dart';
import '../application.dart';
import 'items.dart';

class ItemAddPage extends StatefulWidget {
  static String tag = 'page-item-add';

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cQtde = TextEditingController();
  final MoneyMaskedTextController _cValor =
      MoneyMaskedTextController(thousandSeparator: '.', decimalSeparator: ',', leftSymbol: 'R\$ ');

  @override
  Widget build(BuildContext context) {
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
      },
    );

    _cQtde.text = '1';
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
      },
    );

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
            'Adicionar item',
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
                      itemBo.insert({
                        'fk_lista': ItemsPage.pkList,
                        'name': _cName.text,
                        'qtde': _cQtde.text,
                        'valor': _cValor.text,
                        'created': DateTime.now().toString()
                      }).then((saved) {
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
