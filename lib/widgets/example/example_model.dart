import 'package:flutter/material.dart';
import 'package:lazyload_lessons/domain/api_clients/api_clients.dart';
import 'package:lazyload_lessons/domain/entity/user.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _users = <User>[];

  List<User> get users => _users;

  Future<void> reloadUsers() async {
    final users = await apiClient.getUsers();
    _users += users;
    notifyListeners();
  }

  void createUsers() {}
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;

  const ExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  }
}
