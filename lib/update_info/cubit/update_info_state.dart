part of 'update_info_cubit.dart';

enum InfoStatus {
  unknown,
  changed,
  unchanged,
}

class UpdateInfoState extends Equatable {
  const UpdateInfoState({
    this.name = const Name.pure(),
    this.birthday = const Birthday.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzStatus.pure,
    this.infoStatus = InfoStatus.unknown,
  });

  final Name name;
  final Birthday birthday;
  final Phone phone;
  final FormzStatus status;
  final InfoStatus infoStatus;

  @override
  // TODO: implement props
  List<Object> get props => [
        name,
        birthday,
        phone,
        status,
        infoStatus,
      ];

  UpdateInfoState copyWith({
    Name name,
    Birthday birthday,
    Phone phone,
    FormzStatus status,
    InfoStatus infoStatus,
  }) {
    return UpdateInfoState(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      infoStatus: infoStatus ?? this.infoStatus,
    );
  }

}
