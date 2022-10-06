import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/constants/color_kit.dart';
import 'package:final_project_ala/core/constants/enum/app_bar_enum.dart';
import 'package:final_project_ala/core/constants/enum/cache_keys.dart';
import 'package:final_project_ala/features/profile/profile_view_model.dart';
import 'package:final_project_ala/ui/components/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../core/init/cache/cache_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel _profileViewModel;

  @override
  void initState() {
    _profileViewModel = ProfileViewModel();
    _profileViewModel.context;
    _profileViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarEnum: AppBarEnum.profile),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.p20),
              child: Container(
                color: ColorKit.blueShade,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p20),
                  child: Text(
                    CacheManager.instance.getString(CacheKeys.name),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: Sizes.p4,
          ),
          Expanded(
            child: ListView(
              children: _profileViewModel.getDrawerItem(context).map(
                (e) {
                  return ListTile(
                    title: Text(e.title),
                    leading: Icon(e.icons),
                    onTap: e.onTap,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
