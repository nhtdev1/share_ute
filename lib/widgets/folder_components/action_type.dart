enum ACTION_TYPE{
  NO_YES,
  NO_OK,
  NO_CONFIRM,
  CANCEL_CREATE,
  CANCEL_OK,
  CANCEL_NEW,
  CANCEL_RENAME,
}
extension ACTION_TYPE_EX on ACTION_TYPE {
  List<String> get convertToString {
    return this.toString().split(".")[1].split("_");
  }
}