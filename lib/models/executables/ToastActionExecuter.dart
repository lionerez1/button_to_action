import 'package:button_to_action/utils/DeviceUtils.dart';
import 'BaseActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';
import 'details/ToastActionExecuterDetails.dart';

class ToastActionExecuter extends BaseActionExecuter {
  @override
  void execute(BaseActionExecuterDetails details) {
    if (details is ToastActionExecuterDetails) {
      DeviceUtils.showToast(details.text);
    }
  }
}
