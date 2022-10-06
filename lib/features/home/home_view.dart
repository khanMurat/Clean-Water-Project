import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';

import 'package:final_project_ala/features/home/home_view_model.dart';

import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

late HomeViewModel _model;

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    _model = HomeViewModel();
    _model.init();
    _model.context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorKit.whiteColor,
      appBar: CustomAppBar(
        appBarEnum: AppBarEnum.ourWork,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _model.navigateToProject();
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: GridView.count(
        mainAxisSpacing: 0,
        childAspectRatio: 1.1,
        crossAxisCount: 1,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: _model.imagesWhyWater().map((whyWater) {
                return Image.asset(whyWater.image);
              }).toList(),
            ),
          ),
          PageView(
            scrollDirection: Axis.vertical,
            children: _model.imagesInformation().map(
              (info) {
                return Image.asset(info.image);
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
