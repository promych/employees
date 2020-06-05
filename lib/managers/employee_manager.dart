import 'package:flutter/foundation.dart';

import '../data/repo/children_repository.dart';
import '../data/repo/employee_repository.dart';
import '../model/employee.dart';
import 'app_status.dart';

class EmployeeManager extends ChangeNotifier {
  final _employeeRepo = LocalEmployeeRepository();
  final _childrenRepo = LocalChildrenRepository();

  List<Employee> _employeeList;
  List<Employee> get employeeList => _employeeList;

  AppStatus _status = AppStatus.Uninitialized;
  AppStatus get status => _status;

  Future<void> init() async {
    await _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      _employeeList = await _employeeRepo.allEmployees();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      await _employeeRepo.addEmployee(employee);
      await _fetchEmployees();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      await _employeeRepo.updateEmployee(employee);
      await _fetchEmployees();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteEmployee(Employee employee) async {
    try {
      _status = AppStatus.Loading;
      notifyListeners();
      await _employeeRepo.deleteEmployee(employee);
      await _childrenRepo.deleteChildrenByParentId(employee.id);
      await _fetchEmployees();
      _status = AppStatus.Loaded;
    } catch (e) {
      print(e);
      _status = AppStatus.Error;
    } finally {
      notifyListeners();
    }
  }
}
