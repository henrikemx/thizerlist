import 'package:flutter/material.dart';
import 'package:thizerlist/layout.dart';

class SettingPage extends StatelessWidget {
  static String tag = 'settings-page';

  @override
  Widget build(BuildContext context) {
    return Layout.getContent(context,
        Center(child: Text('Página de configurações do App', style: TextStyle(color: Layout.info()))));
  }
}
