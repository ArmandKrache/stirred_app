import 'package:cocktail_app/src/domain/models/drink_details.dart';
import 'package:cocktail_app/src/domain/models/ingredient.dart';
import 'package:equatable/equatable.dart';

class LookupDetailsResponse extends Equatable {
  final List<DrinkDetails> drinksDetails;
  final List<Ingredient> ingredients;

  const LookupDetailsResponse({
    required this.drinksDetails,
    required this.ingredients,
  });


  factory LookupDetailsResponse.fromMap(Map<String, dynamic> map) {
    return LookupDetailsResponse(
      drinksDetails: List<DrinkDetails>.from(
        (map['drinks'] ?? []).map<DrinkDetails>(
              (x) => DrinkDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      ingredients: List<Ingredient>.from(
        (map['ingredients'] ?? []).map<Ingredient>(
              (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [drinksDetails, ingredients];

}