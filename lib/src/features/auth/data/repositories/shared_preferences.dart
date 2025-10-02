
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo {
  Future<void> saveProfileInfo(
    String username,
    String email,
    String userType,
    String group,
    int userId,
    String token,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('userType', userType);
    await prefs.setString('group', group);
    await prefs.setInt('userId', userId);
    await prefs.setString('token', token);
  }

  Future<Map<String, dynamic>> getProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final dynamic storedUserId = prefs.get('userId');
    return {
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'userType': prefs.getString('userType'),
      'group': prefs.getString('group'),
      'userId': prefs.getInt('userId'),
    };
  }

  Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    final dynamic storedUserId = prefs.get('userId');
    if (storedUserId == null) return null;
    return storedUserId is String ? storedUserId : storedUserId.toString();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('userType');
    await prefs.remove('group');
    await prefs.remove('userId');
  }
}
