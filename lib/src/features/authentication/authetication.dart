import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authentication {
  final String status;
  final String message;

  const Authentication({required this.status, required this.message});

  factory Authentication.fromJson(Map<String, dynamic> json) {

    return Authentication(
      status: json['status'],
      message: json['message'],
    );
  }
}


Future<Authentication> createUser(String phoneNumber ,String password ) async {
  final response = await http.post(
    Uri.parse('https://bank.veegil.com/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phoneNumber': phoneNumber,
      'password':password
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("The response is in success and it is ${response.body}");
    return Authentication.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create account. ${response.statusCode}');
  }
}
