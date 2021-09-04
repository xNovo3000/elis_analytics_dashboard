import 'package:http/http.dart';

class Fetcher extends BaseClient {

  final Client _client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // TODO: implement session checking
    return _client.send(request);
  }

}