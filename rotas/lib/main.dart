import 'package:flutter/material.dart';

main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark,
                      primaryColor: Colors.purple,
                      fontFamily: 'Fantasy'),
      initialRoute: '/',
      routes: {
        '/':(context) => Tela1(),
        'tela2':(context) => Tela2(),
        'tela3':(context) => Tela3(),
        }
      );
  }
}

class Cliente{
  int id;
  String nome;
  Cliente(this.id, this.nome);
}

class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    int valor = 1;
    return Scaffold(appBar: AppBar(title: const Text('Tela 01'), 
                                  backgroundColor: Colors.blue,),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Hello World", style: TextStyle(
                                                              fontFamily: 'Fantasy',
                                                              fontSize: 50, 
                                                              fontStyle: FontStyle.italic, 
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: FontWeight.bold,
                                                              color: const Color.fromARGB(255, 90, 176, 246),
                                                              backgroundColor: const Color.fromARGB(255, 234, 111, 103),
                                                              )),
                          ElevatedButton(child: const Text('Tela 2'),
                            onPressed: (){
                              Navigator.pushNamed(context, 'tela2', arguments: Cliente(valor, "Pedro"));
                              valor++;
                            },),
                            ElevatedButton(child: const Text('Tela 3'),
                            onPressed: () => {
                              Navigator.pushNamed(context, 'tela3')
                            },),
                      ],)
                    ));
  }
}

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    final Cliente pessoa = ModalRoute.of(context)?.settings.arguments as Cliente; 
    return Scaffold(appBar: AppBar(title: Text('ID: ${pessoa.id} - ${pessoa.nome}'), 
                                  backgroundColor: Colors.red,),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(child: const Text('Voltar'),
                            onPressed: () => {
                              Navigator.pop(context)
                            },),
                            ElevatedButton(child: const Text('Tela 3'),
                            onPressed: () => {
                              Navigator.pushNamed(context, 'tela3')
                            },),
                      ],)
                    ));
  }
}

class Tela3 extends StatelessWidget {
  const Tela3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Tela 03'), 
                                  backgroundColor: Colors.green,),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(child: const Text('Tela 1'),
                            onPressed: () => {
                              Navigator.pushNamed(context, '/')
                            },),
                            ElevatedButton(child: const Text('Tela 2'),
                            onPressed: () => {
                              Navigator.pushNamed(context, 'tela2')
                            },),
                          ElevatedButton(child: const Text('Voltar'),
                            onPressed: () => {
                              Navigator.pop(context)
                            },),
                      ],)
                    ));
  }
}

