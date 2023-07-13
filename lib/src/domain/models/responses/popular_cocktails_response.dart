import 'package:equatable/equatable.dart';

class PopularCocktailsResponse extends Equatable {
  final List<dynamic> res;


  const PopularCocktailsResponse({
    required this.res,
  });


  factory PopularCocktailsResponse.fromMap(Map<String, dynamic> map) {
    return PopularCocktailsResponse(
      res: List<dynamic>.from(
        (map['articles'] ?? []).map<dynamic>((x) => x)),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [res];

}