//import 'package:clean_arch_app/Feature_Post/presentation/pages/TypeCategory/TypeCategoryAdd.dart';
//import 'package:clean_arch_app/Feature_Post/presentation/pages/TypeCategory/TypeCategoryClass.dart';
//import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

import '../../../../core/resource/AssetManager.dart';
import '../../../../core/resource/Construct.dart';
import 'TypeCategoryAdd.dart';
import 'TypeCategoryClass.dart';
import 'TypeCategoryDetailsEdit.dart';
import 'TypeCategoryEdit.dart';
//import 'TypeCategoryDetailsEdit.dart';

class TypeCategoryMain extends StatefulWidget {
  const TypeCategoryMain({super.key});

  @override
  _TypeCategoryMainState createState() => _TypeCategoryMainState();
}

List<TypeCategoryClass> list = [];

List<TypeCategoryClass> instCatList = [];

List<TypeCategoryClass>? listTemp;
List<TypeCategoryClass> duplicateItems = [];
List<TypeCategoryClass> duplicateItems2 = [];
var db = FirebaseFirestore.instance;

QuerySnapshot? cars;
//List<TypeCategoryClass> TypeCategoryMain= [];
final CollectionReference TypeCategory =
    FirebaseFirestore.instance.collection(StringManager.collectionTypeCategory);
final TextEditingController _catIdController = TextEditingController();
final TextEditingController _catNameController = TextEditingController();
final TextEditingController _catImageController = TextEditingController();
final TextEditingController _catPriceController = TextEditingController();
final TextEditingController _catCatController = TextEditingController();
final TextEditingController _catEntryDateController = TextEditingController();

class _TypeCategoryMainState extends State<TypeCategoryMain> {
  void filterSearchResults(String query) {
    List<TypeCategoryClass> dummySearchList = [];
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      //print('inside if');
      List<TypeCategoryClass> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.catName.toUpperCase().contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      }
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
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color pYellow = Colors.red;

