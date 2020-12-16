import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:user_repository/user_repository.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit({
    @required NotificationCubit notificationCubit,
  })  : assert(notificationCubit != null),
        super(
          DocumentState(
            post: notificationCubit.state.currentPost,
          ),
        );
}
