class MyFolder {
  final String iconPath;
  final String title;
  final DateTime lastUpdate;
  final String totalSize;
  final int totalItem;

  MyFolder(
      {this.iconPath,
      this.title,
      this.lastUpdate,
      this.totalSize,
      this.totalItem = 0});
}
