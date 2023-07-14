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
  final String? title;
  final String? thumb;
  final String? tags;
  final String? category;
  final String? IBA;
  final String? alcoholic;
  final String? glass;
  final String? instructions;
  final List<String>? ingredients;
  final List<String>? measures;

  const DrinkDetails({
    this.id,
    this.idDrink,
    this.title,
    this.thumb,
    this.tags,
    this.category,
    this.IBA,
    this.alcoholic,
    this.glass,
    this.instructions,
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
      title: map['strDrink'] != null ? map['strDrink'] as String : null,
      thumb: map['strDrinkThumb'] != null ? map['strDrinkThumb'] as String : null,
      tags: map['strTags'] != null ? map['strTags'] as String : null,
      category: map['strCategory'] != null ? map['strCategory'] as String : null,
      IBA: map['strIBA'] != null ? map['strIBA'] as String : null,
      alcoholic: map['strAlcoholic'] != null ? map['strAlcoholic'] as String : null,
      glass: map['strGlass'] != null ? map['strGlass'] as String : null,
      instructions: map['strInstructions'] != null ? map['strInstructions'] as String : null,
      ingredients: ingredients,
      measures: measures
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, idDrink, title, ingredients, measures];

}