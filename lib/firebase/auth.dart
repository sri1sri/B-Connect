import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanges;

  Future<User> currentUser();

  Future<FirebaseUser> firebaseUser();

  Future<User> signInAnonymously();

  Future<void> verifyPhoneNumber(String phoneNumber, {Function success, Function failed});

  Future<User> verifyOtp(String smsCode);

  Future<void> signOut();
}

class AuthFirebase implements AuthBase {
  final FirebaseAuth _firebaseAuth;
  String verificationId;
  String phoneNumberWithCode;

  AuthFirebase({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Stream<User> get onAuthStateChanges {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber, {Function success, Function failed}) async {
    phoneNumberWithCode = '+91' + phoneNumber;

    final PhoneCodeAutoRetrievalTimeout autoRetrieval =
        (String verificationId) {
          this.verificationId = verificationId;
    };

    final PhoneCodeSent smsCodeSent =
        (String verificationId, [int forceCodeResend]) {
          this.verificationId = verificationId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      print('Verified ');
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('${exception.message}');
    };

    print('${this.phoneNumberWithCode} <- phone number');

    await _firebaseAuth
        .verifyPhoneNumber(
      phoneNumber: this.phoneNumberWithCode,
      timeout: Duration(seconds: 60),
      verificationCompleted: success,
      verificationFailed: failed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieval,
    );
  }

  @override
  Future<User> verifyOtp(String smsCode) async {
    final _authCredential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: smsCode);

    final authResult =
        await _firebaseAuth.signInWithCredential(_authCredential);
    print('${authResult.user.uid}<- uid from phone number');
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> firebaseUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }
}
