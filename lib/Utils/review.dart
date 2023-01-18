import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Utils/utils.dart';
import 'package:smartapp_fyp/models/user_model.dart';
import 'package:smartapp_fyp/screens/registration/loginpage.dart';

addReview(
    {required BuildContext context,
    required String productId,
    required String collectionName,
    required List reviews}) {
  TextEditingController reviewText = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Add Review'),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextFormField(
              decoration:
                  const InputDecoration(hintText: "Please write your review"),
              controller: reviewText,
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 5,
            ),
            TextButton.icon(
              onPressed: () async {
                if (await GetStorage().read("user_info") != null) {
                  if (reviewText.text.isNotEmpty) {
                    final userInfo = await GetStorage().read("user_info");
                    try {
                      print("review ${userInfo['name']}");
                      reviews.add({
                        "user_name": userInfo['name'],
                        "review": reviewText.text
                      });

                      firebaseFirestore
                          .collection(collectionName)
                          .doc(productId)
                          .update({
                        "reviews": reviews,
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    Utils().toastmessage("Textfeild is empty ");
                  }
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                  Utils().toastmessage("You have to login first");
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Post Review'),
            )
          ],
          content: setupAlertDialoadContainer(context, reviews),
        );
      });
}

Widget setupAlertDialoadContainer(BuildContext context, List review) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: review.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: review.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(review[index]['review']),
                subtitle: Text("Review By: ${review[index]['user_name']}"),
              );
            },
          )
        : const Text("No reviews available"),
  );
}
