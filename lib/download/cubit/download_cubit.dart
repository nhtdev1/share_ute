import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  static DownloadCubit _instance;

  DownloadCubit._() : super(const DownloadState()) {
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, 'downloader_send_port');
    _receivePort.listen((data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      emit(state.copyWith(percentage: data[2]));
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  final ReceivePort _receivePort = ReceivePort();

  static DownloadCubit get instance {
    if (_instance == null) {
      _instance = DownloadCubit._();
    }
    return _instance;
  }

  @override
  Future<void> close() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    return super.close();
  }

  void reset() {
    emit(state.copyWith(
      taskId: '',
      percentage: 0,
      status: DownloadStatus.unknown,
    ));
  }

  static downloadCallback(id, status, progress) {
    final SendPort sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    sendPort.send([id, status, progress]);
  }

  Future<void> downloadFile({
    @required String url,
    @required String fileName,
    bool showNotification = true,
    bool openFileFromNotification = true,
  }) async {
    emit(state.copyWith(status: DownloadStatus.downloadInProgress));
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final baseStorage = await getExternalStorageDirectory();
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          fileName: fileName,
          showNotification: showNotification,
          openFileFromNotification: openFileFromNotification,
          savedDir: baseStorage.path,
        );
        emit(state.copyWith(
          taskId: taskId,
          status: DownloadStatus.downloadSuccess,
        ));
      } on Exception {
        emit(state.copyWith(status: DownloadStatus.downloadFailure));
      }
    } else {
      emit(state.copyWith(status: DownloadStatus.downloadFailure));
    }
  }
}
