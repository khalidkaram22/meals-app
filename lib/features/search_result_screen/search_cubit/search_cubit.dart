import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/features/search_result_screen/search_cubit/search_state.dart';
import '../repo/search_repo.dart';



class SearchCubit extends Cubit<SearchState> {

  final SearchRepo searchRepo;

  String _currentQuery = "";

  SearchCubit(this.searchRepo) : super(SearchInitialState());

  Future<void> fetchMealsByNameSearch(String query) async {
    _currentQuery = query;

    emit(LoadSearchState());

    try {
      final response = await searchRepo.searchItemByName(query);

      if (query != _currentQuery) return;

      emit(SuccessSearchState(response));
    } catch (e) {
      if (query != _currentQuery) return;

      emit(ErrorSearchState(e.toString()));
    }
  }




}