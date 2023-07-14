part of 'local_details_cubit.dart';

abstract class LocalDrinkState extends Equatable {
  final List<Drink> drinkList;

  const LocalDrinkState({
    this.drinkList = const []
  });

  @override
  List<Object> get props => [drinkList];
}

class LocalDrinkLoading extends LocalDrinkState {
  const LocalDrinkLoading();
}

class LocalDrinkSuccess extends LocalDrinkState {
  const LocalDrinkSuccess({super.drinkList});
}
