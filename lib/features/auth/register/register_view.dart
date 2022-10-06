import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/constants/enum/form_type.dart';
import 'package:final_project_ala/core/constants/text_constants.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/features/auth/register/register_view_model.dart';
import 'package:final_project_ala/core/extensions/string_extension.dart';
import 'package:final_project_ala/ui/components/button/custom_button.dart';
import 'package:final_project_ala/ui/components/snackbar/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

late RegisterViewModel _model;
const String _text = 'Do you have an account ?';
final GlobalKey<FormState> _key = GlobalKey();
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    _model = RegisterViewModel();
    _model.init();
    _model.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _RegisterTextWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (name) {
                        if (name.isNullOrEmpty) {
                          return _ValidatorMessage._nullName;
                        }
                        return null;
                      },
                      decoration: _inputDecoration(TextForm.name),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
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
                    child: Consumer<RegisterViewModel>(
                      builder: (context, pValue, child) {
                        return TextFormField(
                          controller: _passwordController,
                          validator: (password) {
                            if (password.isNullOrEmpty) {
                              return _ValidatorMessage._nullPassword;
                            } else if (!password!.isLengthBigger(6)) {
                              return _ValidatorMessage._passwordLength;
                            }
                            return null;
                          },
                          obscureText: pValue.isVisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(TextForm.visiblePassword.label),
                            prefixIcon: IconButton(
                              onPressed: () {
                                pValue.changedVisibility();
                              },
                              icon: pValue.isVisible
                                  ? Icon(TextForm.unvisiblePassword.icon)
                                  : Icon(TextForm.visiblePassword.icon),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
                    child: Consumer<RegisterViewModel>(
                      builder: (context, cValue, child) {
                        return TextFormField(
                          controller: _confirmPasswordController,
                          validator: (password) {
                            if (password.isNullOrEmpty) {
                              return _ValidatorMessage._confirmPassword;
                            } else if (!password!.isLengthBigger(6)) {
                              return _ValidatorMessage._passwordLength;
                            }
                            return null;
                          },
                          obscureText: cValue.isVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: const Text('Confirm Password'),
                            prefixIcon: IconButton(
                              onPressed: () {
                                cValue.changedVisibility();
                              },
                              icon: cValue.isVisible
                                  ? Icon(TextForm.unvisiblePassword.icon)
                                  : Icon(TextForm.visiblePassword.icon),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const _CustomRegisterButton(),
                  const _ToLoginWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(TextForm type) {
    return InputDecoration(
      label: Text(type.label),
      prefixIcon: Icon(type.icon),
      border: const OutlineInputBorder(),
    );
  }
}

class _RegisterTextWidget extends StatelessWidget {
  const _RegisterTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p40),
      child: Text(
        AuthConstants.registerText,
        style: context.textTheme.titleLarge,
      ),
    );
  }
}

class _ToLoginWidget extends StatelessWidget {
  const _ToLoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(_text),
          TextButton(
              onPressed: () => _model.navigateToLogin(),
              child: const Text(AuthConstants.loginText))
        ],
      ),
    );
  }
}

class _CustomRegisterButton extends StatelessWidget {
  const _CustomRegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.p50),
      child: Center(
        child: CustomButton(
            text: AuthConstants.registerText,
            horizontal: Sizes.p60,
            onPressed: () {
              var name = _nameController.text.trim();
              var email = _emailController.text.trim();
              var password = _passwordController.text.trim();
              var confirmPassword = _confirmPasswordController.text.trim();
              if (_key.currentState!.validate()) {
                if (confirmPassword == password) {
                  _model.register(name, email, password);
                } else {
                  CustomSnackBar(context).showSnackBar(
                      AuthConstants.passwordErrorText, ColorKit.redColor);
                }
              }
            }),
      ),
    );
  }
}

class _ValidatorMessage {
  static const String _nullName = 'Please enter your name';
  static const String _nullEmail = 'Please enter an email adress';
  static const String _validEmail = 'Please enter an valid email';
  static const String _nullPassword = 'Please enter a password';
  static const String _passwordLength = 'Password must at least 6 character';
  static const String _confirmPassword = 'Please enter confirm password';
}
