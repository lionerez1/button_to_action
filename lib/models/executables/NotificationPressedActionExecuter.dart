import 'package:button_to_action/models/executables/details/NotificationPressedActionExecuterDetails.dart';

import 'CallActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';
import 'details/CallActionExecuterDetails.dart';

class NotificationPressedActionExecuter extends CallActionExecuter {
  @override
  Future<void> execute(BaseActionExecuterDetails details) async {
    if (details is NotificationPressedActionExecuterDetails) {
      super.execute(CallActionExecuterDetails());
    }
  }
}
