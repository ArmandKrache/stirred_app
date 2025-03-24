part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable {
  final List<Drink> drinks;
  final Exception? exception;

  const HomepageState({
    required this.drinks,
    this.exception,
  });

  @override
  List<Object?> get props => [drinks, exception];
}

class HomepageLoading extends HomepageState {
  const HomepageLoading({required super.drinks});
}

class HomepageSuccess extends HomepageState {
  const HomepageSuccess({required super.drinks});
}

class HomepageError extends HomepageState {
  const HomepageError({required super.drinks, super.exception});
}

class DrinksListLoading extends HomepageState {
  const DrinksListLoading({required super.drinks});
}

class DrinksListSuccess extends HomepageState {
  const DrinksListSuccess({required super.drinks});
}

class DrinksListFailed extends HomepageState {
  const DrinksListFailed({required super.drinks, required Exception super.exception});
}