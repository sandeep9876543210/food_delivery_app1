import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'DbHelper.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final List<String> imgList = [
    'assets/Food-Plate.png',
    'assets/Dessert.png',
    'assets/Grilled-Chicken.png',
    'assets/Dessert2.png'
  ];
  int _current = 0;
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  final List<String> food_typesList = [
    'Salads',
    'Pizza',
    'Beverages',
    'Snacks'
  ];
  final List<String> food_itemsNames = [
    'Poke with chicken',
    'Salad with radishes, tomatoes and mushrooms',
    'Beverages',
    'Snacks'
  ];
  final List<String> food_itemsPrice = [
    '47.00',
    '12.40',
    '9.45',
    '10.00'
  ];
  List<Map<String, dynamic>>? allData =[];
  bool isRowAvailable = true;
  double totalPaymentsAmount = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(28, 6, 28, 6),
                          child: Text(
                            '100a Eating Rd. 24 mins',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.search),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    'Hints of the week',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  CarouselSlider(
                    items: imgList
                        .map((item) => Container(
                      child: Center(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 25,
                                ),
                                Container(
                                    height: 230,
                                    width: double.maxFinite,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                        gradient: LinearGradient(
                                          colors: [Color(0xFF88c6fe), Color(0xFFcbcaff)],  // Start and end colors of the gradient
                                          begin: Alignment.topLeft,  // Starting point of the gradient
                                          end: Alignment.bottomRight, // Ending point of the gradient
                                        ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 120),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 20,),
                                          Text('Two slices of pizza \nwith delicious salami',style: TextStyle(
                                            fontSize: 14,fontWeight: FontWeight.bold
                                          ),),
                                          Spacer(),
                                          Container(
                                            height: 30,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(Radius.circular(12))
                                            ),
                                            child: Center(
                                              child: Text('\$${food_itemsPrice[0]}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white
                                              ),),
                                            ),
                                          ),SizedBox(width: 20,)
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Image.asset(item, width: 160,height: 160,fit: BoxFit.fill,),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 265,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => buttonCarouselController.animateToPage(entry.key),
                        child: Container(
                          width: 50.0,
                          height: 5.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: food_typesList.length,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15,10,15,10),
                            child: Text(food_typesList[index]),
                          )),
                    );
                  },),
                ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: food_typesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap:()=> _showBottomPopup(context,index),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                             // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: Image.asset(imgList[index],height: 120,width: 120,)),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(food_itemsNames[index],softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 13,
                                      ),),
                                      const SizedBox(height: 10,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            borderRadius: const BorderRadius.all(Radius.circular(15))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15,10,15,10),
                                            child: Text('\$${food_itemsPrice[index]}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },),
                  ),
                ],
              ),
            ),
          ),

        ),

      ),
    );
  }

  void _showBottomcartPopupbutton(BuildContext context,double total_amount) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the popup to resize according to its content
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,20),
            child: GestureDetector(
              onTap: (){
               // totalPaymentsList = total_amount;
                fetchData();
                _showBottomPopupForCart(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Text('Cart',style: TextStyle(color: Colors.white),),
                    Spacer(),
                    Text('24min · \$${totalPaymentsAmount.toStringAsFixed(2)}',style: TextStyle(color: Colors.white),),
                    SizedBox(width: 15,),
                  ],
                ),

              ),
            ),
          );
        }
    );
  }


