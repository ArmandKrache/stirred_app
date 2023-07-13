import 'package:cocktail_app/src/config/config.dart';
import 'package:cocktail_app/src/utils/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'source.dart';

@Entity(tableName: ingredientTableName)
class Ingredient extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? idIngredient;
  final String? strIngredient;
  final String? strDescription;
  final String? strType;
  final String? strAlcohol;
  final String? strABV;

  const Ingredient({
    this.id,
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strType,
    this.strAlcohol,
    this.strABV,
  });

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'] != null ? map['id'] as int : null,
      idIngredient: map['idIngredient'] != null ? map['idIngredient'] as String : null,
      strIngredient: map['strIngredient'] != null ? map['strIngredient'] as String : null,
      strDescription: map['strDescription'] != null ? map['strDescription'] as String : null,
      strType: map['strType'] != null ? map['strType'] as String : null,
      strAlcohol: map['strAlcohol'] != null ? map['strAlcohol'] as String : null,
      strABV: map['strABV'] != null ? map['strABV'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, idIngredient, strIngredient,
    strDescription, strType, strAlcohol, strABV];

}