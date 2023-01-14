// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('ChasUp').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(),
//           body: StreamBuilder<QuerySnapshot>(
//             stream: _usersStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }

//               return ListView(
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data()! as Map<String, dynamic>;
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       color: Colors.deepPurple,
//                       shadowColor: Colors.white60,
//                       child: ListTile(
//                           //  leading: Image.network('product_pic'),
//                           title: Text(data['product_name']),
//                           subtitle: Text(data['product_weight'].toString()),
//                           trailing: Text(
//                             data["product_price"].toString(),
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           isThreeLine: true,
//                           textColor: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               );
//             },
//           )),
//     );
//   }
// }

    








// class FetchData extends StatefulWidget {
//   const FetchData({Key? key}) : super(key: key);

//   @override
//   State<FetchData> createState() => _FetchDataState();
// }

// class _FetchDataState extends State<FetchData> {
//   final auth = FirebaseAuth.instance;
//   final fireStore = FirebaseFirestore.instance.collection('ChasUp').snapshots();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           StreamBuilder<QuerySnapshot>(builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }

//             if (snapshot.hasError) return const Text("Some Error");

//             return Expanded(
//                 child: ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       return const ListTile(
//                         title: Text('sanoj'),
//                       );
//                     }));
//           }),
//         ],
//       ),
//     ));
//   }
// }
