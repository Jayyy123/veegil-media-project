import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transfer {
  final String status;
  final String message;

  const Transfer({required this.status, required this.message});

  factory Transfer.fromJson(Map<String, dynamic> json) {

    return Transfer(
      status: json['status'],
      message: json['message'],
    );
  }
}


Future<Transfer> makePayment(String phoneNumber ,String amount ) async {
  final response = await http.post(
    Uri.parse('https://bank.veegil.com/accounts/transfer'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phoneNumber': phoneNumber,
      'amount':amount
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("The response is in success and it is ${response.body}");
    return Transfer.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create account. ${response.statusCode}');
  }
}
