import 'package:bhavani_connect/auth/authentication_state.dart';
import 'package:bhavani_connect/firebase/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
}

class SubmitPhoneNumber extends AuthenticationEvent {
  final String phoneNumber;
  final bool isNewUser;

  SubmitPhoneNumber({this.phoneNumber, this.isNewUser})
      : super([phoneNumber, isNewUser]);

  @override
  List<Object> get props => [phoneNumber, isNewUser];
}

class VerifyPhoneSuccess extends AuthenticationEvent {
  final String phoneNumber;
  final bool isNewUser;

  VerifyPhoneSuccess({this.phoneNumber, this.isNewUser})
      : super([phoneNumber, isNewUser]);

  @override
  List<Object> get props => [phoneNumber, isNewUser];
}

class VerifyPhoneFailed extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OtpVerifyError extends AuthenticationEvent {
  final Exception ex;

  OtpVerifyError({this.ex});

  @override
  List<Object> get props => throw UnimplementedError();
}

class OtpVerifiedEvent extends AuthenticationEvent {
  final User user;

  OtpVerifiedEvent({this.user});

  @override
  List<Object> get props => throw UnimplementedError();
}

class OtpVerifiedNewUserEvent extends AuthenticationEvent {
  final String phoneNo;

  OtpVerifiedNewUserEvent({this.phoneNo});

  @override
  List<Object> get props => throw UnimplementedError();
}

class OtpVerifyErrorState extends AuthenticationState {
  final Exception ex;

  OtpVerifyErrorState({this.ex});
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SubmitOpt extends AuthenticationEvent {
  final String otp;
  final String phoneNo;
  final bool isNewUser;

  SubmitOpt({this.otp, this.phoneNo, this.isNewUser}) : super([otp, phoneNo, isNewUser]);

  @override
  List<Object> get props => [otp, phoneNo, isNewUser];
}
