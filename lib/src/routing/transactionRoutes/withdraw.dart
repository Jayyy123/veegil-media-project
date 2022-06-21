import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:veegil_bank_app/src/features/payments/withdraw.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  Map data = {};

  final TextEditingController _controllerText = TextEditingController();
  Future<Transfer>? _futureAuth;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: (_futureAuth == null ) ? SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                            Icons.arrow_back
                        ),
                      ),
                      const SizedBox(width: 100,),
                      Text('Deposit',style: TextStyle(fontFamily:'Gobold-Thin',color: Colors.indigo[800], fontSize: 32))
                    ],
                  ),
                  const SizedBox(height: 50),

                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 26.5),
                              Image.asset('assets/veegil.png',width: 121.65,height: 83.47),
                              Text('Veegil Media',style: TextStyle(fontFamily:'Gobold-Thin',color: Colors.indigo[800], fontSize: 32))
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Opacity(opacity: 0.09,
                              child: Image.asset('assets/veegil.png', height: 113.0, width: 234.0))
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 14, 45, 31),
                    child: Material(
                        elevation: 18,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text('My Account No: ${data['phoneNumber']}',style: TextStyle(fontFamily:'Gotham',color: Colors.indigo[800], fontWeight: FontWeight.bold ,fontSize: 16)),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 14, 45, 31),
                    child: Material(
                      elevation: 18,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _controllerText,
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
                          hintText: 'Amount',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Expanded(
                            child: Material(
                              elevation: 18,
                              child: ElevatedButton(onPressed:(){
                                setState(() {
                                  _futureAuth = makePayment(data['phoneNumber'], _controllerText.text);
                                });
                              }, style: ElevatedButton.styleFrom(primary: Colors.indigo[800],padding: const EdgeInsets.fromLTRB(19, 25, 19, 25),    shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // <-- Radius
                              ),) ,child: const Text('Withdraw', style: TextStyle(fontFamily:'Gotham',color: Colors.white, fontSize: 20),)),
                            )),
                        const SizedBox(width: 41),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) : buildFutureBuilder()
    );
  }
  FutureBuilder<Transfer> buildFutureBuilder() {

    return FutureBuilder<Transfer>(
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
                          const SizedBox(height: 30.0,),
                          ElevatedButton(onPressed: (){
                            Navigator.pushNamed(context, 'home', arguments: {
                              "phoneNumber":data['phoneNumber'],
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
