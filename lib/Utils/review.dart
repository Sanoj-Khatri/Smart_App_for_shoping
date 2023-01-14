import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartapp_fyp/Utils/utils.dart';

addReview(context) {
  TextEditingController reviewText = TextEditingController();
  //final fireStore = FirebaseFirestore.instance.collection('ChasUp');
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: const Text('Add Review'),
          content: Column(
            children: [
              TextFormField(
                controller: reviewText,
                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 5,
              ),
              TextButton.icon(
                  onPressed: () {
                    //updateUser();
                    // fireStore
                    //     .doc('product_id')
                    //     .set(({
                    //       'review': reviewText.text.toString(),
                    //     }))
                    //     .then((value) {})
                    //     .onError((error, stackTrace) {
                    //   Utils().toastmessage(error.toString());
                    // });
                    // FirebaseFirestore.instance
                    //     .collection('ChasUp')
                    //     .doc('product_id')
                    //     .update({
                    //   'review': FieldValue.arrayUnion(['el1', 'el2'])
                    // });
                    // FirebaseFirestore.instance.collection('ChasUp').get().then(
                    //       (value) => value.docs.forEach(
                    //         (element) {
                    //           var docRef = FirebaseFirestore.instance
                    //               .collection('Chasup')
                    //               .doc(element.id);

                    //           docRef.update({'bio': ''});
                    //         },
                    //       ),
                    //     );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Post Review'))
            ],
          ),
        );
      });
}

// CollectionReference users = FirebaseFirestore.instance.collection('ChasUp');

// Future<void> updateUser() {
//   return users
//       .doc('1KCjJxOuPRa6glqXaYSC')
//       .update({'ChasUp': 'review'})
//       .then((value) => print("User Updated"))
//       .catchError((error) => print("Failed to update user: $error"));
// }

