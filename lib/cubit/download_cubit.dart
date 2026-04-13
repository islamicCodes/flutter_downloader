import 'package:flutter/material.dart';
import 'package:flutter_downloader/downloader_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/src/download_manager.dart';
import 'download_state.dart';

class DownloadCubit extends Cubit<DownloadStates> {
  static DownloadCubit get(BuildContext context) => BlocProvider.of(context);

  DownloadCubit() : super(DownloadInitialState());

  void publishGotAndroidListData(String listData) {
   DownloadManager().getAndroidList(listData);
  }

  void publishAdded({required String url, String? androidListData})  {
    if (DownloaderPlugin.isPlatformAndroid()) {
      DownloadManager().getAndroidList(androidListData);
    }
    emit(DownloadAddedState(url));
  }

  void publishProgress({required String url, required int progress , String? androidListData})  {
    if (DownloaderPlugin.isPlatformAndroid()) {
      DownloadManager().getAndroidList(androidListData);
    }
    else
      {
        DownloadManager().updateIosProgress(url, progress);
      }
    emit(DownloadProgressState(url, progress));
  }

  void publishCanceled({required String url, String? androidListData})  {
    if (DownloaderPlugin.isPlatformAndroid()) {
      DownloadManager().getAndroidList(androidListData);
    }
    emit(DownloadCanceledState(url));
  }

  void publishCompleted({required String url, String? androidListData})  {
    if (DownloaderPlugin.isPlatformAndroid()) {
      DownloadManager().getAndroidList(androidListData);
      emit(DownloadCompletedState(url));
    } else if (DownloaderPlugin.isPlatformIos()) {
      DownloadManager().iosRemoveDownload(url);
      emit(DownloadCompletedState(url));
      if (DownloaderPlugin.isSerial) {
        DownloadManager().iosCheckToDownloadNext();
      }
    }
  }

  void publishError({required String url, String? error , String? androidListData})  {
    if (DownloaderPlugin.isPlatformAndroid()) {
      DownloadManager().getAndroidList(androidListData);
      emit(DownloadErrorState(url,error));
    } else if (DownloaderPlugin.isPlatformIos()) {
      DownloadManager().iosRemoveDownload(url);
      emit(DownloadErrorState(url,error));
      if (DownloaderPlugin.isSerial) {
        DownloadManager().iosCheckToDownloadNext();
      }
    }
  }

  void publishFileDeleted(String url) {
    emit(DownloadFileDeletedState(url));
  }
}
