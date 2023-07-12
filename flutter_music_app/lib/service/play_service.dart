import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

@immutable
abstract final class IMusicService {
  late AudioPlayer audioPlayer;
  late OnAudioQuery onAudioQuery;
  void Audioinit();

  Future<List<SongModel>> songModelList();
}

base class MusicService extends IMusicService {
  static MusicService? _instance;
  static MusicService get instance {
    if (_instance != null) return _instance!;
    _instance = MusicService._init();
    return _instance!;
  }

  @override
  MusicService._init() {
    Audioinit();
  }
  void Audioinit() {
    audioPlayer = AudioPlayer();
    onAudioQuery = OnAudioQuery();
  }

  @override
  Future<List<SongModel>> songModelList() async {
    var listem = await onAudioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
    return listem;
  }
}
