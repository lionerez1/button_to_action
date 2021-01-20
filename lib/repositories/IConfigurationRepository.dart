import 'package:button_to_action/models/ActionModel.dart';

abstract class IConfigurationRepository {
  Future<List<ActionModel>> getSupportedActions();

  void updateAction(ActionModel action);
}
