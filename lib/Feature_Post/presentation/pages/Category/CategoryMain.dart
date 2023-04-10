import 'package:clean_arch_app/Feature_Post/presentation/pages/Category/CategoryClass.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/view_login.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductAdd.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductsClass.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/resource/Construct.dart';
//import '../Products/CategoryClass.dart';

class CategoryMain extends StatefulWidget {
  @override
  _CategoryMainState createState() => _CategoryMainState();
}

  List<CategoryClass> list = [];

List<CategoryClass>? listTemp;
List<CategoryClass> duplicateItems = [];
List<CategoryClass> duplicateItems2 = [];
var db = FirebaseFirestore.instance;

QuerySnapshot? cars;
//List<CategoryClass> CategoryMain= [];
final CollectionReference _Categoryss_Main =
    FirebaseFirestore.instance.collection('Categorys');
final TextEditingController _catIdController = TextEditingController();
final TextEditingController _catNameController = TextEditingController();
final TextEditingController _catImageController = TextEditingController();
final TextEditingController _catPriceController = TextEditingController();
final TextEditingController _catCatController = TextEditingController();
final TextEditingController _catEntryDateController =
    TextEditingController();
final TextEditingController _favoriteFlagController = TextEditingController();

class _CategoryMainState extends State<CategoryMain> {
  void filterSearchResults(String query) {
    List<CategoryClass> dummySearchList = [];
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      print('inside if');
      List<CategoryClass> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.Cat_Name.toUpperCase().contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        list = dummyListData;
      });
      return;
    } else {
      setState(() {
        list = duplicateItems;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call_get_datatype();
    // _readdball();
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color pyellow = Colors.red;

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    print('inside _createOrUpdate');
    if (documentSnapshot != null) {
      action = 'update';
      _catIdController.text = documentSnapshot['productId'];
      _catNameController.text = documentSnapshot['productName'];
      _catImageController.text = documentSnapshot['productImage'];
      _catCatController.text = documentSnapshot['productCat'];
      _catEntryDateController.text = documentSnapshot['productEntryDate'];
      _catPriceController.text = documentSnapshot['productPrice'];
    } else {
      _catNameController.text = '';
      _catPriceController.text = '';
      _catCatController.text = '';
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
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _catNameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _catPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _catCatController,
                  decoration: const InputDecoration(
                    labelText: 'Cat',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _catNameController.text;
                    final String? price = _catPriceController.text;
                    final String? cat = _catCatController.text;
                    if (name != null && price != null && cat != null) {
                      if (action == 'create') {
                        _catNameController.text = '';
                        _catPriceController.text = '';
                        _catCatController.text = '';
                        final todayDate = DateTime.now();
                        var currentdate = formatDate(todayDate, [
                          yyyy,
                          '-',
                          mm,
                          '-',
                          dd,
                          ' ',
                          hh,
                          ':',
                          nn,
                          ':',
                          ss,
                          ' ',
                          am
                        ]);

                        // Persist a new product to Firestore
                        await _Categoryss_Main.add({
                          "Cat_Name": name,
                          "Cat_Price": price,
                          "Cat_Desc": cat,
                          "Cat_Id": "13",
                          "Cat_image": "IMAGEPAth",
                          "Cat_Desc": "COLTHES",
                          "Cat_Date": currentdate,
                          "favoriteFlag": "0"
                        });
                      }

                      if (action == 'update') {
                        // Update the Cat_
                        await _Categoryss_Main.doc(documentSnapshot!.id).update({
                          "Cat_Name": name,
                          "Cat_Price": price,
                          "Cat_Desc": cat
                        });
                      }

                      // Clear the text fields
                      _catNameController.text = '';
                      _catPriceController.text = '';
                      _catCatController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteProduct(String Cat_Id) async {
    await _Categoryss_Main.doc(Cat_Id).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Cat_')));
  }

  Widget build(BuildContext context) {
    // Deleteing a Cat_ by id

    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: Appdrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createOrUpdate(),
          // onPressed: () {  },
          child: const Icon(Icons.add),
        ),

        body: Stack(
          children: <Widget>[
            //header shape
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(200),
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              top: 125,
              left: -150,
              child: Container(
                height: 450, //MediaQuery.of(context).size.height / 4,
                width: 450, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 115,
              child: Container(
                height: 350, //MediaQuery.of(context).size.height / 4,
                width: 350, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.yellow,
                ),
              ),
            ),
            //footer
            Positioned(
              bottom: -125,
              left: -150,
              child: Container(
                height: 250, //MediaQuery.of(context).size.height / 4,
                width: 250, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              right: -115,
              child: Container(
                height: 250, //MediaQuery.of(context).size.height / 4,
                width: 250, //MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.yellow,
                ),
              ),
            ),
            //menu
            Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  print('inside button');
                  // _scaffoldKey.currentState.openDrawer();
                  //Navigator.pushNamed(context, "/MainPage");
                  Navigator.pop(context);
                  // Navigator.of(context).pushReplacement(
                  //   new MaterialPageRoute(builder: (BuildContext context) => new PaysMain()),
                  // );
                },
              ),
            ),
            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 2 - 70,
              child: Text(
                'List Cat_s',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              ),
            ),
            //body
            Positioned(
              top: 100,
              left: 15,
              right: 15,

              // left: MediaQuery.of(context).size.width / 2 - 70,
              child: SingleChildScrollView(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(5.0),
                    child: TextField(
                        onChanged: (value) {
                          print('inside change');
                          filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                                color: Colors.yellow, size: 30.0),
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Quicksand'))),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: getHeight(context) / 1.2,
                child: StreamBuilder(
                  stream: _Categoryss_Main.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          //late CategoryClass instpc;
                          //Raw form data
                          DocumentSnapshot dbData =
                              streamSnapshot.data!.docs[index];
                          CategoryClass filteredData = CategoryClass(
                              Cat_Id: int.parse(documentSnapshot['Cat_Id']),
                              Cat_Name: documentSnapshot['Cat_Name'],
                              Cat_image: documentSnapshot['Cat_image'],
                              Cat_Desc: documentSnapshot['Cat_Desc'],
                              Cat_Date: DateTime
                                  .now(), //DateTime.parse(documentSnapshot['Cat_Date']),
                              Cat_Price: documentSnapshot['Cat_Price']);

                          var currentdate = formatDate(
                              filteredData.Cat_Date, [
                            yyyy,
                            '-',
                            mm,
                            '-',
                            dd,
                            ' ',
                            hh,
                            ':',
                            nn,
                            ':',
                            ss,
                            ' ',
                            am
                          ]);

                          var a = documentSnapshot['Cat_Id'];

                          return Container(
                            height: getHeight(context) / FontManagerSize.s6,
                            width: double.infinity,
                            child: Card(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(AppSize.s6),
                                      child: CircleAvatar(
                                        radius: FontManagerSize.s35,
                                        backgroundImage: NetworkImage(
                                            filteredData.Cat_image),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          filteredData.Cat_Name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AppSize.s20),
                                        ),
                                        Text(
                                          filteredData.Cat_Price,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: AppSize.s20),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          filteredData.Cat_Desc,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AppSize.s20),
                                        ),
                                        Text(
                                          '${formatDate(filteredData.Cat_Date, [
                                                yyyy,
                                                '-',
                                                mm,
                                                '-',
                                                dd
                                              ])}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: AppSize.s20),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Press this button to edit a single Cat_
                                        IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: AppSize.s20,
                                            ),
                                            //  onPressed: () =>
                                            onPressed: () => _createOrUpdate(
                                                documentSnapshot)),
                                        // This icon button is used to delete a single Cat_
                                        IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              size: AppSize.s20,
                                            ),

                                            ///onPressed: (){},
                                            onPressed: () async {
                                              _deleteProduct(
                                                  documentSnapshot.id);
                                              // Create a reference to the file to delete
                                              FirebaseStorage.instance
                                                  .refFromURL(documentSnapshot[
                                                      'Cat_image'])
                                                  .delete();
// Child references can also take paths
// spaceRef now points to "images/space.jpg
// imagesRef still points to "images"
                                            }),
                                      ],
                                    ),
                                  ],
                                )

                                // ListTile(
                                //
                                //
                                //   title: Text('${filteredData.Cat_Name}'),
                                //   subtitle: Column(
                                //     children: [
                                //      Text('${filteredData.Cat_Name}'),
                                //       Text('${filteredData.Cat_Price}')
                                //     ],
                                //   ),
                                //   leading:  Column(
                                //     children: [
                                //       // Text('${filteredData.Cat_image}'),
                                //       Text('${filteredData.favoriteFlag}'),
                                //       //   Text('${filteredData.Cat_Price}'),
                                //       Text('${formatDate(filteredData.Cat_Date,
                                //           [yyyy, '-', mm, '-', dd])}'),
                                //       Text('${filteredData.Cat_Desc}'),
                                //     ],
                                //   ),
                                //   trailing: SizedBox(
                                //     width: 100,
                                //     height: 200,
                                //     child: Row(
                                //       children: [
                                //         // Press this button to edit a single Cat_
                                //         IconButton(
                                //           icon: const Icon(Icons.edit),
                                //           //  onPressed: () =>
                                //           onPressed:()=> _createOrUpdate(documentSnapshot)
                                //         ),
                                //         // This icon button is used to delete a single Cat_
                                //         IconButton(
                                //             icon: const Icon(Icons.delete),
                                //             ///onPressed: (){},
                                //             onPressed: () =>  _deleteCat_(documentSnapshot.id)
                                //         ),
                                //
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),

            Positioned(
              top: pheight / 30,
              right: pwidth / 20,
              child: IconButton(
                icon: Icon(Icons.add, size: 30),
                onPressed: () async {
                  var maxCat_Id = await getDocumentMaxId(
                      'Categorys', 'Cat_Id');

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => Cat_Add(
                  //               Docs_max: maxCat_Id+1,
                  //             )));

                  //  }
                  //pushNamed(context, "/Cat_Add");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
