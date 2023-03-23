import 'package:flutter/material.dart';
import '../../../provider/dashboard_provider.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/strings.dart';
import 'dashboard_card.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {
    screenSizeDesign = Helper().getDesignSize(context);

    DashboardProvider dashboardProvider =
        Provider.of<DashboardProvider>(context);

    return Center(
      child: dashboardProvider.isLoading
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  DashboardCard(
                      label: Strings.revenue,
                      icon: Icons.attach_money,
                      counter:
                          dashboardProvider.revenueValue!.toStringAsFixed(1)),
                  Expanded(
                      child: GridView.count(
                          shrinkWrap: true,
                          scrollDirection:
                              screenSizeDesign == Strings.smallDesign
                                  ? Axis.vertical
                                  : Axis.horizontal,
                          padding: EdgeInsets.all(20),
                          childAspectRatio: 1.0,
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          children: <Widget>[
                        DashboardCard(
                            label: Strings.users,
                            icon: Icons.people_outline,
                            counter: dashboardProvider.usersCount.toString()),
                        DashboardCard(
                            label: Strings.categories,
                            icon: Icons.category,
                            counter:
                                dashboardProvider.categoryCount.toString()),
                        DashboardCard(
                            label: Strings.products,
                            icon: Icons.track_changes,
                            counter:
                                dashboardProvider.productsCount.toString()),
                        DashboardCard(
                            label: Strings.sold,
                            icon: Icons.tag_faces,
                            counter: dashboardProvider.soldCount.toString()),
                        DashboardCard(
                            label: Strings.orders,
                            icon: Icons.shopping_cart,
                            counter: dashboardProvider.ordersCount.toString()),
                        DashboardCard(
                            label: Strings.returned,
                            icon: Icons.close,
                            counter: "0"),
                      ]))
                ]),
    );
  }
}
