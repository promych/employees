import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'managers/children_manager.dart';
import 'managers/employee_manager.dart';
import 'ui/pages/employees_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmployeeManager()..init()),
        ChangeNotifierProvider(create: (context) => ChildrenManager()..init()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: EmployeesPage(),
      ),
    );
  }
}
