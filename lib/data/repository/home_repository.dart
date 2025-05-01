import 'package:my_flutter_starter_shell/data/models/activities/activity_response.dart';
import 'package:my_flutter_starter_shell/data/models/customers/customer_response.dart';

import '../api_client.dart';
import '../models/visits/visits_response.dart';

class HomeRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<VisitsResponse>> fetchVisits() async {
    return await _apiClient
        .getVisits(headers: {});
  }

  Future<List<ActivityResponse>> fetchActivities() async {
    return await _apiClient
        .getActivities(headers: {});
  }
  Future<List<CustomerResponse>> fetchCustomers() async {
    return await _apiClient
        .getCustomers(headers: {});
  }
}