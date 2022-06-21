import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String intro = "Veegil Bank";
  bool effect = false;

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 2), (){
      setState(() {
        intro = "The bank that helps you save";
      });
    });
    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacementNamed(context, 'signin');
    });

    return Scaffold(
      backgroundColor: Colors.indigo[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/veegil.png',width: 121.65,height: 83.47)),
          const SizedBox(height: 15.0,),
           Center(child: Text(intro, style: TextStyle(fontFamily:'Gobold-Thin',color: Colors.white, fontSize: 28)))
        ],
      ),
    );
  }
}
