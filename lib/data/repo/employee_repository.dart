import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../model/employee.dart';
import '../db_provider.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> allEmployees();
  Future<void> addEmployee(Employee employee);
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(Employee employee);
}

class LocalEmployeeRepository implements EmployeeRepository {
  Future<Database> get _db async => await AppDatabase.instance.database;
  final _store = stringMapStoreFactory.store('employees');

  Future<List<Employee>> allEmployees() async {
    final finder = Finder(sortOrders: [SortOrder('created')]);
    final records = await _store.find(await _db, finder: finder);
    return records.map((snapshot) {
      final employee = Employee.fromMap(snapshot.value);
      employee.id = snapshot.key;
      return employee;
    }).toList();
  }

  Future<void> addEmployee(Employee employee) async {
    final id = Uuid().v4();
    await _store.record(id).put(await _db, employee.toMap());
  }

  Future<void> updateEmployee(Employee employee) async {
    await _store.update(
      await _db,
      employee.toMap(),
      finder: Finder(filter: Filter.byKey(employee.id)),
    );
  }

  Future<void> deleteEmployee(Employee employee) async {
    await _store.delete(
      await _db,
      finder: Finder(filter: Filter.byKey(employee.id)),
    );
  }
}
