// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_back_cubit.dart';

final class FeedBackState extends Equatable {
  const FeedBackState({
    required this.apiState,
    this.data,
  });

  final APIState apiState;
  final List<String>? data;
  @override
  List<Object?> get props => [apiState, data];

  FeedBackState copyWith({
    APIState? apiState,
    List<String>? data,
  }) {
    return FeedBackState(
      apiState: apiState ?? this.apiState,
      data: data ?? this.data,
    );
  }
}
