import 'package:cloudwalk/service/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'api_service.dart';

class ApiRepository implements ApiService {
  const ApiRepository({required this.client});
  final NetworkClient client;

  @override
  Future<Response> getCurrentLocationFrom() async{
    var url = '${dotenv.env['API_URL']}/json/';
    return await client.get(url, '');
  }

}