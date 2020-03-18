import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thizerlist/layout.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static String tag = 'about-page';

  Container theLogoThizer = Container(
      child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.asset(
      'assets/images/thizer-logo.png',
      scale: 2.0,
      width: 150,
    ),
  ));

  Container linkThizer = Container(
    width: 180,
    child: RaisedButton(
        color: Layout.info(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.externalLinkAlt, color: Colors.white, size: 20),
            SizedBox(width: 15),
            Text(
              'www.thizer.com',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        onPressed: () {
        String url = 'https://www.thizer.com';
        canLaunch(url).then((bool status) {
          if (status) {
            launch(url);
          } else {
            Scaffold.of(Layout.scaffoldContext).showSnackBar(SnackBar(
                content: Text('Sem conexão com o servidor'), duration: Duration(seconds: 5)));
          }
        });
        }),
  );

  Container linkYoutube = Container(
    width: 180,
    child: RaisedButton(
      color: Layout.danger(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.youtube, color: Colors.white, size: 15),
          SizedBox(width: 15),
          Text('Thizer no Youtube',
              style: TextStyle(
                color: Colors.white,
              ))
        ],
      ),
      onPressed: () {
        String url = 'https://www.youtube.com/channel/UCwoZZYTjG-RsvaQZVTyc_5w';
        canLaunch(url).then((bool status) {
          if (status) {
            launch(url);
          } else {
            Scaffold.of(Layout.scaffoldContext).showSnackBar(SnackBar(
                content: Text('Sem conexão com o servidor'), duration: Duration(seconds: 5)));
          }
        });
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Layout.getContent(
        context,
        Center(
            child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Text(
                'ThizerList',
                style:
                    TextStyle(fontSize: 22, color: Layout.primary(), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              'Listas de compras',
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Aplicativo desenvolvido por: '),
            ),
            SizedBox(height: 10),
            Center(child: theLogoThizer),
            SizedBox(height: 20),
            Column(
              children: <Widget>[linkThizer, SizedBox(height: 5), linkYoutube],
            ),
          ],
        )));
  }
}
