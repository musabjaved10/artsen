import 'dart:convert';
import 'package:artsen_van/screens/authentication/login_screen.dart';
import 'package:artsen_van/screens/root.dart';
import 'package:artsen_van/screens/settings_screen.dart';
import 'package:artsen_van/utils/constants.dart';
import 'package:artsen_van/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:http/http.dart' as http;

class GlobalController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  Map userData = {};
  RxBool isLightTheme = true.obs;
  RxBool isFontLarge = false.obs;
  late TextEditingController emailController,
      passController,
      fullNameController;
  late ShakeDetector shakeDetector;
  double audioSpeed = 1.0;

  RxBool isLoading = false.obs;

  String? get user => _firebaseUser.value?.email;

  @override
  void onInit() {
    shakeDetector = ShakeDetector.autoStart(onPhoneShake: () => changeTheme());
    super.onInit();
    if (_auth.currentUser != null) {
      getUserData();
    }
    _firebaseUser.bindStream(_auth.authStateChanges());
    emailController = TextEditingController();
    passController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    shakeDetector.stopListening();
  }

  void changeTheme() async{
    isLightTheme.value = !isLightTheme.value;
    showCustomDialog('Updating Contrast');
    final res = await updateProfile();
    closeCustomDialog();
    if(res){
      update();
      return;
    }
    isLightTheme.value = !isLightTheme.value;
    showSnackBar('Error', 'Could not update.');
    Get.to(() => SettingsScreen());

  }

  void changeFont() async{
    isFontLarge.value = !isFontLarge.value;
    showCustomDialog('Updating Font');
    final res = await updateProfile();
    closeCustomDialog();
    if(res){
      update();
      return;
    }
    isFontLarge.value = !isFontLarge.value;
    showSnackBar('Error', 'Could not update.');
    Get.to(() => SettingsScreen());
  }

  void changeAudioPlaybackSpeed(value) {
    audioSpeed = value;
    update();
  }

  // Function to Register User
  void registerUser(String email, String password,
      String fullName,) async {
    print(email+'@artsenvanmorgen.nl');
    if(email.contains('@')){
      return showSnackBar('Error', 'Domain name is not required in the email');
    }
    isLoading.value = true;
    showCustomDialog('Signing Up...');

    await _auth
        .createUserWithEmailAndPassword(email: email+'@artsenvanmorgen.nl', password: password)
        .then((u) async {
      Map<String, String> userDataForApi = {
        'full_name': fullName,
        'email': email+'@artsenvanmorgen.nl',
      };

      try {
        final url =
            Uri.parse('${dotenv.env['db_url']}/user/${u.user!.uid}');
        final res = await http.post(url,
            headers: {'api-key': '${dotenv.env['api_key']}', 'Content-Type': 'application/json'},
            body: jsonEncode(userDataForApi));
        print(userDataForApi);
        final resData = jsonDecode(res.body);
        print('printing res data $resData');

        if (resData['status'] == 200) {
          await getUserData();
          isLoading.value = false;
          print('printing user data $userData');
          closeCustomDialog();
          Get.offAll(() => Root());

          //check if is_profile-completed

        } else if ((resData['status'] != 200) && (resData['errors'] != null)) {
          closeCustomDialog();
          isLoading.value = false;
          Get.snackbar('Error', resData['errors'].values.first,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white);
          FirebaseAuth.instance.currentUser!.delete();
        }
      } catch (e) {
        print('Im in catches $e');
        FirebaseAuth.instance.currentUser!.delete();
        Get.snackbar('Error', 'Error',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      } finally {
        isLoading.value = false;
        closeCustomDialog();
      }
    }).catchError((onError) {
      Get.snackbar('Error', onError.message,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      print('inside firebase email');
      closeCustomDialog();
    });
  }

  //Function to login User
  void login( String email, String password) async {
    if(email.contains('@')){
      return showSnackBar('Error', 'Domain name is not required in the email');
    }
    try{
      isLoading.value = true;
      showCustomDialog('Loggin in...');
      await _auth
          .signInWithEmailAndPassword(email: email+'@artsenvanmorgen.nl', password: password)
          .then((value) async {
        print('signInWithEmailAndPassword with value: $value');
        isLoading.value = false;
        closeCustomDialog();
        await getUserData();
        print('Printing the user status ${userData.isEmpty}');
        Get.offAll(() => Root());
      }).catchError((onError) {
        closeCustomDialog();
        print('whoops');
        print(onError);
        isLoading.value = false;
        showSnackBar('Error', onError.message);
      });
    }catch(e){
      print('Im in the catch of login $e');
    }finally{
      isLoading.value = false;
      closeCustomDialog();
    }

  }

  Future updateProfile() async {
    print('called');
    isLoading.value = true;
    try {
      final url = Uri.parse('${dotenv.env['db_url']}/user/${userData['uid']}');
      final Map<String, dynamic> info = {
        "full_name": userData['full_name'],
        "is_light_theme": isLightTheme.value,
        "is_font_large": isFontLarge.value
      };
      final response = await http.patch(url,
          headers: {
            'api-key': '${dotenv.env['api_key']}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(info));
      final resData = jsonDecode(response.body);
      print("Printing response for updating profile $resData");
      if (resData['status'] == 200) {
        await getUserData();
        isLoading.value = false;
        showSnackBar('Success', 'Settings updated');
        return true;
      } else if (resData['status'] != 200 && resData['errors'] != null) {
        showSnackBar('Error', resData['errors'].values.first);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void signOut() async {
    await showCustomDialog('Signing Out...');
    await _auth
        .signOut()
        .then((value) => Get.offAll(() => LoginScreen()));
    userData = {};
    fullNameController.text = '';
    emailController.text = '';
    passController.text = '';
  }

  getUserData() async {
    print('getUserData function called');
    isLoading.value = true;
    try {
      final userId = _auth.currentUser?.uid;
      final url = Uri.parse('${dotenv.env['db_url']}/user/$userId');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final data = jsonDecode(res.body);
      if (data['status'] != 200 && data['errors'] != null) {
        FirebaseAuth.instance.currentUser!.delete();
        showSnackBar('Error', data['errors'].values.first);
        return;
      }
      userData = data['success']['data']['user'];
      print(userData);
      isLightTheme.value = userData['is_light_theme'];
      isFontLarge.value = userData['is_font_large'];
      isLoading.value = false;
      update();
      return ;
    } catch (e) {
      isLoading.value = false;
      print('error in fetching one user $e');
    }
  }
}
