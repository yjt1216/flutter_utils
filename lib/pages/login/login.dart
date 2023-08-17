import 'package:flutter/material.dart';
import 'package:flutter_utils/components/log/console_print.dart';
import 'package:flutter_utils/components/log/log_config.dart';
import 'package:flutter_utils/components/log/log_manager.dart';
import 'package:flutter_utils/components/log/log_util.dart';
import 'package:flutter_utils/components/tab_bar/tab_bar.dart';
import 'package:flutter_utils/pages/login/login_form.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }

}
class _LoginState extends State<LoginPage> {

  final _key = GlobalKey<FormState>();
  late LoginFormState _state;
  late final TextEditingController _mobileController;
  late final TextEditingController _passwordController;

  void _onMobileChanged(){
    setState(() {
      _state = _state.copyWith(mobile: Mobile.dirty(_mobileController.text));
    });
  }

  void _onPasswordChanged(){
    setState(() {
      _state = _state.copyWith(password: Password.dirty(_passwordController.text));
    });
  }

  Future<void> _onSubmit() async {
    if(!_key.currentState!.validate()) return;
    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });
    try{
      await _submitForm();
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
    } catch (_){
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
    }
    if(!mounted) return;
    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    const successSnackBar = SnackBar(content: Text('Submitted successfully!'));
    const failureSnackBar = SnackBar(content: Text('something went wrong...'));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_state.status.isSuccess ? successSnackBar : failureSnackBar);

    if(_state.status.isSuccess) _resetForm();

  }
  Future<void> _submitForm() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    Get.off(()=>PersistentTabBarPage(menuScreenContext: context,));
  }
  void _resetForm(){
    _key.currentState!.reset();
    _mobileController.clear();
    _passwordController.clear();
    setState(() {
      _state = LoginFormState();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state = LoginFormState();
    _mobileController = TextEditingController(text: _state.mobile.value)
      ..addListener(() {
        _onMobileChanged();
      });
    _passwordController = TextEditingController(text: _state.password.value)
      ..addListener(() {
        _onPasswordChanged();
      });







  }
  @override
  void dispose() {
    // TODO: implement dispose
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _mobileController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person_pin),
              labelText: 'Phone',
              helperText: '请输入手机号',
            ),
            //validator: (_) => _state.mobile.displayError?.text(),
            validator: (_) {
              return _state.mobile.isValid ? null :'请输入正确的手机号';
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              helperText: '请输入密码',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
            ),
            validator: (_) {
              return _state.password.isValid ? null :'由字母 数字 特殊字符 至少6位字符组成的密码';
            },
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 30,),
          _state.status.isInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Submit'),
          )

        ],
      ),
    );
  }

}