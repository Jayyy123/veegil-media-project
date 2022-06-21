import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:veegil_bank_app/src/features/payments/history.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  Map data = {};
  String filter = "All Transactions";
  bool change = false;

  Widget getTextWidgets(List<dynamic> objects)
  {
    return Column(
        children: objects.map((item) => Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: item["type"] == "credit" ?  Colors.blue : Colors.red[400],
                      elevation: 19,
                      borderRadius: BorderRadius.circular(50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: item["type"] == "credit" ?  Colors.blue : Colors.red[400],
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Account no: ",style: TextStyle(fontFamily:'Gotham', fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(item["phoneNumber"],style: TextStyle(fontFamily:'Gotham', fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Amount: ", style: TextStyle(fontFamily:'Gotham', fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                    Text("₦" +item["amount"], style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                  ],
                                ),
                                SizedBox(height: 15.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Type : ",style: TextStyle(fontFamily:'Gotham', fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                    Text(item["type"],style: TextStyle(fontFamily:'Gotham', fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20)),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ))]))
            .toList()
    );
  }

  List<Object> trans = <Map<dynamic, dynamic>>[];


  final TextEditingController _controllerText = TextEditingController();
  Future<History>? _futureAuth;

  @override
  void initState(){
    super.initState();
    _futureAuth = fetchHistory();
  }


  @override
  Widget build(BuildContext context) {

    if(change == true){
      _futureAuth = fetchHistory();
      setState(() {
        change = false;
      });
    }

    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      const SizedBox(width: 50,),
                      Text('Transaction History',style: TextStyle(fontFamily:'Gobold-Thin',color: Colors.indigo[800], fontSize: 28))
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
                  DropdownButton<String>(
                    value: filter,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        filter = newValue!;
                        change = true;
                      });
                    },
                    items: <String>['All Transactions', 'My Transactions' ,'Credit', 'Debit']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 50),

                  buildFutureBuilder()
                ],
              ),
            ),
          ),
        )
    );
  }
  FutureBuilder<History> buildFutureBuilder() {

    return FutureBuilder<History>(
        future: _futureAuth,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("what is happening fam?");
            trans.clear();
            for (var i in snapshot.data!.data) {
              if (filter == 'All Transactions') {
                print("we hereee 1?" + trans.toString());
                trans.add(
                    {
                      "type": i["type"],
                      "amount": i["amount"].toString(),
                      "phoneNumber": i["phoneNumber"],
                    }
                );
                print("we hereee 2?" + trans.toString());
              } else if (filter == "My Transactions") {
                if (i["phoneNumber"] == data["phoneNumber"]) {
                  print("we hereee 1?" + trans.toString());
                  print("we hereee 2?" + trans.toString());
                  trans.add(
                      {
                        "type": i["type"],
                        "amount": i["amount"].toString(),
                        "phoneNumber": i["phoneNumber"],
                      }
                  );
                  print("we hereee 3?" + trans.toString());
                }
              } else if (filter == "Credit" || filter == "Debit") {
                String value = filter == "Credit" ? "credit" : "debit";
                if (i["type"] == value) {
                  print("we hereee 1 c or d?" + trans.toString());
                  print("we hereee 1 c or d?" + trans.toString());
                  trans.add(
                      {
                        "type": i["type"],
                        "amount": i["amount"].toString(),
                        "phoneNumber": i["phoneNumber"],
                      }
                  );
                  print("we hereee 3 c or d?" + trans.toString());
                }
              } else{
                print("okay");
                trans.add(
                    {
                      "type": i["type"],
                      "amount": i["amount"].toString(),
                      "phoneNumber": i["phoneNumber"],
                    }
                );
              }

            }
            return getTextWidgets(trans);

          }else if (snapshot.hasError) {
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
