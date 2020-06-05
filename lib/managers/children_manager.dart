import 'package:flutter/foundation.dart';

import '../data/repo/children_repository.dart';
import '../model/employee_child.dart';
import 'app_status.dart';

class ChildrenManager extends ChangeNotifier {
  final _repo = LocalChildrenRepository();

  List<EmployeeChild> _children;
  List<EmployeeChild> get childList => _children;

  AppStatus _status = AppStatus.Uninitialized;
  AppStatus get status => _status;

  Future<void> init() async {
    await fetchChildren();
  }

  Future<void> fetchChildren() async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      _children = await _repo.allChildren();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addChild(EmployeeChild employeeChild) async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      await _repo.addChild(employeeChild);
      await fetchChildren();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteChild(EmployeeChild employeeChild) async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      await _repo.deleteChild(employeeChild);
      await fetchChildren();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }
}
