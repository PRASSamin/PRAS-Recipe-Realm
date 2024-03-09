import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_realm/activity/details.dart';
import 'package:recipe_realm/modals/random.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isHovered = false;

//   Future<void> requestPermission(BuildContext context) async {
//   AndroidDeviceInfo androidSDK = await DeviceInfoPlugin().androidInfo;
//   int androidSDKVersion = androidSDK.version.sdkInt;

//   if (androidSDKVersion >= 29) {
//     const permission = Permission.manageExternalStorage;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool permissionDenied = prefs.getBool('storagePermissionDenied') ?? false;

//     if (permissionDenied) {
//       // Handle the case where permission was previously denied
//       return;
//     }

//     if (await permission.isDenied) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           title: Column(
//             children: [
//               Icon(Icons.storage),
//               SizedBox(height: 10),
//             ],
//           ),
//           content: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               text: "Allow ",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 21,
//                 fontWeight: FontWeight.w500,
//               ),
//               children: [
//                 TextSpan(
//                   text: "Storage",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: " to store your recipes on the device?",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 21,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           actions: [
//             SizedBox(height: 30),
//             Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 50.0,
//                     width: double.infinity,
//                     child: TextButton(
//                       onPressed: () async {
//                         await permission.request();
//                         Navigator.of(context).pop();
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.resolveWith((states) =>
//                                 Color.fromARGB(255, 0, 0, 0)),
//                         shape: MaterialStateProperty.resolveWith((states) =>
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0))),
//                       ),
//                       child: Text(
//                         "Allow",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5.0),
//                   SizedBox(
//                     height: 50.0,
//                     width: double.infinity,
//                     child: TextButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.resolveWith((states) =>
//                                 Color.fromARGB(255, 0, 0, 0)),
//                         shape: MaterialStateProperty.resolveWith((states) =>
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0))),
//                       ),
//                       onPressed: () async {
//                         Navigator.of(context).pop();
//                         prefs.setBool('storagePermissionDenied', true);
//                       },
//                       child: Text(
//                         "Don't Allow",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }


  void _saveRecipe(Meal recipe) async {
    try {
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        String appDataFolderPath = '${externalDir.path}/history';
        Directory appDataFolder = Directory(appDataFolderPath);
        if (!appDataFolder.existsSync()) {
          appDataFolder.createSync(recursive: true);
        }

        String recipeFilePath = '$appDataFolderPath/history.json';
        File recipeFile = File(recipeFilePath);

        List<dynamic> existingData;
        if (recipeFile.existsSync()) {
          String jsonData = await recipeFile.readAsString();
          existingData = jsonData.isNotEmpty ? jsonDecode(jsonData) : [];
        } else {
          existingData = [];
        }

        bool recipeExists =
            existingData.any((item) => item['idMeal'] == recipe.idMeal);
        if (!recipeExists) {
          Map<String, dynamic> recipeMap = {
            "idMeal": recipe.idMeal,
            "strMeal": recipe.strMeal,
            "strCategory": recipe.strCategory,
            "strArea": recipe.strArea,
            "strInstructions": recipe.strInstructions,
            "strMealThumb": recipe.strMealThumb,
            "strYoutube": recipe.strYoutube,
            "strIngredient1": recipe.strIngredient1,
            "strIngredient2": recipe.strIngredient2,
            "strIngredient3": recipe.strIngredient3,
            "strIngredient4": recipe.strIngredient4,
            "strIngredient5": recipe.strIngredient5,
            "strIngredient6": recipe.strIngredient6,
            "strIngredient7": recipe.strIngredient7,
            "strIngredient8": recipe.strIngredient8,
            "strIngredient9": recipe.strIngredient9,
            "strIngredient10": recipe.strIngredient10,
            "strIngredient11": recipe.strIngredient11,
            "strIngredient12": recipe.strIngredient12,
            "strIngredient13": recipe.strIngredient13,
            "strIngredient14": recipe.strIngredient14,
            "strIngredient15": recipe.strIngredient15,
            "strIngredient16": recipe.strIngredient16,
            "strIngredient17": recipe.strIngredient17,
            "strIngredient18": recipe.strIngredient18,
            "strIngredient19": recipe.strIngredient19,
            "strIngredient20": recipe.strIngredient20,
            "strMeasure1": recipe.strMeasure1,
            "strMeasure2": recipe.strMeasure2,
            "strMeasure3": recipe.strMeasure3,
            "strMeasure4": recipe.strMeasure4,
            "strMeasure5": recipe.strMeasure5,
            "strMeasure6": recipe.strMeasure6,
            "strMeasure7": recipe.strMeasure7,
            "strMeasure8": recipe.strMeasure8,
            "strMeasure9": recipe.strMeasure9,
            "strMeasure10": recipe.strMeasure10,
            "strMeasure11": recipe.strMeasure11,
            "strMeasure12": recipe.strMeasure12,
            "strMeasure13": recipe.strMeasure13,
            "strMeasure14": recipe.strMeasure14,
            "strMeasure15": recipe.strMeasure15,
            "strMeasure16": recipe.strMeasure16,
            "strMeasure17": recipe.strMeasure17,
            "strMeasure18": recipe.strMeasure18,
            "strMeasure19": recipe.strMeasure19,
            "strMeasure20": recipe.strMeasure20,
            "strSource": recipe.strSource
          };

          existingData.add(recipeMap);

          await recipeFile.writeAsString(jsonEncode(existingData));
        } else {
          return;
        }
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  bool isLoading = true;
  List<Meal> recipesList = [];

  @override
  void initState() {
    super.initState();
    // requestPermission(context);
    checkOrCreateAppDataFolder();
    fetchData();
  }

  Future<void> checkOrCreateAppDataFolder() async {
    try {
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        String appDataFolderPath = '${externalDir.path}/history';
        Directory appDataFolder = Directory(appDataFolderPath);

        if (!appDataFolder.existsSync()) {
          appDataFolder.createSync(recursive: true);
        }
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<void> fetchData() async {
    try {
      final List<Meal> recipes = await RecipeService.fetchRandomRecipes(20);
      setState(() {
        recipesList = recipes;
        isLoading = false;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const ui.Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
          )),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: isLoading ? _buildSkeletonLoader() : _buildRecipeList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: List.from(
          [BoxShadow(color: Color.fromARGB(98, 0, 0, 0), blurRadius: 10)],
        ),
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          "PRAS RECIPES",
          style: TextStyle(
            color: Color.fromARGB(186, 0, 0, 0),
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            _buildSearchBar(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: MouseRegion(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: SizedBox(
                          height: 120,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 200,
                                                color: Colors.white,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                height: 10,
                                                width: 100,
                                                color: Colors.white,
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 120,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            _buildSearchBar(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipesList.length,
              itemBuilder: (context, index) {
                if (recipesList[index].strMeal!.length >= 20) {
                  recipesList[index].strMeal =
                      recipesList[index].strMeal!.substring(0, 20) + "...";
                }

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      _saveRecipe(recipesList[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Details(recipe: recipesList[index])),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                recipesList[index]
                                                    .strMeal
                                                    .toString(),
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
                                                    Icons.location_on,
                                                    color: Color.fromARGB(
                                                        166, 0, 0, 0),
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    recipesList[index]
                                                        .strArea
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                    ),
                                    Image.network(
                                      '${recipesList[index].strMealThumb}',
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
