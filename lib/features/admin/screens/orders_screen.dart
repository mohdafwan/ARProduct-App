import 'package:flutter/material.dart';
import 'package:interior_design_arapp/common/widgets/loader.dart';
import 'package:interior_design_arapp/features/admin/services/admin_services.dart';
import 'package:interior_design_arapp/features/order_details/screens/order_details.dart';
import 'package:interior_design_arapp/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: orders == null
                    ? const Loader()
                    : Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            orderData.products[0].images[0],
                          ),
                        ),
                      ),
              );
            },
          );
  }
}
