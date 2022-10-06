import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/features/donation/donation_view_model.dart';
import 'package:final_project_ala/ui/components/donation/donation_widget.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationView extends StatefulWidget {
  const DonationView({
    Key? key,
  }) : super(key: key);

  @override
  State<DonationView> createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  late DonationViewModel _model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DonationViewModel>(context, listen: false).getDonateList();
      _model = DonationViewModel.instance;
      _model.getDonateList();
      _model.context;
      _model.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarEnum: AppBarEnum.donation),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<DonationViewModel>(
            builder: (context, value, child) {
              if (value.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      height: context.heightRate(Sizes.p24),
                      child: DonationWidget(
                          donationInfo: value.donationList[index]),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      height: Sizes.p4,
                    );
                  }),
                  itemCount: value.donationList.length);
            },
          );
        },
      ),
    );
  }
}
