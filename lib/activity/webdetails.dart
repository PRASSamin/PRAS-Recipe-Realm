import 'package:flutter/material.dart';
import 'package:recipe_realm/modals/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class WebDetails extends StatelessWidget {
  final FoodRecipe recipe;

  const WebDetails({Key? key, required this.recipe});

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
                      recipe.foodImage.toString(),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.fitWidth,
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
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(234, 255, 255, 255),
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  recipe.foodArea[0].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(228, 255, 255, 255)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.foodLabel.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        softWrap: true,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Color.fromARGB(159, 255, 0, 0),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          _Calories()
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Text("Instructions",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(height: 30),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(),
                              margin: EdgeInsets.only(left: 20, right: 170),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Transform.rotate(
                                      angle: 135 * 3.1416 / 180,
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          launchUrl(
                                              Uri.parse(recipe.foodUrl));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              minWidth: 0,
                                              maxWidth: double.infinity),
                                          child: Text(
                                                recipe.foodSource,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                )
                                              ),
                                      
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Text("Ingredients",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(height: 30),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipe.foodIngredientLines.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.only(left: 20),
                              dense: true,
                              leading: Icon(Icons.check),
                              title: Text(
                                  recipe.foodIngredientLines[index].toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Calories() {
    if (recipe.foodCal.toString().contains(".")) {
      int indexofDot = recipe.foodCal.toString().indexOf(".");
      return Text(
        recipe.foodCal.toString().substring(0, indexofDot),
        style:
            TextStyle(fontSize: 16, color: const Color.fromARGB(200, 0, 0, 0)),
      );
    } else {
      return Text(
        recipe.foodCal.toString(),
        style:
            TextStyle(fontSize: 16, color: const Color.fromARGB(200, 0, 0, 0)),
      );
    }
  }
}
