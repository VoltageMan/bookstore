// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.state,
    this.pagination,
    this.prods,
    this.stateInfo,
  });
  final ProductAPIState state;
  final List<ProductModel>? prods;
  final StateModel? stateInfo;
  final PaginationModel? pagination;

  @override
  List<Object?> get props => [state, prods, stateInfo, pagination];
}
