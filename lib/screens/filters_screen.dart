import "package:flutter/material.dart";
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilter;

  FiltersScreen(this.currentFilter, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarianFree = false;
  bool _veganFree = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter["gluten"]!;
    _lactoseFree = widget.currentFilter["lactose"]!;
    _veganFree = widget.currentFilter["vegan"]!;
    _vegetarianFree = widget.currentFilter["vegetarian"]!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    description,
    bool currentVlue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentVlue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegan": _veganFree,
                "vegetarian": _vegetarianFree,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  "Gluten-free",
                  "Only include gluten-free meals.",
                  _glutenFree,
                  (bool value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Lactose-free",
                  "Only include lactose-free meals.",
                  _lactoseFree,
                  (bool value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  "Only include vegetarian meals.",
                  _vegetarianFree,
                  (bool value) {
                    setState(() {
                      _vegetarianFree = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegan",
                  "Only include vegan meals.",
                  _veganFree,
                  (bool value) {
                    setState(() {
                      _veganFree = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
