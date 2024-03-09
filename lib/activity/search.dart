import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_realm/activity/webdetails.dart';
import 'package:recipe_realm/modals/recipe.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  

  List<FoodRecipe> recipeList = [];
  bool isLoading = false;
  TextEditingController textSearch = TextEditingController();
  void reset() {
    setState(() {
      recipeList = [];
    });
  }

  String truncateString(String input, {int maxLength = 30}) {
    if (input.length <= maxLength) {
      return input;
    } else {
      String truncatedString = input.substring(0, maxLength);
      truncatedString += '...';
      return truncatedString;
    }
  }

  Future<void> getData(String query) async {
    setState(() {
      isLoading = true;
    });

    String appID = "45799632";
    String appKey = "81c5c5c3acb00bc10c88a6df63846c2c";

    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&beta=true&q=$query&app_id=$appID&app_key=$appKey";
    Response response = await get(Uri.parse(url));
    Map foodData = jsonDecode(response.body);

    setState(() {
      recipeList.clear();
      foodData["hits"].forEach((element) {
        FoodRecipe foodRecipe = FoodRecipe.fromMap(element["recipe"]);
        recipeList.add(foodRecipe);
      });
      isLoading = false;
    });

    recipeList.forEach((recipe) {
      print(recipeList[0].foodIngredientLines);
    });

    _notFound(foodData);
  }

  Map notFound = {};

  void _notFound(Map foodData) {
    if (foodData["hits"].length == 0) {
      notFound = {
        "Text": "Recipe Not Found",
        "Icon": Icons.desktop_access_disabled_sharp,
      };
    } else {
      notFound = {
        "Text": "Search for Your Favorite Dishes",
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: List.from([
                      BoxShadow(
                        color: Color.fromARGB(98, 0, 0, 0),
                        blurRadius: 10,
                      )
                    ]),
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((textSearch.text).replaceAll(" ", "") == "") {
                            print("null");
                          } else {
                            getData(textSearch.text);
                            reset();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 11, 0),
                          child: Icon(
                            Icons.search,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                          controller: textSearch,
                          onSubmitted: (value) {
                            if ((textSearch.text).replaceAll(" ", "") == "") {
                              print("null");
                            } else {
                              getData(textSearch.text);
                              reset();
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Food",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _content(),
                if (isLoading) _Loader(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    String displayText = notFound["Text"] ?? "Search for Your Favorite Dishes";
    IconData? displayIcon = notFound["Icon"] ?? Icons.food_bank_outlined;

    if (recipeList.isEmpty) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          margin: EdgeInsets.only(top: 200),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Icon(
                displayIcon,
                size: 100,
                color: Color.fromARGB(255, 71, 71, 71),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                displayText,
                style: TextStyle(
                  color: Color.fromARGB(255, 71, 71, 71),
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return _result();
    }
  }

  Widget _Loader() {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
      margin: EdgeInsets.only(top: 250),
      padding: EdgeInsets.symmetric(horizontal: 150),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SpinKitDancingSquare(
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 60.0,
          ),
        ),
      ),
    );
  }

  Widget _result() {
    return ListView.builder(
      key: UniqueKey(),
      reverse: false,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        String foodCalSubstring = '';
        if (recipeList[index].foodCal.toString().length >= 6) {
          foodCalSubstring =
              recipeList[index].foodCal.toString().substring(0, 6);
        } else {
          foodCalSubstring = recipeList[index].foodCal.toString();
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebDetails(recipe: recipeList[index])),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Card(
              elevation: 10,
              shadowColor: Color.fromARGB(252, 0, 0, 0),
              color: Color(0xFFFFFFFF),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    truncateString(recipeList[index].foodLabel),
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department_sharp,
                                        color: Color(0xFFE8443D),
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        foodCalSubstring,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            '${recipeList[index].foodImage}',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
