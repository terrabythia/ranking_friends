import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ranking_friends/database/db.dart';

class IntroPage extends StatefulWidget {

  @override
  _IntroPageState createState() => _IntroPageState();

}

class _IntroPageState extends State<IntroPage> {

  bool _firebaseLoaded = false;
  DatabaseReference _counterRef;

  @override
  void initState() {
    super.initState();

    _initDatabase();
  }

  _initDatabase() async {

    try {
      await instance.createDatabase();
      _counterRef = instance.database.reference().child('counter');
      setState(() {
          _firebaseLoaded = true;
      });
    }
    catch(error) {
      print(error);
    }

  }

  Future<Null> _increment() async {

    final TransactionResult transactionResult =
      await _counterRef.runTransaction((MutableData mutableData) async {
        mutableData.value = (mutableData.value ?? 0) + 1;
        return mutableData;
      });

    if (transactionResult.committed) {
      print('Transaction committed!');
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    // if not loaded return loader
    if (!_firebaseLoaded) {
      return Center(
        child: LinearProgressIndicator(),
      );
    }

    return Material(
      child: Center(
          child: InkWell(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: _increment,
            ),
          )
      ),
    );
  }
}
