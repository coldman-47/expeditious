import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nrj_express/api/livraison_service.dart';
import 'package:nrj_express/models/livraison.dart';
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
  late String filePath;
  bool _isRecord = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // startIt();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonBar(alignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade100)),
              onPressed: () {},
              child: Container(
                  height: 150,
                  width: 175,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/van.png'),
                          fit: BoxFit.contain)))),
        ]),
        const SizedBox(
          height: 56,
        ),
        Center(
            child: Column(
          children: [
            ElevatedButton(
              child: Icon(_isRecord ? Icons.stop : Icons.mic),
              onPressed: () {
                setState(() {
                  _isRecord = !_isRecord;
                });
                if (_isRecord) record();
                if (!_isRecord) stopRecord();
              },
            ),
            const SizedBox(
              height: 56,
            ),
            ElevatedButton(
              child: Icon(!_isPlaying ? Icons.stop : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
                if (!_isPlaying) startPlaying();
                if (_isPlaying) stopPlaying();
              },
            ),
            ElevatedButton(
              child: const Text("Envoyer"),
              onPressed: startPlaying,
            ),
            SizedBox(
              height: 56,
            ),
            ElevatedButton(
              child: Icon(Icons.send),
              onPressed: () {
                sendAudio();
              },
            )
          ],
        ))
      ],
    );
  }

  void startIt() async {
    filePath = '/sdcard/Download/Express/audio.wav';
    _myRecorder = FlutterSoundRecorder();
    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription =
        _myRecorder.onProgress!.listen((e) {
      // var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //     isUtc: true);
    });
    _recorderSubscription.cancel();
  }

  Future<String> stopRecord() async {
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder().then((value) => value.toString());
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }

  void sendAudio() {
    Livraison delivery = Livraison();

    delivery.audio = audioPlayer
        .open(Audio.file("/sdcard/Download/Express/audio.wav"))
        .toString();
    final livraisonSrv = LivraisonService();
    livraisonSrv.create(delivery);
  }
}
