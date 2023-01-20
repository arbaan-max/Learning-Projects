import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/login_register_page.dart';

import 'auth.dart';

class Verifier extends StatefulWidget {
  const Verifier({Key? key}) : super(key: key);

  @override
  State<Verifier> createState() => _VerifierState();
}

class _VerifierState extends State<Verifier> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}


