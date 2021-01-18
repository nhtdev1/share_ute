import 'package:equatable/equatable.dart';

class PopularTags extends Equatable {
  const PopularTags({this.tags = const []});

  final List<String> tags;

  static const empty = PopularTags(tags: []);

  @override
  List<Object> get props => [tags];
}
