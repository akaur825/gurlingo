// lib/services/lesson_audio_player.dart
//
// The one audio player used for lessons and quizzes. Playing a new clip stops
// the previous one, tapping the clip that is playing stops it, and disposing
// the player (when its screen closes) stops all sound.
//
// It uses the plain audioplayers defaults on purpose (no custom audio context
// or player mode). Play requests are serialised, so tapping several buttons
// quickly cannot start a second stream before the first has been stopped.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class LessonAudioPlayer extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  /// The asset path that is playing right now, or null.
  String? playingPath;

  Future<void> _queue = Future.value();
  bool _disposed = false;

  LessonAudioPlayer() {
    _player.onPlayerComplete.listen((_) {
      playingPath = null;
      _notify();
    });
  }

  // Runs [task] after every earlier request has finished.
  Future<void> _enqueue(Future<void> Function() task) {
    _queue = _queue.then((_) => task()).catchError((Object e) {
      debugPrint('Audio error: $e');
    });
    return _queue;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  /// Plays [path] from the start, stopping whatever was playing.
  Future<void> play(String path) {
    playingPath = path;
    _notify();
    return _enqueue(() async {
      if (_disposed || playingPath != path) return; // a newer tap replaced it
      try {
        await _player.stop();
        // AssetSource expects the path without the leading "assets/".
        await _player.play(AssetSource(path.replaceFirst('assets/', '')));
      } catch (e) {
        debugPrint('Error playing audio ($path): $e');
        if (playingPath == path) {
          playingPath = null;
          _notify();
        }
      }
    });
  }

  /// Plays [path], or stops it if it is the clip already playing.
  Future<void> toggle(String path) {
    if (playingPath == path) return stop();
    return play(path);
  }

  /// Stops any sound right away.
  Future<void> stop() {
    playingPath = null;
    _notify();
    return _enqueue(() async {
      await _player.stop();
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _player.stop().whenComplete(_player.dispose);
    super.dispose();
  }
}
