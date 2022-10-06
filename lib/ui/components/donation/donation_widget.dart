import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/models/donation/donation_model.dart';
import 'package:flutter/material.dart';

class DonationWidget extends StatelessWidget {
  const DonationWidget({
    Key? key,
    required this.donationInfo,
  }) : super(key: key);

  final DonationInfo donationInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p40),
        decoration: const BoxDecoration(
          color: ColorKit.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(Sizes.p32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  donationInfo.imageURL.toString(),
                  height: 200,
                ),
              ),
              gapW10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        donationInfo.projectName.toString(),
                        style: context.textTheme.bodyText1,
                      ),
                    ),
                    const Divider(
                      height: Sizes.p10,
                    ),
                    Expanded(
                      child: Text('💲 ${donationInfo.amount}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
