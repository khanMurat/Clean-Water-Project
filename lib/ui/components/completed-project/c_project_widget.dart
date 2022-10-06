import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';

import 'package:final_project_ala/models/completed-project/c_project_model.dart';
import 'package:flutter/material.dart';

class CProjectWidget extends StatelessWidget {
  const CProjectWidget({
    Key? key,
    required this.projectModel,
  }) : super(key: key);

  final CProjectInfo projectModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  projectModel.imageURL.toString(),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Text(
                        projectModel.projectName.toString(),
                        style: context.textTheme.bodyText1,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          const Icon(Icons.place),
                          Text(
                            '${projectModel.place}',
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleSmall!
                                .copyWith(fontSize: Sizes.p10),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        const Icon(Icons.gps_fixed),
                        Text(
                            '${projectModel.location!.latitude},${projectModel.location!.longitude}'),
                      ],
                    )),
                    Flexible(
                        child: Row(
                      children: [
                        const Icon(Icons.people),
                        Text('${projectModel.servePeople} people')
                      ],
                    )),
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.check,
                          color: ColorKit.greenColor,
                        ),
                        Text(
                          'Project Completed on \n${projectModel.finishedTime}',
                          style: context.textTheme.titleSmall!.copyWith(
                              color: ColorKit.greenColor, fontSize: Sizes.p10),
                        ),
                      ],
                    ))
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
