import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
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
                if (_shipToDifferentAddress) _buildBillingAddressSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process checkout data
                      }
                    },
                    child: const Text('Checkout'),
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
        children: [
          Flexible(
            child: TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name*',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your first name' : null,
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
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your last name' : null,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile*',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your mobile number' : null,
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
        validator: (value) =>
            value!.isEmpty ? 'Please enter your email address' : null,
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
        children: [
          Flexible(
            child: TextFormField(
              controller: _street1Controller,
              decoration: const InputDecoration(
                labelText: 'Street Address 1*',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your street address' : null,
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
        children: [
          Flexible(
            child: TextFormField(
              controller: _townCityController,
              decoration: const InputDecoration(
                labelText: 'Town/City*',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your town/city' : null,
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
        children: [
          Flexible(
            child: TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country*',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your country' : null,
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: TextFormField(
              controller: _postcodeController,
              decoration: const InputDecoration(
                labelText: 'Post code',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
