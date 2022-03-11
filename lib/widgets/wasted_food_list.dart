import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../screens/new_waste_screen.dart';
import '../screens/waste_detail_screen.dart';

class WastedFoodList extends StatefulWidget {
  const WastedFoodList({ Key? key }) : super(key: key);

  @override
  _WastedFoodListState createState() => _WastedFoodListState();
}

class _WastedFoodListState extends State<WastedFoodList> {

  File? image;
  final picker = ImagePicker();

  /*
  * Pick an image from the gallery, upload it to Firebase Storage and return 
  * the URL of the image in Firebase Storage.
  * Code adapted from CS492 Exploration: Firebase Cloud Firestore & Storage
  * Date Retrieved: 28-Feb-2022
  */
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
  child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData &&
        snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return Semantics(
                      label: 'Food waste post tile',
                      enabled: true,
                      onTapHint: 'Viewing post details',
                      child: ListTile(
                        title: Text(
                          DateFormat('EEEE, MMMM dd, yyyy').format(post['date'].toDate()),
                          style: const TextStyle(fontSize: 24),
                        ),
                        trailing: Text(
                          post['quantity'],
                          style: const TextStyle(fontSize: 24),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            WasteDetailScreen.routeName, 
                            arguments: [
                              post['date'],
                              post['quantity'],
                              post['imageURL'],
                              post['latitude'],
                              post['longitude']
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Semantics(
                label: 'Image selection button',
                button: true,
                enabled: true,
                onTapHint: 'Select an image',
                child: FloatingActionButton(
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    final String url = await getImage();
                    Navigator.of(context).pushNamed(NewWasteScreen.routeName, arguments: [image, url]);
                  },
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator()
                ),
              ),
              Semantics(
                label: 'Image selection button',
                button: true,
                enabled: true,
                onTapHint: 'Select an image',
                child: FloatingActionButton(
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    final String url = await getImage();
                    Navigator.of(context).pushNamed(NewWasteScreen.routeName, arguments: [image, url]);
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
