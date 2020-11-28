import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

const kTitleOfProject = "SECS Hanan";

const Color kAppBarColor = Color(0xFFceb8e0);
const Color kWolcomeBkg = Color(0xFFd8d8d8);
const Color kBackgroundPageColor = Color(0xFFeeeeee);
const Color kCardColor = Color(0xfff4f4f4);
const Color kButtonColor = Color(0xff9181bd);
const kSelectedItemColor = Color(0xff5F3E60);
const kUnselectedItemColor = Color(0xff9181bd);

const kTextAppBarStyle = TextStyle(
    fontSize: 20,
    color: kUnselectedItemColor,
    fontWeight: FontWeight.w800,
    letterSpacing: 1);

const kTextButtonStyle = TextStyle(
    fontSize: 18,
    color: kWolcomeBkg,
    fontWeight: FontWeight.w600,
    letterSpacing: 1);

const kTextPageStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    decorationStyle: TextDecorationStyle.dotted,
    fontWeight: FontWeight.bold);

RoundedRectangleBorder kButtonShape() {
  return RoundedRectangleBorder(
      side: BorderSide(color: kUnselectedItemColor),
      borderRadius: BorderRadius.circular(18.0));
}

//add the text and screen you want to move it when pressed on text
class KAppBarTextInkwell extends StatelessWidget {
  String text;
  Widget page;

  KAppBarTextInkwell({this.text, this.page});

  Widget build(BuildContext context) {
    return Container(
        padding: new EdgeInsets.all(15),
        child: InkWell(
          child: Text(
            "$text ",
            style: kTextAppBarStyle.copyWith(fontSize: 17),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => page));
          },
        ));
  }
}

class KCircularTextFormField extends StatelessWidget {
  TextEditingController controller;
  String validatorText;

  KCircularTextFormField(this.controller, this.validatorText);

  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 70,
        child: TextFormField(
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                  const Radius.circular(18.0),
                ))),
            validator: (value) {
              if (value.isEmpty) {
                return '$validatorText ';
              }
            }));
  }
}

class KNormalTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String validatorText;
  final String hintText;
  final Function onChanged;
  String title = '';
  bool readOnly = false;

  KNormalTextFormField(
      {this.hintText,
      this.validatorText,
      this.controller,
      this.onChanged,
      this.title,
      this.readOnly});

  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly == null ? false : readOnly,
      initialValue: title,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        labelText: "$hintText",
        labelStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '$validatorText ';
        }
      },
      onChanged: onChanged,
    );
  }
}

class KNormalTextFormFieldLines extends StatelessWidget {
  final TextEditingController controller;
  final String validatorText;
  final String hintText;
  final Function onChanged;
  final String initialValue;
  bool readOnly;

  KNormalTextFormFieldLines(
      {this.hintText,
      this.validatorText,
      this.controller,
      this.onChanged,
      this.initialValue,
      this.readOnly});

  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly == null ? false : readOnly,
      initialValue: initialValue,
      maxLines: 6,
      minLines: 1,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: "$hintText",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '$validatorText ';
        }
      },
      onChanged: onChanged,
    );
  }
}

class KNormalTextFormFieldLinesNoV extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;

  KNormalTextFormFieldLinesNoV(
      {this.hintText, this.controller, this.onChanged});

  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      minLines: 1,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: "$hintText",
      ),
      onChanged: onChanged,
    );
  }
}

class KNormalTextFormFieldNoV extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  KNormalTextFormFieldNoV({this.hintText, this.controller});

  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
          hintText: "$hintText",
        ));
  }
}

// i think we need to add in the same page to can access ValueOfIndex
class KCustomTwoRadioButton extends StatefulWidget {
  @override
  String valueOfIndex;
  List<String> list;
  KCustomTwoRadioButton(String valueOfIndex, List<String> list) {
    this.valueOfIndex = valueOfIndex;
    this.list = list;
  }

  _KCustomTwoRadioButtonState createState() =>
      _KCustomTwoRadioButtonState(valueOfIndex, list);
}

// i think we need to add in the same page to can access ValueOfIndex
class _KCustomTwoRadioButtonState extends State<KCustomTwoRadioButton> {
  String valueOfIndex;
  List<String> list;
  _KCustomTwoRadioButtonState(String valueOfIndex, List<String> list) {
    this.valueOfIndex = valueOfIndex;
    this.list = list;
  }
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RadioButton(list[0], 0),
          new Padding(padding: new EdgeInsets.all(10)),
          RadioButton(list[1], 1),
        ],
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? valueOfIndex = list[0] : valueOfIndex = list[1];
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color:
              selectedIndex == index ? Colors.deepPurpleAccent : Colors.grey),
      child: Text(txt,
          style: TextStyle(
              color: selectedIndex == index
                  ? Colors.deepPurpleAccent
                  : Colors.grey)),
    );
  }
}

class kDatePicker extends StatefulWidget {
  DateTime whatDate;
  String textDef;

  kDatePicker(DateTime whatDate, String textDef) {
    this.whatDate = whatDate;
    this.textDef = textDef;
  }

  _kDatePickerState createState() => _kDatePickerState(whatDate, textDef);
}

class _kDatePickerState extends State<kDatePicker> {
  DateTime whatDate;
  String textDef;

