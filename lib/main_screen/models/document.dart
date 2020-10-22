class Document {
  Document(
      {this.fileUrl,
      this.title,
      this.dateCreated,
      this.userUrl,
      this.type,
      this.tags,
      this.like,
      this.dislike});

  String fileUrl;
  String title;
  String dateCreated;
  String userUrl;
  DocumentType type;
  List<String> tags;
  int like;
  int dislike;

  static final List<Document> randomList = [
    Document(
        fileUrl:
            'http://fit.hcmute.edu.vn/Resources/Docs/SubDomain/fit/20172018/HK1/MCB-%C4%90T-%C4%90%C3%A1p%20%C3%A1n_HK11718.pdf',
        title: 'Mạng máy tính 2017-2018',
        dateCreated: '12/06/2017',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/women/55.jpg',
        tags: [
          'CNTT',
          '4TC',
          '2017-2018',
          'HK2',
          'DaiTra',
          'Nguyen Huu Trung',
          'CuoiKy'
        ],
        like: 932,
        dislike: 10),
    Document(
        fileUrl:
            'http://fit.hcmute.edu.vn/Resources/Docs/SubDomain/fit/20172018/HK1/%C4%90A-CuoiKy-01-17-18-TRR-LT%C4%90T.pdf',
        title: 'Toán rời rạc 2017-2018',
        dateCreated: '10/06/2017',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/men/54.jpg',
        tags: [
          'CNTT',
          '3TC',
          '2017-2018',
          'HK2',
          'DaiTra',
          'Nguyen Van A',
          'CuoiKy'
        ],
        like: 1230,
        dislike: 16),
    Document(
        fileUrl:
            'http://fit.hcmute.edu.vn/Resources/Docs/SubDomain/fit/Dethi_dapan/DapAnCuoiKyNMLT_HK1_2016_2017_DT%20copy.pdf',
        title: 'Nhập môn lập trình 2016-2017',
        dateCreated: '15/12/2016',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/women/85.jpg',
        tags: [
          'CNTT',
          '3TC',
          '2016-2017',
          'HK1',
          'DaiTra',
          'Tran Cong Tu',
          'CuoiKy'
        ],
        like: 121,
        dislike: 21),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_18_19/GiaiTich1-17-12-2018.pdf',
        title: 'Giải tích 1 2018-2019',
        dateCreated: '12/06/2018',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/men/66.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2018-2019',
          'HK2',
          'DaiTra',
          'Nguyen Van B',
          'CuoiKy'
        ],
        like: 333,
        dislike: 5),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_18_19/%C4%90%E1%BB%81%20thi%20V%E1%BA%ADt%20l%C3%BD%201%20PHYS130102_hkI_2018_2019.pdf',
        title: 'Vật lý đại cương 1 2018-2019',
        dateCreated: '12/06/2018',
        type: DocumentType.PDF,
        tags: [
          'KHUD',
          '3TC',
          '2018-2019',
          'HK2',
          'DaiTra',
          'Le Thi C',
          'CuoiKy'
        ]),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_18_19/XSTK20-12-2018.pdf',
        title: 'Xác xuất thống kê 2018-2019',
        dateCreated: '12/06/2018',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/women/37.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2018-2019',
          'HK2',
          'DaiTra',
          'Nguyen Thi A',
          'CuoiKy'
        ],
        like: 83,
        dislike: 2),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_18_19/de_a2_daitra_hk1_18_19.pdf',
        title: 'Toán cao cấp A2 2018-2019',
        dateCreated: '18/12/2018',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2018-2019',
          'HK1',
          'DaiTra',
          'Tran Van D',
          'CuoiKy'
        ],
        like: 411,
        dislike: 5),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_18_19/%C4%90%E1%BB%81%20thi%20v%C3%A0%20%C4%91%C3%A1p%20%C3%A1n%20A3.pdf',
        title: 'Toán cao cấp A3 2018-2019',
        dateCreated: '22/12/2018',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/women/0.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2017-2018',
          'HK1',
          'DaiTra',
          'Ly Van T',
          'CuoiKy'
        ],
        like: 76,
        dislike: 0),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_19_20/%C4%90%E1%BB%81%20to%C3%A1n%203-%20hk%201-1920.pdf',
        title: 'Toán 3 2019-2020',
        dateCreated: '30/06/2019',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/men/79.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2019-2020',
          'HK2',
          'DaiTra',
          'Tran Van E',
          'CuoiKy'
        ],
        like: 561,
        dislike: 1),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_19_20/ToanUDn1920Gui.pdf',
        title: 'Toán ứng dụng (CKM) 2019-2020',
        dateCreated: '01/07/2019',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/women/16.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2019-2020',
          'HK2',
          'DaiTra',
          'Nguyen Van F',
          'CuoiKy'
        ],
        like: 190,
        dislike: 10),
    Document(
        fileUrl:
            'http://fas.hcmute.edu.vn/Resources/Docs/SubDomain/fas/Dethi_dapan/HK1_19_20/%C4%90%E1%BB%81%20thi%20To%C3%A1n%20Kinh%20T%E1%BA%BF%201%20HKI%202019%20-%202020.pdf',
        title: 'Toán kinh tế 1 2019-2020',
        dateCreated: '15/06/2019',
        type: DocumentType.PDF,
        userUrl: 'https://randomuser.me/api/portraits/men/19.jpg',
        tags: [
          'KHUD',
          '3TC',
          '2019-2020',
          'HK2',
          'DaiTra',
          'Le Thi A',
          'CuoiKy'
        ],
        like: 40,
        dislike: 0),
  ];
}

enum DocumentType { PDF, DOCS, EXCEL, PPT }
