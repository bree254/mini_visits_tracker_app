import 'package:my_flutter_starter_shell/data/models/visits/visits_response.dart';

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