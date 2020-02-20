abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator{
  @override
  bool isValid(String value) {
    // TODO: implement isValid
    return value.isNotEmpty;
  }
}

class PhoneNumberStringValidator implements StringValidator{
  @override
  bool isValid(String value) {
    if (value.length == 10) {
      return true;
    }
    return false;
  }
}

class PhoneNumberValidator {
  final StringValidator phoneNumberValidator = PhoneNumberStringValidator();
  final String invalidPhoneNumberErrorText = 'Please enter valid phone number.';
}

class OtpValidator {
  final StringValidator otpValidator = NonEmptyStringValidator();
  final String invalidOtpErrorText = 'One Time Password cant be empty';
}

class RegisterAccountValidator {
  final StringValidator usernameValidator = NonEmptyStringValidator();
  final String invalidUsernameErrorText = 'Username cant be empty';
}