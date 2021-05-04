import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_emoij_type_state.dart';

class SelectEmoijTypeCubit extends Cubit<SelectEmoijTypeState> {
  SelectEmoijTypeCubit() : super(const SelectEmoijTypeState());

  void emoijTypeChanged(EmoijType currentType) {
    emit(state.copyWith(currentType: currentType));
  }
}
