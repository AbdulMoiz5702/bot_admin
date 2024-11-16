import 'package:bot_admin/const/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DailyTasksController extends GetxController {
  Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      await fireStore.collection(dailyTasks).add(taskData);
      Get.snackbar('Success', 'Task added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error adding task: $e');
    }
  }

  Future<void> updateTask(String docId, Map<String, dynamic> updatedData) async {
    try {
      await fireStore.collection(dailyTasks).doc(docId).update(updatedData);
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error updating task: $e');
    }
  }

  Future<void> deleteTask(String docId) async {
    try {
      await fireStore.collection(dailyTasks).doc(docId).delete();
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error deleting task: $e');
    }
  }

  Future<void> moveToUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController buttonTextController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  void showTaskForm(BuildContext context, {String? docId, Map<String, dynamic>? existingData}) {
    if (existingData != null) {
      taskNameController.text = existingData['task_name'] ?? '';
      imageUrlController.text = existingData['image_url'] ?? '';
      buttonTextController.text = existingData['button_text'] ?? '';
      priceController.text = existingData['price'].toString();
      urlController.text = existingData['url'] ?? '';
    } else {
      taskNameController.clear();
      imageUrlController.clear();
      buttonTextController.clear();
      priceController.clear();
      urlController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(docId == null ? 'Add Task' : 'Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: taskNameController, decoration: InputDecoration(labelText: 'Task Name')),
              TextField(controller: imageUrlController, decoration: InputDecoration(labelText: 'Image URL')),
              TextField(controller: buttonTextController, decoration: InputDecoration(labelText: 'Button Text')),
              TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              TextField(controller: urlController, decoration: InputDecoration(labelText: 'URL')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final taskData = {
                  'task_name': taskNameController.text,
                  'image_url': imageUrlController.text,
                  'button_text': buttonTextController.text,
                  'price': int.tryParse(priceController.text) ?? 0,
                  'url': urlController.text,
                  'completed': existingData?['completed'] ?? [],
                };
                if (docId == null) {
                  addTask(taskData);
                } else {
                  updateTask(docId, taskData);
                }
                Navigator.pop(context);
              },
              child: Text(docId == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}