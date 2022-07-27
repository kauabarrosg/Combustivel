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
  Color _color = Color(0xffFFA500);
  Color _color2 = Color(0xff008000);

  bool _cardRst = true;
  bool _corGasEtl = true;
  bool _title = true;
  String _resultado = '';
  String _preco = '';
  String _percentual = '';
  String _informacao = '';

  _AppBar() {
    return AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _color,
        title: _title
            ? const Text(
                'Gasolina ou Alcool',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )
            : const Text(
                'Resultado',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      backgroundColor: _color,
      body: Center(
          child: SingleChildScrollView(
        child: _cardRst
            ? Card(
                elevation: 9,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text('Saiba qual a melhor opção de combustivel',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      const Text(' para abastecer seu carror',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                          Text(
                        'Utilize "." para preencher os campos',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _gasController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Gasolina',
                              hintText: '0.000',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, color: _color),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _etlController,
                          decoration: InputDecoration(
                              labelText: 'Alcool',
                              hintText: '0.000',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _color2,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: _color,
                          onPressed: Calcular,
                          child: Container(
                            width: 120,
                            height: 40,
                            child: const Center(
                                child: Text(
                              'Calcular',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ))
                    ],
                  ),
                ),
              )
            : Card(
                elevation: 9,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Melhor opção:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Text(
                        _resultado,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _corGasEtl ? _color : _color2),
                      ),
                      Text(
                        _percentual,
                        style: TextStyle(
                            fontSize: 16, color: _corGasEtl ? _color : _color2),
                      ),
                      Text(
                        _preco,
                        style: TextStyle(
                            fontSize: 16, color: _corGasEtl ? _color : _color2),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: _color,
                          onPressed: CalcularNovamente,
                          child: Container(
                            width: 120,
                            height: 40,
                            child: const Center(
                                child: Text(
                              'Calcular novamente',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                            )),
                          ))
                    ],
                  ),
                )),
      )),
    );
  }

  CalcularNovamente() {
    setState(() {
      _etlController = new TextEditingController();
      _gasController = new TextEditingController();
      _cardRst = true;
      _title = true;
    });
    print(_cardRst);
  }

  Calcular() {
    double etl = double.parse(_etlController.text) / 100;
    double gas = double.parse(_gasController.text) / 100;
    double rslt = etl / gas;

    double resultado = (gas - etl) * 100;
    double percentual = rslt * 100;

    setState(() {
      if (etl == null || gas == null) {
        _informacao = 'preencha o campo utilizando  "."';
      }
    });

    setState(() {
      _percentual = 'Economia de ${percentual.truncateToDouble()}%';
      _preco = ('Economia de \$${resultado.toDouble()}');
      _title = false;
    });

    setState(() {
      if (rslt >= 0.7) {
        _resultado = 'Gasolina';
        _corGasEtl = true;
        _cardRst = false;
      } else {
        _resultado = 'Alcool';
        _corGasEtl = false;
        _cardRst = false;
      }
    });

    print(rslt);
    print(_cardRst);
  }
}
