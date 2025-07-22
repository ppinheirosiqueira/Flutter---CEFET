import 'package:flutter/material.dart';
import 'homepage.dart';
import 'profile.dart';
import 'settings.dart';

main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int itemSelecionado = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'HomePage': (content) => HomePage(),
        'Settings': (content) => Settings(),
        'Profile': (content) => Profile(),
      },
      home: Scaffold(
        appBar: AppBar(title: Text("Navegação"),backgroundColor: Colors.blue[700],),
        body: IndexedStack(
          index: itemSelecionado,
          children: <Widget>[
            HomePage(),
            Settings(),
            Profile()
        ]),
        drawer: Builder(
          builder: (context) {
            return Drawer(child: Column(children: [
              ListTile(onTap: (){
                setState(() {
                  Navigator.pushNamed(context, 'HomePage');
                });
              }, leading: Icon(Icons.attach_money, color: Colors.red),title: Text("Financeiro"), subtitle: Text('Consulte seu extrato'),),
              ListTile(onTap: (){
                setState(() {
                  Navigator.pushNamed(context, 'Settings');
                });
              }, leading: Icon(Icons.house, color: Colors.red),title: Text("Casa"), subtitle: Text('Móveis a venda'),),
              SizedBox(height:100),
              Text("Produzido por Pedro Pinheiro"),
            ],));
          }
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, 
          currentIndex: itemSelecionado,
          backgroundColor: Colors.blue[700],
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (opcao){
            setState(() {
              itemSelecionado = opcao;
            });
          },
          items:[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Página Inicial'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Jogos'),
          BottomNavigationBarItem(icon: Icon(Icons.ballot), label: 'Campeonatos')]),
      ),
    );
  }
}