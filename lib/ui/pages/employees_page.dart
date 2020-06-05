import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/app_status.dart';
import '../../managers/children_manager.dart';
import '../../managers/employee_manager.dart';
import '../../model/employee.dart';
import '../../theme.dart';
import 'employee_details.dart';
import 'employee_editor.dart';

class EmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeManager = context.watch<EmployeeManager>();
    final childrenManager = context.watch<ChildrenManager>();
    final employees = employeeManager.employeeList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      body: SafeArea(
        bottom: false,
        child: Builder(
          builder: (_) {
            switch (employeeManager.status) {
              case AppStatus.Uninitialized:
                return Container();
              case AppStatus.Loading:
                return Center(child: CircularProgressIndicator());
              case AppStatus.Loaded:
                return employees.isEmpty
                    ? Center(
                        child: Text('Добавьте нового сотрудника, чтобы начать'))
                    : ListView.separated(
                        itemCount: employees.length,
                        itemBuilder: (_, i) {
                          final employee = employees[i];
                          final children = childrenManager.childList.where(
                              (element) => element.parentId == employee.id);
                          return Dismissible(
                            key: Key(employee.id),
                            child: ListTile(
                              title: Text('${employee.surname} ${employee.name} ${employee.patronymic}'),
                              subtitle: Text(employee.position),
                              trailing: children.length > 0
                                  ? Text(children.length.toString(), style: Styles.defaultText20)
                                  : SizedBox.shrink(),
                              onTap: () => _onEmployeeTap(context, employee),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                employeeManager.deleteEmployee(employee);
                              }
                            },
                            background: Container(
                              color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        separatorBuilder: (_, i) =>
                            Container(color: Colors.grey[200], height: 1),
                      );
              case AppStatus.Error:
                return Center(child: Text('error'));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onEmployeeEdit(context, null),
      ),
    );
  }

  void _onEmployeeTap(BuildContext context, Employee employee) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmployeeDetails(
          employeeId: employee.id,
          onEmployeeEdit: _onEmployeeEdit,
        ),
      ),
    );
  }

  void _onEmployeeEdit(BuildContext context, Employee employee) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmployeeEditorPage(
          employee: employee,
        ),
      ),
    );
  }
}
