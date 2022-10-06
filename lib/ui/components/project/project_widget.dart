import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/models/project/project_model.dart';
import 'package:final_project_ala/ui/components/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    Key? key,
    required this.onTap,
    required this.projectModel,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  final ProjectInfo projectModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.p20),
              color: ColorKit.whiteColor),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p10),
            child: Column(
              children: [
                Hero(
                  tag: '${projectModel.imageURL}',
                  child: Image.network(
                    projectModel.imageURL!,
                    height: context.heightRate(Sizes.p40),
                    width: context.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  projectModel.projectName.toString(),
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
                gapH10,
                Text(
                  projectModel.summary.toString(),
                  textAlign: TextAlign.center,
                ),
                gapH10,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(projectModel.country.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.group),
                      title:
                          Text('Help serve ${projectModel.servePeople} people'),
                    ),
                    ListTile(
                      leading: Text(
                        '💲 ${projectModel.raisedMoney}\n raised',
                      ),
                      title: StepProgressIndicator(
                        padding: 0,
                        size: 5,
                        totalSteps: projectModel.needMoney! ~/ 1000,
                        currentStep: projectModel.raisedMoney! ~/ 1000,
                        selectedColor: Colors.blue,
                        unselectedColor: Colors.brown,
                      ),
                      trailing: Text('💲 ${projectModel.needMoney}\n need'),
                      subtitle: Center(
                        child: Text(
                            '${((projectModel.raisedMoney! * 100) / (projectModel.needMoney!)).round()} % '),
                      ),
                    ),
                    gapH20,
                    CustomButton(
                        text: 'DETAIL',
                        horizontal: Sizes.p100,
                        onPressed: onTap)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
