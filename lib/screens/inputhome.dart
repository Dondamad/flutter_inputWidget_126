import 'package:flutter/material.dart';
import 'package:inputwidgets/models/drink.dart';
import 'package:inputwidgets/models/food.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? _favFood;
  List<Food>? foods;

  List checkedDrink = [];
  List<Drink>? drinks;

  //Dropdown
  List<ListItem>? types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foods = Food.getFood();
    drinks = Drink.getDrink();
    _dropdownMenuItem = createDropdownMenuItem(types);
    _selectedTypeItem = _dropdownMenuItem[0].value!;
    // print(foods![0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input widgets'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            usernameTextField(),
            passwordTextField(),
            Column(
              children: createRadioFood(),
            ),
            Center(
              child: Text('Radio selected: ${_favFood.toString()}'),
            ),
            Divider(
              color: Colors.black.withOpacity(0.6),
            ),
            SizedBox(height: 10),
            Column(
              children: createCheckboxDrink(),
            ),
            Center(child: Text('Checkbox selected: ${checkedDrink}')),
            Divider(
              color: Colors.black.withOpacity(0.6),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 300,
                child: DropdownButton(
                  items: _dropdownMenuItem,
                  value: _selectedTypeItem,
                  isExpanded: true,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  onChanged: (ListItem? value) {
                    setState(() {
                      _selectedTypeItem = value!;
                    });
                  },
                ),
              ),
            ),
            Center(
                child: Text('Dropdown selected: ${_selectedTypeItem.value}')),
            submitButton()
          ],
        ),
      ),
    );
  }

  Container submitButton() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('Username is ${_username.text}');
              print('Username is ${_password.text}');
            }
          },
          child: Text('Submit')),
    );
  }

  Widget usernameTextField() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _username,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter username';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        controller: _password,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter Password';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.vpn_key),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }

  List<Widget> createRadioFood() {
    List<Widget> listFood = [];
    for (var food in foods!) {
      listFood.add(
        RadioListTile<dynamic>(
          title: Text(food.engName!),
          subtitle: Text(food.thName!),
          secondary: Text('${food.price} บาท'),
          value: food.foodValue,
          groupValue: _favFood,
          onChanged: (value) {
            setState(() {
              _favFood = value;
            });
          },
        ),
      );
    }
    return listFood;
  }

  List<Widget> createCheckboxDrink() {
    List<Widget> listDrink = [];

    for (var drink in drinks!) {
      listDrink.add(
        CheckboxListTile(
          title: Text(drink.thName!),
          subtitle: Text('${drink.price} บาท'),
          value: drink.checked,
          onChanged: (value) {
            setState(() {
              drink.checked = value;
            });
            if (value!) {
              checkedDrink.add(drink.thName);
            } else {
              checkedDrink.remove(drink.thName);
            }
            // print(checkedDrink);
          },
        ),
      );
    }
    return listDrink;
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenuItem(
      List<ListItem>? types) {
    List<DropdownMenuItem<ListItem>> item = [];
    for (var type in types!) {
      item.add(DropdownMenuItem(
        child: Text(type.name!),
        value: type,
      ));
    }
    return item;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);
  static getItem() {
    return [
      ListItem(1, 'First item'),
      ListItem(2, 'Second item'),
      ListItem(3, 'Third item'),
    ];
  }
}
