import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/food_repository.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc({required this.foodRepository}) : super(const FoodInitial()) {
    on<LoadFoodCatalog>(_onLoadFoodCatalog);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchFood>(_onSearchFood);
  }

  Future<void> _onLoadFoodCatalog(LoadFoodCatalog event, Emitter<FoodState> emit) async {
    emit(const FoodLoading());
    try {
      final foods = await foodRepository.getFoods(category: 'All');
      emit(FoodLoaded(foods: foods, selectedCategory: 'All', searchQuery: ''));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onFilterByCategory(FilterByCategory event, Emitter<FoodState> emit) async {
    final currentState = state;
    String currentQuery = '';
    
    if (currentState is FoodLoaded) {
      currentQuery = currentState.searchQuery;
    }
    
    emit(const FoodLoading());
    try {
      final foods = await foodRepository.getFoods(category: event.category, query: currentQuery);
      emit(FoodLoaded(foods: foods, selectedCategory: event.category, searchQuery: currentQuery));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  Future<void> _onSearchFood(SearchFood event, Emitter<FoodState> emit) async {
    final currentState = state;
    String currentCategory = 'All';
    
    if (currentState is FoodLoaded) {
      currentCategory = currentState.selectedCategory;
    }
    
    emit(const FoodLoading());
    try {
      final foods = await foodRepository.getFoods(category: currentCategory, query: event.query);
      emit(FoodLoaded(foods: foods, selectedCategory: currentCategory, searchQuery: event.query));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
}
