import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:urban_home/pages/auth/controller/opt_response.dart';
import 'package:urban_home/pages/auth/otp_screen.dart';

class Triplet {
  int statusCode;
  String authToken;
  String userId;
  Triplet({this.statusCode, this.authToken, this.userId});
}

class User {
  final number;
  final authToken;
  final userId;
  User(this.number, this.authToken, this.userId);
}

class ApiProvider {
  static String baseUrl = "https://urban-home.herokuapp.com/";

// user otp

  onRequest(String number) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({"number": number});

    var url = baseUrl + "api/userOtp";

    try {
      final r = await post(Uri.parse(url), body: body, headers: headers);
      print(r.body);

      // LoginModel data = loginModelFromJson(r.body);
      if (r.statusCode == 201) {
        OtpResponse data = otpResponseFromJson(r.body);
        print(data);
      } else {
        print(r.statusCode);
      }
      // return json.decode(r.body);
      return r.statusCode;
    } on Exception catch (e) {
      return Future.error(e.toString());
      // TODO
    }
  }

  Future<Triplet> validateOtp(String number, String otp) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({"number": number, "otp": otp});

    var url = baseUrl + "api/verifyOtp";

    try {
      final Response r =
          await post(Uri.parse(url), body: body, headers: headers);
      if (r.statusCode == 200) {
        var body = jsonDecode(r.body);
        print(body);
        return Triplet(
          statusCode: r.statusCode,
          authToken: body["token"],
          userId: body["user"]["_id"],
        );
      } else {
        return Triplet(
          statusCode: r.statusCode,
          authToken: "no available token",
          userId: "no available user id",
        );
      }
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  // Future get(var body , String restUrl, var authToken) async{
  //   var headers = {'Content-Type': 'application/json'};
  //   var url = baseUrl + restUrl;
  //
  //   Response r = await http.get(Uri.parse(url),
  //   headers: headers,
  //   );
  //
  //
  // }

  postMethod(var body, String restUrl) async {
    var url = baseUrl + restUrl;
    body = jsonEncode(body);
    try {
      final http.Response r = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.authToken}'
          },
          body: body);
      print(r.statusCode);
      return r.statusCode;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  postMethodAuthorized(String restUrl) async {
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.authToken}'
        },
      );
      print(r.statusCode);
      dynamic body = jsonDecode(r.body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  getMethod(String restUrl) async {
    var url = baseUrl + restUrl;

    try {
      http.Response r = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.authToken}'
        },
      );
      print(r.request);
      var body = jsonDecode(r.body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  getMethodAuthorized(String restUrl) async {
    var url = baseUrl + restUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.authToken}'
    };

    try {
      http.Response r = await http.get(Uri.parse(url), headers: headers);
      print(r.request);
      var body = jsonDecode(r.body);
      print(body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  favPostMethod(String restUrl) async {
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${user.authToken}'
        },
      );
      print(r.statusCode);
      dynamic data = jsonDecode(r.body);
      return data;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  deleteMethod(String restUrl) async {
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.authToken}'
        },
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  addNotification() async {
    var url = 'https://urban-home.herokuapp.com/api/addnotification';
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.authToken}'
        },
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
