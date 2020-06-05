import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../../model/employee_child.dart';
import '../db_provider.dart';

abstract class ChildrenRepository {
  Future<List<EmployeeChild>> allChildren();
  Future<void> addChild(EmployeeChild employeeChild);
  Future<List<EmployeeChild>> childrenByParentId(String id);
  Future<void> deleteChildrenByParentId(String parentId);
  Future<void> deleteChild(EmployeeChild employeeChild);
}

class LocalChildrenRepository implements ChildrenRepository {
  Future<Database> get _db async => await AppDatabase.instance.database;
  final _store = stringMapStoreFactory.store('children');

  Future<List<EmployeeChild>> allChildren() async {
    final finder = Finder(sortOrders: [SortOrder('created')]);
    final records = await _store.find(await _db, finder: finder);
    return records
        .map((snapshot) => EmployeeChild.fromMap(snapshot.value))
        .toList();
  }

  Future<void> addChild(EmployeeChild employeeChild) async {
    final id = Uuid().v4();
    await _store.record(id).put(await _db, employeeChild.toMap());
  }

  Future<List<EmployeeChild>> childrenByParentId(String id) async {
    final finder = Finder(
      sortOrders: [SortOrder('created')],
      filter: Filter.equals('parentId', id),
    );
    final records = await _store.find(await _db, finder: finder);
    return records
        .map((snapshot) => EmployeeChild.fromMap(snapshot.value))
        .toList();
  }

  Future<void> deleteChildrenByParentId(String parentId) async {
    await _store.delete(
      await _db,
      finder: Finder(filter: Filter.equals('parentId', parentId)),
    );
  }

  Future<void> deleteChild(EmployeeChild employeeChild) async {
    await _store.delete(
      await _db,
      finder: Finder(
        filter: Filter.and([
          Filter.equals('parentId', employeeChild.parentId),
          Filter.equals('created', employeeChild.created)
        ]),
      ),
    );
  }
}
