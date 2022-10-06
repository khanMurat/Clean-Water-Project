import 'package:final_project_ala/core/constants/app_sizes.dart';
import 'package:final_project_ala/core/extensions/context_extension.dart';
import 'package:final_project_ala/core/init/navigation/navigation_constant.dart';
import 'package:final_project_ala/core/init/navigation/navigation_service.dart';
import 'package:final_project_ala/ui/components/drawer/nav_item.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  String _launchURL = 'https://lifewater.org/';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.widthRate(Sizes.p55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.heightRate(Sizes.p20),
          ),
          Expanded(
            child: ListView(
              children: _getDrawerItem(context).map(
                (e) {
                  return ListTile(
                      leading: Icon(e.icons),
                      title: Text(e.title),
                      onTap: e.onTap);
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<NavItem> _getDrawerItem(BuildContext context) {
    return [
      NavItem('On Going Project', Icons.apps, () {
        NavigationService.instance.navigateToPage(NavigationConstant.project);
      }),
      NavItem('Completed Project', FontAwesomeIcons.check, () {
        NavigationService.instance
            .navigateToPage(NavigationConstant.completedProject);
      }),
      NavItem('Ourk Work', FontAwesomeIcons.info, () {
        NavigationService.instance.navigateToPage(NavigationConstant.home);
      }),
      NavItem('More Information', Icons.more, () {
        _launchUrl(_launchURL);
      }),
      NavItem(
        'Donation History',
        Icons.history,
        () {
          NavigationService.instance
              .navigateToPage(NavigationConstant.donation);
        },
      ),
      NavItem(
        'Profile',
        Icons.person,
        () {
          NavigationService.instance.navigateToPage(NavigationConstant.profile);
        },
      ),
    ];
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
