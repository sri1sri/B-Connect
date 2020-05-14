
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/services/validators.dart';
import 'package:flutter/cupertino.dart';

class PhoneNumberModel with PhoneNumberValidator, ChangeNotifier {
  PhoneNumberModel({
    @required this.auth,
    this.phoneNumber = '',
    this.isLoading = false ,
    this.submitted = false
  });

  final AuthBase auth;

  String phoneNumber;
  bool isLoading;
  bool submitted;

  Future <void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      print('$phoneNumber <- number');
      await auth.verifyPhoneNumber(phoneNumber);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updatePhoneNumber(String phoneNumber) => updateWith(phoneNumber: phoneNumber);

  bool get canSubmit{
    return phoneNumberValidator.isValid(phoneNumber) &&
        !isLoading;
  }

  void updateWith({
    String phoneNumber,
    bool isLoading,
    bool submitted,

  }) {

    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;

    notifyListeners();
  }
}