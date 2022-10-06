import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/enum/form_type.dart';
import 'package:final_project_ala/core/constants/text_constants.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/core/extensions/string_extension.dart';
import 'package:final_project_ala/features/auth/login/login_view_model.dart';
import 'package:final_project_ala/ui/components/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _model;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  final String _text = 'Do you not have an account ?';
  final String checkboxText = 'Remember Me';

  @override
  void initState() {
    _model = LoginViewModel();
    _model.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.p20),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p40),
                    child: Text(
                      AuthConstants.loginText,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p24),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (email) {
                        if (email.isNullOrEmpty) {
                          return _ValidatorMessage._nullEmail;
                        } else if (!email!.isValidEmail) {
                          return _ValidatorMessage._validEmail;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(TextForm.email),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
                    child: Consumer<LoginViewModel>(
                      builder: (BuildContext context, pvalue, Widget? child) {
                        return TextFormField(
                          validator: (password) {
                            if (password.isNullOrEmpty) {
                              return _ValidatorMessage._nullPassword;
                            } else if (!password!.isLengthBigger(6)) {
                              return _ValidatorMessage._passwordLength;
                            }
                            return null;
                          },
                          obscureText: pvalue.isVisible,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(TextForm.visiblePassword.label),
                            prefixIcon: IconButton(
                              icon: pvalue.isVisible
                                  ? Icon(TextForm.unvisiblePassword.icon)
                                  : Icon(TextForm.visiblePassword.icon),
                              onPressed: () {
                                pvalue.changedVisibility();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer<LoginViewModel>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                              value: value.remember,
                              onChanged: (remember) {
                                value.rememberMe();
                              }),
                          Text(checkboxText),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Sizes.p50),
                    child: Center(
                      child: CustomButton(
                        text: AuthConstants.loginText,
                        horizontal: Sizes.p70,
                        onPressed: () {
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          if (_key.currentState!.validate()) {
                            _model.signIn(email, password);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_text),
                        TextButton(
                            onPressed: () => _model.navigateToRegister(),
                            child: const Text(AuthConstants.registerText))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(TextForm type, {VoidCallback? onPressed}) {
    return InputDecoration(
        label: Text(type.label),
        prefixIcon: IconButton(
          icon: Icon(type.icon),
          onPressed: onPressed,
        ),
        border: const OutlineInputBorder());
  }
}

class _ValidatorMessage {
  static const String _nullEmail = 'Please enter an email adress';
  static const String _validEmail = 'Please enter an valid email';
  static const String _nullPassword = 'Please enter a password';
  static const String _passwordLength = 'Password must at least 6 character';
}
