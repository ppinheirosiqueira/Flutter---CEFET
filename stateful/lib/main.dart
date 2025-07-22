import 'package:flutter/material.dart';

main(){
  runApp(const MyApp(nome:'João'));
}

class MyApp extends StatefulWidget {
  final String nome; 
  const MyApp({super.key,this.nome=''});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int salario = 1000;
  void aumentarSalario(int valor){
    setState(() {
      salario = salario + valor;
    });
  }
  void diminuirSalario(int valor){
    setState(() {
      salario = salario - valor;
      if (salario < 0){
        salario = 0;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: GestureDetector(
          onTap:() => {
            aumentarSalario(100)
          },
          onDoubleTap: () => {
            diminuirSalario(1000)
          },
          child: Text('O salário do ${widget.nome} é: R\$ $salario', textDirection: TextDirection.ltr,),
        )
      )
    );
  }
}