import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:thizerlist/utils/QuantityFormatter.dart';
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

  String selectedUnit = unity.keys.first;
  bool isSelected = false;

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
        return null;
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
      inputFormatters: [ new QuantityFormatter(
        precision: unity[this.selectedUnit]
      )],
      validator: (value) {
        if (int.parse(value) < 1) {
          return 'Informe um valor positivo';
        }
        return null;
      },
    );

    final inputUnit = DropdownButton<String>(
        value: this.selectedUnit,
        onChanged: (String newValue) {
          setState(() {
            // calculo vai aqui
            double valueAsDouble = (double.tryParse(_cQtde.text) ?? 0.0);
            _cQtde.text = valueAsDouble.toStringAsFixed(unity[newValue]);
            this.selectedUnit = newValue;
          });
        },
        items: unity.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());

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
        return null;
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
          SizedBox(height: 10),
          Text('Produto'),
          inputName,
          SizedBox(height: 10),
          Text('Quantidade'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: inputQuantidade,
              ),
              Container(
                width: 100,
                child: inputUnit,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('Valor'),
          inputValor,
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                activeColor: Layout.primary(),
                value: this.isSelected,
                onChanged: (bool value) {
                  setState(() {
                    this.isSelected = value;
                  });
                },
              ),
              GestureDetector(
                child: Text(
                'O item está no carrinho ?',
                style: TextStyle(fontSize: 18),
              ),
              onTap: (){
                setState(() {
                  this.isSelected = !this.isSelected;
                });
              },
              ),
            ],
          ),
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
