import 'package:bot_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/firebase_const.dart';
import '../../controllers/social_taks_controller.dart';

class SocialTaksScreen extends StatelessWidget {
  const SocialTaksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SocialTasksController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Tasks'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseServices.getSocialTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading tasks'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Tasks Found'));
          } else {
            var allTasks = snapshot.data!.docs;
            return ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                var data = allTasks[index].data() as Map<String, dynamic>;
                var docId = allTasks[index].id;
                List completedList = data['completed'] ?? [];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['image_url'] ?? '')),
                  title: Text(data['task_name'] ?? ''),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'price: ${data['price'] ?? 0} Done: ${completedList.length}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () => controller.showTaskForm(context,
                              docId: docId, existingData: data),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          )),
                      InkWell(
                        onTap: () => () => controller.deleteTask(docId),
                        child: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            controller.moveToUrl(data['url'] ?? ''),
                        child: Text(data['button_text'] ?? ''),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showTaskForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
