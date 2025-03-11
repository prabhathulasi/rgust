import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;
class TestingPdf extends StatefulWidget {
  const TestingPdf({super.key});

  @override
  State<TestingPdf> createState() => _TestingPdfState();
}

class _TestingPdfState extends State<TestingPdf> {
   final pdf = pw.Document();



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}