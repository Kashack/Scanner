import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.vinelabs.org/api';

class HTTPApi {
  var client = http.Client();

  Future LectureLogin(String email) async {
    var uri =
        Uri.parse('$baseUrl/lecturer-access/validate?lecturerEmail=$email');
    var response = await client.get(uri);
    var message;
    if (response.statusCode == 200) {
      message = jsonDecode(response.body);
    } else {
      message = jsonDecode(response.body);
    }
    return message;
  }

  Future LoginVerification({required String otp, required String email}) async {
    var uri = Uri.parse(
        '$baseUrl/lecturer-access/verify?lecturerEmail=$email&accessCode=$otp');
    var response = await client.get(uri);
    var message;
    if (response.statusCode == 200) {
      message = jsonDecode(response.body);
    } else {
      message = jsonDecode(response.body);
    }
    return message;
  }

  Future LectureAssignCourse(String lecturerId) async {
    var uri = Uri.parse('$baseUrl/lecturer/fetch?lecturerId=$lecturerId');
    var response = await client.get(uri);
    var message;
    if (response.statusCode == 200) {
      message = jsonDecode(response.body);
    } else {
      message = jsonDecode(response.body);
    }
    return message;
  }

  Future CreateAttendance(String lecturerId, String courseId) async {
    var uri = Uri.parse('https://api.vinelabs.org/api/lecture/create');
    var body = jsonEncode({'courseId': courseId, 'lecturerId': lecturerId,});
    var response = await client.post(uri,body: body);
    var message;
    print(response.statusCode);
    if (response.statusCode == 200) {
      message = jsonDecode(response.body);
    } else {
      message = jsonDecode(response.body);
    }
    return message;
  }

  createApi () async {
    try {
      var url = Uri.parse('https://api.vinelabs.org/api/lecture/create');
      var response = await http.post(url, body: jsonEncode({
            "courseId": "01c693ea-65b3-48ad-afbc-68c5af04f2d8",
            "lecturerId": "8c8b8332-6496-4865-a7c6-93fce5113830",
          }));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = response.body;

        final decoded = jsonDecode(response.body);
        print('Response body decoded: ${decoded['status']}');

        final msg = decoded['message'];
        // defaultSnackyBar(context, msg,primaryColor);
        // nextPage(context,(context)=>SignIn());
      } else {
        final decoded = jsonDecode(response.body);
        final msg = decoded['message'];
        // defaultSnackyBar(context, msg, dangerColor);
      }

      return response;
    } on SocketException {
      // defaultSnackyBar(context, "No Internet connection 😑", dangerColor);
    } on HttpException {
      // defaultSnackyBar(context, "Couldn't find the post 😱", dangerColor);
    } on FormatException {
      // defaultSnackyBar(context, "Bad response format 👎", dangerColor);
    } catch (e) {
      // defaultSnackyBar(context, "An error occured",dangerColor);
    }
  }
}
