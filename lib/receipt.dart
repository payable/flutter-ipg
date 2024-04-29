import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  final String? uid;

  const Receipt({
    super.key,
    required this.uid
  });

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  String? _uid;

  @override
  void initState() {
    super.initState();
    _uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Text(_uid!);
  }
}
