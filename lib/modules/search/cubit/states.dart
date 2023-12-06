abstract class SearchStates{}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}

class ChangFavoriteState extends SearchStates {}

class ChangFavoriteSuccessState extends SearchStates {}

class ChangeFavoriteErrorState extends SearchStates {}

class GetFavoriteSuccessState extends SearchStates {}

class GetFavoriteErrorState extends SearchStates {}
