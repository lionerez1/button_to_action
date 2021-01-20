import 'BaseActionExecuter.dart';
import 'details/BaseActionExecuterDetails.dart';
import 'details/RotaeAnimationActionExecuterDetails.dart';

class RotateAnimationActionExecuter extends BaseActionExecuter {
  @override
  void execute(BaseActionExecuterDetails details) {
    if (details is RotaeAnimationActionExecuterDetails) {
      details.actionButton.rotate();
    }
  }
}
