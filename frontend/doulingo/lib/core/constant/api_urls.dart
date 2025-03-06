class ApiUrls {
  static const baseUrl = 'http://10.100.13.3:8000/api/v1';

  // auth
  static const register = '$baseUrl/auth/register';
  static const signin = '$baseUrl/auth/signin';
  static const checkUser = '$baseUrl/auth/checkUser';
  static const forgotPW = '$baseUrl/auth/fg_pass';
  static const changePW = '$baseUrl/auth/changePW';
  static const requestToken = '$baseUrl/auth/requestToken';
  static const logout = '$baseUrl/auth/logout';
  static const search = '$baseUrl/auth/search';
  static const order = '$baseUrl/auth/order';
  // courses
  static const addCourse = '$baseUrl/course/add';
  static const methodById = '$baseUrl/course';
  static const getAllCourse = "$baseUrl/course/all";

  // chapter
  static const getAllChapter = '$baseUrl/chapter/all';
  static const getChapterById = '$baseUrl/chapter';
}
//192.168.9.102
//10.100.13.3
