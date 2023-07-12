import 'package:flutter/material.dart';
import 'package:flutter_music_app/product/companent/listile_leading.dart';
import 'package:flutter_music_app/service/play_service.dart';
import 'package:flutter_music_app/product/theme/mytheme.dart';
import 'package:flutter_music_app/view/play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SongModel> sarkiListem = [];
  @override
  void initState() {
    // TODO: implement initState
    MusicService.instance.songModelList().then((value) {
      setState(() {
        sarkiListem = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: MyTheme.backgroundColor,
        ),
        child: FutureBuilder<List<SongModel>>(
            future: MusicService.instance.songModelList(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.white),
                );
              else if (snapshot.data!.isEmpty)
                return Center(
                    child: Text(
                  "Not Sound Found",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: MyTheme.white),
                ));
              else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayScreen(
                                      songmodel: sarkiListem[index],
                                      listem: sarkiListem,
                                      audioPlayer:
                                          MusicService.instance.audioPlayer,
                                      index: index)));
                        },
                        child: ListTile(
                          leading: ListileLeading(),
                          title: Text(snapshot.data![index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: MyTheme.white)),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
