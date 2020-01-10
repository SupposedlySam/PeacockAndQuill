import 'package:dio/dio.dart';

class Api {
  static const String _apiEndpoint =
      'https://us-central1-thebasics-2f123.cloudfunctions.net/thebasics';

  Future<dynamic> getEpisodes() async {
    var response = await Dio().get<dynamic>('$_apiEndpoint/courseEpisodes');

    if (response.statusCode == 200) {}

    // something wrong happened
    return 'Could not fetch the episodes at this time';
  }

  Future<dynamic> getEpisode(int id) async {
    var response = await Dio().get<dynamic>('$_apiEndpoint/episode?id=$id');

    if (response.statusCode == 200) {}

    // something wrong happened
    return 'Could not fetch episode $id. Make sure it exists';
  }
}
