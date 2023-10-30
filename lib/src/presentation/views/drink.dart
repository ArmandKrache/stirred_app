import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


@RoutePage()
class DrinkView extends StatefulHookWidget {
  final String id;

  const DrinkView({Key? key, required this.id}) : super (key: key);

  @override
  State<DrinkView> createState() => _DrinkViewState();
}

class _DrinkViewState extends State<DrinkView> {
  final scrollController = ScrollController();
  Color topBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drinkCubit = BlocProvider.of<DrinkCubit>(context);

    useEffect(() {
      drinkCubit.retrieveDrink(id: widget.id);
      scrollController.addListener(() {
        if (scrollController.offset > 64) {
          setState(() {
            topBarColor = Colors.black.withOpacity(0.2);
          });
        } else {
          setState(() {
            topBarColor = Colors.transparent;
          });
        }
      });
      return ;
    }, const []);

    return Scaffold(
      body : SafeArea(
        top: false,
        child: Stack(
          children: [
            SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<DrinkCubit, DrinkState>(
                  builder: (context, state) {
                    if (state.runtimeType == DrinkFailed) {
                      /// TODO: exit view and display toast
                      return const Center(
                        heightFactor: 50,
                        child: Text("Drink couldn't be loaded"),
                      );
                    } else if (state.runtimeType == DrinkLoading) {
                      return const Center(
                        heightFactor: 50,
                        child: Text("Drink is loading"),
                      );
                    } else {
                      return _buildDrinkDataWidgets(state.drink!, drinkCubit);
                    }
                  })
            ),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).padding.top + 36,
              color: topBarColor,
            ),
            SafeArea(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      appRouter.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 16),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28,),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrinkDataWidgets(Drink drink, DrinkCubit drinksCubit ) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(drink.picture, fit: BoxFit.fitWidth,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(drink.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text("${drink.recipe.difficulty} - ${drink.recipe.preparationTime} minutes"),
                ],
              ),
              const Expanded(child: SizedBox(width: 24,)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Visibility(
                      visible: drink.averageRating != 0.0,
                      child: Text(drink.averageRating.toStringAsPrecision(2))
                    ),
                    const Icon(Icons.star, color: Colors.orangeAccent),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Equipment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(" - ${drink.glass.name}",),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ingredients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              for (var ingredient in drink.recipe.ingredients)
                ...[Text("${ingredient.quantity} ${ingredient.unit} of ${ingredient.ingredientName}")]
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Instructions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              for (var i = 0; i < drink.recipe.instructions.length ; i++)
                ...[Text("${i + 1}: ${drink.recipe.instructions[i]}")]
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Created by : ${drink.author.name}", style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 4,),
              for (var rating in drink.ratings)
                ...[commentWidget(rating)]
            ],
          ),
        ),
      ],
    );
  }

  Widget commentWidget(Rating rating) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey, width: 0.5)
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                  child: Image.network(baseMediaUrl +  rating.userPicture, width: 44, height: 44,)
              ),
              Column(children: [
                Text(rating.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                RatingBarIndicator(
                  rating: rating.rating.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  direction: Axis.horizontal,
                ),
              ],),
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  const Icon(Icons.favorite, color: Colors.redAccent,),
                  Text(rating.upvotes.toString())
                ],
              )
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            child: Text(rating.comment,
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(rating.creationTime.toString(),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}