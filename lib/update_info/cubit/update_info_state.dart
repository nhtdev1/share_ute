part of 'update_info_cubit.dart';

class UpdateInfoState extends Equatable {
  const UpdateInfoState({
    this.name = const Name.pure(),
    this.birthday = const Birthday(date: ''),
    this.mobile = const Mobile.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Birthday birthday;
  final Mobile mobile;
  final FormzStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [name, birthday, mobile, status];

  UpdateInfoState copyWith({
    Name name,
    Birthday birthday,
    Mobile mobile,
    FormzStatus status,
  }) {
    return UpdateInfoState(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      mobile: mobile ?? this.mobile,
      status: status ?? this.status,
    );
  }

}