void _showBottomPopup(BuildContext context,int index) {
    int value = 1;
    double totalprice = double.parse(food_itemsPrice[index]);
  showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the popup to resize according to its content
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset(imgList[index],height: 230,width: 220)),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text(food_itemsNames[index],softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text('Famous hawalian dish,Rice pillow with tender chicken breasts,mushrooms,lettuse,cherry,tomatos,seawed and corn,with unagi sauce',softWrap: true,
                    maxLines: 4,style: TextStyle(fontSize: 16,color: Colors.grey),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 20,top: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15,10,15,10),
                          child: Row(
                            children: [
                              Column(
                             children: [
                               Text('325',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                               Text('kcal',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                             ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text('420',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text('grams',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text('21',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text('proteins',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text('19',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text('fats',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text('65',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text('carbs',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      const Row(
                        children: [
                          Text('Add in poke',style: TextStyle(
                            fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black
                          ),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 14,)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                 color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   GestureDetector(
                                       onTap: (){
                                         if(value == 1){
                                           setState(() {
                                             totalprice = double.parse(food_itemsPrice[index]);
                                           });
                                         }else{
                                           setState(() {
                                             value--;
                                             totalprice = totalprice-double.parse(food_itemsPrice[index]);
                                           });
                                         }
                                       },
                                       child: const Icon(Icons.minimize_rounded)),
                                  const SizedBox(width: 12,),
                                  Text(value.toString()),
                                  const SizedBox(width: 12,),
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          value++;
                                          totalprice = totalprice+double.parse(food_itemsPrice[index]);
                                        });
                                      },
                                      child: const Icon(Icons.add)),
                                ],
                              ),
                            ),
                          ),
                         const SizedBox(width: 20,),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap:()async{
                                print(value);
                                final event = {
                                DbHelper.foodImage: imgList[index],
                                  DbHelper.foodName: food_itemsNames[index],
                                  DbHelper.foodValue: value.toString(),
                                  DbHelper.foodPerValue: double.parse(food_itemsPrice[index]).toString()
                               };
                                await checkdata(food_itemsNames[index]);
                              if(isRowAvailable){

                              }else{
                                addToDatabase(event);
                              }
                                Navigator.pop(context);
                         _showBottomcartPopupbutton(context,totalprice);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(child: Text('Add to cart  \$$totalprice',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
  );
}

  void _showBottomPopupForCart(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the popup to resize according to its content
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.maxFinite,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 40),
                        child: Text('We will deliver in\n24 minutes to the address:',softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 20,),
                      const Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Text('100a Ealing rd',softWrap: true,
                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                            SizedBox(width: 15,),
                            Text('Change address',softWrap: true,
                              maxLines: 4,style: TextStyle(fontSize: 14,color: Colors.grey),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 20,top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: allData?.length,
                                itemBuilder: (context, index) {
                                  int value =  int.parse(allData?[index]['value']);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Image.asset(allData?[index]['image'],height: 80,width: 80,)),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(allData?[index]['name'],softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                                ),),
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          value--;
                                                        });
                                                        if(value == 0){
                                                          delete(allData?[index]['_id']);
                                                        }else{
                                                          final event = {
                                                            DbHelper.foodImage: allData?[index]['image'],
                                                            DbHelper.foodName: allData?[index]['name'],
                                                            DbHelper.foodValue: value,
                                                            DbHelper.foodPerValue: double.parse(allData?[index]['pervalue'])
                                                          };
                                                          updateItem(allData?[index]['_id'],event);
                                                        }
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey.shade300,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets.all(5.0),
                                                            child: Icon(Icons.minimize_rounded),
                                                          ))),
                                                  const SizedBox(width: 6,),
                                                  Text('$value'),
                                                  const SizedBox(width: 6,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          value++;
                                                        });
                                                        final event = {
                                                          DbHelper.foodImage: allData?[index]['image'],
                                                          DbHelper.foodName: allData?[index]['name'],
                                                          DbHelper.foodValue: value,
                                                          DbHelper.foodPerValue: double.parse(allData?[index]['pervalue'])
                                                        };
                                                        updateItem(allData?[index]['_id'],event);
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey.shade300,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets.all(5.0),
                                                            child: Icon(Icons.add),
                                                          ))),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(15,10,0,25),
                                            child: Text('\$${double.parse(allData?[index]['pervalue'])*value}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },),
                            ),
                            Divider(),
                            SizedBox(height: 20,),
                             Row(
                              children: [
                                 const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Delivery',style: TextStyle(
                                       fontWeight: FontWeight.w700,fontSize: 17
                                     ),),
                                     SizedBox(height: 5,),
                                     Text('Free delivery from \$30',style: TextStyle(
                                       color: Colors.grey
                                     ),)
                                   ],
                                 ),
                                Spacer(),
                                Text('\$${totalPaymentsAmount.toStringAsFixed(2)}',style: const TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16
                                ),),
                                SizedBox(width: 15,)
                              ],
                            ),
                            SizedBox(height: 15,),
                            Divider(),
                            SizedBox(height: 15,),
                            const Text('Payment method',style: TextStyle(
                                color: Colors.grey,
                              fontSize: 16
                            ),),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(8,3,8,3),
                                    child: Row(
                                      children: [
                                        Icon(Icons.apple,size: 20,),
                                        Text('Pay',style: TextStyle(
                                          fontSize: 14
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                const Text('Apple pay',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios,size: 15,)
                              ],
                            ),
                            SizedBox(height: 90,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child:  Row(
                        children: [
                          const SizedBox(width: 20,),
                          const Text('Pay',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          const Spacer(),
                          const Text('24min ·',style: TextStyle(color: Colors.white),),
                         const SizedBox(width: 2,),
                          Text('\$${totalPaymentsAmount.toStringAsFixed(2)}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          const SizedBox(width: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
  addToDatabase(Map<String, dynamic> updatedRow)async{
    final result = await DbHelper.instance.insert(updatedRow);
    print('resultt--${result}');
  }

  void fetchData() async {
    allData = await DbHelper.instance.quaryall();
    setState(() {
      print("dataaa--${allData}");
    });
    fetchValueAndFoodPerValue();
  }
  Future<int?> updateItem(int id,Map<String, dynamic> updatedRow) async {
    int? db = await DbHelper.instance.update(id,updatedRow);
    print('updated result--$db');
    fetchData();
  }
void delete(int id) async {
    int? db = await DbHelper.instance.delete(id);
    print('deleted row--$db');
    fetchData();
  }

   checkdata(String name) async {
      isRowAvailable = (await DbHelper.instance.isAvailablequaryall(name))!;
      // setState(() {
      //
      // });
    print('row available--$isRowAvailable');
  }

  void fetchValueAndFoodPerValue() async {
    List<Map<String, dynamic>>? valuesList = await DbHelper.instance.getValueAndFoodPerValue();
    double total = 0.0;
    for (var item in valuesList!) {
      final value = double.parse(item['value']);
      final pervalue = double.parse(item['pervalue']);
      total += value * pervalue;
    }
    print('Total of all value * pervalue: $total');
    setState(() {
      totalPaymentsAmount = total;
    });
  }

}

