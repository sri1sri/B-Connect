import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
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

  SubmitOpt({this.otp}) : super([otp]);

  @override
  List<Object> get props => [otp];
}

class SubmitPhoneNumber extends AuthenticationEvent {
  final String phoneNumber;
  final bool isNewUser;

  SubmitPhoneNumber({this.phoneNumber, this.isNewUser})
      : super([phoneNumber, isNewUser]);

  @override
  List<Object> get props => [phoneNumber, isNewUser];
}
