part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostRefreshed extends PostEvent {}

class PostJustAdded extends PostEvent {}
