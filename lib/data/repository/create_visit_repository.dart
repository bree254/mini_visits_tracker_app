import '../api_client.dart';

class CreateVisitRepository {
  final ApiClient _apiClient = ApiClient();

  Future<void> createVisit({
    required Map<String, dynamic> requestData,
  }) async {
    await _apiClient.createVisit(requestData: requestData);
  }
}