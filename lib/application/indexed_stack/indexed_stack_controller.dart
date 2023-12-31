
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IndexedStackController extends GetxController {
  RxInt currentIndex = 0.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }

}
