import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/notification/notification.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit({
    NotificationCubit notificationCubit,
  })  : assert(notificationCubit != null),
        _notificationCubit = notificationCubit,
        super(const DocumentState());

  final NotificationCubit _notificationCubit;
}
