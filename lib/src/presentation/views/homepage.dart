
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/widgets/custom_generic_data_table_widget.dart';
import 'package:stirred_app/src/presentation/widgets/search_bar_widget.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

@RoutePage()
class HomepageView extends HookWidget {
  const HomepageView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final scrollController = useScrollController();
    final TextEditingController searchController = TextEditingController();
    final currentRoute = ModalRoute.of(context);


    useEffect(() {
      homepageCubit.fetchDrinksList();
      return ;
    }, const []);


    return Scaffold(
      body : SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: searchController,
              onChanged: (query) async {
                homepageCubit.fetchDrinksList(query: query);
              },
              margin: const EdgeInsets.all(8),
            ),
            const SizedBox(height: 4,),
            Expanded(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  if (state.drinks.isEmpty) {
                    return const Center(child: Text("Drinks list is empty"),);
                  } else {
                    return _buildDataWidgets(state.drinks, homepageCubit);
                  }
                }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataWidgets(List<Drink> drinks, HomepageCubit drinksCubit ) {
    double imageSideSize = 192;
    List<Widget> items = [];
    
    for (var drink in drinks) {
      bool isFav = (currentProfile.preferences.favorites.any((element) => element.id == drink.id));
      items.add(
        GestureDetector(
          onTap: () {
            appRouter.push(DrinkRoute(id: drink.id));
          },
          child: Column(
            children: [
              SizedBox(
                width: imageSideSize,
                height: imageSideSize,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(drink.picture, fit: BoxFit.cover, width: imageSideSize, height: imageSideSize,)
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(isFav ? Icons.favorite : Icons.favorite_outline, color: isFav ? Colors.redAccent : Colors.white, size: 28,),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Text(drink.name, style: const TextStyle(fontSize: 17),)
            ],
          ),
        )
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            ...items,
          ],
        ),
      ),
    );
  }

}