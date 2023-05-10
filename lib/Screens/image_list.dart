
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_voiture/Services/storage_service.dart';
import 'package:path/path.dart';
class ImageList extends StatefulWidget {

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  State<StatefulWidget> createState() => ImageListState();
}


Widget _title() {
  return const Text('Gallery');
}
class ImageListState extends State<ImageList> {
  @override
  Widget build(BuildContext context) {

    final Storage storage = Storage();
    return Scaffold(
        appBar: AppBar(
          title: _title(),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }, icon: Icon(Icons.home), padding: EdgeInsets.symmetric(horizontal: 92),),
          ],
        ),
        body: Column(
          children: [
            Center(
        child: ElevatedButton(onPressed: () async {
          final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );

          if (results == null ) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No file selected."),)
            );
            return null;
          }

          final path = results.files.single.path!;
          final fileName = results.files.single.name;

          storage.uploadFile(path, fileName).then((value) => print("Done"));

        },
                child: Text("Upload Image")),
            ),
            FutureBuilder(
            future: storage.listFiles(),
                builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Container(
                  padding: const  EdgeInsets.symmetric(horizontal: 20),
                  height: 250,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.network(snapshot.data!.items[index].getDownloadURL().toString(), fit: BoxFit.cover,),
                      );
                    },
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            }),
          ],
        )
    );
  }
}