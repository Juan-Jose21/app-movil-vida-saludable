import 'package:get/get.dart';
import 'package:app_vida_saludable/src/models/user.dart';
import 'package:get_storage/get_storage.dart';

class InformationsController extends GetxController {

  User user = User.fronJson(GetStorage().read('User') ?? {});

  InfromationsController() {
    print('USUARIO DE SESSION: ${user.toJson()}');
  }

}
