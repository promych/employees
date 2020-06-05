import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../managers/children_manager.dart';
import '../../managers/employee_manager.dart';
import '../../theme.dart';
import 'child_editor.dart';

class EmployeeDetails extends StatelessWidget {
  final String employeeId;
  final Function onEmployeeEdit;

  const EmployeeDetails({
    Key key,
    @required this.employeeId,
    @required this.onEmployeeEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employeeManager = context.watch<EmployeeManager>();
    final employee = employeeManager.employeeList
        .singleWhere((element) => element.id == employeeId);
    final childrenManager = context.watch<ChildrenManager>();
    final childList = childrenManager.childList
        .where((element) => element.parentId == employeeId)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Просмотр сотрудника')),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Фамилия: ${employee.surname}',
                      style: Styles.defaultText20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Имя: ${employee.name}',
                      style: Styles.defaultText20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Отчество: ${employee.patronymic}',
                      style: Styles.defaultText20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Дата рождения: ${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(employee.birthDate))}',
                      style: Styles.defaultText20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Должность: ${employee.position}',
                      style: Styles.defaultText20,
                    ),
                  ],
                ),
              ),
              OutlineButton(
                child: Text('Добавить ребенка'),
                onPressed: () => _onChildAdd(
                  context,
                  employee.id,
                  employee.surname,
                ),
              ),
              SizedBox(height: 20),
              childList != null && childList.isEmpty
                  ? Container()
                  : ListView.separated(
                      itemCount: childList.length,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        final employeeChild = childList[i];
                        return Dismissible(
                          key: UniqueKey(),
                          child: Container(
                            color: Colors.grey[100],
                            child: ListTile(
                              title: Text(
                                  '${employeeChild.name} ${employeeChild.patronymic}'),
                              trailing: Text(DateFormat('dd.MM.yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      employeeChild.birthDate))),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              await childrenManager.deleteChild(employeeChild);
                            }
                          },
                          background: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, i) => Container(color: Colors.grey[200], height: 1),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => onEmployeeEdit(context, employee),
      ),
    );
  }

  void _onChildAdd(BuildContext context, String parentId, String surname) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChildEditorPage(
        parentId: parentId,
        initSurname: surname,
      ),
    ));
  }
}
