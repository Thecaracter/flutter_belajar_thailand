// ignore_for_file: constant_identifier_names

class ConstanApi {
  static const String BASE_URL = "https://veryzona.geniusprog.com";
  static const String API = "$BASE_URL/api";
  static const String Login = "$API/login";
  static const String Register = "$API/register";
  static const String SendOTP = "$API/forgot-password/send-otp";
  static const String CheckOTP = "$API/forgot-password/verify-otp";
  static const String ChangePassword = "$API/forgot-password/reset-password";
  static const String Logout = "$API/logout";
  static const String Artikel = "$API/artikel";
  static const String ArtikelDetail = "$API/artikel/show";
  static const String AddLike = "$API/artikel/like";
  static const String AddBookmark = "$API/artikel/bookmark";
  static const String GetProfile = "$API/profile";
  static const String UpdateProfile = "$API/profile";
  static const String UpdateAvatar = "$API/profile/avatar";
  static const String BookmarkedArticles = "$API/bookmarked-articles";
  static const String Categories = "$API/categories";
  static const String LessonsByCategory = "$API/kategori-lessons/lessons";
}
