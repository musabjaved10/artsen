import 'dart:convert';

import 'package:artsen_van/controllers/global_controller.dart';
import 'package:artsen_van/models/course_model.dart';
import 'package:artsen_van/screens/courses/enrolled_courses_screen.dart';
import 'package:artsen_van/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSingleCourseLoading = false.obs;
  RxBool isChapterLoading = false.obs;
  final _globalController = Get.find<GlobalController>();
  RxList enrolledCourses = [].obs;
  Map chapter = {};

  late SingleCourseModel singleCourse;


  Future<void> getAllEnrolledCourses() async {
    isLoading.value = true;
    enrolledCourses.value = [];
    try {
      final userId = _globalController.userData['uid'];
      final url = Uri.parse('${dotenv.env['db_url']}/course');
      final res = await http.get(url,
          headers: {
            "api-key": "${dotenv.env['api_key']}",
            "uid": "$userId"
          });
      final resData = jsonDecode(res.body);
      if (resData['status'] == 200) {
        final courses = resData['success']['data']['course'];
        for (var course in courses) {
          enrolledCourses.add(CourseModel(
              id: course['id'],
              title: course['title'],
              tag: course['topic'],
              description: course['description'],
              progressValue: course['progress']['progress'],
              status: course['progress']['status']));
        }
        print(enrolledCourses.value);
      } else if (resData['status'] != 200 && resData['errors'] != null) {
        showSnackBar('Error', resData['errors'].values.first);
      }
    } catch (e) {
      print('Error in all courses $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSingleCourseById(courseId) async {
    isSingleCourseLoading.value = true;
    try {
      final userId = _globalController.userData['uid'];
      final url = Uri.parse('${dotenv.env['db_url']}/course/$courseId');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final resData = jsonDecode(res.body);
      if (resData['status'] == 200) {
        final course = resData['success']['data']['course'];
        final chapters = resData['success']['data']['chapters'];
        singleCourse = SingleCourseModel(
            id: course['id'],
            title: course['title'],
            tag: course['topic'],
            description: course['description'],
            progressValue: course['progress']['progress'],
            status: course['progress']['status'],
            chapters: chapters
        );

        print('printing single course ${singleCourse.chapters}');
      } else if (resData['status'] != 200 && resData['errors'] != null) {
        showSnackBar('Error', resData['errors'].values.first);
      }
    } catch (e) {
      print('Error while fetching single course : $e}');
    } finally {
      isSingleCourseLoading.value = false;
    }
  }

  Future<void>getChapterById(chapterId) async {
    print('printing chapter id $chapterId');
    isChapterLoading.value = true;
    chapter = {};
    try {
      final userId = _globalController.userData['uid'];
      final url = Uri.parse('${dotenv.env['db_url']}/chapter/$chapterId');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final resData = jsonDecode(res.body);
      if (resData['status'] == 200) {
        chapter = resData['success']['data'];
        print('printing single chapter ${chapter['content']}');

      } else if (resData['status'] != 200 && resData['errors'] != null) {
        showSnackBar('Error', resData['errors'].values.first);
      }
    } catch (e) {
      print('Error while fetching single chapter : $e}');
    } finally {
      isChapterLoading.value = false;
    }
  }

  Future<void>submitCourseReview(courseId) async {
    await showCustomDialog('Submitting Review');
    showSnackBar('Review Submitted', 'Thank you for choosing this course', icon: Icon(Icons.check_circle, color: Colors.green,));
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(EnrolledCoursesScreen());
    // print('printing chapter id $courseId');
    // isChapterLoading.value = true;
    // chapter = {};
    // try {
    //   final userId = _globalController.userData['uid'];
    //   final url = Uri.parse('${dotenv.env['db_url']}/course/$courseId');
    //   final res = await http.get(url,
    //       headers: {"api-key": "${dotenv.env['api_key']}", "uid": "H9OCgGXRiwMYPJFwgYvFeVmybq23"});
    //   final resData = jsonDecode(res.body);
    //   if (resData['status'] == 200) {
    //     chapter = resData['success']['data'];
    //     print('printing single chapter ${chapter['content']}');
    //
    //   } else if (resData['status'] != 200 && resData['errors'] != null) {
    //     showSnackBar('Error', resData['errors'].values.first);
    //   }
    // } catch (e) {
    //   print('Error while fetching single chapter : $e}');
    // } finally {
    //   isChapterLoading.value = false;
    // }
  }


}
