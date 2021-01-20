enum ActionType {
  ANIMATION,
  CALL,
  NOTIFICATION_PRESSED,
  SEND_NOTIFICATION,
  TOAST,
  UNSUPPORTED
}

extension ActionTypeExtension on ActionType {
  String toShortString() {
    if (this == ActionType.SEND_NOTIFICATION) {
      return 'notification';
    }
    return this.toString().split('.').last.toLowerCase();
  }
}

class ActionTypeFactory {
  static ActionType factorActionType(String action) {
    switch (action.toLowerCase()) {
      case 'animation':
        return ActionType.ANIMATION;
      case 'toast':
        return ActionType.TOAST;
      case 'call':
        return ActionType.CALL;
      case 'notification':
        return ActionType.SEND_NOTIFICATION;
      default:
        return ActionType.UNSUPPORTED;
    }
  }
}
