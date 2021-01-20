import 'package:button_to_action/components/ActionButton.dart';
import 'package:button_to_action/models/ActionType.dart';
import 'package:button_to_action/models/executables/CallActionExecuter.dart';
import 'package:button_to_action/models/executables/NoAvailableActionExecuter.dart';
import 'package:button_to_action/models/executables/NotificationPressedActionExecuter.dart';
import 'package:button_to_action/models/executables/RotateAnimationActionExecuter.dart';
import 'package:button_to_action/models/executables/SendNotificationActionExecuter.dart';
import 'package:button_to_action/models/executables/ToastActionExecuter.dart';
import 'package:button_to_action/models/executables/details/CallActionExecuterDetails.dart';
import 'package:button_to_action/models/executables/details/NoAvailableActionExecuterDetails.dart';
import 'package:button_to_action/models/executables/details/NotificationPressedActionExecuterDetails.dart';
import 'package:button_to_action/models/executables/details/RotaeAnimationActionExecuterDetails.dart';
import 'package:button_to_action/models/executables/details/SendNotificationActionExecuterDetails.dart';
import 'package:button_to_action/models/executables/details/ToastActionExecuterDetails.dart';
import 'package:button_to_action/viewmodels/HomeScreenViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final _MyHomePageState state = _MyHomePageState();

  @override
  _MyHomePageState createState() => state;
}

class _MyHomePageState extends State<MyHomePage> {
  HomeScreenViewModel _viewModel;
  final ActionButtonWidget _actionButton = ActionButtonWidget();

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    _viewModel.loadActionsConfiguration();
    _initialNotificationsHandler();
  }

  void _initialNotificationsHandler() {}

  void _creaeteExecuter() {
    ActionType actionType = _viewModel.chosenAction;
    switch (actionType) {
      case ActionType.ANIMATION:
        RotateAnimationActionExecuter()
            .execute(RotaeAnimationActionExecuterDetails(_actionButton));
        break;
      case ActionType.CALL:
        CallActionExecuter().execute(CallActionExecuterDetails());
        break;
      case ActionType.NOTIFICATION_PRESSED:
        NotificationPressedActionExecuter()
            .execute(NotificationPressedActionExecuterDetails());
        break;
      case ActionType.SEND_NOTIFICATION:
        SendNotificationActionExecuter()
            .execute(SendNotificationActionExecuterDetails());
        break;
      case ActionType.TOAST:
        ToastActionExecuter()
            .execute(ToastActionExecuterDetails('Action is Toast!'));
        break;
      case ActionType.UNSUPPORTED:
        NoAvailableActionExecuter().execute(NoAvailableActionExecuterDetails());
        break;
    }
    _viewModel.cleanChosenAction();
  }

  Scaffold _buildLoadingScaffold() {
    return Scaffold(
        body: Center(
      child: Text('Loading actions...'),
    ));
  }

  Scaffold _buildNoAvailableActionsScaffold() {
    return Scaffold(
        body: Center(
      child: Text('Loading actions...'),
    ));
  }

  Scaffold _buildActionsScaffold() {
    return Scaffold(
      body: _actionButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomeScreenViewModel>().actions;
    context.watch<HomeScreenViewModel>().chosenAction;
    if (_viewModel.chosenAction != null) {
      _creaeteExecuter();
    }
    if (_viewModel.actions == null) {
      return _buildLoadingScaffold();
    } else if (_viewModel.actions.isEmpty) {
      return _buildNoAvailableActionsScaffold();
    } else {
      return _buildActionsScaffold();
    }
  }
}
