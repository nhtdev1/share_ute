import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'firestore_user_event.dart';

part 'firestore_user_state.dart';

class FirestoreUserBloc extends Bloc<FirestoreUserEvent, FirestoreUserState> {
  FirestoreUserBloc({
    @required FirestoreUserRepository firestoreUserRepository,
  })  : assert(firestoreUserRepository != null),
        _firestoreUserRepository = firestoreUserRepository,
        super(const FirestoreUserState.unknown()) {
    _userSubscription = _firestoreUserRepository.user.listen(
      (user) {
        add(FirestoreUserChanged(user));
      },
    );
  }

  final FirestoreUserRepository _firestoreUserRepository;

  StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<FirestoreUserState> mapEventToState(FirestoreUserEvent event) async* {
    if (event is FirestoreUserChanged) {
      yield _mapFirestoreUserChangedToState(event);
    }
  }

  FirestoreUserState _mapFirestoreUserChangedToState(
    FirestoreUserChanged event,
  ) {
    if (event.user != User.empty) {
      return state.status == FirestoreUserStatus.authenticatedWithOldUser
      || state.status == FirestoreUserStatus.updatedUser
          ? FirestoreUserState.updatedUser(event.user)
          : FirestoreUserState.authenticatedWithOldUser(event.user);
    }
    return const FirestoreUserState.authenticatedWithNewUser();
  }

}
