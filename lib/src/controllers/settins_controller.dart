import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class SettingsController extends GetxController {

  User user = User.fronJson(GetStorage().read('User') ?? {});

  void signOut() {
    GetStorage().remove('User');
    
    Get.offNamedUntil('/', (route) => false);
  }
  
}