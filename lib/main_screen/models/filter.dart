import 'package:flutter/material.dart';
import 'package:share_ute/search/search.dart';

class Filter {
  Filter({this.icon, this.title, this.option});

  Widget icon;

  String title;

  FilterOptions option;

  static final options = [
    Filter(option: FilterOptions.unknown, title: 'Loại file'),
    Filter(
      option: FilterOptions.byPdfFile,
      title: 'Pdfs',
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        height: 35,
        width: 35,
        child: Image.asset(
          'assets/images/pdf_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
    Filter(
      option: FilterOptions.byDocFile,
      title: 'Documents',
      icon: Container(
        height: 35,
        width: 35,
        child: Image.asset(
          'assets/images/doc_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
    Filter(
      option: FilterOptions.byXlsFile,
      title: 'Spreadsheets',
      icon: Container(
        height: 35,
        width: 35,
        child: Image.asset(
          'assets/images/xls_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
    Filter(
      option: FilterOptions.byPptFile,
      title: 'Presentations',
      icon: Container(
        height: 35,
        width: 35,
        child: Image.asset(
          'assets/images/ppt_icon.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
    Filter(option: FilterOptions.unknown, title: 'Lọc theo ngày'),
    Filter(
      option: FilterOptions.byDateCreatedToday,
      title: 'Hôm nay',
      icon: Icon(Icons.calendar_today_outlined),
    ),
    Filter(
      option: FilterOptions.byDateCreatedYesterday,
      title: 'Hôm qua',
      icon: Icon(Icons.calendar_view_day_outlined),
    ),
    Filter(
      option: FilterOptions.byDateCreatedWeek,
      title: '7 ngày qua',
      icon: Icon(Icons.calendar_view_day_outlined),
    ),
    Filter(
      option: FilterOptions.byDateCreatedMonth,
      title: 'Tháng qua',
      icon: Icon(Icons.calendar_view_day_outlined),
    ),
    Filter(
      option: FilterOptions.byDateCreatedQuarter,
      title: '3 tháng qua',
      icon: Icon(Icons.calendar_view_day_outlined),
    ),
  ];

  static final historyQuery = [
    'Đề thi toán cao cấp A1',
    'Đề thi toán cao cấp A2',
    'Đề thi toán cao cấp A3',
    'Đề thi xác xuất thống kê ứng dụng',
    'Đề thi xử lý ảnh',
    'Đề thi hóa phân tích',
    'Đề thi sức bền vật liệu',
    'Đề thi vật lý 1',
    'Đề thi vật lý 2',
    'Đề thi vật lý 3',
    'Đề thi giải tích 1',
    'Đề thi giải tích 2',
    'Đề thi toán rời rạc',
    'Đề thi kỹ thuật số',
    'Đề thi cơ lý thuyết',
    'Đề thi vi xử lý',
    'Đề thi anh văn 1',
    'Đề thi anh văn 2',
    'Đề thi anh văn 3',
    'Đề thi anh văn 4',
    'Đề thi anh văn 5',
    'Đề thi đại số tuyến tính',
    'Đề thi toán ứng dụng',
    'Đề thi toán cao cấp c1',
    'Đề thi toán cao cấp c2',
    'Đề thi toán cao cấp c3',
    'Đề thi phương pháp tính',
    'Đề thi điều khiển lập trình',
    'Đề thi ứng dụng matlab',
    'Khoa Lý luận Chính trị',
    'Khoa Khoa học ứng dụng',
    'Khoa Cơ khí Chế tạo máy',
    'Khoa Điện - Điện tử',
    'Khoa Cơ khí Động lực',
    'Khoa Kinh tế',
    'Khoa Công nghệ thông tin',
    'Khoa In và Truyền thông',
    'Khoa Công nghệ May và Thời Trang',
    'Khoa Công nghệ Hóa học và Thực phẩm',
    'Khoa Xây dựng',
    'Khoa Ngoại ngữ',
    'Khoa Đào tạo Chất lượng cao',
    'Viện Sư phạm Kỹ thuật',
    'Khoa Đào tạo Chất lượng cao',
    'Ngành CNKT điện, điện tử',
    'Ngành CNKT điện tử - viễn thông',
    'Ngành CNKT máy tính',
    'Ngành CNKT điều khiển và tự động hóa',
    'Ngành Kỹ thuật y sinh (Điện tử y sinh)',
    'Ngành Hệ thống nhúng và IoT',
    'Ngành Robot và trí tuệ nhân tạo',
    'Ngành CN chế tạo máy',
    'Ngành CNKT cơ điện tử',
    'Ngành CNKT cơ khí',
    'Ngành Kỹ thuật công nghiệp',
    'Ngành Kỹ nghệ gỗ và nội thất',
    'Ngành CNKT công trình xây dựng',
    'Ngành Kỹ thuật xây dựng công trình giao thông',
    'Ngành Quản lý xây dựng',
    'Ngành Hệ thống kỹ thuật công trình xây dựng',
    'Ngành CNKT ô tô',
    'Ngành CNKT nhiệt',
    'Ngành Năng lượng tái tạo',
    'Ngành CN thông tin',
    'Ngành Kỹ thuật dữ liệu',
    'Ngành Quản lý công nghiệp',
    'Ngành Kế toán',
    'Ngành Thương mại điện tử',
    'Ngành Logistics và quản lý chuỗi cung ứng',
    'Ngành Kinh doanh Quốc tế',
    'Ngành Công nghệ may',
    'Ngành CN Kỹ thuật in',
    'Ngành Thiết kế đồ họa',
    'Ngành Kiến trúc',
    'Ngành Kiến trúc nội thất',
    'Ngành Công nghệ vật liệu',
    'Ngành CNKT môi trường',
    'Ngành CN thực phẩm',
    'Ngành CNKT hóa học',
    'Ngành Quản trị NH và DV ăn uống',
    'Ngành Thiết kế thời trang',
    'Ngành Sư phạm tiếng Anh',
    'Ngành Ngôn ngữ Anh',
  ];
}
