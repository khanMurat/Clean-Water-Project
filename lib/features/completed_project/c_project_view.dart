import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/features/completed_project/c_project_view_model.dart';
import 'package:final_project_ala/ui/components/completed-project/c_project_widget.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:final_project_ala/ui/components/drawer/custom_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CProjectView extends StatefulWidget {
  const CProjectView({Key? key}) : super(key: key);

  @override
  State<CProjectView> createState() => _CProjectViewState();
}

class _CProjectViewState extends State<CProjectView> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('CompletedProject').snapshots();

  final _homeViewModel = CProjectViewModel.instance;
  String _errorText = 'Something went wrong';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CProjectViewModel>(context, listen: false).getCProjectList();
      _homeViewModel.getCProjectList();
      _homeViewModel.context;
      _homeViewModel.init();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar(
          appBarEnum: AppBarEnum.cProject,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(_errorText);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<CProjectViewModel>(
              builder: (context, value, child) {
                if (value.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.count(
                    padding: const EdgeInsets.symmetric(
                        vertical: Sizes.p20, horizontal: Sizes.p16),
                    childAspectRatio: 1.9,
                    mainAxisSpacing: context.height * 0.06,
                    crossAxisCount: 1,
                    children: [
                      for (var project in value.cProjectList)
                        CProjectWidget(projectModel: project),
                    ]);
              },
            );
          },
        ));
  }
}
