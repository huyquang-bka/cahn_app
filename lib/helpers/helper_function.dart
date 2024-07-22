import 'dart:convert';

//helper function
String findNameById(int id, List<dynamic> items) {
  String name = "Không xác định";
  for (dynamic item in items) {
    if (item.id == id) {
      name = item.name!;
      break;
    }
  }
  // print("name by id: $name");
  return name;
}

int findIdByName(String name, List<dynamic> items) {
  int id = 0;
  for (dynamic item in items) {
    if (item.name == name) {
      id = item.id!;
      break;
    }
  }
  return id;
}

int findCompanyIdByName(String name, List<dynamic> items) {
  dynamic item = items.firstWhere((element) => element.name == name);
  return item.idCompany!;
}

String convertToUtf8(String text) {
  final List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}
