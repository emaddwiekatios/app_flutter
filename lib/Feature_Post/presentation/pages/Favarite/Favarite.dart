
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductDetails.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductDetailsEdit.dart';
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

import 'package:clean_arch_app/core/resource/Construct.dart' as cons;

import '../../../../core/resource/Construct.dart';
import '../../../../core/resource/StringManager.dart';
import '../Home/HomePage.dart';

class Favarite extends StatefulWidget {
  @override
  _FavariteState createState() => _FavariteState();
}

List<ProductClass> listProductFav = [];

List<ProductClass>? listTemp;
List<ProductClass> duplicateItems = [];
List<ProductClass> duplicateItems2 = [];
var db = FirebaseFirestore.instance;

QuerySnapshot? cars;
var _productss=getCollectionReference(StringManager.collection_Products);
//List<ProductClass> Favarite= [];
//final CollectionReference _productss = FirebaseFirestore.instance.collection(StringManager.collection_Products);
final TextEditingController _productIdController = TextEditingController();
final TextEditingController _productNameController = TextEditingController();
final TextEditingController _productImageController = TextEditingController();
final TextEditingController _productPriceController = TextEditingController();
final TextEditingController _productCatController = TextEditingController();
final TextEditingController _productEntryDateController =
TextEditingController();
final TextEditingController _favoriteFlagController = TextEditingController();

class _FavariteState extends State<Favarite> {
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
        listProductFav = dummyListData;
      });
      return;
    } else {
      setState(() {
        listProductFav = duplicateItems;
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

    if (documentSnapshot != null) {
      action = 'update';
      _productIdController.text = documentSnapshot['productId'];
      _productNameController.text = documentSnapshot['productName'];
      _productImageController.text = documentSnapshot['productImage'];
      _productCatController.text = documentSnapshot['productCat'];
      _productEntryDateController.text = documentSnapshot['productEntryDate'];
      _productPriceController.text = documentSnapshot['productPrice'];
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
                    final String? name = _productNameController.text;
                    final String? price = _productPriceController.text;
                    final String? cat = _productCatController.text;
                    if (name != null && price != null && cat != null) {
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
                          "productCat": "COLTHES",
                          "productEntryDate": currentdate,
                          "favoriteFlag": "0"
                        });
                      }

                      if (action == 'update') {


                        await _productss.doc(documentSnapshot?.id).update({
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
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    showMessage(context, 'You have successfully deleted a product');

  }

  @override
  Widget build(BuildContext context) {
    // Deleteing a product by id

    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // drawer: Appdrawer(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _createOrUpdate(),
        //   // onPressed: () {  },
        //   child: const const Icon(Icons.add),
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

            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 2 - 70,
              child: const Text(
                'List Favarite',
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

                          filterSearchResults(value);
                        },
                        decoration:const  InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:  Icon(Icons.search,
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
                  //stream: _productss.snapshots(),

                    stream: _productss.where('favoriteFlag', isEqualTo: 1).snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {



                    if (streamSnapshot.hasData) {

                        instProdList.clear();
                        for (int i = 0; i <
                            streamSnapshot.data!.docs.length; i++) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot
                              .data!.docs[i];
                          ProductClass filteredData = ProductClass(
                              productId: int.parse(
                                  documentSnapshot['productId']),
                              productName: documentSnapshot['productName'],
                              productImage: documentSnapshot['productImage'],
                              productCat: documentSnapshot['productCat'],
                              productEntryDate: DateTime.now(),
                              //DateTime.parse(documentSnapshot['productEntryDate']),
                              productPrice: documentSnapshot['productPrice'],
                              favoriteFlag:
                              documentSnapshot['favoriteFlag'],
                              docsId: documentSnapshot.id
                              ,productCount: 1);


                          instProdList.add(filteredData);
                          duplicateItems = instProdList;
                        }

                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {


                          return InkWell(
                            onTap: ()
                            {

                              Get.to(() => ProductDetails(
                                  instProd: instProdList[index],prodList: instProdListSimilar,
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
                                        padding: const EdgeInsets.all(AppSize.s6),
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
                                            instProdList[index].productPrice.toString(),
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
                                        MainAxisAlignment.center,
                                        children: [
                                          // Press this button to edit a single product
                                          IconButton(
                                              icon: const  Icon(
                                                Icons.shopping_cart,
                                                size: AppSize.s20,
                                              ),
                                              //  onPressed: () =>
                                              onPressed: () {
                                                updateIntField(StringManager.collection_Products, 'favoriteFlag',instProdList[index].docsId,0);

                                                addProducttoCart(instProdList[index]);

                                              }
                                                ),
                                          // This icon button is used to delete a single product
                                          IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                size: AppSize.s20,
                                              ),

                                              ///onPressed: (){},
                                              onPressed: () async {
                                                updateIntField(StringManager.collection_Products,"favoriteFlag",instProdList[index].docsId,0);

                                              }),
                                        ],
                                      ),
                                    ],
                                  )

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

          ],
        ),
      ),
    );
  }

  void addProducttoCart(ProductClass prodClass) {

    FirebaseFirestore.instance.collection(StringManager.collection_Carts).add({
      "productId":  prodClass.productId,
      "productName":  prodClass.productName,
      "productImage":  prodClass.productImage,
      "productPrice":  prodClass.productPrice,
      "productCat":  prodClass.productCat ,//contProductcat.text,
      "productEntryDate": DateTime.now(),
      "favoriteFlag":  prodClass.favoriteFlag,
      "productCount":1//contProductfav.text
    });

  }

}
