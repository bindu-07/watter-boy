import 'package:get/get.dart';
import 'package:water_boy/utils/helper/network_manager.dart';

class GeneralBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }}
