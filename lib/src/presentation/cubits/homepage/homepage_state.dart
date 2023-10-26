part of 'homepage_cubit.dart';


abstract class HomepageState extends Equatable {
  final List<Drink> drinks;
  final bool noMoreData;
  final DioException? exception;

  const HomepageState({
    this.drinks = const [],
    this.noMoreData = true,
    this.exception,
  });

  @override
  List<Object?> get props => [drinks, noMoreData, exception];
}

class HomepageLoading extends HomepageState {
  const HomepageLoading({super.drinks, super.noMoreData});
}

class HomepageSuccess extends HomepageState {
  const HomepageSuccess({super.drinks, super.noMoreData});
}

class DrinksListLoading extends HomepageState {
  const DrinksListLoading({super.drinks, super.noMoreData});
}

class DrinksListSuccess extends HomepageState {
  const DrinksListSuccess({super.drinks, super.noMoreData});
}

class DrinksListFailed extends HomepageState {
  const DrinksListFailed({super.exception});
}