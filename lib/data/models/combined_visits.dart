import 'package:mini_visits_tracker_app/data/models/visits/visits_response.dart';

class AllVisits {

  final VisitsResponse visitsResponse;
  final String customerName;
  final List<String> activityDescriptions;

  AllVisits({
    required this.visitsResponse,
    required this.customerName,
    required this.activityDescriptions,
  });


}