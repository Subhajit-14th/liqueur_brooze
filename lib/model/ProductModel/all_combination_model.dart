class VariationCombination {
  Map<String, String> combination; // e.g., {Model: "One", Color: "Red"}
  String? regularPrice;
  String? discountPrice;
  String? stock;

  VariationCombination({required this.combination});

  @override
  String toString() {
    return 'VariationCombination(model: $combination, regularPrice: $regularPrice, discountPrice: $discountPrice, stock: $stock)';
  }
}
