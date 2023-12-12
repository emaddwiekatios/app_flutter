//import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
///import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypeAdd.dart';
//import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypeDetailsEdit.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypeEdit.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Types/TypesClass.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

import '../../../../../core/resource/Construct.dart';
import '../../../../../core/resource/StringManager.dart';
import 'TypeSummaryClass.dart';

class TypeSummary extends StatefulWidget {
  const TypeSummary({super.key});

  @override
  _TypeSummaryState createState() => _TypeSummaryState();
}

List<TypeClass> list = [];

List<TypeClass> instProdList = [];
List<TypeClass>? listTemp;
List<TypeClass> duplicateItems = [];
List<TypeClass> duplicateItems2 = [];
List<TypeClass> dummySearchList = [];
List<TypeClass> dummyListData = [];
bool updateDataFlag = true;
List<TypeSummaryClass> totaltype = [];
List<TypeClass> instProdListSimilar = [];

var db = FirebaseFirestore.instance;

double sumprice = 0;
QuerySnapshot? cars;
//List<TypeClass> TypeSummary= [];
//final CollectionReference _Typess =FirebaseFirestore.instance.collection(StringManager.collection_Types);
var _Types = getCollectionReference(StringManager.collectionTypes)
    .orderBy('TypeId', descending: true);
final TextEditingController _TypeIdController = TextEditingController();
final TextEditingController _TypeNameController = TextEditingController();
final TextEditingController _TypeImageController = TextEditingController();
final TextEditingController _TypePriceController = TextEditingController();
final TextEditingController _TypeCatController = TextEditingController();
final TextEditingController _TypeEntryDateController = TextEditingController();

class _TypeSummaryState extends State<TypeSummary> {


