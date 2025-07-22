import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool telaPronta = false;
  var listaProdutos;

  @override
  void initState() {
    super.initState();
    puxarLista();
  }

void puxarLista() {
    Uri uri = Uri.parse("https://api.json-generator.com/templates/km5tq8Y_NDzy/data?access_token=etqahrml07zjp7uqx4npfer5m0cq8o49i882wpew");

    Future future = http.get(uri);

    future.then((response) {
      if (response.statusCode == 404) {
        print('Página não encontrada');
      } else if (response.statusCode == 500) {
        print('Erro no Servidor');
      } else if (response.statusCode == 200) {
        setState(() {
          listaProdutos = json.decode(response.body) as List;
        });
      }
    }).catchError((error) {
      print('Ocorreu um erro: $error');
    }).whenComplete(() {
      setState(() {
        telaPronta = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: telaPronta ? buildLista() : buildCarregar(),
          ),
        ),
      ),
    );
  }

  Widget buildCarregar() {
    return const Center(child: Text('Carregando'));
  }

  Widget buildLista() { 
    print(listaProdutos.length);
    return ListView.builder(
      itemCount: listaProdutos.length,
      itemBuilder: (context, index) {
        final produto = Produto.fromJson(listaProdutos[index]);
        return ListTile(
          leading: Image.network(produto.imagem, width: 50, height: 50),
          title: Text(produto.descricao),
          trailing: Text(
            'R\$ ${produto.preco.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutoDetalhesScreen(produto: produto),
              ),
            );
          },
        );
      },
    );
  }
}

class Produto{
  String produtoId = 'produtoId', produto  = 'produto', endereco = 'endereco', descricao = 'descricao', imagem = '';
  int quantidade = -1;
  double preco = -1;

  Produto(this.produtoId, this.produto, this.endereco, this.descricao, this.quantidade, this.preco, this.imagem);

  factory Produto.fromJson(Map<String, dynamic> dado) {
    return Produto(dado['produto_id'],dado['produto'],dado['endereco'],dado['descrição'],int.parse(dado['quantidade']),double.parse(dado['preco']),dado['imagem']);
  }

  Map<String, dynamic> toJson() {
    return {
      'produtoId': produtoId,
      'produto': produto,
      'endereco': endereco,
      'descricao': descricao,
      'imagem': imagem,
      'quantidade': quantidade,
      'preco': preco,
    };
  }
}

class ProdutoDetalhesScreen extends StatelessWidget {
  final Produto produto;

  const ProdutoDetalhesScreen({Key? key, required this.produto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.produto),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(produto.imagem),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(produto.descricao),
            const SizedBox(height: 16),
            const Text(
              'Endereço:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(produto.endereco),
            const SizedBox(height: 16),
            const Text(
              'Quantidade:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${produto.quantidade}'),
            const SizedBox(height: 16),
            const Text(
              'Preço:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'R\$ ${produto.preco.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}