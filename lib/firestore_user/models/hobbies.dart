class Hobbies {
  const Hobbies._({this.value = const []});

  final List<String> value;

  const Hobbies.pure() : this._();

  const Hobbies.dirty(List<String> value) : this._(value: value);
}