  void filterSearchResultsCatSimilar(String query) {
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      dummyListData.clear();
      // List<Clients> dummyListData = List<Clients>();
      for (var item in dummySearchList) {
        if (item.TypeCat.toUpperCase().contains(query.toUpperCase()) ||
            item.TypeCat.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        instProdListSimilar = dummyListData;
      });
      return;
    } else {
      setState(() {
        instProdListSimilar = duplicateItems;
      });
    }
  }

  void filterSearchResultsCat(String query) {
    setState(() {
      updateDataFlag = false;
    });
    dummySearchList = duplicateItems;
    dummyListData = [];
    // //print('instProdList=${instProdList.length}');
    if (query.isNotEmpty) {
      for (var item in dummySearchList) {
        if (item.TypeCat.toUpperCase().contains(query.toUpperCase()) ||
            item.TypeCat.contains(query)) {
          dummyListData.add(item);
          //print('dummyListData=$dummyListData');
        }
      }
    } else {
      //print("inside else");
      setState(() {
        instProdList = duplicateItems;
        getlisttypecat();
        //indexParameter = null;
        //titlePage = 'Home';

        updateDataFlag = true;
      });
    }
    setState(() {
      instProdList = dummyListData;
      getlisttypecat();
    });
    ////print('instProdList=${instProdList.length}');
  }

  void filterSearchResults(String query) {
    setState(() {
      updateDataFlag = false;
    });
    dummySearchList = duplicateItems;
    dummyListData = [];

    if (query.isNotEmpty) {
      for (var item in dummySearchList) {
        if (item.TypeName.toUpperCase().contains(query.toUpperCase()) ||
            item.TypeName.contains(query)) {
          print(item.TypeName);
          dummyListData.add(item);
          // print('dummyListData=$dummyListData');
        }
      }
      setState(() {
        updateDataFlag = false;
        instProdList = dummyListData;
      });
    } else {
      setState(() {
        instProdList.clear();
        instProdList = duplicateItems;
        // indexParameter = null;
        //   titlePage = 'Home';

        updateDataFlag = true;
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

  Future<void> _createOrUpdate([TypeClass? documentSnapshot]) async {
    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      _TypeIdController.text = documentSnapshot.TypeId.toString();
      _TypeNameController.text = documentSnapshot.TypeName;
      _TypeCatController.text = documentSnapshot.TypeCat;
      _TypeEntryDateController.text = documentSnapshot.TypeEntryDate.toString();
      _TypePriceController.text = documentSnapshot.TypePrice;
    } else {
      _TypeNameController.text = '';
      _TypePriceController.text = '';
      _TypeCatController.text = '';
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
                  controller: _TypeNameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _TypePriceController,
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
                  controller: _TypeCatController,
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
                    final String name = _TypeNameController.text;
                    final String price = _TypePriceController.text;
                    final String cat = _TypeCatController.text;
                    if (action == 'create') {
                      _TypeNameController.text = '';
                      _TypePriceController.text = '';
                      _TypeCatController.text = '';
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

                      // Persist a new Type to Firestore
                      // await _Types.add({
                      //   "TypeName": name,
                      //   "TypePrice": price,
                      //   "TypeCat": cat,
                      //   "TypeId": "13",
                      //   "TypeEntryDate": currentdate
                      // });
                    }

                    if (action == 'update') {
                      // Update the Type
                      // await _Types.doc(documentSnapshot?.docsId).update({
                      //   "TypeName": name,
                      //   "TypePrice": price,
                      //   "TypeCat": cat
                      // });
                    }

                    // Clear the text fields
                    _TypeNameController.text = '';
                    _TypePriceController.text = '';
                    _TypeCatController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: Appdrawer(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _createOrUpdate(),
        //   // onPressed: () {  },
        //   child: const Icon(Icons.add),
        // ),

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
                'List Types',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              ),
            ),
            //body
            Positioned(
              top: 100,
              left: 15,
              right: 15,
              bottom: 20,

              // left: MediaQuery.of(context).size.width / 2 - 70,
              child: SingleChildScrollView(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                        onChanged: (value) {
                          print('inside change');
                          // filterSearchResults(value);
                          filterSearchResultsCat(value);
                        },
                        decoration: const InputDecoration(
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getHeight(context) / 1.35,
                child: StreamBuilder(
                  stream: _Types.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      if (updateDataFlag) {
                        sumprice = 0.0;
                        instProdList.clear();
                        for (int i = 0;
                            i < streamSnapshot.data!.docs.length;
                            i++) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[i];
                          TypeClass filteredData = TypeClass(
                              TypeId: documentSnapshot['TypeId'],
                              TypeName: documentSnapshot['TypeName'],
                              TypeCat: documentSnapshot['TypeCat'],
                              TypeEntryDate:
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      documentSnapshot['TypeEntryDate']
                                          .microsecondsSinceEpoch),
                              //DateTime.parse(
                              //documentSnapshot['TypeEntryDate']),
                              TypePrice: documentSnapshot['TypePrice'],
                              docsId: documentSnapshot.id,
                              TypeCount: 1);

                          instProdList.add(filteredData);
                          duplicateItems = instProdList;

                          sumprice = sumprice +
                              double.parse(documentSnapshot['TypePrice']);
                        }

                        instProdList.sort((a, b) =>
                            b.TypeEntryDate.compareTo(a.TypeEntryDate));

                        getlisttypecat();
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: totaltype
                            .length, //streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Get.to(
                              //     () => TypeEdit(instProd: instProdList[index]
                              //         //   prodList: instProdListSimilar,
                              //         ));
                            },
                            child: SizedBox(
                              height: getHeight(context) / FontManagerSize.s6,
                              width: double.infinity / 2,
                              child: Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            totaltype[index].TypeCat,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: AppSize.s20),
                                          ),
                                          Text(
                                            '\$${totaltype[index].Total}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: AppSize.s18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
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

            // Positioned(
            //   top: pheight / 30,
            //   right: pwidth / 20,
            //   child: IconButton(
            //       icon: Icon(Icons.add, size: 30),
            //       onPressed: () async {
            //         print('inside addd');
            //         Navigator.push(
            //             context, MaterialPageRoute(builder: (_) => TypeAdd()));
            //       }

            //       //pushNamed(context, "/TypeAdd");

            //       ),
            // ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Total :$sumprice'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getlisttypecat() async {
    totaltype.clear();
    List<String> catNameList = [];
    double sum1 = 0;
    int cnt = 0;
    catNameList.clear();
    for (int i = 0; i < instProdList.length; i++) {
      print(instProdList[i].TypeCat);
      catNameList.add(instProdList[i].TypeCat);
      //  print(catNameList);
    }
    var result = catNameList.toSet().toList();
    print(result);
    for (int i = 0; i < result.length; i++) {
      sum1 = 0;
      cnt = 0;
      for (int c = 0; c < instProdList.length; c++) {
        if (instProdList[c].TypeCat == result[i]) {
          cnt = cnt + 1;
          sum1 = sum1 + double.parse(instProdList[c].TypePrice);
        }
      }

      print('before if');
      if (sum1 > 0.0 && instProdList[i].TypeCat != null) {
        totaltype.add(TypeSummaryClass(TypeCat: result[i], Total: sum1));
      }
    }
  }
}
