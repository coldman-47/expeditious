import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:nrj_express/api/livraison_service.dart';
import 'package:nrj_express/components/modal_post_creation.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path/path.dart' as path;

class Record extends StatefulWidget {
  final String title = 'Envoyer un message vocal';
  final int index = 3;
  final double stepValue = 1;
  final Livraison delivery;
  const Record({Key? key, required this.delivery}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  String filePath = '';
  bool _isRecord = false;
  bool _isPlaying = false;
  late Duration audioDuration;
  final List<Color> colors = [
    Colors.orange[700]!,
    Colors.blue[900]!,
    Colors.blueGrey,
    Colors.blue[100]!,
    Colors.blueGrey[900]!,
    Colors.lightBlue[300]!
  ];
  late dynamic wave = Container();
  bool sending = false;

  final List<int> duration = [900, 700, 600, 800, 500];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
                child: Column(children: [
              SizedBox(
                  height: 100,
                  width: 250,
                  child: Opacity(
                    child: wave,
                    opacity: _isPlaying ? 1 : 0,
                  )),
              TextButton(
                child: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                style: TextButton.styleFrom(
                    primary: Colors.blueGrey[filePath != '' ? 900 : 200]),
                onPressed: () {
                  if (filePath != '') {
                    if (!_isPlaying) startPlaying();
                    if (_isPlaying) stopPlaying();
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  }
                },
              )
            ])),
            ElevatedButton(
              child: GestureDetector(
                child: Icon(Icons.mic, size: _isRecord ? 40 : 35),
                onLongPress: () {
                  startIt();
                  record();
                },
                onLongPressUp: () {
                  stopRecord();
                },
              ),
              style: ElevatedButton.styleFrom(
                  primary:
                      !_isRecord ? Colors.blueGrey[900] : Colors.amber[800],
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(_isRecord ? 20 : 15)),
              onPressed: () {},
            ),
            Container(
                constraints: const BoxConstraints(maxWidth: 225),
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.amber[700]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('SOUMETTRE  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        sending
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(Icons.send)
                      ],
                    ),
                    onPressed: () async {
                      var submit = await sendAudio();
                      print(submit);
                      if (submit == true) {
                        popUpPostCreation(context);
                      }
                    }))
          ],
        ));
  }

  void startIt() async {
    if (await Permission.microphone.isGranted) {
      _myRecorder = FlutterSoundRecorder();
      await _myRecorder.openAudioSession(
          focus: AudioFocus.requestFocusAndStopOthers,
          category: SessionCategory.playAndRecord,
          mode: SessionMode.modeDefault,
          device: AudioDevice.speaker);
      await _myRecorder
          .setSubscriptionDuration(const Duration(milliseconds: 10));
      await initializeDateFormatting();
    } else {
      await Permission.microphone.request();
    }
  }

  Future<void> record() async {
    Directory tempDir = await getTemporaryDirectory();
    filePath = tempDir.path + '/new_delivery.wav';
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
    setState(() {
      _isRecord = true;
      wave = MusicVisualizer(
        barCount: 45,
        colors: colors,
        duration: duration,
        curve: Curves.bounceInOut,
      );
    });
  }

  Future<void> stopRecord() async {
    await _myRecorder.stopRecorder().then((value) => value.toString());
    setState(() {
      _isRecord = false;
    });
    return await _myRecorder.closeAudioSession();
  }

  Future<void> startPlaying() async {
    await audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
    audioDuration = audioPlayer.realtimePlayingInfos.value.duration;
    Future.delayed(audioDuration, () {
      if (_isPlaying) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }

  Future<dynamic> sendAudio() async {
    widget.delivery.status = 'NEW';
    try {
      final File fileDir = File(filePath);
      dynamic file = await fileDir.readAsBytes();
      widget.delivery.audio = base64.encode(file);
    } catch (e) {
      print("Couldn't read file");
    }
    final livraisonSrv = LivraisonService();
    setState(() {
      sending = true;
    });
    if (sending) {
      return await livraisonSrv.create(widget.delivery);
    }
  }
}
