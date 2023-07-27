import 'package:formz/formz.dart';

class LoginFormState with FormzMixin {
  LoginFormState({
    Mobile? mobile,
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : mobile = mobile ?? Mobile.pure();

  final Mobile mobile;
  final Password password;
  final FormzSubmissionStatus status;

  LoginFormState copyWith({
    Mobile? mobile,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return LoginFormState(
      mobile: mobile?? this.mobile,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
  @override
  List<FormzInput<dynamic,dynamic>> get inputs => [mobile,password];
}

enum MobileValidationError { invalid }
class Mobile extends FormzInput<String,MobileValidationError> with FormzInputErrorCacheMixin {
  Mobile.pure([super.value = '']) : super.pure();
  Mobile.dirty([super.value = '']) : super.dirty();

  static final _mobileRegExp = RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$");

  @override
  MobileValidationError? validator(String value) {
    return _mobileRegExp.hasMatch(value) ? null : MobileValidationError.invalid;
  }

}

enum PasswordValidationError{ invalid }
class Password extends FormzInput<String, PasswordValidationError>{
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  /* 由字母 数字 特殊字符 至少6位 */
  static final _passwordRegex = RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^\da-zA-Z\s]).{6,26}$");

  @override
  PasswordValidationError? validator(String value) {
    // TODO: implement validator
    return _passwordRegex.hasMatch(value) ? null : PasswordValidationError.invalid;
  }

}

extension on MobileValidationError {
  String text(){
    switch(this){
      case MobileValidationError.invalid:
        return "请输入正确的手机号";
    }
  }
}

extension on PasswordValidationError {
  String text(){
    switch(this) {
      case PasswordValidationError.invalid:
        return "由字母 数字 特殊字符 至少6位字符组成的密码";
    }
  }
}




