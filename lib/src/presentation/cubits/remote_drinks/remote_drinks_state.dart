part of 'remote_drinks_cubit.dart';

abstract class RemoteDrinksState extends Equatable {
  final List<Drink> drinks;
  final bool noMoreData;
  final DioException? exception;

  const RemoteDrinksState({
    this.drinks = const [],
    this.noMoreData = true,
    this.exception
  });

  @override
  List<Object?> get props => [drinks, noMoreData, exception];
}

class RemoteDrinksLoading extends RemoteDrinksState {
  const RemoteDrinksLoading();
}

class RemoteDrinksSuccess extends RemoteDrinksState {
  const RemoteDrinksSuccess({super.drinks, super.noMoreData});
}

class RemoteDrinksFailed extends RemoteDrinksState {
  const RemoteDrinksFailed({super.exception});
}