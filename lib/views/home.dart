import 'package:flutter/material.dart';
import 'package:template_app/utils/app_colors.dart';
import 'package:template_app/views/champions.dart';
import 'package:template_app/views/dashboard.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _body(),
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
}
