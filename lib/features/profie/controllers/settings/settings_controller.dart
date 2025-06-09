import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/repository/user/user_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/models/users/user_mode.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final userRepo = Get.put(UserRepository());
      final fetchedUser = await userRepo.fetchUserData();
      print('object ============> $fetchedUser');
      user.value = fetchedUser;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
