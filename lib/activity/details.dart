import 'package:flutter/material.dart';
import 'package:recipe_realm/modals/random.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final Meal recipe;

  const Details({Key? key, required this.recipe}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isNull = true;

  @override
  void initState() {
    super.initState();
    if (widget.recipe.strIngredient20 != null &&
        widget.recipe.strIngredient20 != "") {
      isNull = false;
      print("not null");
    } else {
      isNull = true;
      print("null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.recipe.strMealThumb.toString(),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                        child: Container(
                      color: Color.fromARGB(109, 0, 0, 0),
                    )),
                    Positioned(
                        child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: Colors.white,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color.fromARGB(234, 255, 255, 255),
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      widget.recipe.strArea.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              228, 255, 255, 255)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.recipe.strMeal.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.category,
                            color: const Color.fromARGB(160, 0, 0, 0),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.recipe.strCategory.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(200, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 40,
                      endIndent: 40,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Instructions",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(widget.recipe.strInstructions.toString(),
                              style: TextStyle(
                                fontSize: 17,
                              )),
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ingredients",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 20),
                              Table(
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient1
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure1
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient2
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure2
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient3
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure3
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient4
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure4
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient5
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure5
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient6
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure6
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient7
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure7
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient8
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure8
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient9
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure9
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient10
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure10
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient11
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure11
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient12
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure12
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient13
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure13
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient14
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure14
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient15
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure15
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient16
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure16
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient17
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure17
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient18
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure18
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient19
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure19
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget
                                              .recipe.strIngredient20
                                              .toString()),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(widget.recipe.strMeasure20
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                1), 
                                            spreadRadius: 2, 
                                            blurRadius: 15, 
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            late String url;
                                            if (widget.recipe.strYoutube ==
                                                    "" ||
                                                widget.recipe.strYoutube ==
                                                    null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 600),
                                                        () {
                                                      try {
                                                        if (Navigator.of(
                                                                context)
                                                            .canPop()) {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      } catch (e) {
                                                        return;
                                                      }
                                                    });
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      title: Text(
                                                        "No Youtube link found",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  });
                                            } else {
                                              url = widget.recipe.strYoutube
                                                  .toString();
                                              launchUrl(Uri.parse(url));
                                            }
                                          },
                                          style: ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 18),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 0, 0, 0)),
                                            overlayColor: MaterialStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Color.fromARGB(
                                                    35, 255, 255, 255);
                                              }
                                              return null;
                                            }),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                );
                                              }
                                              return RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              );
                                            }),
                                          ),
                                          child: Text("Youtube")),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                1), 
                                            spreadRadius: 2, 
                                            blurRadius: 15, 
                                            offset: Offset(5, 5), 
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            late String url;
                                            if (widget.recipe.strSource == "" ||
                                                widget.recipe.strSource ==
                                                    null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      try {
                                                        if (Navigator.of(
                                                                context)
                                                            .canPop()) {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      } catch (e) {
                                                        return;
                                                      }
                                                    });
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      title: Text(
                                                        "No Source link found",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  });
                                            } else {
                                              url = widget.recipe.strSource
                                                  .toString();
                                              launchUrl(Uri.parse(url));
                                            }
                                          },
                                          style: ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 18),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 0, 0, 0)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            overlayColor: MaterialStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Color.fromARGB(
                                                    35, 255, 255, 255);
                                              }
                                              return null;
                                            }),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                );
                                              }
                                              return RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              );
                                            }),
                                          ),
                                          child: Text(" Source ")),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 50),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
