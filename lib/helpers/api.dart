import 'dart:convert';
import 'package:cahn_app/helpers/helpers_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//call get api
Future<List> callGetApi(BuildContext context, String url,
    {String filterKey = "items", int timeout = 3}) async {
  try {
    final response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: timeout));
    if (response.statusCode == 200) {
      //decode json
      final List<dynamic> data = json.decode(response.body)[filterKey];
      //convert json to list of cameras
      return data;
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context: context, message: "Failed to load $url");
      return [];
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showErrorMessage(
        context: context, message: "Failed to load $url with error: $e");
    return [];
  }
}