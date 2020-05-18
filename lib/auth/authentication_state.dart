import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}

class Verified extends AuthenticationState {}

class OtpVerified extends AuthenticationState {}

class PhoneNumberVerified extends AuthenticationState {
  final String phoneNumber;
  final bool isNewUser;

  PhoneNumberVerified({this.phoneNumber, this.isNewUser});
}

class PhoneNumberVerifyFailed extends AuthenticationState {}

class UnVerified extends AuthenticationState {}

class OtpStateLoading extends AuthenticationState {}

class PhoneNumberLoading extends AuthenticationState {}
