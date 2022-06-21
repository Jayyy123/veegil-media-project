import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veegil_bank_app/src/features/authentication/authetication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:veegil_bank_app/src/routing/home.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController _controllerText = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  Future<Authentication>? _futureAuth;
  //07060942704
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body:  (_futureAuth == null) ? SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 126.5),
                            Image.asset('assets/veegil.png',width: 121.65,height: 83.47),
                            Text('Veegil Media',style: TextStyle(fontFamily:'Gobold-Thin',color: Colors.indigo[800], fontSize: 32))
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Opacity(opacity: 0.09,
                        child: Image.asset('assets/veegil.png', height: 313.0, width: 234.0))
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Text('Create new account',style: TextStyle(fontFamily:'Gotham',color: Colors.black, fontSize: 20)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 14, 45, 31),
                  child: Material(
                    elevation: 18,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      controller: _controllerText,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.fromLTRB(15, 24, 0, 25),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        disabledBorder:const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0)
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        hintText: 'Phone number',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 45, 31),
                  child: Material(
                    elevation: 18,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _controllerPass,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(15, 24, 0, 25),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                          child: Material(
                            elevation: 18,
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                _futureAuth = createUser(_controllerText.text,_controllerPass.text);
                              });
                            }, style: ElevatedButton.styleFrom(primary: Colors.indigo[800],padding: const EdgeInsets.fromLTRB(19, 25, 19, 25),    shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // <-- Radius
                            ),) ,child: const Text('Sign up', style: TextStyle(fontFamily:'Gotham',color: Colors.white, fontSize: 20),)),
                          )),
                      const SizedBox(width: 41),
                    ],
                  ),
                ),
                const Text('• Or sign up with -',style: TextStyle(fontFamily:'Gotham',color: Colors.black, fontSize: 16),),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 9,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 99,
                        height: 63,
                        padding: const EdgeInsets.fromLTRB(28, 12, 25, 9),
                        child: Image.asset('assets/verve.webp',width: 29,height: 29,),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Material(
                      elevation: 9,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 99,
                        height: 63,
                        padding: const EdgeInsets.fromLTRB(28, 15, 25, 9),
                        child: Image.asset('assets/visa.png',width: 29,height: 29),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Material(
                      elevation: 9,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 99,
                        height: 63,
                        padding: const EdgeInsets.fromLTRB(28, 15, 25, 9),
                        child: Image.asset('assets/master.png',width: 29,height: 29,),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ) : buildFutureBuilder()
    );
  }

  FutureBuilder<Authentication> buildFutureBuilder() {

    return FutureBuilder<Authentication>(
      future: _futureAuth,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return SafeArea(child: Center(
              child: Container(
                color: Colors.blue[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                    Text(snapshot.data!.message, style: const TextStyle(color: Colors.white, fontSize: 24, fontFamily:'Gobold-Thin')),
                    SizedBox(height: 30.0,),
                    ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, 'home', arguments: {
                        "phoneNumber":_controllerText.text,
                      });
                    }, child: const Text(
                      "Continue ➡", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily:'Gotham')
                    ),)
            ],
          ),
                  ],
                ),
              )));
        } else if (snapshot.hasError) {
          return SafeArea(child: Center(child: Text('${snapshot.error}')));
        }

        return SafeArea(
          child: Center(
            child: Container(
              color: Colors.blue[900],
              child: const SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        );
      }
    );
  }
}




