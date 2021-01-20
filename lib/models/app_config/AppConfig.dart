import '../ActionModel.dart';
import 'AppSettings.dart';

class AppConfig {
  List<ActionModel> _actions = [];
  List<ActionModel> get actions => _actions;
  AppSettings _settings;
  AppSettings get settings => _settings;

  AppConfig.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('actions')) {
      json['actions'].map((actionJson) {
        var action = ActionModel.fromJson(actionJson);
        if (action != null) {
          _actions.add(action);
        }
      }).toList();
    }

    if (json.containsKey('settings')) {
      _settings = AppSettings.fromJson(json['settings']);
    }
  }

  Map<String, dynamic> toJson() => {'actions': _actions};

  void merge(AppConfig config) {
    if (config == null) return;
    for (int i = 0; i < config.actions.length; i++) {
      ActionModel currentAction = config.actions[i];
      for (int y = 0; y < _actions.length; y++) {
        ActionModel innerAction = _actions[y];
        if (currentAction.type == innerAction.type) {
          _actions[y].merge(currentAction);
          break;
        }
      }
    }
  }

  void updateAction(ActionModel action) {
    for (int i = 0; i < _actions.length; i++) {
      ActionModel currentItem = _actions[i];
      if (currentItem == action) {
        _actions[i] = action;
        break;
      }
    }
  }
}
