import 'package:button_to_action/models/executables/details/CallActionExecuterDetails.dart';
import 'package:button_to_action/utils/DeviceUtils.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'ToastActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';
import 'details/ToastActionExecuterDetails.dart';

class CallActionExecuter extends ToastActionExecuter {
  @override
  Future<void> execute(BaseActionExecuterDetails details) async {
    if (details is CallActionExecuterDetails) {
      PhoneContact contact = await DeviceUtils.pickContact();
      if (contact != null) {
        super.execute(ToastActionExecuterDetails(
            'Calling ${contact.phoneNumber.number}'));
      }
    }
  }
}
