import 'package:artsen_van/bindings/quiz_binding.dart';
import 'package:artsen_van/controllers/course_controller.dart';
import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/controllers/media_controller.dart';
import 'package:artsen_van/screens/quiz/quiz_screen.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/utils/util_functions.dart';
import 'package:artsen_van/widgets/custom_button.dart';
import 'package:artsen_van/widgets/small_round_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({Key? key}) : super(key: key);

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final chapterId = Get.arguments[0];
  final _courseController = Get.find<CourseController>();
  final controller = Get.find<GlobalController>();

  @override
  void initState() {
    super.initState();
    _courseController.getChapterById(chapterId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<GlobalController>(builder: (controller) {
      return Scaffold(
        backgroundColor:
            controller.isLightTheme.value ? COLOR_OFFWHITE : COLOR_DARK_BLUE,
        body: SafeArea(
            child: Obx(
          () => _courseController.isChapterLoading.value
              ? Center(
                  child: SpinKitFadingCube(
                    color: Colors.cyan,
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            controller.isLightTheme.value
                                ? 'assets/images/logo-light.png'
                                : 'assets/images/logo-dark.png',
                            width: Get.width * 0.5,
                            fit: BoxFit.fill,
                          ),
                          SmallButton(
                            icon: Icons.settings,
                            onPressed: () => Get.to(() => SettingsScreen()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        '${_courseController.chapter['chapter']['title']}',
                        style: !controller.isLightTheme.value
                            ? textTheme.headline1
                            : textTheme.headline2,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 6.0, left: 4.0, right: 4.0, bottom: 4.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: controller.isLightTheme.value
                                      ? Colors.transparent
                                      : Colors.cyan),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.isLightTheme.value
                                      ? Colors.grey.shade400
                                      : Colors.transparent,
                                  blurRadius: 9.0, // soften the shadow
                                  offset: Offset(
                                    1.0, // Move to right 10  horizontally
                                    3.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: controller.isLightTheme.value
                                  ? Colors.white
                                  : COLOR_DARK_BLUE),
                          child: ListView.builder(
                              padding: EdgeInsets.only(
                                  top: 8.0, left: 10.0, right: 10.0),
                              itemCount:
                                  _courseController.chapter['content'].length,
                              itemBuilder: (context, index) {
                                return
                                    // Text('${_courseController.chapter['content'][index]['Type']}');
                                    dynamicWidget(
                                        textTheme,
                                        _courseController.chapter['content']
                                            [index]['Type'],
                                        _courseController.chapter['content']
                                            [index]);
                              }),
                        ),
                      ),
                      Center(
                          child: CustomButton(
                        text: 'Take Quiz',
                        height: 42,
                        width: 140,
                        onPressed: () =>
                            Get.to(()=> QuizScreen(), arguments: [_courseController.chapter['quiz_id']], binding: QuizBinding()),
                      ))
                    ],
                  ),
                ),
        )),
      );
    });
  }

  Container dynamicWidget(textTheme, type, content) {
    if (type == 'text') {
      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Text(
          content['text'],
          style: !controller.isLightTheme.value
              ? textTheme.bodyText1
              : textTheme.bodyText2,
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
      );
    } else if (type == 'image') {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.only(bottom: 16.0),
        height: Get.height * 0.25,
        width: double.infinity,
        child: Image.network(
          '${dotenv.env['base_url']}${content['file']}',
          fit: BoxFit.fill,
        ),
      );
    } else if (type == 'heading') {
      return Container(
          margin: EdgeInsets.only(bottom: 16.0),
          child: Text(
            '${content['text']}',
            style: !controller.isLightTheme.value
                ? textTheme.headline3
                : textTheme.headline4,
          ));
    } else if (type == 'video') {
      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: VideoPlayer(
          videoUrl: '${dotenv.env['base_url']}${content['file']}',
        ),
      );
    } else if (type == 'audio') {
      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child:
            MyAudioPlayer(url: '${dotenv.env['base_url']}${content['file']}'),
      );
    }
    return Container();
  }
}

class MyAudioPlayer extends StatefulWidget {
  MyAudioPlayer({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  final globalController = Get.find<GlobalController>();
  bool isPlaying = false;

  Duration duration = Duration();
  Duration position = Duration();

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _audioPlayer.seek(newPos);
  }

  void getAudio(url) async {
    if (isPlaying) {
      // pause audio
      var res = await _audioPlayer.pause();
      if (res == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else {
      // play audio
      var res = await _audioPlayer.play(url);
      if (res == 1) {
        setState(() {
          isPlaying = true;
          _audioPlayer.setPlaybackRate(globalController.audioSpeed);
        });
      }
    }
    _audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlaying = false;
      });
      showSnackBar('Audio Finished', 'You have completed the audio lesson',
          icon: Icon(
            Icons.multitrack_audio,
            color: Colors.cyan,
          ));
      _audioPlayer.dispose();
      _audioPlayer = AudioPlayer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 14.0, bottom: 2.0, top: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(colors: [Colors.cyan, Color(0xff1ae8e8)])),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Slider(
                    min: 0.0,
                    activeColor: Colors.cyanAccent,
                    inactiveColor: Colors.grey[350],
                    value: position.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    thumbColor: Colors.white,
                    onChanged: (value) {
                      print(value);
                      seekToSec(value.toInt());
                    }),
              ),
              GestureDetector(
                  onTap: () {
                    getAudio(widget.url);
                  },
                  child: Icon(
                    !isPlaying ? Icons.play_arrow : Icons.pause,
                    size: 43,
                    color: Colors.white,
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' ${position.inMinutes}:${position.inSeconds.remainder(60)}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(),
                Text(
                    ' ${duration.inMinutes}:${duration.inSeconds.remainder(60)}',
                    style: TextStyle(color: Colors.white, fontSize: 12))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, this.videoUrl}) : super(key: key);
  final videoUrl;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final mediaCOntroller = Get.find<MediaController>();

  // ChewieController? chewieController;
  // VideoPlayerController? videoPlayerController ;

  @override
  void initState() {
    super.initState();
    // mediaCOntroller.initializePlayer('abcd',chewieController, videoPlayerController);
    mediaCOntroller.initializePlayer(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaController>(builder: (controller) {
      return Container(
          height: Get.height * 0.27,
          width: double.infinity,
          child: !controller.isVideoLoading.value
              ? Chewie(
                  controller: controller.chewieController!,
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                ));
    });
  }
}
