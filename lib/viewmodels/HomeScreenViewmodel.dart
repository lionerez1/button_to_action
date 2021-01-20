import 'package:button_to_action/models/ActionModel.dart';
import 'package:button_to_action/models/ActionType.dart';
import 'package:button_to_action/repositories/ConfigurationRepository.dart';
import 'package:button_to_action/utils/NotificationUtils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel with ChangeNotifier {
  final ConfigurationRepository _repository = ConfigurationRepository();
  List<ActionModel> _actions;
  List<ActionModel> get actions => _actions;
  ActionType _chosenActionType;
  ActionType get chosenAction => _chosenActionType;
  ConnectivityResult _connectivityState;
  String _payload = '';
  String get payload => _payload;
  bool _shouldRotateActionButton = false;
  bool get shouldRotateActionButton => _shouldRotateActionButton;

  HomeScreenViewModel() {
    _startConnectivityChangeListener();
    _initialNotificationsListener();
  }

  void cleanChosenAction() {
    _chosenActionType = ActionType.UNSUPPORTED;
  }

  bool containsActions() {
    return _actions != null && _actions.length > 0;
  }

  void loadActionsConfiguration() async {
    _actions = await _repository.getSupportedActions();
    notifyListeners();
  }

  Future<void> handlePress() async {
    _chosenActionType = await _findNextAction();
    notifyListeners();
  }

  void _initialNotificationsListener() {
    NotificationUtils.notificationsHandler
        .initialize(NotificationUtils.factorInitializationSettings(),
            onSelectNotification: (String payload) async {
      if (payload != null) {
        _chosenActionType = ActionType.NOTIFICATION_PRESSED;
        notifyListeners();
      }
    });
  }

  void _startConnectivityChangeListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityState = result;
    });
  }

  Future<ActionType> _findNextAction() async {
    for (ActionModel action in _actions) {
      if (_isAllowToPerformAction(action)) {
        action.updateExecuted();
        await _repository.updateAction(action);
        return action.type;
      }
    }
    return ActionType.UNSUPPORTED;
  }

  bool _isAllowToPerformAction(ActionModel action) {
    if (action.isInCoolDownState() ||
        action.type == ActionType.TOAST &&
            _connectivityState == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
