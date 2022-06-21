import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAuthentication {
  final String status;
  final String message;

  const LoginAuthentication({required this.status, required this.message});

  factory LoginAuthentication.fromJson(Map<String, dynamic> json) {

    return LoginAuthentication(
      status: json['status'],
      message: json['message'],
    );
  }
}


Future<LoginAuthentication> findUser(String phoneNumber ,String password ) async {
  final response = await http.post(
    Uri.parse('https://bank.veegil.com/auth/login'),
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
    print("\n\nThe response is in success and it is ${response.body}");
    return LoginAuthentication.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to find account. ${response.statusCode}');
  }
}
