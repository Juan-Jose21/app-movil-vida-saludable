import 'package:app_vida_saludable/src/controllers/home_controller.dart';
import 'package:app_vida_saludable/src/models/response_api.dart';
import 'package:app_vida_saludable/src/pages/home/home_pages.dart';
import 'package:app_vida_saludable/src/providers/login_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginProviders loginProviders = LoginProviders();

  void login() async {
    String correo = emailController.text.trim();
    String password = passwordController.text.trim();

    if(isValidForm(correo, password)){

      ResponseApi responseApi = await loginProviders.login(correo, password);

      if (responseApi.success == true) {

        String userRole = responseApi.data['role'];

        if (userRole != 'Paciente') {
          Get.snackbar('Acceso Denegado', 'No tienes acceso al sistema');
          return; // Detiene la ejecución si el rol es "Paciente"
        }
        GetStorage().write('User', responseApi.data);
        Get.offAll(() => HomePage(), binding: BindingsBuilder(() {
          Get.put(HomeController());
        }));
        goToHomePage();

      }
      else {
        Get.snackbar('Login Fallido', responseApi.message ?? '');
        print(responseApi.message);
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
