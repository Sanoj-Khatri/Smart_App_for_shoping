import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Utils/review.dart';
import 'package:smartapp_fyp/Utils/utils.dart';
import 'package:smartapp_fyp/screens/registration/loginpage.dart';
import '../Widgets/text_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();

  String search = '';
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('ChasUp').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Products",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.white12));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: TextFormField(
                      controller: searchController,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search product",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          search = value.toString();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(children: [
                  //   snapshot.data!.docs.map((DocumentSnapshot document) {
                  // Map<String, dynamic> data =
                  //     document.data()! as Map<String, dynamic>;
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['product_name']
                              .toString()
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(top: 30.0, left: 8, right: 8),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 8),
                          elevation: 50,
                          shadowColor: Colors.white,
                          surfaceTintColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    NetworkImage(data['product_pic']),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Textdata(
                                text: data['product_name'],
                                fontsize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const heightSpacer(),
                                  Textdata(
                                    text: 'Brand: ${data['product_company']}',
                                    fontsize: 16,
                                  ),
                                  const heightSpacer(),
                                  Textdata(
                                    text: data['product_weight'],
                                    fontsize: 16,
                                  ),
                                  const heightSpacer(),
                                  Textdata(
                                    text: 'Mart: ${data['mart']}',
                                    fontsize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  const heightSpacer(),
                                  TextButton.icon(
                                      onPressed: () async {
                                        if (GetStorage().read("user_info") !=
                                            null) {
                                          List<dynamic> wishListIds =
                                              await GetStorage().read(
                                                  'user_info')['wishListIds'];

                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(GetStorage()
                                                  .read("user_info")["user_id"])
                                              .get()
                                              .then((doc) async {
                                            if (!doc
                                                .data()!["wishListIds"]
                                                ?.contains(
                                                    data.id.toString())) {
                                              wishListIds
                                                  .add(data.id.toString());
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(GetStorage().read(
                                                      "user_info")["user_id"])
                                                  .update({
                                                "wishListIds": wishListIds
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      dismissDirection:
                                                          DismissDirection.down,
                                                      duration:
                                                          Duration(seconds: 1),
                                                      content: Text(
                                                          "Added Successfully")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      dismissDirection:
                                                          DismissDirection.down,
                                                      duration:
                                                          Duration(seconds: 1),
                                                      content: Text(
                                                          "Already Added in the list")));
                                            }
                                          });
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login()));
                                          Utils().toastmessage(
                                              "You have to login first");
                                        }
                                      },
                                      icon: const Icon(Icons.add_box_rounded),
                                      label: const Text('Add Wishlist'))
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Textdata(
                                    text:
                                        'Rs: ${data['product_price'].toString()}',
                                    fontsize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  GestureDetector(
                                    onTap: (() async {
                                      await addReview(
                                        collectionName: 'ChasUp',
                                        context: context,
                                        productId: data.id,
                                        reviews: data['reviews'] ?? [],
                                      );
                                    }),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2 /
                                          2,
                                      decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: const Center(
                                          child: Text(
                                        'Add Review',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ));
                  })
                ]))
              ],
            );
          },
        ));
  }
}

class heightSpacer extends StatelessWidget {
  const heightSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4 / 30,
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../Widgets/text_widget.dart';

// class ProductsScreenInformation extends StatefulWidget {
//   @override
//   _ProductsScreenInformationState createState() => _ProductsScreenInformationState();
// }

// class _ProductsScreenInformationState extends State<ProductsScreenInformation> {
//   TextEditingController searchController = TextEditingController();
//   String search = '';
//   final Stream<QuerySnapshot> _ProductsScreensStream =
//       FirebaseFirestore.instance.collection('ChasUp').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: _ProductsScreensStream,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                       strokeWidth: 4.0,
//                       color: Colors.deepPurple,
//                       backgroundColor: Colors.white12));
//             }

//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 20.0, horizontal: 15),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0)),
//                     child: TextFormField(
//                       controller: searchController,
//                       enableSuggestions: true,
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.all(8.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         prefixIcon: const Icon(Icons.search),
//                         hintText: "Search product",
//                       ),
//                       onChanged: (String? value) {
//                         print(value);
//                         setState(() {
//                           search = value.toString();
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView(
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data()! as Map<String, dynamic>;

//                       return Padding(
//                         padding:
//                             const EdgeInsets.only(top: 30.0, left: 8, right: 8),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.height / 4.5,
//                           child: Card(
//                             margin: const EdgeInsets.symmetric(horizontal: 12),
//                             elevation: 50,
//                             shadowColor: Colors.white30,
//                             surfaceTintColor: Colors.red,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 leading: CircleAvatar(
//                                   radius: 30.0,
//                                   backgroundImage:
//                                       NetworkImage(data['product_pic']),
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                                 title: Textdata(
//                                   text: data['product_name'],
//                                   fontsize: 21,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const heightSpacer(),
//                                     Textdata(
//                                       text: 'Brand: ${data['product_company']}',
//                                       fontsize: 16,
//                                     ),
//                                     const heightSpacer(),
//                                     Textdata(
//                                       text: data['product_weight'],
//                                       fontsize: 16,
//                                     ),
//                                     const heightSpacer(),

//                                     Textdata(
//                                       text: 'Mart: ${data['mart']}',
//                                       fontsize: 16,
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                     // Row(
//                                     //   mainAxisAlignment: MainAxisAlignment.end,
//                                     //   crossAxisAlignment: CrossAxisAlignment.end,
//                                     //   children: [Text('data')],
//                                     // )
//                                   ],
//                                 ),
//                                 trailing: Textdata(
//                                   text:
//                                       'Rs: ${data['product_price'].toString()}',
//                                   fontsize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 isThreeLine: true,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 heightSpacer()
//               ],
//             );
//           },
//         ));
//   }
// }

// class heightSpacer extends StatelessWidget {
//   const heightSpacer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 4 / 30,
//     );
//   }
// }
