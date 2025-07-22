// Exercício 1 - Pedro Pinheiro de Siqueira
// 
// 1- Descrever:
// a) Widget:
// É um componente visual do flutter.
// 
// b) Stateless Widget e os passos de criação de um:
// Stateless Widget é um widget que não é alterado em tela, ou seja, a partir do momento que ele é renderizado, manterá aquela forma até sair de cena
// Para criar um stateless Widget basta criar um widget que extenda a classe StatelessWidget, retornando obviamente um componente flutter que nós desejamos.
//
// c) Stateful Widget e os passos de criação de um:
// Stateful Widget, ao contrário do anterior, é um widget que permite alterações de estados. Ou seja, são os componentes que o usuário consegue interagir.
// Para criar um Stateful Widget é simples, basta criar um widget que extenda a classe StatefulWidget. No entanto, ao contrário do anterior, para utilizá-lo
// não basta retornar um material. É necessário retornar um State, que extende State com <nome do seu widget stateful>, e esse state que conterá as partes que
// possuem interação com o usuário.

import 'package:flutter/material.dart';

main(){
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Relógio | Calendário'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(child: MyDate()),
      ),
    );
  }
}

class MyDate extends StatefulWidget {
  const MyDate({super.key});

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate>{
  int modoAtual = 1;
  void mudarModo(){
    setState(() {
      modoAtual = modoAtual + 1;
      if (modoAtual == 4){
        modoAtual = 1;
      }
    });
  }
  String mostrar(){
    DateTime now = DateTime.now();
    if (modoAtual == 1){
      String convertedDateTime = "${now.day.toString().padLeft(2,'0')}-${now.month.toString().padLeft(2,'0')}-${now.year.toString()}";
      return convertedDateTime;
    }
    if (modoAtual == 2){
      String convertedDateTime = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}';
      return convertedDateTime;
    }
    String convertedDateTime = "${now.day.toString().padLeft(2,'0')}-${now.month.toString().padLeft(2,'0')}-${now.year.toString()} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}";
    return convertedDateTime;
  }
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: GestureDetector(
          onTap:() => {
            mudarModo()
          },
          child: Text(mostrar(), textDirection: TextDirection.ltr,),
        )
      )
    );
  }
}