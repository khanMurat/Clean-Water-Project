import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:final_project_ala/features/project/project_view_model.dart';
import 'package:final_project_ala/ui/components/project/project_widget.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:final_project_ala/ui/components/drawer/custom_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('Projects').snapshots();

  final _homeViewModel = ProjectViewModel.instance;
  String _errorText = 'Something went wrong';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectViewModel>(context, listen: false).getProjectList();
      _homeViewModel.getProjectList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar(
          appBarEnum: AppBarEnum.project,
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
            return Consumer<ProjectViewModel>(
              builder: (context, value, child) {
                if (value.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(Sizes.p10),
                  child: GridView.count(
                      childAspectRatio: 0.5,
                      mainAxisSpacing: context.height * 0.08,
                      crossAxisCount: 1,
                      children: [
                        for (var project in value.projectList)
                          ProjectWidget(
                              onTap: () {
                                NavigationService.instance.navigateToPage(
                                    NavigationConstant.detail,
                                    data: project);
                              },
                              projectModel: project),
                      ]),
                );
              },
            );
          },
        ));
  }
}
