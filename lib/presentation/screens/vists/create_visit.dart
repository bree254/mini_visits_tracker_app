import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mini_visits_tracker_app/core/app_export.dart';
import '../../../core/theme/theme_helper.dart';
import '../../../data/models/activity_items.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../home/controllers/home_controller.dart';
import 'controllers/create_visits_controller.dart';

class CreateVisit extends StatefulWidget {
  CreateVisit({
    super.key,
  });

  @override
  State<CreateVisit> createState() => _CreateVisitState();
}

class _CreateVisitState extends State<CreateVisit> {
  final HomeController homeController = Get.put(HomeController());
  final CreateVisitController controller = Get.put(CreateVisitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Create Visit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: appTheme.lightTextColor
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 20,
            color: appTheme.lightTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Name',
                        style: TextStyle(
                            color: appTheme.lightTextColor, fontSize: 14
                            ),
                      ),
                      SizedBox(height: 8.v),
                      Obx(
                            () => controller.isLoading.value
                            ? CircularProgressIndicator(
                              color: appTheme.colorPrimary,
                            )
                            : DropDownTextField(
                          onChanged: (val) {
                            controller.selectedCustomer.value = val;
                          },
                          textFieldDecoration: InputDecoration(
                            hintText: 'Select Customer',
                            hintStyle: TextStyle(color: appTheme.disabledColor, fontSize: 14.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                              borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.h),
                              borderSide: BorderSide(
                                color: appTheme.colorPrimary,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: appTheme.grayBackground,
                          ),
                          dropDownList:
                          controller.customers.map((customer) {
                            return DropDownValueModel(
                              name: customer.name ?? 'Unknown',
                              value: customer.id.toString(),

                            );
                          }).toList(),
                          enableSearch: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color: appTheme.lightTextColor, fontSize: 14
                        ),
                      ),
                      SizedBox(height: 8.v),
                      DropDownTextField(
                        onChanged: (val) {
                          controller.selectedStatus.value = val;
                        },
                        textFieldDecoration: InputDecoration(
                          hintText: 'Select Status',
                          hintStyle: TextStyle(color: appTheme.disabledColor, fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.h),
                            borderSide: BorderSide(
                              color: appTheme.colorPrimary,
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: appTheme.grayBackground,
                        ),
                        dropDownList: controller.statuses,
                        enableSearch: true,
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activities',
                        style: TextStyle(color: appTheme.lightTextColor, fontSize: 14),
                      ),
                      SizedBox(height: 8.v),
                      Container(
                        height: 200.v,
                        decoration: BoxDecoration(
                          color: appTheme.grayBackground,
                          borderRadius: BorderRadius.circular(10.h),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            return CheckboxListTile(
                              title: Text(activity.name,style: TextStyle(color: appTheme.disabledColor) ,),
                              value: activity.isChecked,
                              activeColor: appTheme.colorPrimary,
                              onChanged: (bool? value) {
                                setState(() {
                                  activity.isChecked = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                CustomTextFormField(
                  controller: controller.locationController,
                  outerLabelText: 'Location',
                  outerLabelStyle: TextStyle(
                      color: appTheme.lightTextColor, fontSize: 14),
                  labelText: 'Enter the location',
                  labelStyle: TextStyle(color: appTheme.disabledColor),
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 16.v, horizontal: 10.h),
                  filled: true,
                  fillColor: appTheme.grayBackground,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Location is required';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: controller.notesController,
                  outerLabelText: 'Notes',
                  outerLabelStyle: TextStyle(
                      color: appTheme.lightTextColor, fontSize: 14),
                  labelText: 'Enter a note',
                  labelStyle: TextStyle(color: appTheme.disabledColor),
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 16.v, horizontal: 10.h),
                  filled: true,
                  fillColor: appTheme.grayBackground,
                  autofocus: false,
                  maxLines: 2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40.v,
                ),
                CustomElevatedButton(
                    onPressed: () {
                      final selectedActivityIds = activities
                          .where((activity) => activity.isChecked)
                          .map((activity) => activity.id)
                          .toList();

                      controller.createVisit(selectedActivityIds);
                    },
                    text: 'Save',
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
