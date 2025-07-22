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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:const Center(child: Text('Vasco da Gama', style: TextStyle(color: Colors.white, fontSize: 30))),
                       backgroundColor: Colors.black,),
        body: Image.asset('assets/images/vasco.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity,)
      )
    );
  }
}

// const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Center(child: Text('Coluna 1')),
//             Center(child: Text('Coluna 2')),
//             Center(child: Text('Coluna 3')),
//           ],
//         )

// body: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(child: Text('Coluna 1')),
//             Center(child: Text('Coluna 2')),
//             Center(child: Text('Coluna 3')),
//           ],
//         ) 


// body: Stack(
        //   fit: StackFit.loose,
        //   alignment: Alignment.topCenter,
        //   children: [
        //     Container(width: 150,
        //               height: 150,
        //               color: Colors.yellow),
        //     Container(width: 50,
        //               height: 50,
        //               color: Colors.blue),
        //   ],
        // )