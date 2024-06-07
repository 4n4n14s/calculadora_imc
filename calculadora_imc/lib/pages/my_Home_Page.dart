import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mensagem = 'calculo do imc';
  TextEditingController tamanho = TextEditingController();
  TextEditingController peso = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('calculadora imc'),
        actions: [
          IconButton(
            onPressed: () {
              _refreshStaus();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Icon(
            Icons.person_outline,
            size: 200,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: tamanho,
              decoration: const InputDecoration(
                labelText: 'tamanho',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: peso,
              decoration: const InputDecoration(
                labelText: 'peso',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(mensagem),
                ElevatedButton(
                    onPressed: () {
                      _calculaImc();
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: const Text('calcular')),
              ],
            ),
          )
        ],
      ),
    );
  }

  _refreshStaus() {
    tamanho.clear();
    peso.clear();
    setState(() {
      mensagem = 'calculo do imc';
    });
  
  }

  _calculaImc() {
    final tamanhoInp = double.tryParse(tamanho.text);
    final pesoInp = double.tryParse(peso.text);

    if (tamanhoInp == null || pesoInp == null) {
      return;
    }

    final imc = pesoInp / (tamanhoInp * tamanhoInp);

    setState(() {
      if (imc < 18.5) {
        mensagem = 'abaixo do peso';
      } else if (imc <= 24.9) {
        mensagem = 'peso normal';
      } else if (imc > 24.9 && imc <= 29.9) {
        mensagem = 'sobrepeso';
      } else if (imc > 29.9 && imc <= 34.9) {
        mensagem = 'obesidade gral I';
      } else if (imc > 34.9 && imc <= 39.9) {
        mensagem = 'obesidade gral II (severa)';
      } else {
        mensagem = 'obesidade gral III (morbida)';
      }
    });
  }
}
