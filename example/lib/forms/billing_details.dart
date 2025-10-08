import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:payable_ipg_demo/form_data.dart';
import 'package:payable_ipg_demo/pages.dart';

class BillingDetailsPage extends StatefulWidget {
  const BillingDetailsPage({super.key});

  @override
  State<BillingDetailsPage> createState() => _BillingDetailsPageState();
}

class _BillingDetailsPageState extends State<BillingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _street1Controller = TextEditingController();
  final _street2Controller = TextEditingController();
  final _townCityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _countryController = TextEditingController();
  final _postcodeController = TextEditingController();
  bool _shipToDifferentAddress = false;

  // Sample data for autofill
  static const Map<String, String> _sampleData = {
    'firstName': 'John',
    'lastName': 'Doe',
    'mobile': '0777123456',
    'phone': '0112345678',
    'email': 'john.doe@example.com',
    'companyName': 'Acme Corporation',
    'street1': '123 Main Street',
    'street2': 'Apt 4B',
    'townCity': 'Colombo',
    'province': 'Western Province',
    'country': 'LK',
    'postcode': '00100',
  };

  void _autofillSampleData() {
    setState(() {
      _firstNameController.text = _sampleData['firstName']!;
      _lastNameController.text = _sampleData['lastName']!;
      _mobileController.text = _sampleData['mobile']!;
      _phoneController.text = _sampleData['phone']!;
      _emailController.text = _sampleData['email']!;
      _companyNameController.text = _sampleData['companyName']!;
      _street1Controller.text = _sampleData['street1']!;
      _street2Controller.text = _sampleData['street2']!;
      _townCityController.text = _sampleData['townCity']!;
      _provinceController.text = _sampleData['province']!;
      _countryController.text = _sampleData['country']!;
      _postcodeController.text = _sampleData['postcode']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing address'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _autofillSampleData,
                      icon: const Icon(Icons.auto_fix_high),
                      label: const Text('Autofill Sample Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        foregroundColor: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ),
                _buildBillingAddressSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: CheckboxListTile(
                      title: const Text('Ship to a different address?'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _shipToDifferentAddress,
                      onChanged: (value) =>
                          setState(() => _shipToDifferentAddress = value!)
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _storeFormData();
                          if (_shipToDifferentAddress) {
                            Navigator.pushNamed(context, Pages.shippingDetails);
                          } else {
                            Navigator.pushNamed(context, Pages.paymentDetails);
                          }
                        }
                      },
                      child: const Text('Next'),
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

  Widget _buildBillingAddressSection() {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              keyboardType: TextInputType.phone,
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone No',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: 'Email Address*',
          border: OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? 'Required' : null,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16.0),
      TextFormField(
        controller: _companyNameController,
        decoration: const InputDecoration(
          labelText: 'Company Name',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 16.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              controller: _street1Controller,
              decoration: const InputDecoration(
                labelText: 'Street Address 1*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _street2Controller,
              decoration: const InputDecoration(
                labelText: 'Street Address 2',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              controller: _townCityController,
              decoration: const InputDecoration(
                labelText: 'Town/City*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _provinceController,
              decoration: const InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country*',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                showCountryPicker(context: context, onSelect: (Country country) {
                  _countryController.text = country.countryCode;
                });
              },
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _postcodeController,
              decoration: const InputDecoration(
                labelText: 'Post code*',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ),
        ],
      ),
    ]);
  }

  void _storeFormData() {
    CheckoutFormData cfd = Get.find();
    cfd.billingFirstName = _firstNameController.value.text;
    cfd.billingLastName = _lastNameController.value.text;
    cfd.billingMobile = _mobileController.value.text;
    cfd.billingPhone = _phoneController.value.text;
    cfd.billingEmail = _emailController.value.text;
    cfd.billingCompanyName = _companyNameController.value.text;
    cfd.billingStreetAddress1 = _street1Controller.value.text;
    cfd.billingStreetAddress2 = _street2Controller.value.text;
    cfd.billingTownCity = _townCityController.value.text;
    cfd.billingProvince = _provinceController.value.text;
    cfd.billingCountry = _countryController.value.text;
    cfd.billingPostcode = _postcodeController.value.text;

    if (!_shipToDifferentAddress) {
      cfd.shippingFirstName = _firstNameController.value.text;
      cfd.shippingLastName = _lastNameController.value.text;
      cfd.shippingMobile = _mobileController.value.text;
      cfd.shippingPhone = _phoneController.value.text;
      cfd.shippingEmail = _emailController.value.text;
      cfd.shippingCompanyName = _companyNameController.value.text;
      cfd.shippingStreetAddress1 = _street1Controller.value.text;
      cfd.shippingStreetAddress2 = _street2Controller.value.text;
      cfd.shippingTownCity = _townCityController.value.text;
      cfd.shippingProvince = _provinceController.value.text;
      cfd.shippingCountry = _countryController.value.text;
      cfd.shippingPostcode = _postcodeController.value.text;
    }
  }
}
