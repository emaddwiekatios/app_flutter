
import 'package:clean_arch_app/Feature_Post/presentation/pages/Home/HomePage.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Products/ProductsClass.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProductMainNew extends StatefulWidget {
  @override
  _ProductMainNewState createState() => _ProductMainNewState();
}

List<ProductClass> list = [];

List<ProductClass>? listTemp ;
List<ProductClass> duplicateItems = [];
List<ProductClass> duplicateItems2 = [];
var db = FirebaseFirestore.instance;



QuerySnapshot? cars;
//List<ProductClass> ProductMainNew= [];
final CollectionReference _productss =
FirebaseFirestore.instance.collection('Clean_App_Products_New');
final TextEditingController _productIdController = TextEditingController();
final TextEditingController _productNameController = TextEditingController();
final TextEditingController _productImageController = TextEditingController();
final TextEditingController _productPriceController = TextEditingController();
final TextEditingController _productCatController = TextEditingController();
final TextEditingController _productEntryDateController = TextEditingController();
final TextEditingController _favoriteFlagController = TextEditingController();





class _ProductMainNewState extends State<ProductMainNew> {



  void filterSearchResults(String query) {
    List<ProductClass> dummySearchList = [];
    dummySearchList=duplicateItems;
    if (query.isNotEmpty) {
      print('inside if');
      List<ProductClass> dummyListData =[];
      dummySearchList.forEach((item) {
        if (item.productName.toUpperCase().contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        list = dummyListData;
      });
      return;
    }
    else {
      setState(() {
        list=duplicateItems;
      });
    }
  }




  printlist() {
    if (cars != null) {
      if(list.length>0)
      {
        list.clear();
      }

      //print(cars.);
      /*
      for (var i = 0; i < cars.docs.length; i++) {
        var tempprice =cars.docs[i].data()['Typeprice'];
        ProductClass _typeone = new ProductClass()
          ..productId=cars.docs[i].data()['productId']
          ..productName=cars.docs[i].data()['productName']
          ..productEntryDate=cars.docs[i].data()['productEntryDate'].toDate()
          ..productPrice=double.parse(tempprice.toString())
          ..productImage=cars.docs[i].data()['productImage'];
          //..Type_doc=cars.docs[i].id;

        setState(() {
          list.add(_typeone);
        });


      }
*/



//      ProductMainNew.sort(
//              (a, b) => a.id.compareTo(b.id));
//      var array_len = ProductMainNew.length;
//      setState(() {
//        Type_id_max = (ProductMainNew[array_len - 1].id + 1);
//        ProductMainNew.sort((b, a) =>
//            a.id.compareTo(b.id));
//        print('Type_id_max$Type_id_max');

//      });
      print(list);
      setState(() {
        duplicateItems = list;
      });
    } else {
      print("error");
    }

    //gettypetotalprice();
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




  Widget build(BuildContext context) {

    Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
      String action = 'create';
      print('inside _createOrUpdate');
      if (documentSnapshot != null) {
        action = 'update';
        _productIdController.text = documentSnapshot['productId'];
        _productNameController.text = documentSnapshot['productName'];
        _productImageController.text = documentSnapshot['productImage'];
        _productCatController.text = documentSnapshot['productCat'];
        _productEntryDateController.text = documentSnapshot['productEntryDate'];
        _productPriceController.text = documentSnapshot['price'].toString();

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
                  TextField(
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    controller: _productPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(action == 'create' ? 'Create' : 'Update'),
                    onPressed: () async {
                      final String? name = _productNameController.text;
                      final double? price = double.tryParse(_productPriceController
                          .text);
                      if (name != null && price != null) {
                        if (action == 'create') {
                          // Persist a new product to Firestore
                          await _productss.add({"name": name, "price": price});
                        }

                        if (action == 'update') {
                          // Update the product
                          await _productss
                              .doc(documentSnapshot!.id)
                              .update({"name": name, "price": price});
                        }

                        // Clear the text fields
                        _productNameController.text = '';
                        _productPriceController.text = '';

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

    // Deleteing a product by id
    Future<void> _deleteProduct(String productId) async {
      await _productss.doc(productId).delete();

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You have successfully deleted a product')));
    }

    var pheight = MediaQuery.of(context).size.height;
    var pwidth = MediaQuery.of(context).size.width;

/*
    FloatingActionButton(
      mini: true,
      onPressed: () {
        setState(() {
          // _canShowfloating = !_canShowfloating;
        });
      },
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor:
      Color(getColorHexFromStr('#FDD100')),
      child: Icon(
        Icons.details,
        size: 26.0,
        color: Colors.white,
      ),
      heroTag: null,
    );
    */
    return SafeArea(


      child: Scaffold(

        key: _scaffoldKey,
        // drawer: Appdrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createOrUpdate(),
         // onPressed: () {  },
          child: const Icon(Icons.dangerous),
        ),

        body:
        Stack(
          children: <Widget>[
            //header shape
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 4,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                  color:Colors.yellow,
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
                  color: Colors.yellow,),
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
                  color:Colors.yellow,
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
                  color: Colors.yellow,),
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
              child:

              SingleChildScrollView(
                child: Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 30,
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
                                color:
                                Colors.yellow,
                                size: 30.0),
                            contentPadding:
                            EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand'))),
                  ),
                ),
              ),

            ),
            Positioned(
              top: 160,
              right: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: getHeight(context)/1.2,
               child: StreamBuilder(
                 stream: _productss.snapshots(),
                 builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                   if (streamSnapshot.hasData) {

                     return ListView.builder(
                       itemCount: streamSnapshot.data!.docs.length,
                       itemBuilder: (context, index) {
                         final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                         print('documentSnapshot==');
                         //late ProductClass instpc;
                         //Raw form data
                         DocumentSnapshot dbData = streamSnapshot.data!.docs[index];
                         ProductClass filteredData =  ProductClass(
                             productId :int.parse(documentSnapshot['productId']),
                             productName:documentSnapshot['productName'],
                             productImage:documentSnapshot['productImage'],
                             productCat:documentSnapshot['productCat'],
                             productEntryDate:DateTime.now(),//DateTime.parse(documentSnapshot['productEntryDate']),
                             productPrice:documentSnapshot['productPrice'],
                             favoriteFlag:int.parse(documentSnapshot['favoriteFlag'])
                         );

                         //    filteredData!.productId = dbData['prodouctId'];  //empty list

                         print(documentSnapshot['productPrice']);

                         var  currentdate = formatDate(filteredData.productEntryDate,
                             [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss, ' ', am]);

                         var a=documentSnapshot['productId'];

                         return Container(
                           height: 150,
                           width: double.infinity,
                           child: Card(
                             margin: const EdgeInsets.all(10),
                             child: ListTile(
                               title: Text('${filteredData.productId}'),
                               subtitle: Column(
                                 children: [
                                   Text('${filteredData.productName}'),
                                   Text('${filteredData.productPrice}')
                                 ],
                               ),
                               leading:  Column(
                                 children: [
                                   // Text('${filteredData.productImage}'),
                                   Text('${filteredData.favoriteFlag}'),
                                   //   Text('${filteredData.productPrice}'),
                                   Text('${formatDate(filteredData.productEntryDate,
                                       [yyyy, '-', mm, '-', dd])}'),
                                   Text('${filteredData.productCat}'),
                                 ],
                               ),

                               trailing: SizedBox(
                                 width: 100,
                                 child: Row(
                                   children: [
                                     // Press this button to edit a single product
                                     IconButton(
                                       icon: const Icon(Icons.edit),
                                       //  onPressed: () =>
                                       onPressed: (){},
                                       //  _createOrUpdate(documentSnapshot)
                                     ),
                                     // This icon button is used to delete a single product
                                     IconButton(
                                         icon: const Icon(Icons.delete),
                                         ///onPressed: (){},
                                         onPressed: () =>  _deleteProduct(documentSnapshot.id)
                                     ),

                                   ],
                                 ),
                               ),
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
                onPressed: () {


                  // _scaffoldKey.currentState.openDrawer();

                  // Navigator.pushNamed(context, "/Types");
                },
              ),
            ),




          ],
        ),
       // floatingActionButton: FloatingActionButton(
       //   onPressed: () {
       //
       //     // Add your onPressed code here!
       //    // Navigator.pushNamed(context, "/Types");
       //   },
       //   child: Icon(Icons.add,color: Colors.white,),
       //   backgroundColor: Colors.green,
       // ),
        
      ),
    );



  }

}






