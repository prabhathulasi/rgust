import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

resultDeleteDialog(BuildContext context, int itemId, int studentId) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: const Text(
              'Are you sure you want to delete this result? This action cannot be undone.'),
          actions: [
            Consumer<StudentProvider>(
                builder: (context, studentConsumer, child) {
              return studentConsumer.isLoading == true ? CircularProgressIndicator() :TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? token = prefs.getString('Token');
                  var result = await studentConsumer.deleteRepeatedResult(
                      token!, itemId, studentId);
                  if (result == "200" && context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Ok'),
              );
            }),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
}
