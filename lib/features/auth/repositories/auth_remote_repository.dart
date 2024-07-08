import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:vpn_apk/core/failure/app_failure.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, String>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = const Uuid().v4();
      final docRef = FirebaseFirestore.instance.collection("users").doc(uid);
      docRef.set({'name': name});

      debugPrint(response.toString());

      return const Right("Successfully registered user");
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(response);

      return const Right("Successfully logged in");
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
