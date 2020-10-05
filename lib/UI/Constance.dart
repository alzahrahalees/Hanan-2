import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

const kTitleOfProject = "SECS Hanan";

const Color KAppBarColor = Color(0xFFe1d0ed);
const Color KBackgroundPageColor = Color(0xFFeeeeee);
const Color KButtonColor = Color(0xFFB39DDB);
const kSelectedItemColor = Color(0xff5F3E60);
const kUnselectedItemColor = Color(0xff9181bd);

const KTextAppBarStyle = TextStyle(
    fontSize: 20,
    color: kUnselectedItemColor,
    fontWeight: FontWeight.w800,
    letterSpacing: 1);

const KTextButtonStyle = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 1);

const KTextPageStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    decorationStyle: TextDecorationStyle.dotted,
    fontWeight: FontWeight.bold);

RoundedRectangleBorder kButtonShape() {
  return RoundedRectangleBorder(
      side: BorderSide(color: Colors.deepPurpleAccent.shade100),
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
            style: KTextAppBarStyle.copyWith(fontSize: 17),
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
    return new Container(
        width: 300,
        height: 70,
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                border: new OutlineInputBorder(
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

  KNormalTextFormField(
      {this.hintText, this.validatorText, this.controller, this.onChanged});

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
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

class KNormalTextFormFieldLines extends StatelessWidget {
  final TextEditingController controller;
  final String validatorText;
  final String hintText;
  final Function onChanged;

  KNormalTextFormFieldLines(
      {this.hintText, this.validatorText, this.controller, this.onChanged});

  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      minLines: 1,
      controller: controller,
      decoration: InputDecoration(
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
          hintText: "$hintText",
        ));
  }
}

class KCustomTwoRadioButton extends StatefulWidget {
  @override
  _KCustomTwoRadioButtonState createState() => _KCustomTwoRadioButtonState();
}

// i think we need to add in the same page to can access ValueOfIndex
class _KCustomTwoRadioButtonState extends State<KCustomTwoRadioButton> {
  String valueOfIndex;
  List<String> list = ["ذكر", "أنثى"];
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
        selectedIndex == 0 ? valueOfIndex = "male" : valueOfIndex = "female";
        print(valueOfIndex);
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
      Text("$textDef", style: KTextPageStyle.copyWith(color: Colors.grey)),
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
      new Padding(padding: new EdgeInsets.all(5)),
      Text("$textBehind", style: KTextPageStyle.copyWith(color: Colors.grey)),
      new Padding(padding: new EdgeInsets.all(7)),
      Expanded(
          child: SizedBox(
        height: 40,
        width: 200,
        child: DropdownButton(
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
        fillColor: KBackgroundPageColor,
        autovalidate: false,
        titleText: 'النمو الإنفعالي',
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
        hintText: ' الرجاء تحديد خيار أو أكثر',
        initialValue: list,
        onSaved: (value) {
          if (value == null) return;
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
