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

import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/StringManager.dart';
import 'TypeAdd.dart';
import 'TypeDetailsEdit.dart';

class TypeMainNew extends StatefulWidget {
  const TypeMainNew({super.key});

  @override
  _TypeMainNewState createState() => _TypeMainNewState();
}

List<TypeClass> list = [];

List<TypeClass> instProdList = [];

List<TypeClass>? listTemp;
List<TypeClass> duplicateItems = [];
List<TypeClass> duplicateItems2 = [];
List<TypeClass> dummySearchList = [];
List<TypeClass> dummyListData = [];
bool updateDataFlag = true;
var db = FirebaseFirestore.instance;
int? indexParameter;
QuerySnapshot? cars;
//List<TypeClass> TypeMainNew= [];
//final CollectionReference _Typess =FirebaseFirestore.instance.collection(StringManager.collection_Types);
var _Types = getCollectionReference(StringManager.collectionTypes)
    .orderBy('TypeId', descending: true);
final TextEditingController _TypeIdController = TextEditingController();
final TextEditingController controllerSearch = TextEditingController();

final TextEditingController _TypeNameController = TextEditingController();
final TextEditingController _TypeImageController = TextEditingController();
final TextEditingController _TypePriceController = TextEditingController();
final TextEditingController _TypeCatController = TextEditingController();
final TextEditingController _TypeEntryDateController = TextEditingController();

class _TypeMainNewState extends State<TypeMainNew> {
  // void filterSearchResults(String query) {
  //   print('query===$query');
  //   List<TypeClass> dummySearchList = [];

  //   dummySearchList = duplicateItems;
  //   if (query.isNotEmpty) {
  //     List<TypeClass> dummyListData = [];
  //     for (var item in dummySearchList) {
  //       //print(item.TypeName);
  //       if (item.TypeName.toUpperCase().contains(query.toUpperCase())) {
  //         //print('inside forrrrrr if =$item');
  //         dummyListData.add(item);
  //         print(dummyListData);
  //       }
  //     }
  //     setState(() {
  //       instProdList = dummyListData;
  //       print(instProdList);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       instProdList = duplicateItems;
  //     });
  //   }
  // }

 

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
                        controller: controllerSearch,
                        onChanged: (value) {
                          //print('inside change');
                          //filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                controllerSearch.clear();
                            //    filterSearchResults(controllerSearch.text);
                              },
                              //  onPressed: () {
                              // controllerSearch.clear();
                              //  filterSearchResults(controllerSearch.text);
                              // }
                            ),
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
                        }
                      }

                      instProdList.sort(
                          (a, b) => b.TypeEntryDate.compareTo(a.TypeEntryDate));

                      return ListView.builder(
                        itemCount: instProdList
                            .length, //streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(instProdList[index].TypeEntryDate);
                              Get.to(
                                  () => TypeEdit(instProd: instProdList[index]
                                      //   prodList: instProdListSimilar,
                                      ));
                            },
                            child: Container(
                              height: getHeight(context) / FontManagerSize.s6,
                              width: double.infinity,
                              child: Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppSize.s6),
                                            child: CircleAvatar(
                                              radius: FontManagerSize.s20,
                                              backgroundImage: AssetImage(
                                                  AssetManager.buying),
                                            ),
                                          ),
                                          Text(
                                            '\$${instProdList[index].TypePrice}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: AppSize.s18),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            instProdList[index].TypeName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: AppSize.s28),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                instProdList[index].TypeCat,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: AppSize.s18),
                                              ),
                                              Text(
                                                '${formatDate(instProdList[index].TypeEntryDate, [
                                                      yyyy,
                                                      '-',
                                                      mm,
                                                      '-',
                                                      dd
                                                    ])}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: AppSize.s20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Press this button to edit a single Type
                                          IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                size: AppSize.s20,
                                              ),
                                              //  onPressed: () =>
                                              onPressed: () => Get.to(() =>
                                                  TypeEdit(
                                                      instProd:
                                                          instProdList[index]
                                                      //   prodList: instProdListSimilar,
                                                      ))),
                                          // This icon button is used to delete a single Type
                                          IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                size: AppSize.s20,
                                              ),

                                              ///onPressed: (){},
                                              onPressed: () async {
                                                deleteProduct(
                                                    context,
                                                    StringManager
                                                        .collectionTypes,
                                                    instProdList[index].docsId);

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
                                  //   title: Text('${instProdList[index].TypeName}'),
                                  //   subtitle: Column(
                                  //     children: [
                                  //      Text('${instProdList[index].TypeName}'),
                                  //       Text('${instProdList[index].TypePrice}')
                                  //     ],
                                  //   ),
                                  //   leading:  Column(
                                  //     children: [
                                  //       // Text('${instProdList[index].TypeImage}'),
                                  //       Text('${instProdList[index].favoriteFlag}'),
                                  //       //   Text('${instProdList[index].TypePrice}'),
                                  //       Text('${formatDate(instProdList[index].TypeEntryDate,
                                  //           [yyyy, '-', mm, '-', dd])}'),
                                  //       Text('${instProdList[index].TypeCat}'),
                                  //     ],
                                  //   ),
                                  //   trailing: SizedBox(
                                  //     width: 100,
                                  //     height: 200,
                                  //     child: Row(
                                  //       children: [
                                  //         // Press this button to edit a single Type
                                  //         IconButton(
                                  //           icon: const Icon(Icons.edit),
                                  //           //  onPressed: () =>
                                  //           onPressed:()=> _createOrUpdate(documentSnapshot)
                                  //         ),
                                  //         // This icon button is used to delete a single Type
                                  //         IconButton(
                                  //             icon: const Icon(Icons.delete),
                                  //             ///onPressed: (){},
                                  //             onPressed: () =>  _deleteType(documentSnapshot.id)
                                  //         ),
                                  //
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  ),
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
                    print('inside addd');
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => TypeAdd()));
                  }

                  //pushNamed(context, "/TypeAdd");

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
