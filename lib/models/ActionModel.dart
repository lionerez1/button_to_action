import 'ActionType.dart';

class ActionModel {
  ActionType _type;
  ActionType get type => _type;
  bool _enabled = false;
  bool get enabled => _enabled;
  int _priority = 0;
  int get priority => _priority;
  List<int> _validDays = [];
  List<int> get validDays => _validDays;
  int _coolDown = 0;
  int get coolDown => _coolDown;
  DateTime _lastCalled;
  DateTime get lastCalled => _lastCalled;

  ActionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    if (json.containsKey('type')) {
      _type = ActionTypeFactory.factorActionType(json['type']);
    }
    if (json.containsKey('enabled')) {
      _enabled = json['enabled'];
    }
    if (json.containsKey('priority')) {
      _priority = json['priority'];
    }
    if (json.containsKey('valid_days')) {
      json['valid_days'].forEach((day) {
        _validDays.add(day);
      });
    }
    if (json.containsKey('cool_down')) {
      _coolDown = json['cool_down'];
    }
    if (json.containsKey('last_called')) {
      int value = json['last_called'];
      if (value != null) {
        _lastCalled = DateTime.fromMillisecondsSinceEpoch(value);
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'type': _type.toShortString(),
        'enabled': _enabled,
        'priority': _priority,
        'valid_days': _validDays,
        'cool_down': _coolDown,
        'last_called':
            _lastCalled != null ? lastCalled.millisecondsSinceEpoch : null
      };

  void merge(ActionModel action) {
    _lastCalled = action._lastCalled;
  }

  bool isInCoolDownState() {
    if (lastCalled != null && _coolDown > 0) {
      DateTime nowTime = DateTime.now();
      DateTime nextAvailableDate =
          _lastCalled.add(Duration(milliseconds: _coolDown));
      if (nextAvailableDate.isAfter(nowTime)) {
        return true;
      }
    }
    return false;
  }

  bool doesSupportDay(int day) {
    for (int validDay in _validDays) {
      if (day == validDay) {
        return true;
      }
    }
    return false;
  }

  void updateExecuted() {
    _lastCalled = DateTime.now();
  }
}
