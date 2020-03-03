
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:bhavani_connect/services/validators.dart';
import 'package:flutter/cupertino.dart';

class OtpModel with OtpValidator, ChangeNotifier {
  OtpModel({
    @required this.auth,
    this.otp = '',
    this.isLoading = false ,
    this.submitted = false
  });

  final AuthBase auth;

  String otp;
  bool isLoading;
  bool submitted;

  Future <void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      print('${otp} <- number');
      await auth.verifyOtp(otp);
    } catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateOtp(String Otp) => updateWith(Otp: Otp);

  bool get canSubmit{
    return otpValidator.isValid(otp) &&
        !isLoading;
  }

  void updateWith({
    String Otp,
    bool isLoading,
    bool submitted,

  }) {

    this.otp = Otp ?? this.otp;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;

    notifyListeners();
  }
}