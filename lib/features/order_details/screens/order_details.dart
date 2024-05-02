// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/common/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:interior_design_arapp/models/order.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;

  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 235, 235, 235), width: 1),
            ),
          ),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                child: Image.asset(
                  'assets/images/logo-no-background-Inblack.png',
                  filterQuality: FilterQuality.high,
                  width: 180,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey, ${user.username.split(" ").first}!',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFamily: 'rejoin',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Thank you for your order! We\'ll keep you updated on its arrival.',
                        style: TextStyle(
                          height: 1.3,
                          color: Colors.grey[600],
                          fontSize: 17.5,
                          fontFamily: 'rejoin',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0)
                          .copyWith(left: 14, right: 14, bottom: 9),
                      margin: const EdgeInsets.all(0).copyWith(left: 12),
                      child: const Text(
                        "View Order details.",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'rejoin',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      padding: const EdgeInsets.all(0).copyWith(
                        left: 12,
                        right: 12,
                        top: 9,
                        bottom: 9,
                      ),
                      margin:
                          const EdgeInsets.all(0).copyWith(left: 17, right: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Date:\t\t\t\t\t\t\t${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                            style: const TextStyle(
                              fontFamily: 'rejoin',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Order ID:\t\t\t\t\t\t\t\t\t\t\t\t${widget.order.id}',
                            style: const TextStyle(
                              fontFamily: 'rejoin',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Order Total:\t\t\t\t\t\t\t\₹${widget.order.totalPrice}',
                            style: const TextStyle(
                              fontFamily: 'rejoin',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const headline(h1: 'Purchase Details.'),
                    Container(
                      padding: const EdgeInsets.all(0).copyWith(
                        left: 12,
                        right: 12,
                        top: 9,
                        bottom: 9,
                      ),
                      margin:
                          const EdgeInsets.all(0).copyWith(left: 17, right: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.order.products.length; i++)
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    widget.order.products[i].images.first,
                                    scale: 1,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.order.products[i].name
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Qty: ${widget.order.quantity[i]}'
                                            .toUpperCase(),
                                      ),
                                      Text(
                                        'Address: ${widget.order.address}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const headline(h1: 'Tracking.'),
                    Container(
                      margin: EdgeInsets.zero, // Set margin to zero
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Stepper(
                          currentStep: _currentStep,
                          controlsBuilder: (context, details) {
                            if (user.type == 'admin') {
                              return CustomButton(
                                text: 'Done',
                                onClick: () {},
                                Btnbg: Colors.red,
                              );
                            }
                            return const SizedBox();
                          },
                          steps: [
                            Step(
                              title: const Text('Pending'),
                              content: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Your Order have been pending",
                                ),
                              ),
                              isActive: _currentStep > 0,
                              state: _currentStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Order Confirmed'),
                              content: Container(
                                  alignment: Alignment.topLeft,
                                  child:
                                      const Text("Your Order have been confrom")),
                              isActive: _currentStep > 1,
                              state: _currentStep > 1
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Shipped'),
                              content: Container(
                                  alignment: Alignment.topLeft,
                                  child:
                                      const Text("Your Order has been Shipped.")),
                              isActive: _currentStep > 2,
                              state: _currentStep > 2
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Out for Delivery'),
                              content: Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                    "Your Order has been Delovered and signed by you!"),
                              ),
                              isActive: _currentStep >= 3,
                              state: _currentStep >= 3
                                  ? StepState.complete
                                  : StepState.indexed,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class headline extends StatelessWidget {
  final String h1;
  const headline({
    Key? key,
    required this.h1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0).copyWith(
        left: 10,
        right: 12,
        top: 9,
        bottom: 9,
      ),
      margin: const EdgeInsets.all(0).copyWith(
        left: 17,
        right: 17,
      ),
      child: Text(
        '${h1}',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'rejoin',
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
