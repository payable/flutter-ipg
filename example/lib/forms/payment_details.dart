import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payable_ipg_demo/form_data.dart';

import '../pages.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _paymentTypeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _recurringAmountController = TextEditingController();
  final _intervalController = TextEditingController();
  final _isRetryController = TextEditingController();
  final _retryAttemptsController = TextEditingController();
  final _doFirstPaymentController = TextEditingController();
  bool _isRecurring = false;
  DateTime _selectedStartDate = DateTime.now();
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _endDateController.text = 'FOREVER';
  }

  @override
  Widget build(BuildContext context) {
    CheckoutFormData cfd = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        const Text('Amount'),
                        Row(
                          children: [
                            Text(
                              cfd.amount!,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              cfd.currency!,
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    DropdownMenu<String>(
                      initialSelection: '1',
                      label: const Text('Payment type'),
                      controller: _paymentTypeController,
                      onSelected: (String? type) {
                        setState(() {
                          _isRecurring = type == '2';
                        });
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<String>(
                          value: '1',
                          label: 'One time',
                        ),
                        DropdownMenuEntry<String>(
                          value: '2',
                          label: 'Recurring',
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isRecurring) _showRecurringPaymentFields(),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isRecurring) {
                          if (_formKey.currentState!.validate()) {
                            _storeFormData();
                            Navigator.pushNamed(context, Pages.pay);
                          }
                        } else {
                          _storeFormData();
                          Navigator.pushNamed(context, Pages.pay);
                        }
                      },
                      child: const Text('Pay'),
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

  Widget _showRecurringPaymentFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    labelText: 'Start date*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context, true);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                child: TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(
                    labelText: 'End date',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context, false);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _recurringAmountController,
                  decoration: const InputDecoration(
                    labelText: 'Recurring amount*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                child: DropdownMenu<String>(
                  controller: _intervalController,
                  initialSelection: 'DAILY',
                  label: const Text('Interval*'),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry<String>(
                      value: 'DAILY',
                      label: 'Daily',
                    ),
                    DropdownMenuEntry<String>(
                      value: 'WEEKLY',
                      label: 'Weekly',
                    ),
                    DropdownMenuEntry<String>(
                      value: 'MONTHLY',
                      label: 'Monthly',
                    ),
                    DropdownMenuEntry<String>(
                      value: 'QUARTERLY',
                      label: 'Quarterly',
                    ),
                    DropdownMenuEntry<String>(
                      value: 'ANNUALLY',
                      label: 'Annually',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _isRetryController,
                  decoration: const InputDecoration(
                    labelText: 'Is retry*',
                    border: OutlineInputBorder(),
                  ),
                  validator: _isValue01,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                child: TextFormField(
                  controller: _retryAttemptsController,
                  decoration: const InputDecoration(
                    labelText: 'Retry attempts*',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Flexible(
            child: TextFormField(
              controller: _doFirstPaymentController,
              decoration: const InputDecoration(
                labelText: 'Do first attempt*',
                border: OutlineInputBorder(),
              ),
              validator: _isValue01,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _selectedStartDate : _selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = selectedDate;
          _startDateController.text = _selectedStartDate.toIso8601String().split('T')[0];
        } else {
          _selectedEndDate = selectedDate;
          _endDateController.text = _selectedEndDate!.toIso8601String().split('T')[0];
        }
      });
    }
  }

  String? _isValue01(String? value) {
    if (value!.isEmpty){
      return 'Required';
    } else if (value == '1' || value == '0') {
      return null;
    } else {
      return 'Invalid';
    }
  }

  void _storeFormData() {
    CheckoutFormData cfd = Get.find();
    cfd.paymentType = _isRecurring ? 2 : 1;
    if (_isRecurring) {
      double amount = double.tryParse(_recurringAmountController.text) ?? 0.00;
      cfd.recurringAmount = amount.toStringAsFixed(2);
      cfd.startDate = _startDateController.text;
      cfd.endDate = _endDateController.text;
      cfd.interval = _intervalController.text.toUpperCase();
      cfd.isRetry = _isRetryController.text;
      cfd.retryAttempts = _retryAttemptsController.text;
      cfd.doFirstPayment = _doFirstPaymentController.text;
    }
  }
}
