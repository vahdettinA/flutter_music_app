import 'package:flutter/material.dart';
import 'package:flutter_music_app/product/theme/mytheme.dart';
import 'package:flutter_music_app/service/play_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayScreen extends StatefulWidget {
  SongModel songmodel;
  List<SongModel> listem;
  AudioPlayer audioPlayer;
  int index;
  PlayScreen({
    required this.songmodel,
    required this.listem,
    required this.audioPlayer,
    required this.index,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Duration duration = Duration();
  Duration position = Duration();
  bool isplaying = false;
  playSong() {
    try {
      isplaying = true;
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songmodel.uri!)));
      widget.audioPlayer.play();
    } on Exception {
      print("dennene");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset(
                "assets/images/ic_arkaplan.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Row(
              children: [
                Text(
                  position.toString().split('.')[0],
                  style: TextStyle(color: MyTheme.white),
                ),
                Expanded(
                  child: Slider(
                    activeColor: MyTheme.textColor,
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changeToSeconds(value.toInt());
                        value = value;
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        changeToSeconds(value.toInt());
                        if (value == duration) {
                          widget.index += 1;
                          widget.songmodel = widget.listem[widget.index];
                          playSong();
                        }
                      });
                    },
                  ),
                ),
                Text(
                  duration.toString().split('.')[0],
                  style: TextStyle(color: MyTheme.white),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.index > 0) {
                        setState(() {
                          widget.index = widget.index - 1;
                          widget.songmodel = widget.listem[widget.index];
                          playSong();
                        });
                      } else {
                        setState(() {
                          widget.index = widget.listem.length - 1;
                          widget.songmodel = widget.listem[widget.index];
                          playSong();
                        });
                      }
                    },
                    icon: Icon(
                      Icons.skip_previous,
                      color: MyTheme.white,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isplaying = !isplaying;
                      });
                      if (isplaying) {
                        widget.audioPlayer.play();
                      } else {
                        widget.audioPlayer.pause();
                      }
                    },
                    icon: Icon(
                      isplaying ? Icons.pause : Icons.play_arrow,
                      color: MyTheme.white,
                    )),
                IconButton(
                    onPressed: () {
                      if (widget.index < widget.listem.length) {
                        setState(() {
                          widget.index = widget.index + 1;
                          widget.songmodel = widget.listem[widget.index];
                          playSong();
                        });
                      } else {
                        widget.index = 0;
                        widget.songmodel = widget.listem[widget.index];
                        playSong();
                      }
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: MyTheme.white,
                    )),
              ],
            )
          ],
        ));
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
