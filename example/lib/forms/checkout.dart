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

  @override
  Widget build(BuildContext context) {
    CheckoutFormData formData = Get.put(CheckoutFormData());
    formData.currency = 'LKR';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check - Out'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter total amount*',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value) {
                        formData.amount = value;
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
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
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, Pages.billingDetails);
                  }
                },
                child: const Text('Checkout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
