import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String operador1 = '';
  String operador2 = '';
  bool somaApertado = false;
  String resultado = '';

  void pressionarBotao(String valor) {
    setState(() {
      if (valor == '+') {
        if (operador1.isNotEmpty) {
          somaApertado = true;
        }
      } else if (valor == '=') {
        if (operador1.isNotEmpty && operador2.isNotEmpty && somaApertado) {
          int res = int.parse(operador1) + int.parse(operador2);
          resultado = res.toString();

          // Imprime no console no formato correto
          print("Operador 1: $operador1");
          print("Operador 2: $operador2");
          print("Soma apertado: ${somaApertado.toString()}");
          print("Resultado: $resultado");

          // Reseta para próxima operação
          operador1 = '';
          operador2 = '';
          somaApertado = false;
        }
      } else {
        if (!somaApertado) {
          operador1 += valor;
          resultado = operador1;
        } else {
          operador2 += valor;
          resultado = operador2;
        }
      }
    });
  }

  Widget criarBotao(String texto) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => pressionarBotao(texto),
          child: Text(
            texto,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                resultado,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Row(children: [criarBotao("7"), criarBotao("8"), criarBotao("9")]),
          Row(children: [criarBotao("4"), criarBotao("5"), criarBotao("6")]),
          Row(children: [criarBotao("1"), criarBotao("2"), criarBotao("3")]),
          Row(children: [criarBotao("0"), criarBotao("="), criarBotao("+")]),
        ],
      ),
    );
  }
}
