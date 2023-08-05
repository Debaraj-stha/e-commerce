import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages/cart.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/categoryItem.dart';
import 'package:e_commerce/utils/productCard.dart';
import 'package:e_commerce/utils/searchBar.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class categoryPage extends StatefulWidget {
  const categoryPage({Key? key}) : super(key: key);

  @override
  State<categoryPage> createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<e_commerceProvider>(context, listen: false)
        .fetchCategoryItem("makeup");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    final _categoryItems = provider.productCategories;
    final categoryProduct = provider.categoryItems;
    final subCategory = provider.subCategory;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Consumer<e_commerceProvider>(
          builder: (context, value, child) {
            return smallText(
              text: value.selectedCategoryNmae,
              color: Colors.black,
            );
          },
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>cart()));
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<String>(
            color: Colors.black,
            onSelected: (value) {
              provider.handlePopUpMenu(value,context);
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'home',
                child: Text('Home'),
              ),
              PopupMenuItem<String>(
                value: 'message',
                child: Text('Message'),
              ),
              PopupMenuItem<String>(
                value: 'myaccount',
                child: Text('My Account'),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              children: List.generate(_categoryItems.length, (index) {
               
                return Consumer<e_commerceProvider>(
                  builder: (context, value, chhild) {
                
                    return InkWell(
                        onTap: () {
                          provider.setSelectedCategory(index);
                          provider.fetchCategoryItem(
                              _categoryItems[index].category);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                          width: 100,
                          color: value.selectedCategory == index
                              ? Colors.white
                              : Color.fromARGB(255, 185, 179, 179),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        _categoryItems[index].image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              smallText(
                                color: value.selectedCategory == index
                              ? constraunts.primary
                              : Colors.black,
                                text: _categoryItems[index].category,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ));
                  },
                );
              }),
            ),
          ),

          Consumer<e_commerceProvider>(
            builder: (context, value, child) {
              if (value.categoryItems.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.subCategory.length,
                    itemBuilder: (context, index) {
                      final subCategory = value.subCategory[index];

                      final products = value.categoryItems
                          .where(
                              (product) => product.subCategory == subCategory)
                          .toList();

                      return ExpansionTile(
                        title: smallText(text: subCategory),
                        children: [
                          Container(
                            height: 500,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 200,
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 4,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, i) {
                                final data = products[i];
                                return productCard(
                                  image: data.image,
                                  text: data.name,
                                  price: data.salesPrice.toString(),
                                  rating: "4",
                                  id: data.id,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )

          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Consumer<e_commerceProvider>(
          //         builder: ((context, value, child) {
          //       if (value.categoryItems.isEmpty) {
          //         return CircularProgressIndicator();
          //       } else {
          //         return Container(
          //           height: 500,
          //           child: GridView.builder(
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                   mainAxisExtent: 200,
          //                   crossAxisCount: 3,
          //                   mainAxisSpacing: 8,
          //                   crossAxisSpacing: 4),
          //               itemCount: categoryProduct.length,
          //               itemBuilder: (context, index) {
          //                 final data = value.categoryItems[index];
          //                 return productCard(
          //                     image: data.image,
          //                     text: data.name,
          //                     price: data.salesPrice.toString(),
          //                     rating: "4",
          //                     id: data.id);
          //               }),
          //         );
          //       }
          //     })),
          //   ),
          // )
        ],
      ),
    );
  }
}
