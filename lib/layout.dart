import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/settings.dart';

class Layout {
  static final pages = [HomePage.tag, SettingPage.tag, AboutPage.tag];

  static int currItem = 0;

  static Scaffold getContent(BuildContext context, content) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Layout.primary(),
        title: Center(
          child: Text('ThizerList'),
        ),
        actions: _getActions(context),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currItem,
        fixedColor: secondary(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Configurações')),
          BottomNavigationBarItem(icon: Icon(Icons.help), title: Text('Sobre')),
        ],
        onTap: (int i) {
          currItem = i;
          Navigator.of(context).pushNamed(pages[currItem]);
        },
      ),
    );
  }

  static List<Widget> _getActions(context) {
    List<Widget> items = List<Widget>();

    // fora da pagina
    if (pages[currItem] != HomePage.tag) {
      return items;
    }

    TextEditingController _ctrl = TextEditingController();

    items.add (
      GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext ctx) {
                  final input = TextFormField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                        hintText: 'Produto',
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  );

                  return AlertDialog(
                    title: Text('Nova lista'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          //Text('Nome'),
                          input,
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      RaisedButton(
                          color: secondary(),
                          child: Text('Cancelar',
                              style: TextStyle(color: Layout.light())),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          }),
                      RaisedButton(
                          color: primary(),
                          child: Text('Adicionar ',
                              style: TextStyle(
                                color: Layout.light(),
                              )),
                          onPressed: () {
                            print(_ctrl.text);
                            Navigator.of(ctx).pop();
                          },
                        )
                     ],
                   );
                  }
                );
              },
          child: Icon(Icons.add)
          ),
      // Padding(padding: EdgeInsets.only(right: 20)),
    );

    items.add(Padding(padding: EdgeInsets.only(right: 20)));

    return items;
  }

  static Color primary([double opacity = 1]) =>
      Color.fromRGBO(62, 63, 89, opacity);
  static Color secondary([double opacity = 1]) =>
      Color.fromRGBO(111, 168, 191, opacity);
  static Color light([double opacity = 1]) =>
      Color.fromRGBO(242, 234, 228, opacity);
  static Color dark([double opacity = 1]) =>
      Color.fromRGBO(51, 51, 51, opacity);
  static Color danger([double opacity = 1]) =>
      Color.fromRGBO(217, 74, 74, opacity);
  static Color success([double opacity = 1]) =>
      Color.fromRGBO(6, 166, 59, opacity);
  static Color info([double opacity = 1]) =>
      Color.fromRGBO(0, 122, 166, opacity);
  static Color warning([double opacity = 1]) =>
      Color.fromRGBO(166, 134, 0, opacity);
}
