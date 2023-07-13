import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:equatable/equatable.dart';

class FilteredCocktailsResponse extends Equatable {
  final List<Drink> drinks;

  const FilteredCocktailsResponse({
    required this.drinks,
  });


  factory FilteredCocktailsResponse.fromMap(Map<String, dynamic> map) {
    return FilteredCocktailsResponse(
      drinks: List<Drink>.from(
        (map['drinks'] ?? []).map<Drink>(
              (x) => Drink.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [drinks];

}