import 'package:cocktail_app/src/config/config.dart';
import 'package:cocktail_app/src/utils/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'source.dart';

@Entity(tableName: drinkDetailsTableName)
class DrinkDetails extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? idDrink;
  final String? strDrink;
  final String? strDrinkThumb;
  final String? strTags;
  final String? strCategory;
  final String? strIBA;
  final String? strAlcoholic;
  final String? strGlass;
  final String? strInstructions;
  final List<String>? ingredients;
  final List<String>? measures;

  const DrinkDetails({
    this.id,
    this.idDrink,
    this.strDrink,
    this.strDrinkThumb,
    this.strTags,
    this.strCategory,
    this.strIBA,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructions,
    this.ingredients,
    this.measures,
  });

  factory DrinkDetails.fromMap(Map<String, dynamic> map) {
    List<String> ingredients = [];
    final RegExp ingredientKeyPattern = RegExp(r'^strIngredient\d+$');
    final List<String> ingredientKeys = map.keys
        .where((key) => ingredientKeyPattern.hasMatch(key))
        .toList();
    for (String ingredientKey in ingredientKeys) {
      final String? ingredientValue = map[ingredientKey];
      if (ingredientValue != null) {
        ingredients.add(ingredientValue);
      }
    }

    List<String> measures = [];
    final RegExp measureKeyPattern = RegExp(r'^strMeasure\d+$');
    final List<String> measureKeys = map.keys
        .where((key) => measureKeyPattern.hasMatch(key))
        .toList();
    for (String k in measureKeys) {
      final String? value = map[k];
      if (value != null) {
        measures.add(value);
      }
    }

    return DrinkDetails(
      id: map['id'] != null ? map['id'] as int : null,
      idDrink: map['idDrink'] != null ? map['idDrink'] as String : null,
      strDrink: map['strDrink'] != null ? map['strDrink'] as String : null,
      strDrinkThumb: map['strDrinkThumb'] != null ? map['strDrinkThumb'] as String : null,
      strTags: map['strTags'] != null ? map['strTags'] as String : null,
      strCategory: map['strCategory'] != null ? map['strCategory'] as String : null,
      strIBA: map['strIBA'] != null ? map['strIBA'] as String : null,
      strAlcoholic: map['strAlcoholic'] != null ? map['strAlcoholic'] as String : null,
      strGlass: map['strGlass'] != null ? map['strGlass'] as String : null,
      strInstructions: map['strInstructions'] != null ? map['strInstructions'] as String : null,
      ingredients: ingredients,
      measures: measures
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, idDrink, strDrink, ingredients, measures];

}