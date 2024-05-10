import 'package:flutter/material.dart';
import 'package:recipe_app/detail_screen.dart';
import 'package:recipe_app/recipes_model.dart';
import 'package:recipe_app/services.dart';

class RecipesHomeScreen extends StatefulWidget {
  const RecipesHomeScreen({Key? key}) : super(key: key);

  @override
  State<RecipesHomeScreen> createState() => _RecipesHomeScreenState();
}

class _RecipesHomeScreenState extends State<RecipesHomeScreen> {
  List<Recipe> recipesModel = [];
  bool isLoading = false;

  @override
  void initState() {
    myRecipes();
    super.initState();
  }

  void myRecipes() {
    setState(() {
      isLoading = true;
    });
    recipesItems().then((value) {
      setState(() {
        recipesModel = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Recipes App"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: recipesModel.length,
              itemBuilder: (context, index) {
                final recipes = recipesModel[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(recipe: recipes),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        // width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          image: DecorationImage(
                            image: NetworkImage(recipes.image),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(-5, 3),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(19),
                              bottomRight: Radius.circular(29),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: Text(
                                    recipes.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 220, 42, 59),
                              ),
                              Text(
                                recipes.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              const SizedBox(width: 14,),
                              Text(
                                recipes.cookTimeMinutes.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "min",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
