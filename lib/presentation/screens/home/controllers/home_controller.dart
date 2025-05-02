import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/models/activities/activity_response.dart';
import '../../../../data/models/combined_visits.dart';
import '../../../../data/models/customers/customer_response.dart';
import '../../../../data/models/visits/visits_response.dart';
import '../../../../data/repository/home_repository.dart';

class HomeController extends GetxController{

  final HomeRepository homeRepository = HomeRepository();
  var isLoading = true.obs;
  var visits = <VisitsResponse>[].obs;
  var customers = <CustomerResponse>[].obs;
  var activities = <ActivityResponse>[].obs;

  var selectedCustomer = <CustomerResponse>[].obs;

  var allVisits = <AllVisits>[].obs;

  var searchQuery = ''.obs;
  var filteredVisitDisplayList = <AllVisits>[].obs;
  var filteredVisits = <VisitsResponse>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchVisits();

  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchVisits() async {
    try {
      isLoading.value = true;

      var fetchedVisits = await homeRepository.fetchVisits();
      var fetchedActivities = await homeRepository.fetchActivities();
      var fetchedCustomers = await homeRepository.fetchCustomers();

      visits.value = fetchedVisits;
      customers.value = fetchedCustomers;
      activities.value = fetchedActivities;

      getAllVisits();

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch visits: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchCustomers() async {
    try {
      isLoading.value = true;

      var fetchedCustomers = await homeRepository.fetchCustomers();

      customers.value = fetchedCustomers;

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void getAllVisits() {
    final list = visits.map((visit) {
      final customer = customers.firstWhere(
            (c) => c.id == visit.customerId,
        orElse: () => CustomerResponse(id: 0, name: 'Unknown'),
      );

      final activityDescriptions = visit.activitiesDone?.map((activityIdStr) {
        final id = int.tryParse(activityIdStr);
        final activity = activities.firstWhere(
              (a) => a.id == id,
          orElse: () => ActivityResponse(description: 'Unknown'),
        );
        return activity.description ?? 'Unknown';
      }).toList() ?? [];

      return AllVisits(
        visitsResponse: visit,
        customerName: customer.name ?? 'Unknown',
        activityDescriptions: activityDescriptions,
      );
    }).toList();

    allVisits.value = list;
    filteredVisitDisplayList.value = list;

  }

  void filterVisits(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      getAllVisits();
      return;
    }

    final filtered = allVisits.where((combinedVisit) {
      final visit = combinedVisit.visitsResponse;
      final customerName = combinedVisit.customerName.toLowerCase();
      final status = visit.status?.toLowerCase() ?? '';
      final date = visit.visitDate?.toString().toLowerCase() ?? '';
      final notes = visit.notes?.toLowerCase() ?? '';
      final activities = combinedVisit.activityDescriptions.join(' ').toLowerCase();

      return customerName.contains(query) ||
          status.contains(query) ||
          date.contains(query) ||
          notes.contains(query) ||
          activities.contains(query);
    }).toList();

    allVisits.value = filtered;
  }

  int get totalVisits {
    return visits.length;
  }

  int get cancelledVisits {
    return visits.where((visit) => visit.status == 'Cancelled').length;
  }
  int get completedVisits {
    return visits.where((visit) => visit.status == 'Completed').length;
  }
  int get pendingVisits {
    return visits.where((visit) => visit.status == 'Pending').length;

    }

}