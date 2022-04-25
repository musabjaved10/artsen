import 'package:artsen_van/screens/courses/chapter_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class MediaController extends GetxController {
  RxBool isVideoLoading = true.obs;
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    print('im init');
  }
  @override
  void onClose() {
    super.onClose();
    if(videoPlayerController != null ){
      videoPlayerController!.dispose();
    }
    if(chewieController != null ){
      chewieController!.dispose();
    }

  }

  Future<void> initializePlayer(url) async{
    isVideoLoading.value = true ;
    update();
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController!.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        materialProgressColors: ChewieProgressColors(
          handleColor: Colors.cyan,
          playedColor: Colors.lightBlue,
          // backgroundColor: KPrimaryColor
        ),
        autoInitialize: true
    );
    await Future.delayed(Duration(seconds: 3));
    isVideoLoading.value = false;
    update();
  }
}