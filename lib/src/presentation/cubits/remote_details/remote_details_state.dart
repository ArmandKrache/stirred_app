part of 'remote_details_cubit.dart';

@immutable
abstract class RemoteDetailsState extends Equatable {
  final List<DrinkDetails> drinksDetails;
  final List<Ingredient> ingredients;
  final bool noMoreData;
  final DioException? exception;

  const RemoteDetailsState({
    this.drinksDetails = const [],
    this.ingredients = const [],
    this.noMoreData = false,
    this.exception
  });

  @override
  List<Object?> get props => [drinksDetails, ingredients, noMoreData, exception];
}

class RemoteDetailsLoading extends RemoteDetailsState {
  const RemoteDetailsLoading();
}

class RemoteDetailsSuccess extends RemoteDetailsState {
  const RemoteDetailsSuccess({super.drinksDetails, super.ingredients, super.noMoreData});
}

class RemoteDetailsFailed extends RemoteDetailsState {
  const RemoteDetailsFailed({super.exception});
}