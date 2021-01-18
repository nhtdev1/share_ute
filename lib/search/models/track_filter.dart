import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

enum FilterOptions {
  unknown,
  byStringQuery,
  byPdfFile,
  byDocFile,
  byXlsFile,
  byPptFile,
  byDateCreatedToday,
  byDateCreatedYesterday,
  byDateCreatedWeek,
  byDateCreatedMonth,
  byDateCreatedQuarter,
  byTopTags,
  byFeatureTags,
  byOwnerTags,
}

class TrackFilter extends Equatable {
  const TrackFilter({
    this.option = FilterOptions.unknown,
    this.optionValues = const [],
    this.result = const [],
  });
  final FilterOptions option;
  final List<String> optionValues;
  final List<Post> result;

  @override
  List<Object> get props => [option, optionValues, result];

  static String getInfoOptionValues(TrackFilter trackFilter) {
    if (trackFilter.option == FilterOptions.byStringQuery) {
      return 'Tiêu đề:';
    }
    if (trackFilter.option == FilterOptions.byPdfFile) {
      return 'Loại file:';
    }
    if (trackFilter.option == FilterOptions.byDocFile) {
      return 'Loại file:';
    }
    if (trackFilter.option == FilterOptions.byXlsFile) {
      return 'Loại file:';
    }
    if (trackFilter.option == FilterOptions.byPptFile) {
      return 'Loại file:';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedToday) {
      return 'Thời gian:';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedYesterday) {
      return 'Thời gian:';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedWeek) {
      return 'Thời gian:';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedMonth) {
      return 'Thời gian:';
    }

    if (trackFilter.option == FilterOptions.byDateCreatedQuarter) {
      return 'Thời gian:';
    }

    if (trackFilter.option == FilterOptions.byTopTags) {
      return 'Tìm theo từ khóa:';
    }

    if (trackFilter.option == FilterOptions.byFeatureTags) {
      return 'Tìm theo tính năng:';
    }

    if (trackFilter.option == FilterOptions.byOwnerTags) {
      return 'Tìm theo tag riêng:';
    }

    return '';
  }

  static String getInfoOption(TrackFilter trackFilter) {
    if (trackFilter.option == FilterOptions.byStringQuery) {
      return 'Chỉ tìm theo tiêu đề';
    }
    if (trackFilter.option == FilterOptions.byPdfFile) {
      return 'Chỉ tìm theo file pdf';
    }
    if (trackFilter.option == FilterOptions.byDocFile) {
      return 'Chỉ tìm theo file word';
    }
    if (trackFilter.option == FilterOptions.byXlsFile) {
      return 'Chỉ tìm theo file excel';
    }
    if (trackFilter.option == FilterOptions.byPptFile) {
      return 'Chỉ tìm theo file powerpoint';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedToday) {
      return 'Chỉ tìm theo thời gian hôm nay';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedYesterday) {
      return 'Chỉ tìm theo thời gian hôm qua';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedWeek) {
      return 'Chỉ tìm theo 7 ngày gần đây';
    }
    if (trackFilter.option == FilterOptions.byDateCreatedMonth) {
      return 'Chỉ tìm theo 1 tháng gần đây';
    }

    if (trackFilter.option == FilterOptions.byDateCreatedQuarter) {
      return 'Chỉ tìm theo 3 tháng gần đây';
    }

    if (trackFilter.option == FilterOptions.byTopTags) {
      return 'Chỉ tìm theo top từ khóa';
    }

    if (trackFilter.option == FilterOptions.byFeatureTags) {
      return 'Chỉ tìm theo top tính năng';
    }

    if (trackFilter.option == FilterOptions.byOwnerTags) {
      return 'Chỉ tìm theo tag riêng';
    }

    return '';
  }
}
