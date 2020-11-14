class Faculty {
  const Faculty._({this.value = ''});

  final value;

  const Faculty.pure() : this._();

  const Faculty.dirty(String value) : this._(value: value);
}
