part of 'drink_cubit.dart';


abstract class DrinkState extends Equatable {
  final Drink? drink;
  final DioException? exception;

  const DrinkState({
    this.drink,
    this.exception,
  });

  @override
  List<Object?> get props => [drink, exception];
}

class DrinkLoading extends DrinkState {
  const DrinkLoading({super.drink});
}

class DrinkSuccess extends DrinkState {
  const DrinkSuccess({super.drink});
}

class DrinkFailed extends DrinkState {
  const DrinkFailed({super.exception});
}