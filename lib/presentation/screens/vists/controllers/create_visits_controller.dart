import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';
import 'package:my_flutter_starter_shell/core/routes/routes.dart';
import 'package:my_flutter_starter_shell/data/models/combined_visits.dart';
import '../../../../data/models/customers/customer_response.dart';
import '../../../../data/models/visits/visits_response.dart';
import '../../../../data/repository/create_visit_repository.dart';
import '../../../../data/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
class CreateVisitController  extends GetxController{

  final HomeRepository homeRepository = HomeRepository();
  final CreateVisitRepository visitRepository = CreateVisitRepository();

  var isLoading = true.obs;

  var customers = <CustomerResponse>[].obs;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  var selectedCustomer = Rxn<DropDownValueModel>();
  var selectedStatus = Rxn<DropDownValueModel>();

  final List<DropDownValueModel> statuses = [
    const DropDownValueModel(name: 'Pending', value: 'Pending'),
    const DropDownValueModel(name: 'Cancelled', value: 'Cancelled'),
    const DropDownValueModel(name: 'Completed', value: 'Completed'),
  ];

  @override
  void onInit() {
    super.onInit();
     fetchCustomers();
  }

  void fetchCustomers() async {
    try {
      isLoading.value = true;

      var fetchedCustomers = await homeRepository.fetchCustomers();

      customers.value = fetchedCustomers;
      print('customers: ${fetchedCustomers}');

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void createVisit(List<String> selectedActivityIds) async {
    if (selectedCustomer.value == null || selectedStatus.value == null) {
      Get.snackbar('Error', 'Please select customer and status');
      return;
    }

    final requestData = {
      'customer_id': int.parse(selectedCustomer.value!.value.toString()),
      'visit_date': DateTime.now().toUtc().toIso8601String(),
      'status': selectedStatus.value!.value,
      'location': locationController.text.trim(),
      'notes': notesController.text.trim(),
      'activities_done': selectedActivityIds,
    };
    print('create visit requestData: $requestData');

    try {
      isLoading.value = true;
      await visitRepository.createVisit(requestData: requestData);
      print('Visit created successfully');
      Get.snackbar('Success', 'Visit created successfully');
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create visit: $e');
    } finally {
      isLoading.value = false;
    }
  }




}