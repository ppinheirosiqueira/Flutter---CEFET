import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Opcao{
  String texto = "";
  bool resposta = false;

  Opcao(this.texto, [this.resposta = false]);
}

class Pergunta{
  String questao = "";
  List<Opcao> opcoes = [];

  Pergunta(String q, List<Opcao> op){
    questao = q;
    opcoes = op;
  }
}

class _MyAppState extends State<MyApp> {
  String nome = "";
  String idade = "";
  bool iniciouQuiz = false;
  Pergunta? perguntaAtual;
  List<Opcao> opcoesEmbaralhadas = [];
  bool respostaSelecionada = false;
  bool respostaCorreta = false;
  List<Pergunta> perguntasRestantes = [];
  int perguntasRespondidas = 0;
  int perguntasCorretas = 0;

  List<Pergunta> paraMaiores = [
      Pergunta("Quem pintou a Mona Lisa?", [Opcao("Leonardo da Vinci", true), Opcao("Michelangelo"), Opcao("Raphael"), Opcao("Donatello")]),
      Pergunta("Qual é a capital da Austrália?", [Opcao("Sydney"), Opcao("Melbourne"), Opcao("Canberra", true), Opcao("Perth")]),
      Pergunta("Quem foi o primeiro presidente dos Estados Unidos?", [Opcao("George Washington", true), Opcao("Abraham Lincoln"), Opcao("Thomas Jefferson"), Opcao("John Adams")]),
      Pergunta("Qual é a fórmula química da água?", [Opcao("H2O", true), Opcao("CO2"), Opcao("O2"), Opcao("H2")]),
      Pergunta("Qual é o maior planeta do sistema solar?", [Opcao("Júpiter", true), Opcao("Saturno"), Opcao("Marte"), Opcao("Terra")])
  ];

  List<Pergunta> paraMenores = [
      Pergunta("Qual é o animal mais rápido do mundo?", [Opcao("Guepardo", true), Opcao("Leão"), Opcao("Águia"), Opcao("Golfinho")]),
      Pergunta("Qual é a cor do céu durante um dia ensolarado?", [Opcao("Azul", true), Opcao("Verde"), Opcao("Roxo"), Opcao("Amarelo")]),
      Pergunta("Quem é o personagem principal da história 'Cinderela'?", [Opcao("Cinderela", true), Opcao("Bela"), Opcao("Aurora"), Opcao("Branca de Neve")]),
      Pergunta("Quantos lados tem um triângulo?", [Opcao("3", true), Opcao("4"), Opcao("5"), Opcao("6")]),
      Pergunta("Qual é o som que o cachorro faz?", [Opcao("Au au", true), Opcao("Miau"), Opcao("Cócóricó"), Opcao("Piu piu")])
  ];

  void iniciarQuiz() {
    setState(() {
      iniciouQuiz = true;
      if (idade == "maior"){
        perguntasRestantes = List.from(paraMaiores);
      }
      else{
        perguntasRestantes = List.from(paraMenores);
      }
      proximaPergunta();
    });
  }

  void proximaPergunta() {
    if (perguntasRestantes.isEmpty) {
      setState(() {
        if (idade == "maior"){
          idade = "menor";
        }
        else{
          idade = "maior";
        }
        iniciouQuiz = false;
      });
      return;
    }

    perguntaAtual = perguntasRestantes.removeAt(Random().nextInt(perguntasRestantes.length));
    opcoesEmbaralhadas = List.from(perguntaAtual!.opcoes)..shuffle();
    respostaSelecionada = false;
  }

  void responderPergunta(bool resposta) {
    setState(() {
      respostaSelecionada = true;
      respostaCorreta = resposta;
      perguntasRespondidas++;
      if (resposta) {
        perguntasCorretas++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!iniciouQuiz && perguntasRespondidas > 5) {
      return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child:Column(
                children: [
                  Image.asset(
                    'assets/images/quiz.jpg',
                    fit: BoxFit.cover,
                    width: 500,
                    height: 200,
                  ),
                  buildFinal(),
                ],
              ),
            )
          ),
        ),
      );
    }

    if (!iniciouQuiz && perguntasRespondidas > 0) {
      return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child:Column(
                children: [
                  Image.asset(
                    'assets/images/quiz.jpg',
                    fit: BoxFit.cover,
                    width: 500,
                    height: 200,
                  ),
                  buildResultado(),
                ],
              ),
            )
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/quiz.jpg',
                fit: BoxFit.cover,
                width: 500,
                height: 200,
              ),
              if (iniciouQuiz) buildQuiz() else buildInicio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInicio() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(label: Text("Nome")),
          onChanged: (String text) {
            setState(() {
              nome = text;
            });
          },
        ),
        Column(
          children: [
            Row(
              children: [
                Radio(
                  value: "maior",
                  groupValue: idade,
                  onChanged: (value) {
                    setState(() {
                      idade = value!;
                    });
                  },
                ),
                const Text("Maior de Idade"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "menor",
                  groupValue: idade,
                  onChanged: (value) {
                    setState(() {
                      idade = value!;
                    });
                  },
                ),
                const Text("Menor de Idade"),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: iniciarQuiz,
          child: const Text("Entrar"),
        ),
      ],
    );
  }

  Widget buildQuiz() {
    if (perguntaAtual == null) return Container();
    return Column(
      children: [
        Text("Bem-vindo ao quiz, $nome!"),
        Text("Você está fazendo o quiz para ${idade == "maior" ? "maiores" : "menores"} de idade."),
        const SizedBox(height: 20),
        Text(perguntaAtual!.questao),
        Column(
          children: opcoesEmbaralhadas.map((opcao) {
            return ListTile(
              title: Text(opcao.texto),
              leading: respostaSelecionada
                  ? Icon(
                      opcao.resposta ? Icons.check : Icons.close,
                      color: opcao.resposta ? Colors.green : Colors.red,
                    )
                  : null,
              onTap: respostaSelecionada
                  ? null
                  : () {
                      responderPergunta(opcao.resposta);
                    },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: respostaSelecionada
              ? () {
                  setState(() {
                    proximaPergunta();
                  });
                }
              : null,
          child: const Text("Próxima"),
        ),
      ],
    );
  }

  Widget buildResultado() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Resultado",
        ),
        const SizedBox(height: 20),
        Text("$nome, você fez $perguntasCorretas acertos. Experimente responder as questões para ${idade == "maior" ? "maiores de idade" : "menores de idade"}"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (idade == "maior"){
                perguntasRestantes = List.from(paraMaiores);
              }
              else{
                perguntasRestantes = List.from(paraMenores);
              }
              iniciarQuiz();
            });
          },
          child: const Text("Recomeçar"),
        ),
      ],
    );
  }

  Widget buildFinal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Resultado",
        ),
        const SizedBox(height: 20),
        Text("$nome, você fez $perguntasCorretas acertos nos dois Quizes juntos."),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              perguntasCorretas = 0;
              perguntasRespondidas = 0;
              iniciouQuiz = false;
            });
          },
          child: const Text("Voltar ao Início"),
        ),
      ],
    );
  }

}