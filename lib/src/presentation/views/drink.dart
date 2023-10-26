import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/widgets/custom_generic_data_table_widget.dart';
import 'package:stirred_app/src/presentation/widgets/search_bar_widget.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

@RoutePage()
class DrinkView extends HookWidget {
  final String id;

  const DrinkView({Key? key, required this.id}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final drinkCubit = BlocProvider.of<DrinkCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      drinkCubit.retrieveDrink(id: id);
      return ;
    }, const []);

    return Scaffold(
      body : SafeArea(
        top: false,
        child: BlocBuilder<DrinkCubit, DrinkState>(
          builder: (context, state) {
            if (state.runtimeType == DrinkFailed) {
              /// TODO: exit view
              return const Center(child: Text("Drink couldn't be loaded"),);
            } else if (state.runtimeType == DrinkLoading) {
              return const Center(child: Text("Drink is loading"),);
            } else {
              return _buildDrinkWidget(state.drink!, drinkCubit);
            }
          }),
      ),
    );
  }

  Widget _buildDrinkWidget(Drink drink, DrinkCubit drinksCubit ) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(drink.picture, fit: BoxFit.fitWidth,),
              SafeArea(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        appRouter.pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28,),
                      ),
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}