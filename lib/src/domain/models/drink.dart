import 'package:cocktail_app/src/config/config.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: drinkTableName)
class Drink extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? idDrink;
  final String? strDrink;
  final String? strDrinkThumb;

  const Drink({
    this.id,
    this.idDrink,
    this.strDrink,
    this.strDrinkThumb,
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      id: map['id'] != null ? map['id'] as int : null,
      idDrink: map['idDrink'] != null ? map['idDrink'] as String : null,
      strDrink: map['strDrink'] != null ? map['strDrink'] as String : null,
      strDrinkThumb: map['strDrinkThumb'] != null ? map['strDrinkThumb'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, idDrink, strDrink, strDrinkThumb];

}