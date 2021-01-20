import 'package:button_to_action/utils/NotificationUtils.dart';

import 'BaseActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';

class SendNotificationActionExecuter extends BaseActionExecuter {
  @override
  void execute(BaseActionExecuterDetails details) {
    NotificationUtils.showNotification();
  }
}
