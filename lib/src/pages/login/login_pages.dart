import 'package:app_vida_saludable/src/controllers/login_controller.dart';
import 'package:app_vida_saludable/src/pages/settins/privacy_policies_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  final LoginController con = Get.put(LoginController());
  final box = GetStorage();
  final RxBool isChecked = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _bgCover(context),
          _formLogin(context),
          Column(
            children: [
              _textAppName(),
              _imageCover(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bgCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(45, 45),
          bottomRight: Radius.elliptical(45, 45),
        ),
      ),
    );
  }

  Widget _textAppName() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Text(
        'VIDA SALUDABLE',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/LogoVidaSaludable.png',
          width: 220,
          height: 220,
        ),
      ),
    );
  }

  Widget _formLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.58,
        left: 40,
        right: 40,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _inputEmail(),
            _inputPassword(),
            _acceptPolicies(context),
            _buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _inputEmail() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black12,
      ),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo Electrónico',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  Widget _inputPassword() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black12,
      ),
      child: Obx(
        () => TextField(
          controller: con.passwordController,
          keyboardType: TextInputType.text,
          obscureText: !con.isPasswordVisible.value,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                con.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () => con.togglePasswordVisibility(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _acceptPolicies(BuildContext context) {
    if (box.hasData('acceptedPolicies')) {
      return SizedBox.shrink();
    }
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: isChecked.value,
            onChanged: (value) {
              isChecked.value = value ?? false;
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPoliciesPage()),
                );
              },
              child: Text(
                'Acepto las políticas y privacidad',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!box.hasData('acceptedPolicies') && !isChecked.value) {
            Get.snackbar('Error', 'Debes aceptar las políticas y privacidad',
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          box.write('acceptedPolicies', true);
          con.login();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: EdgeInsets.symmetric(vertical: 13),
          shape: StadiumBorder(),
        ),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
