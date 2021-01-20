import 'package:button_to_action/models/executables/details/NoAvailableActionExecuterDetails.dart';

import 'ToastActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';
import 'details/ToastActionExecuterDetails.dart';

class NoAvailableActionExecuter extends ToastActionExecuter {
  @override
  void execute(BaseActionExecuterDetails details) {
    if (details is NoAvailableActionExecuterDetails) {
      super.execute(ToastActionExecuterDetails('No Available Action!!!'));
    }
  }
}
