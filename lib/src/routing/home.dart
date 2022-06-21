import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:veegil_bank_app/src/common_widgets/CardClass/CardWidget.dart';
import 'package:veegil_bank_app/src/common_widgets/CardClass/CardClass.dart';
import 'package:http/http.dart';
import 'package:veegil_bank_app/src/features/authentication/accounts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Account> futureAccount;
  Map data = {};

  void getUserAccount() async{
    print("hello");
    Response response = await get(Uri.parse('https://bank.veegil.com/auth/users'));
    print("the response is ===>>"+ (response.body));
    // print(response.body.);
  }



  @override
  void initState(){
    super.initState();
    getUserAccount();
    futureAccount = fetchAccount();
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    print("number is" + " " + data['phoneNumber']);



    final List<Cardd> cardInfo = [
      Cardd('valid until july 30th', 'receive\ndiscount on\nevery\ntransaction!', Colors.lightBlue[100], Colors.white, 'assets/recieve.png'),
      Cardd('valid until july 30th', 'cashback 5%\nfrom each\n transaction', Colors.grey[200], Colors.indigo[200]!, 'assets/ATTRAC_3 1.png'),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 18, 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            const SizedBox(width:18,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 3,
                                        width: 18,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                          width: 13
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 3,
                                    width: 28,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const SizedBox(width: 13,),
                                      Container(
                                        height: 3,
                                        width: 18,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height:31,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        const SizedBox(width:18,),
                        Text("Welcome ${data['phoneNumber']}",style: TextStyle(fontFamily:'Gotham',color: Colors.black, fontSize: 24))
                      ],
                    ),
                    const SizedBox(height:19,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.blue[900],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('Account No        :',style: TextStyle(fontFamily:'Gotham',color: Colors.white70, fontSize: 16)),
                                    const SizedBox(width: 30.0,),
                                    Text(data["phoneNumber"],style: TextStyle(fontFamily:'Gotham',color: Colors.white70, fontSize: 16),)
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  children: [
                                    const Text('Account balance:',style: TextStyle(fontFamily:'Gotham',color: Colors.white70, fontSize: 16)),
                                    const SizedBox(width: 30.0,),
                                    buildFutureBuilder()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                    const SizedBox(height:24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width:18,),
                        Text('Offers', style: TextStyle(fontFamily:'Gotham',color: Colors.black87, fontSize: 20),),
                      ],
                    ),
                    const SizedBox(height:24),
                    CarouselSlider(items: cardInfo.map((cardd) => Material( borderRadius: BorderRadius.circular(10), child: ClipRRect( borderRadius: BorderRadius.circular(10) ,child: card(cardd)))).toList(), options: CarouselOptions(autoPlay: true,height: 261 )),
                    const SizedBox(height:24,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        child: ElevatedButton.icon(onPressed: (){
                          Navigator.pushNamed(context, 'deposit', arguments: {
                            'phoneNumber':data['phoneNumber']
                          });
                        }, icon: const Icon(Icons.add),label: const Text("Deposit Money")),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        child: ElevatedButton.icon(onPressed: (){
                          Navigator.pushNamed(context, 'withdraw', arguments: {
                            'phoneNumber':data['phoneNumber']
                          });
                        }, icon: const Icon(Icons.linear_scale),label: const Text("Withdraw Money")),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        child: ElevatedButton.icon(onPressed: (){
                          Navigator.pushNamed(context, 'transfer', arguments: {
                            'phoneNumber':data['phoneNumber']
                          });
                        }, icon: const Icon(Icons.send),label: const Text("Make Transfer     ")),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        child: ElevatedButton.icon(onPressed: (){
                          Navigator.pushNamed(context, 'history', arguments: {
                            'phoneNumber':data['phoneNumber']
                          });
                        }, icon: const Icon(Icons.notes),label: Text("Transaction History")),
                      ),
                    )
                  ],
                ),
              )
          ),
        )
    );
  }
  FutureBuilder<Account> buildFutureBuilder() {

    return FutureBuilder<Account>(
        future: futureAccount,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String bal;
            for (var i in snapshot.data!.data) {
              if (i['phoneNumber'] == data['phoneNumber']){
                bal = i['balance'].toString();
                return Text("₦ "+ bal, style: const TextStyle(color: Colors.white, fontSize: 19));
              }
            }

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
