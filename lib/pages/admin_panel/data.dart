import 'package:app_quiz/pages/admin_panel/adminpanel.dart';

class QuestionData {
  static final List<DropdownMenuEntry<String>> languages = [
    DropdownMenuEntry(value: 'flutter', label: 'Flutter'),
    DropdownMenuEntry(value: 'python', label: 'Python'),
    DropdownMenuEntry(value: 'java', label: 'Java'),
    DropdownMenuEntry(value: 'android', label: 'Android'),
    DropdownMenuEntry(value: 'frontend', label: 'Frontend'),
    DropdownMenuEntry(value: 'c#', label: 'C#'),
    DropdownMenuEntry(value: 'c++', label: 'C++'),
    DropdownMenuEntry(value: 'ios', label: 'iOS'),
  ];

  static final List<DropdownMenuEntry<String>> modullar = [
    DropdownMenuEntry(value: '1modul', label: '1-Modul'),
    DropdownMenuEntry(value: '2modul', label: '2-Modul'),
    DropdownMenuEntry(value: '3modul', label: '3-Modul'),
    DropdownMenuEntry(value: '4modul', label: '4-Modul'),
  ];

  static final List<DropdownMenuEntry<String>> darslar1 = [
    DropdownMenuEntry(value: '1dars', label: ' Language Access'),
    DropdownMenuEntry(value: '2dars', label: ' Syntax'),
    DropdownMenuEntry(value: '3dars', label: ' Data types'),
    DropdownMenuEntry(value: '4dars', label: ' Operators'),
  ];

  static final List<DropdownMenuEntry<String>> darslar2 = [
    DropdownMenuEntry(value: '1dars', label: ' Algoritims'),
    DropdownMenuEntry(value: '2dars', label: ' Functions'),
    DropdownMenuEntry(value: '3dars', label: ' String'),
    DropdownMenuEntry(value: '4dars', label: ' List'),
  ];

  static final List<DropdownMenuEntry<String>> darslar3 = [
    DropdownMenuEntry(value: '1dars', label: ' Map'),
    DropdownMenuEntry(value: '2dars', label: ' Set'),
    DropdownMenuEntry(value: '3dars', label: ' OOP Access'),
    DropdownMenuEntry(value: '4dars', label: ' Constructor'),
  ];

  static final List<DropdownMenuEntry<String>> darslar4 = [
    DropdownMenuEntry(value: '1dars', label: ' Inkapsulatsion'),
    DropdownMenuEntry(value: '2dars', label: ' Inheritance'),
    DropdownMenuEntry(value: '3dars', label: ' Polimorfizim'),
    DropdownMenuEntry(value: '4dars', label: ' Abstraction'),
  ];
  static final List<DropdownMenuEntry<String>> level = [
    DropdownMenuEntry(value: 'easy', label: ' Easy'),
    DropdownMenuEntry(value: 'medium', label: ' Medium'),
    DropdownMenuEntry(value: 'hard', label: ' Hard'),
  ];

  static List<DropdownMenuEntry<String>> darslar(String modull) {
    switch (modull) {
      case '1modul':
        return darslar1;
      case '2modul':
        return darslar2;
      case '3modul':
        return darslar3;
      case '4modul':
        return darslar4;
      default:
        return darslar1;
    }
  }
}
