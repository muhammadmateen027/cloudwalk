part of 'api_repository.dart';

abstract class ApiService {
  Future<Response> getCurrentLocationFrom();
}