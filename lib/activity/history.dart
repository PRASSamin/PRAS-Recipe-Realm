import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:recipe_realm/activity/details.dart';
import 'package:recipe_realm/modals/random.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Meal> historyRecipes = [];

  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
    try {
      Directory? appDocumentsDirectory = await getExternalStorageDirectory();
      if (appDocumentsDirectory != null) {
        String historyFilePath =
            '${appDocumentsDirectory.path}/history/history.json';
        File historyFile = File(historyFilePath);
        

        if (await historyFile.exists()) {
          final String jsonData = await historyFile.readAsString();
          final List<dynamic> jsonList = jsonDecode(jsonData);
          final List<Meal> recipes =
              jsonList.map((jsonRecipe) => Meal.fromJson(jsonRecipe)).toList();

          setState(() {
            historyRecipes = recipes;
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<dynamic> clearAll() async {
    try {
      Directory? appDocumentsDirectory = await getExternalStorageDirectory();
      if (appDocumentsDirectory != null) {
        String historyFilePath =
            '${appDocumentsDirectory.path}/history/history.json';
        final File historyFile = File(historyFilePath);

        if (await historyFile.exists()) {
          await historyFile.delete();
        } else {
          return;
        }

        setState(() {
          historyRecipes.clear();
        });
      }
    } catch (e) {
      return;
    }
  }

  void historyclearConfirmation() {
    showDialog(
      context: context,
      builder: (context) => HistoryAlert(
        titleText: "Clear History",
        messageText: "Are you sure you want to clear all history?",
        button1Text: "Cancel",
        button2Text: "Yes",
        list: historyRecipes,
        clearFunction: clearAll,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 48,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: List.from(
                    [
                      BoxShadow(
                          color: Color.fromARGB(98, 0, 0, 0), blurRadius: 10)
                    ],
                  ),
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        "HISTORY",
                        style: TextStyle(
                          color: Color.fromARGB(186, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          historyclearConfirmation();
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
              _historyCheck()
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyCheck() {
    if (historyRecipes.isEmpty) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 350),
        child: Center(
          child: Text(
            "No History",
          ),
        ),
      );
    } else {
      return _history();
    }
  }

  Widget _history() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: historyRecipes.length,
      itemBuilder: (context, index) {
        if (historyRecipes[index].strMeal!.length >= 20) {
          historyRecipes[index].strMeal =
              historyRecipes[index].strMeal!.substring(0, 20) + "...";
        }

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(recipe: historyRecipes[index]),
                ),
              );
            },
            child: MouseRegion(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            historyRecipes[index].strMealThumb.toString(),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                historyRecipes[index].strMeal.toString(),
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                historyRecipes[index].strCategory.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80),
                      ],
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
}

class HistoryAlert extends StatelessWidget {
  final String titleText;
  final String messageText;
  final String button1Text;
  final String button2Text;
  final List list;
  final Function()? clearFunction;

  const HistoryAlert({
    this.titleText = "",
    this.messageText = "",
    this.button1Text = "",
    this.button2Text = "",
    this.list = const [],
    this.clearFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          titleText,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
        ),
        content: Text(
          messageText,
          style: TextStyle(color: Color.fromARGB(255, 52, 52, 52)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              button1Text,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              if (list.isNotEmpty) {
                clearFunction!();
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(milliseconds: 800), () {
                      try {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        return;
                      }
                    });
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Text(
                          'All History Cleared',
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 52, 52),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                );
              } else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(milliseconds: 800), () {
                      try {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        return;
                      }
                    });
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Text(
                          'No History to Clear',
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 52, 52),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: Text(
              button2Text,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          )
        ]);
  }
}
