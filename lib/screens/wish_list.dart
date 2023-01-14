import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WishList'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
            ),
            const Text(
              "No Product to show",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return const AlertDialog(
                          backgroundColor: Colors.green,
                          title: Text("Here are you"),
                        );
                      });
                },
                child: const Text('Click Me'))
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_const

// ignore_for_file: unnecessary_const

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
