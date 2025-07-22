import 'package:flutter/material.dart';

main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String resultado = '';
  String valor1 = '';
  String valor2 = '';
  String equacao = '';
  bool primeiro = true;
  void alterarResultado(igual){
    setState(() {
      if (igual){
      int aux1 = int.parse(valor1);
      int aux2 = 0;
      if (!primeiro){
        aux2 = int.parse(valor2);
      }
      int aux3 = 0;
      double aux4 = 0;
      if (equacao == "+"){
        aux3 = aux1 + aux2;
      }
      else if(equacao == "-"){
        aux3 = aux1 - aux2;
      }
      else if(equacao == 'x'){
        aux3 = aux1 * aux2;
      }
      else if(equacao == '/'){
        aux4 = aux1 / aux2;
      }
      else{
        aux3 = aux1;
      }
      if (equacao == '/'){
        resultado = aux4.toString();
      }
      else{ 
        resultado = aux3.toString();
      }
      valor1 = '';
      valor2 = '';
      equacao = '';
      return;
    }
    resultado = '';
    primeiro = true;
    equacao = '';
    valor1 = '';
    valor2 = '';
    });
  }
  void deletarUltimo(){
    setState(() {
    if (primeiro){
      valor1 = valor1.substring(0, valor1.length - 1);
      resultado = valor1;
    }
    else{
      valor2 = valor2.substring(0, valor2.length - 1);
      resultado = valor2;
    }
    });
  }
  void attValores(valor){
    setState(() {
    if (equacao.length == 1){
      primeiro = false;
    }
    if (primeiro){
      valor1 = valor1 + valor;
      resultado = valor1;
    }
    else{
      valor2 = valor2 + valor;
      resultado = valor2;
    } 
    });
  }
  void attEquacao(valor){
    setState(() {
    if (!primeiro){
      resultado = "ERRO";
      return;
    }
    equacao = valor;
    resultado = valor;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:const Center(child: Text('Calculadora', style: TextStyle(color: Colors.black, fontSize: 60))),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Text(resultado, textAlign: TextAlign.right, textDirection: TextDirection.ltr, style: const TextStyle(color: Colors.white, fontSize: 48, backgroundColor: Colors.black))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap:() => alterarResultado(false),
                    child: const Text('AC', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  const Text('', textDirection: TextDirection.ltr,),
                  GestureDetector(
                    onTap: () => deletarUltimo(),
                    child: const Text('<-', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attEquacao('/'),
                    child: const Text('/', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => attValores('7'),
                    child: const Text('7', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('8'),
                    child: const Text('8', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('9'),
                    child: const Text('9', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attEquacao('x'),
                    child: const Text('x', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                ],
            ),            
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => attValores('4'),
                    child: const Text('4', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('5'),
                    child: const Text('5', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('6'),
                    child: const Text('6', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attEquacao('-'),
                    child: const Text('-', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                ],
            ),            
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => attValores('1'),
                    child: const Text('1', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('2'),
                    child: const Text('2', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attValores('3'),
                    child: const Text('3', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  GestureDetector(
                    onTap: () => attEquacao('+'),
                    child: const Text('+', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                ],
            ),            
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(child: const Text('0', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)),
                  const Text('', textDirection: TextDirection.ltr,),
                  const Text('', textDirection: TextDirection.ltr,),
                  GestureDetector(
                      onTap:() => alterarResultado(true),
                      child:const Text('=', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 48),)
                  )
                ],
            ),
          ],
        ) 
      )
    );
  }
}