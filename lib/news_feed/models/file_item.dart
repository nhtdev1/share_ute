class FileItem {
  FileItem({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = '',
    this.response = 0,
    this.like = 1,
    this.dislike = 1,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  int response;
  int like;
  int dislike;

  static List<FileItem> fileItem = <FileItem>[
    FileItem(
      imagePath: 'assets/file/file1.png',
      titleTxt: 'De thi NMLT',
      subTxt: '2017, Hoc ky 1',
      response: 80,
      like: 4,
      dislike: 10,
    ),
    FileItem(
      imagePath: 'assets/file/file2.png',
      titleTxt: 'De thi toan A1',
      subTxt: '2018, Hoc ky 2',
      response: 74,
      like: 45,
      dislike: 2,
    ),
    FileItem(
      imagePath: 'assets/file/file3.png',
      titleTxt: 'De thi OOP',
      subTxt: '2019, Hoc ky 1',
      response: 62,
      like: 40,
      dislike: 6,
    ),
    FileItem(
      imagePath: 'assets/file/file4.png',
      titleTxt: 'De thi KTDL',
      subTxt: '2019, Hoc ky 3',
      response: 90,
      like: 84,
      dislike: 10,
    ),
  ];
}
