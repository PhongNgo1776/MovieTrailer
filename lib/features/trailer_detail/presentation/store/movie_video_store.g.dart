// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieVideoStore on MovieVideoStoreBase, Store {
  late final _$videoUrlAtom =
      Atom(name: 'MovieVideoStoreBase.videoUrl', context: context);

  @override
  String? get videoUrl {
    _$videoUrlAtom.reportRead();
    return super.videoUrl;
  }

  @override
  set videoUrl(String? value) {
    _$videoUrlAtom.reportWrite(value, super.videoUrl, () {
      super.videoUrl = value;
    });
  }

  late final _$getVideoPathAsyncAction =
      AsyncAction('MovieVideoStoreBase.getVideoPath', context: context);

  @override
  Future<void> getVideoPath(int id) {
    return _$getVideoPathAsyncAction.run(() => super.getVideoPath(id));
  }

  @override
  String toString() {
    return '''
videoUrl: ${videoUrl}
    ''';
  }
}
