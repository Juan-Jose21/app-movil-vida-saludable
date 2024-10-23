import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/datos_fisicos_model.dart';
import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../providers/datos_fisicos_provider.dart';


class BottomBarController extends GetxController {

  User user = User.fronJson(GetStorage().read('User') ?? {});

  DatosFisicosProviders datosFisicosProviders = DatosFisicosProviders();

  var datosFisicos = <DatosFisicos>[].obs;

  var indexTab = 0.obs;

  void changeTab(int index) {
    indexTab.value = index;
    if(indexTab.value == 2){
      listarDatosFisicos(user.id.toString());
    }
    print(indexTab.value);
  }

  void listarDatosFisicos(String usuario) async {
    ResponseApi responseApi = await datosFisicosProviders.getAll(usuario);
    if (responseApi.success == true) {
      datosFisicos.value = List<DatosFisicos>.from(responseApi.data);
      print('Lista Datos Fisicos ${datosFisicos.value}');
    } else {
      print('Error al listar datos Fisicos: ${responseApi.message}');
    }
  }

}