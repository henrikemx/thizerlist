import 'package:flutter/material.dart';
import '../layout.dart';
import '../widgets/HomeList.dart';
import '../models/Lista.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeListBloc listaBloc = HomeListBloc();

  @override
  void dispose() {
    listaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Map>>(
        stream: listaBloc.lists,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('Carregando...'),
              );
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return HomeList(items: snapshot.data);
              }
          }
        });

    return Layout.getContent(context, content);
  }
}

class HomeListBloc {
  HomeListBloc() {
    getList();
  }

  ModelLista listaBo = ModelLista();

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dispose() {
    _controller.close();
  }

  getList() async {
    _controller.sink.add(await listaBo.list());
  }
}
