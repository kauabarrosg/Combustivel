import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  var mask = MaskTextInputFormatter(mask: '#.###');
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
                'Gasolina ou Álcool',
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
          child: _cardRst
              ? Card(
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('Saiba qual a melhor opção de combustível',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          const Text(' para abastecer seu carro',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              inputFormatters: [mask],                              
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
                              inputFormatters: [mask],                           
                              keyboardType: TextInputType.number,
                              controller: _etlController,
                              decoration: InputDecoration(
                                  labelText: 'Álcool',
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
                  ))),
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
      _percentual = 'Economia de ${percentual.truncateToDouble()}%';
      _preco = ('Economia de \$${resultado.truncateToDouble()}');
      _title = false;
    });

    setState(() {
      if (rslt >= 0.7) {
        _resultado = 'Gasolina';
        _corGasEtl = true;
        _cardRst = false;
      } else {
        _resultado = 'Álcool';
        _corGasEtl = false;
        _cardRst = false;
      }
    });

    print(rslt);
    print(_cardRst);
  }
}
