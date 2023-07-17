class SearchedCocktailsRequest {
  final String? name; // Search by Name
  final String? firstLetter; // Search by first letter
  final String? ingredient; // Search by ingredient

  SearchedCocktailsRequest({
    this.name,
    this.firstLetter,
    this.ingredient,
  });

}