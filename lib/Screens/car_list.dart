

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location_voiture/Screens/LoginOrRegister_Page.dart';
import 'package:location_voiture/Screens/ShowCar.dart';
import 'package:location_voiture/Services/auth.dart';
import 'package:flutter/material.dart';
class CarList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => CarListState();
}

class CarListState extends State<CarList> {

  final CollectionReference _cars =
  FirebaseFirestore.instance.collection('cars');

  final User? user = Auth().currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _refController = TextEditingController();
  final TextEditingController _matController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();


  // update car
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _nameController.text = documentSnapshot['name'];
      _refController.text = documentSnapshot['ref'].toString();
      _matController.text = documentSnapshot['mat'];
      _modelController.text = documentSnapshot['model'].toString();
      _colorController.text = documentSnapshot['color'].toString();

    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _refController,
                  decoration: const InputDecoration(
                    labelText: 'Ref',
                  ),
                ),
                TextField(
                  controller: _matController,
                  decoration: const InputDecoration(labelText: 'License plate Number'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: 'model',
                  ),
                ),
                TextField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String color = _colorController.text;
                    final String mat = _matController.text;
                    final String model = _modelController.text;                    final int? ref =
                    int.tryParse(_refController.text);
                    if (ref != null) {

                      await _cars
                          .doc(documentSnapshot!.id)
                          .update({"name":name, "ref":ref, "mat":mat, "color":color, "model":model});
                      _nameController.text = '';
                      _refController.text = '';
                      _colorController.text = '';
                      _matController.text = '';
                      _refController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
// update car




  // create car
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _nameController.text = documentSnapshot['name'];
      _refController.text = documentSnapshot['ref'].toString();
      _matController.text = documentSnapshot['mat'];
      _modelController.text = documentSnapshot['model'].toString();
      _colorController.text = documentSnapshot['color'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _refController,
                  decoration: const InputDecoration(
                    labelText: 'Reference',
                  ),
                ),
                TextField(
                  controller: _matController,
                  decoration: const InputDecoration(labelText: 'License plate Number'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: 'model',
                  ),
                ),
                TextField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String color = _colorController.text;
                    final String mat = _matController.text;
                    final String model = _modelController.text;

                    final int? ref =
                    int.tryParse(_refController.text);
                    if (ref != null) {

                      await _cars.add({"name":name, "ref":ref, "mat":mat, "color":color, "model":model});
                      _nameController.text = '';
                      _refController.text = '';
                      _colorController.text = '';
                      _matController.text = '';
                      _refController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
// create car




  
  // delete car
  Future<void> _delete(String productId) async {
    await _cars.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted this car.')));
  }
  // delete car

  Widget _title() {
    return const Text('Car List');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }, icon: Icon(Icons.home), padding: EdgeInsets.symmetric(horizontal: 92),),
      ElevatedButton(onPressed: (){_create();}, child: Text("Add Car"),
    ),
    ],
      ),
      body: StreamBuilder(
        stream: _cars.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Card(
                    color: Colors.white54,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            GetCarName(documentSnapshot.id)),
                        );
                        },
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['ref'].toString()),
                        trailing: SizedBox(
                        width: 100,
                        child: Row(
                        children: [
                        IconButton(icon: Icon(Icons.edit),
                        onPressed: ()=> _update(documentSnapshot)),
                        IconButton(icon: Icon(Icons.delete),
                        onPressed: ()=> _delete(documentSnapshot.id)),
                        ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

  }
}

