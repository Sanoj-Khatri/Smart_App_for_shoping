import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartapp_fyp/Widgets/text_widget.dart';
import 'package:smartapp_fyp/screens/product_screen.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isLoading = true;
  List<dynamic> wishListIds = [];
  List<DocumentSnapshot> products = [];
  String userId = "";
  @override
  void initState() {
    if (GetStorage().read("user_info") != null) {
      Future.delayed(const Duration(seconds: 5), () => getWishListIDS());
    }

    super.initState();
  }

  getWishListIDS() async {
    try {
      setState(() => isLoading = true);
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(GetStorage().read("user_info")['user_id'])
          .get();
      final userInfo = {
        "user_id": GetStorage().read("user_info")['user_id'],
        "name": doc['name'],
        "email": doc['email'],
        "wishListIds": doc['wishListIds'],
      };
      await GetStorage().write("user_info", userInfo);
      setState(() async {
        wishListIds = GetStorage().read("user_info")['wishListIds'];
        for (var id in wishListIds) {
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection("ChasUp")
              .doc(id.toString())
              .get();
          setState(() {
            products.add(doc);
          });
        }
      });
      setState(() => isLoading = false);
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WishList'),
        centerTitle: true,
      ),
      body: wishListIds.isEmpty
          ? EmptyView(
              isLoading: isLoading,
            )
          : ListView.builder(
              key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 8, right: 8),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                  NetworkImage(products[index]['product_pic']),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Textdata(
                              text: products[index]['product_name'],
                              fontsize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const heightSpacer(),
                                Textdata(
                                  text:
                                      'Brand: ${products[index]['product_company']}',
                                  fontsize: 16,
                                ),
                                const heightSpacer(),
                                Textdata(
                                  text: products[index]['product_weight'],
                                  fontsize: 16,
                                ),
                                const heightSpacer(),
                                Textdata(
                                  text: 'Mart: ${products[index]['mart']}',
                                  fontsize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                                TextButton.icon(
                                    onPressed: () async {
                                      if (GetStorage().read("user_info") !=
                                          null) {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(GetStorage()
                                                  .read("user_info")['user_id'])
                                              .update({
                                            'wishListIds':
                                                FieldValue.arrayRemove([
                                              products[index]['product_id']
                                            ])
                                          }).then((value) async {
                                            setState(() {
                                              products.removeAt(index);
                                            });
                                            //   DocumentSnapshot doc =
                                            //       await FirebaseFirestore.instance
                                            //           .collection("users")
                                            //           .doc(GetStorage().read(
                                            //               "user_info")['user_id'])
                                            //           .get();
                                            //   final userInfo = {
                                            //     "user_id": GetStorage()
                                            //         .read("user_info")['user_id'],
                                            //     "name": doc['name'],
                                            //     "email": doc['email'],
                                            //     "wishListIds": doc['wishListIds'],
                                            //   };
                                            //   await GetStorage()
                                            //       .write("user_info", userInfo);
                                            // });
                                            // setState(() async {
                                            //   wishListIds = GetStorage().read(
                                            //       "user_info")['wishListIds'];
                                            //   products.clear();
                                            //   for (var id in wishListIds) {
                                            //     DocumentSnapshot doc =
                                            //         await FirebaseFirestore
                                            //             .instance
                                            //             .collection("ChasUp")
                                            //             .doc(id.toString())
                                            //             .get();
                                            //     setState(() {
                                            //       products.add(doc);
                                            //     });
                                            //}
                                          });
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.remove_shopping_cart_outlined),
                                    label: const Text("Remove"))
                              ],
                            ),
                            trailing: Textdata(
                              text:
                                  'Rs: ${products[index]['product_price'].toString()}',
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      ),
                    ));
              }),
    );
  }
}

class EmptyView extends StatelessWidget {
  final bool isLoading;
  const EmptyView({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                const Icon(
                  Icons.error_outline,
                  size: 100,
                ),
                const Text(
                  "No Product to show",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w200),
                ),
              ],
            ),
          );
  }
}

// ignore_for_file: unnecessary_const
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../Widgets/text_widget.dart';

// class User extends StatefulWidget {
//   @override
//   _UserState createState() => _UserState();
// }

// class _UserState extends State<User> {
//   TextEditingController searchController = TextEditingController();
//   String search = '';
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('ChasUp').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: _usersStream,
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
//                     child: ListView(children: [
//                   //   snapshot.data!.docs.map((DocumentSnapshot document) {
//                   // Map<String, dynamic> data =
//                   //     document.data()! as Map<String, dynamic>;
//                   ...snapshot.data!.docs
//                       .where((QueryDocumentSnapshot<Object?> element) =>
//                           element['product_name']
//                               .toString()
//                               .toLowerCase()
//                               .contains(search.toLowerCase()))
//                       .map((QueryDocumentSnapshot<Object?> data) {
//                     final String title = data.get('product_name');
//                     return Padding(
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
//                         ));
//                   })
//                 ]))
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
