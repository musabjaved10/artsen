import 'dart:convert';

import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/utils/util_functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class QuizController extends GetxController{
  final _globalController = Get.find<GlobalController>();

  RxBool isQuizLoading = false.obs;
  Map quiz = {};
  int numOfQuestions = 0;
  int currentIndex = 0;
  Map currentQuestion = {};
  List options = [];
  bool isAnswered = false;
  int correctIndex = 0;
  int selectedIndex = 0;
  bool quizFinished = false;

  getQuizById(quizId) async{
    print('printing chapter id $quizId');
    isQuizLoading.value = true;
    quiz = {};
    try {
      final userId = _globalController.userData['uid'];
      final url = Uri.parse('${dotenv.env['db_url']}/quiz/$quizId');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final resData = jsonDecode(res.body);
      if (resData['status'] == 200) {
        quiz = resData['success']['data']['quiz'];
        numOfQuestions = quiz['questions'].length;
        getCurrentQuestion();
        print('printing single quiz ${quiz['name']}');

      } else if (resData['status'] != 200 && resData['errors'] != null) {
        showSnackBar('Error', resData['errors'].values.first);
      }
    } catch (e) {
      print('Error while fetching single chapter : $e}');
    } finally {
      isQuizLoading.value = false;
    }
  }

  getCurrentQuestion(){
    currentQuestion = quiz['questions'][currentIndex];
    options = quiz['questions'][currentIndex]['options'];
    for(int i=0; i <options.length; i++){
      if(options[i]['is_correct'] == true ){
        correctIndex = i;
      }
    }
    print(correctIndex);
    update();
  }

  getNextQuestion(){
    currentIndex += 1;
    isAnswered = false;
    getCurrentQuestion();
    update();
  }

  checkFinished(){
    if(currentIndex+1 == numOfQuestions){
      quizFinished = true;
      update();
      return;
    }
  }

  submitOption(index){
    selectedIndex = index;
    update();
  }

  isCorrectlyAnswered(index){
    if(isAnswered) return;
    submitOption(index);
    isAnswered = true;
    if(selectedIndex == correctIndex){
      update();
      return true;
    }
    update();
    return false;
  }
}