  Future<void> _createOrUpdate([TypeCategoryClass? documentSnapshot]) async {
    String action = 'create';
    //print('inside _createOrUpdate');
    if (documentSnapshot != null) {
      action = 'update';
      _catIdController.text = documentSnapshot.catId.toString();
      _catNameController.text = documentSnapshot.catName;
      _catImageController.text = documentSnapshot.catImage;
      _catCatController.text = documentSnapshot.catDesc;
      _catEntryDateController.text = documentSnapshot.catDate.toString();
      _catPriceController.text = documentSnapshot.catPrice;
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
                    final String name = _catNameController.text;
                    final String price = _catPriceController.text;
                    final String cat = _catCatController.text;
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

                      await TypeCategory.add({
                        "catName": name,
                        "catPrice": price,
                        "catDesc": cat,
                        "catId": "13",
                        "catImage": "IMAGEAth",
                        "catDate": currentdate,
                        "favoriteFlag": "0"
                      });
                    }

                    if (action == 'update') {
                      // Update the cat
                      await TypeCategory.doc(documentSnapshot!.docsId).update(
                          {"catName": name, "catPrice": price, "catDesc": cat});
                    }

                    // Clear the text fields
                    _catNameController.text = '';
                    _catPriceController.text = '';
                    _catCatController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> deleteProductMain(String CatId) async {
    await TypeCategory.doc(CatId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a cat')));
  }

  @override
  Widget build(BuildContext context) {
    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                decoration: const BoxDecoration(
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
              child: const Text(
                'Categorys',
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
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(5.0),
                    child: TextField(
                        onChanged: (value) {
                          //print('inside change');
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getHeight(context) / 1.35,
                child: StreamBuilder(
                  stream: TypeCategory.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      instCatList.clear();
                      for (int i = 0;
                          i < streamSnapshot.data!.docs.length;
                          i++) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[i];
                        TypeCategoryClass filteredData = TypeCategoryClass(
                            catId: int.parse(documentSnapshot['catId']),
                            catName: documentSnapshot['catName'],
                            catImage: documentSnapshot['catImage'],
                            catPrice: documentSnapshot['catPrice'],
                            catDesc: documentSnapshot['catDesc'],
                            catDate: DateTime.fromMicrosecondsSinceEpoch(
                                documentSnapshot['catDate']
                                    .microsecondsSinceEpoch),
                            docsId: documentSnapshot
                                .id //documentSnapshot['catDate']
                            );

                        instCatList.add(filteredData);
                      }

                      instCatList
                          .sort((a, b) => b.catDate.compareTo(a.catDate));

                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => TypeCategoryEdit(
                                  IntTypeCategory: instCatList[index]
                                  //   prodList: instProdListSimilar,
                                  ));
                            },
                            child: SizedBox(
                              height: getHeight(context) / FontManagerSize.s6,
                              width: double.infinity,
                              child: Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(AppSize.s6),
                                        child: CircleAvatar(
                                            radius: FontManagerSize.s35,
                                            backgroundImage:
                                                AssetImage(AssetManager.gift)
                                            //  NetworkImage( instCatList[index].catImage),
                                            ),
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     Text(
                                      //       instCatList[index].catName,
                                      //       style: const TextStyle(
                                      //           fontWeight: FontWeight.w500,
                                      //           fontSize: AppSize.s20),
                                      //     ),
                                      //     Text(
                                      //       instCatList[index].catPrice,
                                      //       style: const TextStyle(
                                      //           fontWeight: FontWeight.w300,
                                      //           fontSize: AppSize.s20),
                                      //     ),
                                      //   ],
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            instCatList[index].catDesc,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: AppSize.s20),
                                          ),
                                          Text(
                                            '${formatDate(instCatList[index].catDate, [
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
                                          // Press this button to edit a single cat
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: AppSize.s20,
                                            ),
                                            //  onPressed: () =>
                                            onPressed: () => Get.to(() =>
                                                TypeCategoryEdit(
                                                    IntTypeCategory:
                                                        instCatList[index]
                                                    //   prodList: instProdListSimilar,
                                                    )),
                                          ),
                                          // This icon button is used to delete a single cat
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
                                                        .collectionTypeCategory,
                                                    instCatList[index].docsId,
                                                    instCatList[index]
                                                        .catImage);
                                                // Create a reference to the file to delete
                                                // FirebaseStorage.instance
                                                //     .refFromURL(documentSnapshot[
                                                // 'catImage'])
                                                //     .delete();
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
                                  //   title: Text('${filteredData.catName}'),
                                  //   subtitle: Column(
                                  //     children: [
                                  //      Text('${filteredData.catName}'),
                                  //       Text('${filteredData.catPrice}')
                                  //     ],
                                  //   ),
                                  //   leading:  Column(
                                  //     children: [
                                  //       // Text('${filteredData.catImage}'),
                                  //       Text('${filteredData.favoriteFlag}'),
                                  //       //   Text('${filteredData.catPrice}'),
                                  //       Text('${formatDate(filteredData.catDate,
                                  //           [yyyy, '-', mm, '-', dd])}'),
                                  //       Text('${filteredData.catDesc}'),
                                  //     ],
                                  //   ),
                                  //   trailing: SizedBox(
                                  //     width: 100,
                                  //     height: 200,
                                  //     child: Row(
                                  //       children: [
                                  //         // Press this button to edit a single cat
                                  //         IconButton(
                                  //           icon: const Icon(Icons.edit),
                                  //           //  onPressed: () =>
                                  //           onPressed:()=> _createOrUpdate(documentSnapshot)
                                  //         ),
                                  //         // This icon button is used to delete a single cat
                                  //         IconButton(
                                  //             icon: const Icon(Icons.delete),
                                  //             ///onPressed: (){},
                                  //             onPressed: () =>  _deletecat(documentSnapshot.id)
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
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () async {
                    //print('go to cat add');
                    var maxCatId = await getDocumentMaxId(
                        StringManager.collectionTypeCategory, 'catId');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TypeCategoryAdd(
                          Docs_max: maxCatId + 1,
                        ),
                      ),
                    );
                  }
                  //pushNamed(context, "/catAdd");

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
