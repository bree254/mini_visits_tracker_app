import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mini_visits_tracker_app/core/app_export.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/app_decoration.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/theme_helper.dart';
import 'controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  String formatDate(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat dateFormatter = DateFormat('d MMM yyyy');
    return dateFormatter.format(parsedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.white,
      body: Padding(
        padding: EdgeInsets.only(top: 60.0.v, left: 16.0.v, right: 16.0.v),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Container(
                    height: 80.0.v,
                    width: 100.0.v,
                    decoration: BoxDecoration(
                      color: appTheme.colorPrimary,
                      borderRadius: BorderRadius.circular(8.0.v),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "Completed",
                          style:
                          AppTextStyles.bodyMedium.copyWith(
                            fontSize: 16.0,
                            color: appTheme.white,
                          ),
                        ),
                        Text(
                          controller.completedVisits.toString(),
                          style:
                          AppTextStyles.bodyMediumPrimary.copyWith(
                            fontSize: 16.0,
                            color: appTheme.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Obx(
                  () {
                    return Container(
                      height: 80.0.v,
                      width: 100.0.v,
                      decoration: BoxDecoration(
                        color: appTheme.colorPrimary,
                        borderRadius: BorderRadius.circular(8.0.v),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Pending",
                            style:
                            AppTextStyles.bodyMedium.copyWith(
                              fontSize: 16.0,
                              color: appTheme.white,
                            ),
                          ),
                          Text(
                            controller.pendingVisits.toString(),
                            style:
                            AppTextStyles.bodyMediumPrimary.copyWith(
                              fontSize: 16.0,
                              color: appTheme.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Obx(
                  () {
                    return Container(
                      height: 80.0.v,
                      width: 100.0.v,
                      decoration: BoxDecoration(
                        color:appTheme.colorPrimary,
                        borderRadius: BorderRadius.circular(8.0.v),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Cancelled",
                             style:
                             AppTextStyles.bodyMedium.copyWith(
                               fontSize: 16.0,
                               color: appTheme.white,
                             ),
                          ),
                          Text(
                            controller.cancelledVisits.toString(),
                            style:
                            AppTextStyles.bodyMediumPrimary.copyWith(
                              fontSize: 16.0,
                              color: appTheme.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0.v),
            Container(
              height: 50.0.v,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.v),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1.0.v,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by name ,status ,date ,activity",
                  hintStyle: TextStyle(color: appTheme.disabledColor, fontSize: 14.0),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  controller.filterVisits(value);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.visits.isEmpty) {
                  return const Center(
                    child: Text(
                      'No visits available',
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.allVisits.length,
                    itemBuilder: (context, index) {
                      final visit = controller.allVisits[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
                        margin: EdgeInsets.only(bottom: 10.v),
                        decoration: AppDecoration.outlineGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        formatDate(
                                          visit.visitsResponse.visitDate!
                                              .toString(),
                                        ),
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          fontSize: 12.0,
                                          color: appTheme.grayText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    visit.visitsResponse.status!,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: visit.visitsResponse.status! ==
                                              'Completed'
                                          ? appTheme.green600
                                          : visit.visitsResponse.status ==
                                                  'Pending'
                                              ? Colors.orange
                                              : visit.visitsResponse.status ==
                                                      'Cancelled'
                                                  ? appTheme.error
                                                  : Colors.black,
                                    ),
                                  )
                                ]),
                            SizedBox(
                              height: 8.v,
                            ),
                            Divider(
                              color: Colors.grey[100],
                              thickness: 1.0,
                            ),
                            SizedBox(
                              height: 8.v,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      visit.customerName.toString(),
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${visit.visitsResponse.location}',
                                      style: AppTextStyles.labelMedium.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                          color: appTheme.disabledColor
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.v,
                                ),
                                Text(
                                  '${visit.visitsResponse.notes}',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: appTheme.grayText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Column(
                              children: visit.activityDescriptions
                                  .map<Widget>((activity) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 4.v),
                                  child: Text(
                                    '\u2022 $activity',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: appTheme.fillGray,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:appTheme.colorPrimary,
        onPressed: () {
          Get.toNamed(AppRoutes.visists);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
