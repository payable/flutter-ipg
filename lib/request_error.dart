import 'package:flutter/material.dart';

class RequestError extends StatefulWidget {
  const RequestError({super.key, this.onBackPressed});
  final OnBackPressed onBackPressed;

  @override
  State<RequestError> createState() => _RequestErrorState();
}

class _RequestErrorState extends State<RequestError> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff477bbb),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Image.network(
                      'https://www.payable.lk/my-content/uploads/2022/11/footerlogo.png',
                      scale: 1.5,
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Error!',
                style: TextStyle(fontSize: 26.0, color: Colors.red),
              ),
              const Text(
                'Something went wrong.\nPlease contact your merchant.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: 120,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xff3D8AB6)),
                    onPressed: () {
                      widget.onBackPressed!();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 8),
                        Text('Back'),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'The payment will be processed through PAYable Private Limited.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
              const Text(
                'For Inquiries; Call Customer Support at +94 11 777 6 777',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnBackPressed = void Function()?;
