
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class GetCarName extends StatelessWidget {
  late final String documentId;

  GetCarName(this.documentId);


  Widget _title() {
    return const Text('Car Details');
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference cars = FirebaseFirestore.instance.collection('cars');

    return Scaffold(
        appBar: AppBar(
        title: _title(),
    ),
    body: FutureBuilder<DocumentSnapshot>(
      future: cars.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Container(
              padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                ListTile( title: Text(" • CAR REFERENCE:    ${data['ref']}"),),
                ListTile( title: Text(" • CAR NAME:    ${data['name']}")),
                ListTile( title: Text(" • CAR COLOR:    ${data['color']}"),),
                ListTile( title: Text(" • CAR PLATE NUMBER:    ${data['mat']}")),
                ListTile( title: Text(" • CAR MODEL:    ${data['model']}")),

              ],
            )
          );
        }

        return Text("loading");
      },
    ),
        );
  }
}