import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<History> fetchHistory() async {
  final response = await http
      .get(Uri.parse('https://bank.veegil.com/transactions'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print("\n\nhistory is " + response);
    return History.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load accounts');
  }
}

class History {
  final List<dynamic> data;

  const History({
    required this.data,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      data: json['data'],
    );
  }
}
