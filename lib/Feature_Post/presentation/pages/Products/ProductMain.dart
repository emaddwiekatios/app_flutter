import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductAdd.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductDetailsEdit.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductsClass.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/ValueManger.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/StringManager.dart';

class ProductMainNew extends StatefulWidget {
  const ProductMainNew({super.key});

  @override
  _ProductMainNewState createState() => _ProductMainNewState();
}

List<ProductClass> list = [];

List<ProductClass>? listTemp;
List<ProductClass> duplicateItems = [];
List<ProductClass> duplicateItems2 = [];
var db = FirebaseFirestore.instance;

QuerySnapshot? cars;
//List<ProductClass> ProductMainNew= [];
//final CollectionReference _productss =FirebaseFirestore.instance.collection(StringManager.collection_Products);
var _productss = getCollectionReference(StringManager.collectionProducts);

final TextEditingController _productIdController = TextEditingController();
final TextEditingController _productNameController = TextEditingController();
final TextEditingController _productImageController = TextEditingController();
final TextEditingController _productPriceController = TextEditingController();
final TextEditingController _productCatController = TextEditingController();
final TextEditingController _productEntryDateController =
    TextEditingController();

class _ProductMainNewState extends State<ProductMainNew> {
  void filterSearchResults(String query) {
    List<ProductClass> dummySearchList = [];
    dummySearchList = duplicateItems;
    if (query.isNotEmpty) {
      List<ProductClass> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.productName.toUpperCase().contains(query.toUpperCase())) {
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
    //call_get_datatype();
    // _readdball();
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color pyellow = Colors.red;

  Future<void> _createOrUpdate([ProductClass? documentSnapshot]) async {
    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      _productIdController.text = documentSnapshot.productId.toString();
      _productNameController.text = documentSnapshot.productName;
      _productImageController.text = documentSnapshot.productImage;
      _productCatController.text = documentSnapshot.productCat;
      _productEntryDateController.text =
          documentSnapshot.productEntryDate.toString();
      _productPriceController.text = documentSnapshot.productPrice;
    } else {
      _productNameController.text = '';
      _productPriceController.text = '';
      _productCatController.text = '';
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
                  controller: _productNameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _productPriceController,
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
                  controller: _productCatController,
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
                    final String name = _productNameController.text;
                    final String price = _productPriceController.text;
                    final String cat = _productCatController.text;
                    if (action == 'create') {
                      _productNameController.text = '';
                      _productPriceController.text = '';
                      _productCatController.text = '';
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
                      await _productss.add({
                        "productName": name,
                        "productPrice": price,
                        "productCat": cat,
                        "productId": "13",
                        "productImage": "IMAGEPAth",
                        "productEntryDate": currentdate,
                        "favoriteFlag": 0
                      });
                    }

                    if (action == 'update') {
                      // Update the product
                      await _productss.doc(documentSnapshot?.docsId).update({
                        "productName": name,
                        "productPrice": price,
                        "productCat": cat
                      });
                    }

                    // Clear the text fields
                    _productNameController.text = '';
                    _productPriceController.text = '';
                    _productCatController.text = '';

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
                'List Products',
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
                          //print('inside change');
                          filterSearchResults(value);
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: getHeight(context) / 1.2,
                child: StreamBuilder(
                  stream: _productss.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      instProdList.clear();
                      for (int i = 0;
                          i < streamSnapshot.data!.docs.length;
                          i++) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[i];
                        ProductClass filteredData = ProductClass(
                            productId: documentSnapshot['productId'],
                            productName: documentSnapshot['productName'],
                            productImage: documentSnapshot['productImage'],
                            productCat: documentSnapshot['productCat'],
                            productEntryDate: DateTime.now(),
                            //DateTime.parse(documentSnapshot['productEntryDate']),
                            productPrice: documentSnapshot['productPrice'],
                            favoriteFlag: documentSnapshot['favoriteFlag'],
                            docsId: documentSnapshot.id,
                            productCount: 1);

                        instProdList.add(filteredData);
                        duplicateItems = instProdList;
                      }

                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //print(instProdList[index].productEntryDate);
                              Get.to(() => ProductDetailsEdit(
                                  instProd: instProdList[index]
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.all(AppSize.s6),
                                        child: CircleAvatar(
                                          radius: FontManagerSize.s35,
                                          backgroundImage: NetworkImage(
                                              instProdList[index].productImage),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            instProdList[index].productName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: AppSize.s20),
                                          ),
                                          Text(
                                            '\$${instProdList[index].productPrice}',
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
                                            instProdList[index].productCat,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: AppSize.s20),
                                          ),
                                          Text(
                                            '${formatDate(instProdList[index].productEntryDate, [
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
                                          // Press this button to edit a single product
                                          IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                size: AppSize.s20,
                                              ),
                                              //  onPressed: () =>
                                              onPressed: () => _createOrUpdate(
                                                  instProdList[index])),
                                          // This icon button is used to delete a single product
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
                                                        .collectionProducts,
                                                    instProdList[index].docsId,
                                                    instProdList[index]
                                                        .productImage);
                                                // Create a reference to the file to delete
                                                // FirebaseStorage.instance
                                                //     .refFromURL(documentSnapshot[
                                                //         'productImage'])
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
                                  //   title: Text('${instProdList[index].productName}'),
                                  //   subtitle: Column(
                                  //     children: [
                                  //      Text('${instProdList[index].productName}'),
                                  //       Text('${instProdList[index].productPrice}')
                                  //     ],
                                  //   ),
                                  //   leading:  Column(
                                  //     children: [
                                  //       // Text('${instProdList[index].productImage}'),
                                  //       Text('${instProdList[index].favoriteFlag}'),
                                  //       //   Text('${instProdList[index].productPrice}'),
                                  //       Text('${formatDate(instProdList[index].productEntryDate,
                                  //           [yyyy, '-', mm, '-', dd])}'),
                                  //       Text('${instProdList[index].productCat}'),
                                  //     ],
                                  //   ),
                                  //   trailing: SizedBox(
                                  //     width: 100,
                                  //     height: 200,
                                  //     child: Row(
                                  //       children: [
                                  //         // Press this button to edit a single product
                                  //         IconButton(
                                  //           icon: const Icon(Icons.edit),
                                  //           //  onPressed: () =>
                                  //           onPressed:()=> _createOrUpdate(documentSnapshot)
                                  //         ),
                                  //         // This icon button is used to delete a single product
                                  //         IconButton(
                                  //             icon: const Icon(Icons.delete),
                                  //             ///onPressed: (){},
                                  //             onPressed: () =>  _deleteProduct(documentSnapshot.id)
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ProductAdd()));

                  //  }
                  //pushNamed(context, "/ProductAdd");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
