import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payable_ipg_demo/form_data.dart';
import 'package:payable_ipg_demo/pages.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _orderDescriptionController = TextEditingController();
  final _custom1Controller = TextEditingController();
  final _custom2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckoutFormData formData = Get.put(CheckoutFormData());
    formData.currency = 'LKR';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check - Out'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter total amount*',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Required' : null,
                        controller: _amountController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownMenu<String>(
                      initialSelection: 'LKR',
                      label: const Text('Currency'),
                      onSelected: (String? currency) {
                        formData.currency = currency;
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<String>(
                          value: 'LKR',
                          label: 'LKR',
                        ),
                        DropdownMenuEntry<String>(
                          value: 'USD',
                          label: 'USD',
                        ),
                        DropdownMenuEntry<String>(
                          value: 'GBP',
                          label: 'GBP',
                        ),
                        DropdownMenuEntry<String>(
                          value: 'EUR',
                          label: 'EUR',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _orderDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Order description',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _custom1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Custom 1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _custom2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Custom 2',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _storeFormData();
                          Navigator.pushNamed(context, Pages.billingDetails);
                        }
                      },
                      child: const Text('Checkout'),
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

  void _storeFormData() {
    CheckoutFormData cfd = Get.find();
    double amount = double.tryParse(_amountController.text) ?? 0.00;
    cfd.amount = amount.toStringAsFixed(2);
    cfd.orderDescription = _orderDescriptionController.text;
    cfd.custom1 = _custom1Controller.text;
    cfd.custom2 = _custom2Controller.text;
  }
}
