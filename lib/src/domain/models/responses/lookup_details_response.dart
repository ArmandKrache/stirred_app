import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/ingredient.dart';
import 'package:equatable/equatable.dart';

class LookupDetailsResponse extends Equatable {
  final List<Drink> drinks;
  final List<Ingredient> ingredients;

  const LookupDetailsResponse({
    required this.drinks,
    required this.ingredients,
  });


  factory LookupDetailsResponse.fromMap(Map<String, dynamic> map) {
    return LookupDetailsResponse(
      drinks: List<Drink>.from(
        (map['drinks'] ?? []).map<Drink>(
              (x) => Drink.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ingredients: List<Ingredient>.from(
        (map['ingredients'] ?? []).map<Drink>(
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