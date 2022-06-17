import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masked_text_field/masked_text_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _gasController = TextEditingController();
  TextEditingController _etlController = TextEditingController();

  bool _cardRst = true;
  bool _corGasEtl = true;
  String _resultado = '';
  String _preco = '';
  String _percentual = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 255, 255, 255),
      body: Center(
          child: _cardRst
              ? Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(
                    horizontal: 28,
                  ),
                  elevation: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Saiba qual a melhor opção ',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      Text(
                        'de abastecimento do seu carro',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text('Digite o preço do litro'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaskedTextField(
                          textFieldController: _gasController,
                          mask: 'x.xxxx',
                          maxLength: 5,
                          inputDecoration: InputDecoration(
                              labelText: 'Gasolina',
                              hintText: '0.000',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,onChange: (String value) {  },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaskedTextField(
                          textFieldController: _etlController,
                          mask: 'x.xxxx',
                          maxLength: 5,
                          inputDecoration: InputDecoration(
                              labelText: 'Etanol',
                              hintText: '0.000',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,onChange: (String value) {  },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            elevation: 7,
                            color: Colors.amber,
                            onPressed: Calcular,
                            child: Text(
                              'Calcular',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 35,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Abasteça com:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          _resultado,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: _corGasEtl ? Colors.orange : Colors.green),
                        ),
                        Text(
                          _percentual,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _corGasEtl ? Colors.orange : Colors.green),
                        ),
                        Text(
                          _preco,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _corGasEtl ? Colors.orange : Colors.green),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: RaisedButton(
                            color: Colors.amber,
                            onPressed: () {
                              setState(() {
                                _etlController = new TextEditingController();
                                _gasController = new TextEditingController();
                                _cardRst = true;
                              });
                            },
                            child: Text('Calcular Novamente'),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  Calcular() {
    double etl = double.parse(_etlController.text) / 100;
    double gas = double.parse(_gasController.text) / 100;
    double rslt = etl / gas;

    double resultado = (gas - etl) * 100;
    double percentual = rslt * 100;

    setState(() {
      _percentual =
          'Você economizou $percentual%'.replaceAll(RegExp(r'[0-9]{4}'), '');
      _preco =
          'Economia de \$$resultado'.replaceAll(RegExp(r'[0-9]{3}'), '');
    });

    setState(() {
      if (rslt >= 0.7) {
        _resultado = 'Gasolina';
        _corGasEtl = false;
        _cardRst = false;
      } else {
        _resultado = 'Etanol';
        _corGasEtl = true;
        _cardRst = false;
      }
    });

    print(rslt);
  }
}
