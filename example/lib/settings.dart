import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final merchantKeyController = TextEditingController();
  final merchantTokenController = TextEditingController();
  final packageNameController = TextEditingController();
  final logoUrlController = TextEditingController();
  final notificationUrlController = TextEditingController();

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('merchantKey', merchantKeyController.text);
    await prefs.setString('merchantToken', merchantTokenController.text);
    await prefs.setString('packageName', packageNameController.text);
    await prefs.setString('logoUrl', logoUrlController.text);
    await prefs.setString('notificationUrl', notificationUrlController.text);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      merchantKeyController.text = prefs.getString('merchantKey') ?? '';
      merchantTokenController.text = prefs.getString('merchantToken') ?? '';
      packageNameController.text = prefs.getString('packageName') ?? '';
      logoUrlController.text = prefs.getString('logoUrl') ?? '';
      notificationUrlController.text = prefs.getString('notificationUrl') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: merchantKeyController,
                  decoration: const InputDecoration(
                    labelText: 'Merchant Key*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: merchantTokenController,
                  decoration: const InputDecoration(
                    labelText: 'Merchant Token*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: packageNameController,
                  decoration: const InputDecoration(
                    labelText: 'Package Name*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: logoUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Logo URL*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: notificationUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Merchant Notification URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveSettings();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved'))
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
