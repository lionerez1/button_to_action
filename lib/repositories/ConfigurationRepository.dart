import 'dart:convert';
import 'package:button_to_action/models/ActionModel.dart';
import 'package:button_to_action/models/app_config/AppConfig.dart';
import 'package:button_to_action/utils/StorageUtils.dart';
import 'package:flutter/services.dart';
import 'IConfigurationRepository.dart';

class ConfigurationRepository extends IConfigurationRepository {
  AppConfig appConfig;

  static final ConfigurationRepository _instance =
      ConfigurationRepository._internal();

  factory ConfigurationRepository() {
    return _instance;
  }

  ConfigurationRepository._internal();

  Future<AppConfig> _initialConfigFile() async {
    final String result = await rootBundle.loadString('config.json');
    return AppConfig.fromJson(jsonDecode(result));
  }

  Future<AppConfig> _retrieveSavedConfiguration() async {
    String json = await StorageUtils.readString(StorageUtils.CONFIGURATION_KEY);
    if (json == null) return null;
    return AppConfig.fromJson(jsonDecode(json));
  }

  Future<AppConfig> _initialConfiguration() async {
    AppConfig defaultConfiguration = await _initialConfigFile();
    if (defaultConfiguration.settings.persistentStorage) {
      AppConfig savedConfiguration = await _retrieveSavedConfiguration();
      defaultConfiguration.merge(savedConfiguration);
    }

    return defaultConfiguration;
  }

  List<ActionModel> _initialEnabledActions() {
    int currentDay = DateTime.now().weekday;
    List<ActionModel> avialableActions = [];
    appConfig.actions.forEach((action) {
      if (action.enabled && action.doesSupportDay(currentDay)) {
        avialableActions.add(action);
      }
    });
    avialableActions.sort((a, b) => b.priority.compareTo(a.priority));
    return avialableActions;
  }

  @override
  Future<List<ActionModel>> getSupportedActions() async {
    if (appConfig == null) {
      appConfig = await _initialConfiguration();
    }
    return _initialEnabledActions();
  }

  @override
  Future<void> updateAction(ActionModel action) async {
    String json = jsonEncode(appConfig);
    await StorageUtils.writeString(StorageUtils.CONFIGURATION_KEY, json);
  }
}
