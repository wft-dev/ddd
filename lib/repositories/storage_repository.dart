import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'storage_repository.g.dart';

class StorageRepository {
  ValueNotifier<double> uploadProgress = ValueNotifier<double>(0);
  Future<String> getImageUrl(String key) async {
    final result = await Amplify.Storage.getUrl(
      key: key,
      options: const StorageGetUrlOptions(
        pluginOptions: S3GetUrlPluginOptions(
          validateObjectExistence: true,
          expiresIn: Duration(days: 1),
        ),
        accessLevel: StorageAccessLevel.private,
      ),
    ).result;
    return result.url.toString();
  }

  ValueNotifier<double> getUploadProgress() {
    return uploadProgress;
  }

  Future<String?> uploadFile(File file) async {
    try {
      final extension = p.extension(file.path);
      final key = 'images/${const Uuid().v1()}$extension';
      final awsFile = AWSFile.fromPath(file.path);
      const options = StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.private,
      );
      await Amplify.Storage.uploadFile(
        localFile: awsFile,
        key: key,
        options: options,
        onProgress: (progress) {
          uploadProgress.value = progress.fractionCompleted;
        },
      ).result;

      return key;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void resetUploadProgress() {
    uploadProgress.value = 0;
  }
}

//[StorageRepository] provider.
@riverpod
StorageRepository storageRepository(StorageRepositoryRef ref) {
  return StorageRepository();
}
