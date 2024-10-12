import 'package:firebasecurd/customalert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Crudscreen extends StatefulWidget {
  const Crudscreen({super.key});

  @override
  State<Crudscreen> createState() => _CrudscreenState();
}

class _CrudscreenState extends State<Crudscreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> docNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    var data = firestore.collection('cruddata');
    QuerySnapshot querySnapshot = await data.get();
    docNames = [];
    for (var doc in querySnapshot.docs) {
      docNames.add(doc.id);
    }
    print(docNames);
    setState(() {});
  }

  deletedoc({required String name}) async {
    var data = firestore.collection("cruddata");
    await data.doc(name).delete().then((value) {
      print("Document Deleted");
      getdata();
    }).catchError((error) => print("Failed to delete document: $error"));
  }

  updateDocument({required String docId, required String updatedData}) {
    var data = firestore.collection("cruddata");

    data.doc(docId).delete().then((value) {
      print("Document Updated");
      addNewDocument(docname: updateDocument(docId: docId, updatedData: updatedData));
    }).catchError((error) => print("Failed to update document: $error"));
  }

  Future addNewDocument({required String docname}) async {
    var data = firestore.collection("cruddata");

    await data.doc(docname).set({}).then((value) {
      print("Document Added with ID: $docname");
      getdata();
    }).catchError((error) => print("Failed to add document: $error"));
  }

  TextEditingController form = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Crud Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => customalert(
                    onPressed: () async {
                      await addNewDocument(docname: form.text);
                      Navigator.pop(context);
                      // form.text = "";
                    },
                    context: context,
                    controller: form,
                  ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
          ),
          itemCount: docNames.length,
          itemBuilder: (context, index) => Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(index.toString()),
                Text(". ${docNames[index]}"),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () => deletedoc(name: docNames[index]),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => customalert(
                              onPressed: () async {
                                await updateDocument(
                                    docId: docNames[index], updatedData: form.text);
                                // form.text = "";
                                Navigator.pop(context);
                              },
                              context: context,
                              controller: form,
                            ));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
