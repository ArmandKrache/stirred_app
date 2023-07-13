class FilteredCocktailsRequest {
  final String? categorie; // Filter with Categories
  final String? alcoholic; // Filter with : Alcoholic / Non_Alcoholic
  final String? glass; // Filter with Type of Glass
  final String? ingredients; // Filter with Ingredients

  FilteredCocktailsRequest({
    this.categorie,
    this.alcoholic = "Alcoholic",
    this.glass,
    this.ingredients,
  });

}