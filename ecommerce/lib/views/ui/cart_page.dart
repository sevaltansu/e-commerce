import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ecommerce/views/shared/appstyle.dart';
import 'package:ecommerce/views/shared/cekckout_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final _cartBox = Hive.box('cart_box');
  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
                Text("My Cart",
                    style: appstyle(36, Colors.black, FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: const ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: null,
                                    backgroundColor: Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ],
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: const Offset(0, 1))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: data['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, left: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: appstyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data['category'],
                                                style: appstyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data['price'],
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "Size",
                                                    style: appstyle(
                                                        18,
                                                        Colors.grey,
                                                        FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    "${data['sizes'].join(', ')}",
                                                    style: appstyle(
                                                        18,
                                                        Colors.grey,
                                                        FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .minus_square_fill,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  data['qty'].toString(),
                                                  style: appstyle(
                                                      12,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .plus_square_fill,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(
                label: "Proceed to Checkout",
              ),
            )
          ],
        ),
      ),
    );
  }
}
