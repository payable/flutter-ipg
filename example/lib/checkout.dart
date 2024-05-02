import 'package:flutter/material.dart';
import 'package:payable_ipg_demo/pages.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _amount;
  String? _currency;

  @override
  Widget build(BuildContext context) {
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
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter total amount*',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      _amount = value;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                DropdownMenu<String>(
                  initialSelection: 'LKR',
                  label: const Text('Currency'),
                  onSelected: (String? currency) {
                    setState(() {
                      _currency = currency;
                    });
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
                  Navigator.pushNamed(context, Pages.contactDetails);
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
