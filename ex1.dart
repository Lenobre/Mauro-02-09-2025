import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculadora extends StatelessWidget {
  final TextEditingController operador1Controller = TextEditingController();
  final TextEditingController operador2Controller = TextEditingController();

  final ValueNotifier<bool> somaApertado = ValueNotifier<bool>(false);
  final ValueNotifier<String> display = ValueNotifier<String>("");

  void pressionarBotao(String valor) {
    if (valor == '+') {
      somaApertado.value = true;
    } else if (valor == '=') {
      final op1 = operador1Controller.text;
      final op2 = operador2Controller.text;
      final soma = somaApertado.value;
      int resultado = 0;

      if (op1.isNotEmpty && op2.isNotEmpty && soma) {
        resultado = int.parse(op1) + int.parse(op2);
      }

      print("Operador 1: $op1");
      print("Operador 2: $op2");
      print("Soma apertado: ${soma.toString()}");
      print("Resultado: $resultado");

      // Reset
      operador1Controller.clear();
      operador2Controller.clear();
      somaApertado.value = false;
      display.value = '';
    } else {
      if (!somaApertado.value) {
        operador1Controller.text += valor;
        display.value = operador1Controller.text;
      } else {
        operador2Controller.text += valor;
        display.value = operador2Controller.text;
      }
    }
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
          ValueListenableBuilder(
            valueListenable: display,
            builder: (context, value, _) => Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              height: 100,
              child: Text(
                value,
                style: TextStyle(fontSize: 32),
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
