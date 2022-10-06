import 'package:final_project_ala/core/constants/regex.constants.dart';

extension StringValidatorExtension on String {
  bool matches(String regex) => RegExp(regex).hasMatch(this);

  bool get isValidEmail => matches(RegexConstants.instance.emailRegex);
  bool get isValidPassword => matches(RegexConstants.instance.passwordRegex);
  bool isLengthBigger(int length) => this.length >= length;
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? false;
  bool get notNullOrEmpty => !isNullOrEmpty;
}
