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




    Map<String ,dynamic > logDic = {
      "RequestData": {
        "examId": 606, "operationSheetId": 578, "operationPersonId": 444,
        "operationItemScoreListTos": [
          {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
          {"deductScore": 2, "itemId": 9678, "score": 2, "reason": "12323"},
          {"deductScore": 4, "itemId": 9679, "score": 4, "reason":"415" },
          {"deductScore": 4, "itemId": 9680, "score": 4, "reason": "45454"},
          {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流3"},
          {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "56adfs"},
          {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "asgh"},
          {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "assuage"},
          {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"asfgasgaewegeag" },
          {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"大家晚上好，交流圈的问题已经回复啦，群19点后禁言" },
          {"deductScore": 2, "itemId": 9671, "score": 2, "reason": "res"},
          {"deductScore": 2, "itemId": 9672, "score": 2, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
          {"deductScore": 4, "itemId": 9683, "score": 4, "reason":"大家晚上好，交流圈的问题已经回复啦，群19点后禁言" },
          {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
          {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "大家晚上好"},
          {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "大家晚上好"},
          {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
          {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "大家晚上好，交流圈的问题已经回复啦，群19点后禁言"},
          {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
          {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
          {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
          {"deductScore": 2, "itemId": 9679, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9682, "score": 4, "reason":"v" },
          {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
          {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
          {"deductScore": 2, "itemId": 9677, "score": 2, "reason": "res"},
          {"deductScore": 2, "itemId": 9679, "score": 2, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9682, "score": 4, "reason":"有技术问题可以到交流圈内留言，欢迎各位同学互相交流" },
          {"deductScore": 4, "itemId": 9684, "score": 4, "reason": "有技术问题可以到交流圈内留言，欢迎各位同学互相交流"},
          {"deductScore": 4, "itemId": 9686, "score": 4, "reason": "大家晚上好"},
          {"deductScore": 2, "itemId": 9688, "score": 2, "reason": "大家晚上好"},
          {"deductScore": 4, "itemId": 9690, "score": 4, "reason": "大家晚上好"},
          {"deductScore": 4, "itemId": 9692, "score": 4, "reason": "大家晚上好"},
          {"deductScore": 4, "itemId": 9694, "score": 4, "reason":"大家晚上好" },
          {"deductScore": 2, "itemId": 9697, "score": 2, "reason":"大家晚上好" },
        ]
      }
    };
    LogUtil.E(tag: 'JSON',json: logDic);


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