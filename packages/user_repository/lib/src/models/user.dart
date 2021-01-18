import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.name,
    this.birthday,
    this.phone,
    this.photo,
    this.year,
    this.faculty,
    this.major,
    this.hobbies,
    this.postTotal,
    this.pointTotal,
    this.dateCreated,
    this.disabled,
    this.premium,
  });

  final String id;

  final String email;

  final String name;

  final String birthday;

  final String phone;

  final String photo;

  final String year;

  final String faculty;

  final String major;

  final List<String> hobbies;

  final String postTotal;

  final String pointTotal;

  final String dateCreated;

  final String disabled;

  final String premium;

  static const empty = User(
    id: '',
    email: '',
    name: '',
    birthday: '',
    phone: '',
    photo: '',
    year: '',
    faculty: '',
    major: '',
    hobbies: [],
    postTotal: '0',
    pointTotal: '0',
    dateCreated: '',
    disabled: 'false',
    premium: 'false',
  );

  @override
  List<Object> get props => [
        id,
        email,
        name,
        birthday,
        phone,
        photo,
        year,
        faculty,
        major,
        hobbies,
        postTotal,
        pointTotal,
        dateCreated,
        disabled,
        premium,
      ];

  User copyWith({
    String id,
    String email,
    String name,
    String birthday,
    String phone,
    String photo,
    String year,
    String faculty,
    String major,
    List<String> hobbies,
    String postTotal,
    String pointTotal,
    String dateCreated,
    String disabled,
    String premium,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      year: year ?? this.year,
      faculty: faculty ?? this.faculty,
      major: major ?? this.major,
      hobbies: hobbies ?? this.hobbies,
      postTotal: postTotal ?? this.postTotal,
      pointTotal: pointTotal ?? this.pointTotal,
      dateCreated: dateCreated ?? this.dateCreated,
      disabled: disabled ?? this.disabled,
      premium: premium ?? this.premium,
    );
  }
}
