import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_app/core/extensions/widget_ref.dart';
import 'package:stirred_app/core/theme/color.dart';
class DrinkDetailsView extends ConsumerStatefulWidget {
  const DrinkDetailsView({super.key, required this.drinkId});

  final int drinkId;

  @override
  ConsumerState<DrinkDetailsView> createState() => _DrinkDetailsViewState();
}

class _DrinkDetailsViewState extends ConsumerState<DrinkDetailsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.colors;
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Image.asset('assets/images/icon.png'),
          ),
          Positioned(
            top: imageHeight - 64,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                ColoredBox(
                  color: colors.transparent,
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: colors.primaryVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Ingredients'),
                      Tab(text: 'Instructions'),
                      Tab(text: 'Nutrition'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(height: 200, color: Colors.red),
                            Container(height: 200, color: Colors.blue),
                            Container(height: 200, color: Colors.green),
                            Container(height: 200, color: Colors.pink),
                            Container(height: 200, color: Colors.purple),
                          ],
                        ),
                      ),
                      const Center(child: Text('Instructions Content')),
                      const Center(child: Text('Nutrition Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
