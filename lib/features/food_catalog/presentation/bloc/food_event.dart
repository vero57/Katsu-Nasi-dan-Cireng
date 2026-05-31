import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object?> get props => [];
}

class LoadFoodCatalog extends FoodEvent {
  const LoadFoodCatalog();
}

class FilterByCategory extends FoodEvent {
  final String category;

  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchFood extends FoodEvent {
  final String query;

  const SearchFood(this.query);

  @override
  List<Object?> get props => [query];
}
