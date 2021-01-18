class Problems {
  static final List<ProblemItem> terms = [
    ProblemItem(
      name: 'Tài liệu đồi trụy',
      details: [
        'Ngôn từ gợi dục',
        'Liên quan đến trẻ em',
        'Dịch vụ tình dục',
      ],
    ),
    ProblemItem(
      name: 'Tài liệu bạo lực',
      details: [
        'Ngôn từ bạo lực',
        'Mối đe dọa bạo lực',
        'Xúc phạm người khác',
      ],
    ),
    ProblemItem(
      name: 'Tài liệu quấy rối',
      details: [
        'Tôi',
        'Người khác',
      ],
    ),
    ProblemItem(
      name: 'Tài liệu sai',
      details: [
        'Đáp án sai',
        'Không xem được file',
      ],
    ),
    ProblemItem(
      name: 'Spam',
      details: [
        'Xuất hiện nhiều lần',
        'Nội dụng lặp lại',
      ],
    ),
    ProblemItem(
      name: 'Tài liệu kích động',
      details: [
        'Gợi dục',
        'Liên quan đến trẻ em',
        'Ngôn từ gợi dục',
        'Dịch vụ tình dục',
      ],
    ),
    ProblemItem(
      name: 'Tài liệu chống phá',
      details: [
        'Trường đại học',
        'Nhà nước',
      ],
    ),
    ProblemItem(
      name: 'Vấn đề khác',
      details: [
        'Quyền sở hữu trí tuệ',
        'Lừa đảo',
        'Quảng cáo',
        'Chia sẻ hình ảnh riêng tư',
      ],
    ),
  ];
}

class ProblemItem {
  ProblemItem({
    this.name = '',
    this.details = const [],
    this.isExpanded = false,
  });
  List<String> details;
  String name;
  bool isExpanded;
}
