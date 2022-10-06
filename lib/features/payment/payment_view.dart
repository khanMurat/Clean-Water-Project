import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:final_project_ala/features/payment/payment_view_model.dart';
import 'package:final_project_ala/models/project/project_model.dart';
import 'package:final_project_ala/ui/components/payment/payment_form.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project_ala/core/extensions/string_extension.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    Key? key,
    required this.projectModel,
  }) : super(key: key);
  final ProjectInfo projectModel;

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late PaymentViewModel _model;

  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController creditCardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expirationController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _model = PaymentViewModel();
    _model.context;
    _model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarEnum: AppBarEnum.payment),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.projectModel.projectName.toString(),
                    style: context.textTheme.headlineMedium!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  gapH10,
                  SizedBox(
                    height: context.heightRate(Sizes.p20),
                    child: Image.network(
                      widget.projectModel.imageURL.toString(),
                    ),
                  ),
                  SizedBox(
                    height: context.heightRate(Sizes.p10),
                  ),
                  CreditCardFormField(
                    validator: (cardNumber) {
                      if (cardNumber.isNullOrEmpty) {
                        return _ValidatorMessage._nullCardNumber;
                      } else if (!cardNumber!.isLengthBigger(16)) {
                        return _ValidatorMessage._validCardNumber;
                      }
                      return null;
                    },
                    decoration:
                        _inputDecoration(_InputDecorationText._cardNoText),
                    controller: creditCardController,
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: CVVFormField(
                          validator: (cvv) {
                            if (cvv.isNullOrEmpty) {
                              return _ValidatorMessage._nullCCV;
                            }
                            return null;
                          },
                          decoration:
                              _inputDecoration(_InputDecorationText._cvv),
                          controller: cvvController,
                        ),
                      ),
                      gapW8,
                      Flexible(
                        child: ExpirationFormField(
                          validator: (exp) {
                            if (exp.isNullOrEmpty) {
                              return _ValidatorMessage._nullExpiration;
                            }
                            return null;
                          },
                          decoration: _inputDecoration(
                              _InputDecorationText._expiration,
                              hintText: _InputDecorationText._mY),
                          controller: expirationController,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.p20,
                    ),
                    child: TextFormField(
                      validator: (amount) {
                        if (amount.isNullOrEmpty) {
                          return _ValidatorMessage._nullAmount;
                        }
                        return null;
                      },
                      controller: amountController,
                      textAlign: TextAlign.center,
                      decoration:
                          _inputDecoration(_InputDecorationText._amount),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var amount = amountController.text.trim();
          if (_key.currentState!.validate()) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(_AlertDialogTexts._confirmText),
                    actions: [
                      OutlinedButton(
                          onPressed: () async {
                            await _model.savePayment(
                                _auth.currentUser!.uid,
                                amount,
                                widget.projectModel.projectName.toString(),
                                widget.projectModel.imageURL.toString());
                            _model.showSuccessDialog(context);
                          },
                          child: const Text(_AlertDialogTexts._yesText)),
                      OutlinedButton(
                        onPressed: () {
                          NavigationService.instance.navigateToPop();
                          _model.showErrorDialog(context);
                        },
                        child: const Text(_AlertDialogTexts._noText),
                      ),
                    ],
                  );
                });
          }
        },
        child: const Icon(Icons.send),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, {String? hintText}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: labelText,
      hintText: hintText,
    );
  }
}

class _ValidatorMessage {
  static const String _nullCardNumber = 'Please enter card number';
  static const String _validCardNumber = 'Enter valid card number';
  static const String _nullExpiration = 'Enter card expiration';
  static const String _nullCCV = 'Please enter CVV';
  static const String _nullAmount = 'Please enter an amount';
}

class _AlertDialogTexts {
  static const String _confirmText = 'Do you confirm the payment?';
  static const String _yesText = 'YES';
  static const String _noText = 'NO';
}

class _InputDecorationText {
  static const String _cardNoText = 'Card Number';
  static const String _cvv = 'CVV';
  static const String _expiration = 'Card Expiration';
  static const String _mY = 'MM/YY';
  static const String _amount = '💲 Amount';
}
