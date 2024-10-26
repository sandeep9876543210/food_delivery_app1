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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.fromLTRB(25, 20, 25, 10),
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

  void _showBottomcartPopup(BuildContext context,double total_amount) {
  //  double totalprice = double.parse(food_itemsPrice[index]);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the popup to resize according to its content
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,20),
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
                  Text('24min · \$${total_amount}',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 15,),
                ],
              ),

            ),
          );
        }
    );
  }


void _showBottomPopup(BuildContext context,int index) {
    int value = 1;
    double totalprice = double.parse(food_itemsPrice[index]);
    DbHelper dbHelper = DbHelper.instance;
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
                                          // return;
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
                                       child: Icon(Icons.minimize_rounded)),
                                  SizedBox(width: 12,),
                                  Text('${value.toString()}'),
                                  SizedBox(width: 12,),
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          value++;
                                          totalprice = totalprice+double.parse(food_itemsPrice[index]);
                                        });
                                      },
                                      child: Icon(Icons.add)),
                                ],
                              ),
                            ),
                          ),
                         SizedBox(width: 20,),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap:(){

                                final event = {
                                DbHelper.foodImage: 'assets/Banana.png',
                                  DbHelper.foodName: 'Banana..',
                                  DbHelper.foodValue: '2',
                                  DbHelper.foodPerValue: '20'
                               };

                                addToDatabase(event);

                                Navigator.pop(context);
                        // _showBottomcartPopup(context,totalprice);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(child: Text('Add to cart  \$${totalprice}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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
  addToDatabase(Map<String, dynamic> updatedRow)async{
    final result = await DbHelper.instance.insert(updatedRow);
    print('resultt--${result}');
    Map<String, dynamic> newRow = {
      'columnName1': 'value1',
      'columnName2': 'value2',
      // add other column-value pairs
    };


  }

}






/*
class BottomPopup extends StatelessWidget {
  final String title;
  final String content;

  BottomPopup({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Arrow pointing upwards
        CustomPaint(
          painter: ArrowPainter(),
          size: Size(30, 10), // Size of the arrow
        ),
        // Popup content
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(content),
            ],
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    // Define the path for the arrow
    Path path = Path();
    path.moveTo(size.width / 2, 0); // Start at the top center
    path.lineTo(0, size.height); // Left bottom
    path.lineTo(size.width, size.height); // Right bottom
    path.close(); // Close the path to create the triangle

    // Draw the arrow
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
*/
