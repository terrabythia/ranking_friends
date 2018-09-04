import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class _FirebaseDatabase {

  FirebaseApp _firebaseApp;
  FirebaseDatabase _firebaseDb;

  createDatabase() async {

    // TODO: move configuration to config file
    _firebaseApp = await FirebaseApp.configure(
      name: 'ranking-friends',
      options: Platform.isIOS
          ? const FirebaseOptions(
            googleAppID: '1:135470733544:ios:0cc5996819480167',
            databaseURL: 'https://ranking-your-friends.firebaseio.com',
            bundleID: 'eu.sndr.rankingFriends',
          )
          : const FirebaseOptions(
            googleAppID: '1:135470733544:ios:0cc5996819480167',
            apiKey: 'AIzaSyA49O_HneixwhWzrZAM6x2XK0B6WmFeO4A',
            databaseURL: 'https://ranking-your-friends.firebaseio.com',
            bundleID: 'eu.sndr.rankingfriends',
          ),
    );

    _firebaseDb = new FirebaseDatabase(app: _firebaseApp);
    _firebaseDb.setPersistenceEnabled(false);
//    _firebaseDb.setPersistenceCacheSizeBytes(10000000);

  }

  FirebaseApp get app => _firebaseApp;
  FirebaseDatabase get database => _firebaseDb;

}

_FirebaseDatabase instance = _FirebaseDatabase();