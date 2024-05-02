// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interior_design_arapp/constants/utils/snackBar.utils.dart';
import 'package:interior_design_arapp/features/address/services/address_services.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:interior_design_arapp/common/widgets/custom_button.dart';
import 'package:interior_design_arapp/common/widgets/custom_textbar.dart';
import 'package:interior_design_arapp/features/address/services/gpay.dart';
import 'package:interior_design_arapp/providers/user.provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';

  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
        label: 'Total Amount',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void addAndChangeAddress(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = flatController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatController.text.trim()}, ${areaController.text.trim()}, ${cityController.text.trim()} - ${pincodeController.text.trim()}';
      } else {
        showSnackBar(context, "Please enter all the values!");
        return;
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "ERROR");
      return;
    }
    AddressServices().saveUserAddress(
      context: context,
      address: addressToBeUsed,
    );
    Navigator.pop(context);
    flatController.clear();
    areaController.clear();
    pincodeController.clear();
    cityController.clear();
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: double.parse(widget.totalAmount),
    );
  }

  void payPress(String addressFromProvider) {
    addressToBeUsed = "";
    if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                child: const Text(
                  "Checkout",
                  style: TextStyle(
                    fontFamily: 'rejoin',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping Details',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'rejoin',
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.black,
                            builder: (_) => Container(
                              margin: EdgeInsets.all(22),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 135,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        address.isEmpty
                                            ? "Add Address"
                                            : "Change Address",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'rejoin',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    flex: 6,
                                    child: Form(
                                      key: _addressFormKey,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          CustomTextField(
                                            hintText:
                                                'Flat, House no, Building',
                                            controller: flatController,
                                          ),
                                          const SizedBox(height: 5),
                                          CustomTextField(
                                            hintText: 'Area, Street',
                                            controller: areaController,
                                          ),
                                          const SizedBox(height: 5),
                                          CustomTextField(
                                            hintText: 'Pincode',
                                            controller: pincodeController,
                                          ),
                                          const SizedBox(height: 5),
                                          CustomTextField(
                                            hintText: 'Town/City',
                                            controller: cityController,
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: address.isEmpty
                                            ? 'Add Address'
                                            : 'Change Address',
                                        textbg: Colors.white,
                                        onClick: () =>
                                            addAndChangeAddress(address),
                                        Btnbg: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          address.isEmpty ? 'Add Address' : 'Edit',
                          style: const TextStyle(
                            fontFamily: 'rejoin',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffea1833),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (address.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(0)
                              .copyWith(top: 15, bottom: 15),
                          padding: const EdgeInsets.all(15).copyWith(top: 17),
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          child: Text(
                            address.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // color: Color.fromARGB(255, 0, 0, 0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GooglePayButton(
                    onPressed: () => payPress(address),
                    type: GooglePayButtonType.buy,
                    theme: GooglePayButtonTheme.dark,
                    paymentConfiguration: PaymentConfiguration.fromJsonString(
                      defaultGooglePay,
                    ),
                    paymentItems: paymentItems,
                    margin: const EdgeInsets.all(12),
                    width: double.infinity,
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    onPaymentResult: onGooglePayResult,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
