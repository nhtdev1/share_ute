// import 'dart:async';
// import 'dart:convert';
// import 'package:file_picker_repository/file_picker_repository.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:share_ute/notification/notification.dart';
// import 'package:solution_repository/solution_repository.dart';

// part 'solution_notification_state.dart';

// class SolutionNotificationCubit extends Cubit<SolutionNotificationState> {
//   SolutionNotificationCubit({
//     @required this.httpClient,
//     @required this.notifyCubit,
//   }) : super(const SolutionNotificationState());

//   final http.Client httpClient;
//   final NotificationCubit notifyCubit;
//   final _firebaseMessaging = FirebaseMessaging();

//   @override
//   Future<void> close() {
//     _firebaseMessaging
//         .unsubscribeFromTopic(notifyCubit.state.currentPost.postID);
//     return super.close();
//   }

//   void refresh() {
//     emit(state.copyWith(
//       status: SolutionNotificationStatus.unknown,
//       recentSolutionTotal: 0,
//     ));
//   }

//   void configFirebaseMessaging() {
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         final solution = Solution(
//           uid: message['data']['uid'],
//           photoURL: message['data']['photoURL'],
//           title: message['data']['title'],
//           solutionFile: File(
//             path: message['data']['solutionFileURL'],
//             fileName: message['data']['fileName'],
//             fileExtension: message['data']['fileExtension'],
//             fileSize: message['data']['fileSize'],
//           ),
//           dateCreated: message['data']['dateCreated'],
//         );
//         _addSolution(solution);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//     _firebaseMessaging.subscribeToTopic(notifyCubit.state.currentPost.postID);
//   }

//   Future<void> fetchSolutions() async {
//     final postId = notifyCubit.state.currentPost.postID;
//     final response = await httpClient.get(
//         'https://us-central1-utes-20591.cloudfunctions.net/getSolutions_v0/?postId=$postId');
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List;
//       final solutions = data.map((rawSolution) {
//         return Solution(
//           uid: rawSolution['uid'],
//           photoURL: rawSolution['photoURL'],
//           title: rawSolution['title'],
//           solutionFile: File(
//             path: rawSolution['solutionFileURL'],
//             fileName: rawSolution['fileName'],
//             fileExtension: rawSolution['fileExtension'],
//             fileSize: rawSolution['fileSize'],
//           ),
//           dateCreated: rawSolution['dateCreated'],
//         );
//       }).toList();
//       emit(
//         state.copyWith(
//           solutions: solutions,
//           status: SolutionNotificationStatus.fetched,
//         ),
//       );
//     } else {
//       throw Exception('error fetching solutions');
//     }
//   }

//   void _addSolution(Solution solution) {
//     // if (solution.title.isEmpty) return;
//     final updateSolutions = List.of(state.solutions)..add(solution);
//     emit(
//       state.copyWith(
//         recentSolution: solution,
//         recentSolutionTotal: state.recentSolutionTotal + 1,
//         solutions: updateSolutions,
//         status: SolutionNotificationStatus.newSolutionAdded,
//       ),
//     );
//   }
// }
