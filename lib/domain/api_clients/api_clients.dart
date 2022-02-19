import 'dart:convert';
import 'dart:io';

import 'package:lazyload_lessons/domain/entity/user.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<User>> getUsers() async {

    final json = await get('https://jsonplaceholder.typicode.com/users') as List<dynamic>;
    final users = json
        .map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
    return users;
  }

  Future<dynamic> get(String url) async {
    final request = await client
        .getUrl(Uri.parse(url));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString);
    return json;
  }
}
