import 'dart:async';

import 'package:combustivel/mianScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MainScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 10,
              child: Icon(Icons.local_gas_station, size: 110, color: Colors.amber,)),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 6,
              ),
            )
          ],
        ),
      ),
    ); 
    
  }
}