import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Account> fetchAccount() async {
  final response = await http
      .get(Uri.parse('https://bank.veegil.com/auth/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Account.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load accounts');
  }
}

class Account {
  final List<dynamic> data;

  const Account({
    required this.data,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      data: json['data'],
    );
  }
}
