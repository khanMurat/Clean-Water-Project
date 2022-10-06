import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:final_project_ala/models/project/project_model.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:final_project_ala/ui/components/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    Key? key,
    required this.projectModel,
  }) : super(key: key);

  final ProjectInfo projectModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarEnum: AppBarEnum.detail),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Sizes.p20, vertical: Sizes.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: '${projectModel.imageURL}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.p20),
                    child: Image.network(
                      projectModel.imageURL.toString(),
                      height: context.height * 0.55,
                      width: context.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Wrap(
                    children: [
                      Text(
                        projectModel.projectName.toString(),
                        style: context.textTheme.titleLarge,
                        textAlign: TextAlign.start,
                      ),
                      gapH20,
                      Text(projectModel.summary.toString()),
                      gapH20,
                      ListTile(
                        leading: const Icon(Icons.place),
                        title: Text(projectModel.country.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.gps_fixed_sharp),
                        title: Text(
                            '${projectModel.location!.latitude},${projectModel.location!.longitude}'),
                      ),
                      Wrap(
                        children: [
                          Text(
                              '💲${projectModel.raisedMoney!} Raised of 💲${projectModel.needMoney}'),
                          StepProgressIndicator(
                            padding: 0,
                            size: Sizes.p4,
                            totalSteps: projectModel.needMoney! ~/ 1000,
                            currentStep: projectModel.raisedMoney! ~/ 1000,
                            selectedColor: Colors.blue,
                            unselectedColor: Colors.brown,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Sizes.p20),
                        child: Text(
                          'STORY',
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                      const Divider(
                        height: Sizes.p10,
                        color: ColorKit.blueColor,
                      ),
                      Text(
                        projectModel.detail.toString(),
                        style: context.textTheme.titleMedium,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: 'DONATE',
                  horizontal: Sizes.p100,
                  onPressed: () {
                    NavigationService.instance.navigateToPage(
                        NavigationConstant.payment,
                        data: projectModel);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
