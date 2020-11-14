class Major {
  const Major._({this.value = ''});

  final value;

  const Major.pure() : this._();

  const Major.dirty(String value) : this._(value: value);
}
