part of 'select_emoij_type_cubit.dart';

enum EmoijType {
  smileysAndPeople,
  animalsAndNature,
  foodAndDrink,
  activities,
  travelAndPlaces,
  objects,
  symbols,
  flags,
}

class SelectEmoijTypeState extends Equatable {
  const SelectEmoijTypeState({this.currentType = EmoijType.smileysAndPeople});

  final EmoijType currentType;

  @override
  List<Object> get props => [currentType];

  static const options = {
    EmoijType.smileysAndPeople: '😀',
    EmoijType.animalsAndNature: '🐻',
    EmoijType.foodAndDrink: '🍔',
    EmoijType.activities: '⚽',
    EmoijType.travelAndPlaces: '🚖',
    EmoijType.objects: '💡',
    EmoijType.symbols: '❤️',
    EmoijType.flags: '🇻🇳',
  };

  SelectEmoijTypeState copyWith({EmoijType currentType}) {
    return SelectEmoijTypeState(currentType: currentType ?? this.currentType);
  }
}
