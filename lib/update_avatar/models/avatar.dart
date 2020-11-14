class Avatar {
  const Avatar._({this.path = ''});

  final String path;

  const Avatar.none() : this._();

  const Avatar.from(String path) : this._(path: path);
}
