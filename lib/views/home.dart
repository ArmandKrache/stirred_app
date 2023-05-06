import 'package:flutter/material.dart';
import 'package:template_app/router.dart';
import 'package:template_app/utils/app_colors.dart';
import 'package:template_app/utils/app_data.dart';
import 'package:template_app/views/champions.dart';
import 'package:template_app/views/dashboard.dart';
import 'package:template_app/widgets/popInDisclaimer.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  void _asyncInit() async {
    if (AppData.currentUser == null) {
      await AppData.getCurrentUserFromCache(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _body(),
      appBar: _appBar(),
    );
  }

  Widget _body() {
    List<Widget> viewTabs = [
      DashboardView(),
      ChampionsView(),
    ];
    return Container(
      child: DefaultTabController(
        initialIndex: 0,
        length: viewTabs.length,
        child: SafeArea(
          child: _childControlTopBar(viewTabs),
        ),
      ),
    );
  }

  Widget _childControlTopBar(List<Widget> tabViews) {
    final List<String> nameTabs = [
      'Dashboard',
      'Champions',
    ];
    return Column(
      children: [
        TabBar(
          tabs: <Widget>[
            for (int i = 0; i < nameTabs.length; i++) ...[
              Tab(
                child: Text(nameTabs[i],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ]
          ],
          unselectedLabelColor: AppColors.gray400,
        ),
        Expanded(
          child: TabBarView(
            children: tabViews,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Welcome ${AppData.currentUser}"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout_rounded, color: AppColors.alert,),
          tooltip: 'Log out',
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return PopInDisclaimer(
                      bodyText: "Are you sure you want to log out ?",
                      cancelTap: () {
                        AppRouter.pop(context);
                      },
                      confirmTap: () {
                        AppRouter.logout(context);
                      });
                });
          },
        ),
      ],
    );
  }

}
