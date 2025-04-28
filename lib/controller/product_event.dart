

abstract class ProductEvent {
  const ProductEvent();
}

class FetchProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class SearchProductsEvent extends ProductEvent {
  final String query;
  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
class LoadMoreProductsEvent extends ProductEvent {}
