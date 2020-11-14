class Year {
  const Year._({this.value = ''});

  final value;

  const Year.pure() : this._();

  const Year.dirty(String value) : this._(value: value);
}
