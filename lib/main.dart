import 'package:flutter/material.dart';
import 'package:veegil_bank_app/src/routing/Signin.dart';
import 'package:veegil_bank_app/src/routing/home.dart';
import 'package:veegil_bank_app/src/routing/signup.dart';
import 'package:veegil_bank_app/src/routing/splash.dart';
import 'package:veegil_bank_app/src/routing/transactionRoutes/deposit.dart';
import 'package:veegil_bank_app/src/routing/transactionRoutes/transactionHistory.dart';
import 'package:veegil_bank_app/src/routing/transactionRoutes/transfer.dart';
import 'package:veegil_bank_app/src/routing/transactionRoutes/withdraw.dart';

void main() {
  runApp(MaterialApp(
    title: "",
    routes: {
      '/':(context) => const Splash(),
      'signup':(context) => const Signup(),
      'signin':(context) => const Signin(),
      'home':(context) => const Home(),
      'transfer':(context) => const TransferScreen(),
      'withdraw':(context) => const WithdrawScreen(),
      'deposit':(context)=> const DepositScreen(),
      'history':(context) => const TransactionHistoryScreen(),
    },
  ));
}