  _kDatePickerState(DateTime whatDate, String textDef) {
    this.whatDate = whatDate;
    this.textDef = textDef;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      Text("$textDef", style: kTextPageStyle.copyWith(color: Colors.grey)),
      new Padding(padding: new EdgeInsets.all(5)),
      SizedBox(
        height: 30,
        width: 250,
        child: CupertinoDatePicker(
          initialDateTime: whatDate,
          maximumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            setState(() {
              whatDate = dateTime;
            });
          },
        ),
      )
    ]);
  }
}


class KDropDownList extends StatefulWidget {
  String textBehind;
  String hintText;
  String selected;
  List<String> items;

  KDropDownList(
      String textBehind, String hintText, String selected, List<String> items) {
    this.textBehind = textBehind;
    this.hintText = hintText;
    this.selected = selected;
    this.items = items;
  }

  @override
  _KDropDownListState createState() =>
      _KDropDownListState(textBehind, hintText, selected, items);
}

class _KDropDownListState extends State<KDropDownList> {
  String textBehind;
  String hintText;
  String selected;
  List<String> items;

  _KDropDownListState(
      String textBehind, String hintText, String selected, List<String> items) {
    this.textBehind = textBehind;
    this.hintText = hintText;
    this.selected = selected;
    this.items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      textBehind == null
          ? SizedBox()
          : Text("$textBehind",
              style: kTextPageStyle.copyWith(color: Colors.grey)),
      new Padding(padding: new EdgeInsets.all(7)),
      Expanded(
          child: SizedBox(
        height: 40,
        width: 100,
        child: DropdownButton(
          isExpanded: false,
          hint: Text('$hintText'),
          // Not necessary for Option 1
          value: selected,
          onChanged: (newValue) {
            setState(() {
              selected = newValue;
            });
          },
          items: items.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
      ))
    ]);
  }
}

class MultiSelect extends StatefulWidget {
  @override
  List list;

  MultiSelect(List list) {
    this.list = list;
  }

  _MultiSelectState createState() => _MultiSelectState(list);
}

class _MultiSelectState extends State<MultiSelect> {
  List list;

  _MultiSelectState(List list) {
    this.list = list;
  }

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    list = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: MultiSelectFormField(
        hintWidget: Center(child: Text('اضغط لاختيار واحدة أو أكثر')),
        fillColor: kBackgroundPageColor,
        autovalidate: false,
        title: Text('النمو الإنفعالي'),
        validator: (value) {
          if (value == null || value.length == 0) {
            return 'مطلوب';
          }
          return null;
        },
        dataSource: [
          {
            "display": "عدواني",
            "value": "عدواني",
          },
          {
            "display": "عنيد",
            "value": "عنيد",
          },
          {
            "display": "تخريب",
            "value": "تخريب",
          },
          {
            "display": "توتر",
            "value": "توتر",
          },
          {
            "display": "قلق",
            "value": "قلق",
          },
          {
            "display": "مخاوف",
            "value": "مخاوف",
          },
          {
            "display": "الإحباط",
            "value": "الإحباط",
          },
          {
            "display": "الهروب",
            "value": "الهروب",
          },
          {
            "display": "نشاط زائد",
            "value": "نشاط زائد",
          },
          {
            "display": "خمول",
            "value": "خمول",
          },
        ],
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'تم',
        cancelButtonLabel: 'إلغاء',
        // hintText: ' الرجاء تحديد خيار أو أكثر',
        initialValue: list,
        onSaved: (value) {
          if (value == null)
            setState(() {
              list = value;
            });
        },
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {this.color,
      this.child,
      this.onPress,
      this.height,
      this.width,
      this.alignment});

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final AlignmentGeometry alignment;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        child: child,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final Widget child;
  final Color color;

  const Circle({this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: child,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final icon;
  final String hintTitle;
  final String title;
  final Color color;
  final Function onChanged;

  final bool readOnly;

  const ProfileTile(
      {this.readOnly,
      this.onChanged,
      this.icon,
      this.hintTitle,
      this.title,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Circle(
                child: Icon(icon),
                color: color,
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 200,
                  child: TextFormField(
                    readOnly: readOnly,
                    initialValue: title,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      helperText: readOnly ? "لايمكن تغييره" : '',
                      labelText: hintTitle,
                      labelStyle: TextStyle(color: Colors.deepPurple),
                    ),
                    onChanged: onChanged,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "لا يمكن تركها فارغة";
                      } else
                        return null;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTileTwo extends StatelessWidget {
  final icon;
  final String hintTitle;
  final String title;
  final Color color;
  final Function onChanged;

  final bool readOnly;

  const ProfileTileTwo(
      {this.readOnly,
      this.onChanged,
      this.icon,
      this.hintTitle,
      this.title,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Circle(
                child: Icon(icon),
                color: color,
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 200,
                  child: TextFormField(
                    readOnly: readOnly,
                    initialValue: title,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2)),
                      //helperText: readOnly?  "لايمكن تغييره": '' ,
                      labelText: hintTitle,
                      labelStyle: TextStyle(color: Colors.deepPurple),
                    ),
                    onChanged: onChanged,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "لا يمكن تركها فارغة";
                      } else
                        return null;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
