import 'package:is_valid/is_valid.dart';
void main() {
  bool isValidEmail = IsValid.validateEmail('example@email.com');
  bool isValidPhoneNumber = IsValid.validatePhoneNumber('1234567890');
}

