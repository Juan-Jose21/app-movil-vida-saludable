import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/providers/login_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginProviders loginProviders = LoginProviders();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(isValidForm(email, password)){

      ResponseApi responseApi = await loginProviders.login(email, password);

      if (responseApi.success == true) {

        GetStorage().write('User', responseApi.data);
        goToHomePage();

      }
      else {
        Get.snackbar('Login Fallido', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/bar', (route) => false);
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formilario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formilario no valido', 'Debes ingresar el password');
      return false;
    }

    return true;

  }

}
