
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
FirebaseFirestore.instance.collection('Clean_App_Products');

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

  getDatatypes() async {
    return await FirebaseFirestore.instance.collection("Clean_App_Products").doc()
        .get();

  }


  // Future getDocs() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Clean_App_Products").get();
  //   for (int i = 0; i < querySnapshot..length; i++) {
  //     var a = querySnapshot.documents[i];
  //     print(a.documentID);
  //   }
  // }
  call_get_datatype()
  {
    getDatatypes().then((results) {
      setState(() {
        print('resualt');
        print(results);
        //cars = results;

        printlist();
      });
    });
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
    call_get_datatype();
    // _readdball();
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color pyellow = Colors.red;




  Widget build(BuildContext context) {
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
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Appdrawer(),


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
                // height: MediaQuery.of(context).size.height >= 775.0
                //     ? MediaQuery.of(context).size.height
                //     : 775.0,
                /* decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.red,
                          Colors.orange
                          //Color(getColorHexFromStr('#FDD100')),
                           //Color(getColorHexFromStr('#FDD120'))
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
*/
                //child:HomePage()

             child: ItemList()

             // list.length > 0 ? ItemList(
             //
             //  )
             //      : new Center(
             //    child: new CircularProgressIndicator(),
             //  ),
              /*  child: new FutureBuilder<List>(
                  future: helperglobel.ProductMainNew(),
                  builder: (context, snapshot) {
                   // print('the snapshot.hasData =${snapshot.data}');
                    return snapshot.hasData
                        ? new ItemList(
                      list: snapshot.data,
                    )
                        : new Center(
                      child: new CircularProgressIndicator(),
                    );
                  },
                )
                */
/*
FutureBuilder<List<UserModel>>(
future: db.getUserModelData(),
builder: (context, snapshot) {
if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
*/


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
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            // Add your onPressed code here!
//            Navigator.pushNamed(context, "/Types");
//          },
//          child: Icon(Icons.add,color: Colors.white,),
//          backgroundColor: Colors.green,
//        ),

    );



  }

}



class ItemList extends StatefulWidget {


  // final List<ProductClass> list;
  //ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    //Comparator<ProductClass> seqComparator = (b,a) => a.id.compareTo(b.id);
    //  list.sort(seqComparator);

    return StreamBuilder(
      stream: _productss.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
              streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['name']),
                  subtitle: Text(documentSnapshot['price'].toString()),
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
                          onPressed: (){},
                          //  onPressed: () =>  _deleteProduct(documentSnapshot.id)
                        ),

                      ],
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
    );
  }


  deletetype(String docId) async {
    FirebaseFirestore.instance
        .collection('Types')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });

//    Navigator.of(context).pushReplacement(
//      new MaterialPageRoute(
//          builder: (BuildContext context) => new SocialHome()),
//    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fie_productsslds' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CollectionReference _productss =
  FirebaseFirestore.instance.collection('Clean_App_Products');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final double? price = double.tryParse(_priceController.text);
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
                      _nameController.text = '';
                      _priceController.text = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: const Text('Kindacode.com'),
      // ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['price'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
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
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}