import 'package:equatable/equatable.dart';

class FeatureTags extends Equatable {
  const FeatureTags({this.tags = const []});

  final List<String> tags;

  static const empty = FeatureTags(tags: []);

  @override
  List<Object> get props => [tags];
}
