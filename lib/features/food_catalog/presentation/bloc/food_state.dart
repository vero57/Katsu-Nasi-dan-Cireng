import 'package:equatable/equatable.dart';
import '../../data/models/food_model.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {
  const FoodInitial();
}

class FoodLoading extends FoodState {
  const FoodLoading();
}

class FoodLoaded extends FoodState {
  final List<FoodModel> foods;
  final String selectedCategory;
  final String searchQuery;

  const FoodLoaded({
    required this.foods,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  FoodLoaded copyWith({
    List<FoodModel>? foods,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return FoodLoaded(
      foods: foods ?? this.foods,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [foods, selectedCategory, searchQuery];
}

class FoodError extends FoodState {
  final String message;

  const FoodError(this.message);

  @override
  List<Object?> get props => [message];
}
