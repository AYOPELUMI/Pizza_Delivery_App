import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

class firebaseRepo implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  firebaseRepo({
  FirebaseAuth? firebaseAuth,
  }):_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // TODO: implement user
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if(firebaseUser == null){
        yield MyUser.empty;
      }
      else{
        yield await usersCollection
        .doc(firebaseUser.uid)
        .get()
        .then((value) =>MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }


  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } 
    catch (e) {
      log(e.toString());
      rethrow;
      
    }
  }

    @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    // TODO: implement signUp
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email, 
        password: password
      );

      myUser.userId = user.user!.uid;

      return myUser;
    }
    catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future logOut() async{
    // TODO: implement logOut
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser user) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

}