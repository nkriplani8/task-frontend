import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_profile_app/Screens/chips_screen.dart';
import 'package:create_profile_app/Screens/components/custom_clipper.dart';
import 'package:create_profile_app/Screens/profile_success.dart';
import 'package:create_profile_app/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _phoneController = TextEditingController();

  List<String> _bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<String> _genders = ['Male', 'Female', 'Others'];
  List<String> _comorbidities = [
    'Cough',
    'Headache',
    'Breathlessness',
    'Fever',
    'Sweating',
    'Body Ache',
    'Chest Pain',
    'Heart Burn',
    'Nausea',
    'Dizziness',
    'Other'
  ];

  String _selectedItem, _selectedBloodGroup, _selectedGender, _birthday;
  List<String> _selectedComorbidities, _selectedAllergies;
  bool _validBloodGroup = true, _validGender = true, _validBirthday = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueAccent,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Name...
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: TextFormField(
                                              controller: _firstnameController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: 'First Name',
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'First name required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 60),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: TextFormField(
                                              controller: _lastnameController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: 'Last Name',
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Last name required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),

                                    ///Birthday... Gender...
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 13, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Text(
                                                    _birthday == null ||
                                                            _birthday.isEmpty
                                                        ? "Date of Birth"
                                                        : _birthday,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _showDatePicker();
                                                  },
                                                ),
                                                SizedBox(height: 5),
                                                Divider(
                                                  thickness: 1,
                                                  color: !_validBirthday
                                                      ? Colors.red
                                                      : Colors.white,
                                                ),
                                                !_validBirthday
                                                    ? Text(
                                                        "Date of Birth Required",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 60,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            padding: EdgeInsets.fromLTRB(
                                                0, 13, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Text(
                                                    _selectedGender == null ||
                                                            _selectedGender
                                                                .isEmpty
                                                        ? "Gender"
                                                        : _selectedGender,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    customAlertDialog(context,
                                                        _genders, "Gender");
                                                  },
                                                ),
                                                SizedBox(height: 5),
                                                Divider(
                                                  thickness: 1,
                                                  color: !_validGender
                                                      ? Colors.red
                                                      : Colors.white,
                                                ),
                                                !_validGender
                                                    ? Text(
                                                        "Gender Required",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),

                                    ///Pincode...
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: TextFormField(
                                        controller: _pincodeController,
                                        style: TextStyle(color: Colors.white),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Pincode',
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        validator: (value) {
                                          Pattern pattern =
                                              '([1-9]{1}[0-9]{5})';
                                          RegExp regex = new RegExp(pattern);
                                          if (value.isEmpty) {
                                            return 'Pincode Required';
                                          } else if (!regex.hasMatch(value)) {
                                            return 'Enter valid pin code';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 15),

                                    ///Phone Number...
                                    TextFormField(
                                      controller: _phoneController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: 'Emergency Contact Number',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      validator: (value) {
                                        Pattern pattern = '([1-9]{1}[0-9]{9})';
                                        RegExp regex = new RegExp(pattern);
                                        if (value.isEmpty) {
                                          return 'Phone number Required';
                                        } else if (!regex.hasMatch(value)) {
                                          return 'Enter valid pnone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),

                                    ///Blood Group...
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Text(
                                              _selectedBloodGroup == null ||
                                                      _selectedBloodGroup
                                                          .isEmpty
                                                  ? "Blood Group"
                                                  : _selectedBloodGroup,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              customAlertDialog(context,
                                                  _bloodGroup, "Blood Group");
                                            },
                                          ),
                                          SizedBox(height: 5),
                                          Divider(
                                            thickness: 1,
                                            color: !_validBloodGroup
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                          !_validBloodGroup
                                              ? Text(
                                                  "Gender Required",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),

                              ///Allergies...
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Allergies",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            getAllergies();
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    _selectedAllergies == null ||
                                            _selectedAllergies.isEmpty
                                        ? Container()
                                        : Wrap(
                                            spacing: 6.0,
                                            runSpacing: 6.0,
                                            children: List<Widget>.generate(
                                                _selectedAllergies.length,
                                                (int index) {
                                              return Chip(
                                                label: Text(
                                                  _selectedAllergies[index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                deleteIcon: Icon(
                                                  Icons
                                                      .remove_circle_outline_sharp,
                                                  color: Colors.white,
                                                ),
                                                onDeleted: () {
                                                  setState(() {
                                                    _selectedAllergies.remove(
                                                        _selectedAllergies[
                                                            index]);
                                                  });
                                                },
                                              );
                                            }),
                                          ),
                                    _selectedAllergies == null ||
                                            _selectedAllergies.isEmpty
                                        ? Container()
                                        : Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),

                              ///Comorbidities...
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Comorbidities",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            getComorbidities();
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    _selectedComorbidities == null ||
                                            _selectedComorbidities.isEmpty
                                        ? Container()
                                        : Wrap(
                                            spacing: 6.0,
                                            runSpacing: 6.0,
                                            children: List<Widget>.generate(
                                                _selectedComorbidities.length,
                                                (int index) {
                                              return Chip(
                                                label: Text(
                                                  _selectedComorbidities[index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                deleteIcon: Icon(
                                                  Icons
                                                      .remove_circle_outline_sharp,
                                                  color: Colors.white,
                                                ),
                                                onDeleted: () {
                                                  setState(() {
                                                    _selectedComorbidities.remove(
                                                        _selectedComorbidities[
                                                            index]);
                                                  });
                                                },
                                              );
                                            }),
                                          ),
                                    _selectedComorbidities == null ||
                                            _selectedComorbidities.isEmpty
                                        ? Container()
                                        : Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///Submit button...
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 0, color: Colors.blueAccent),
                          ),
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: BackgroundCustomClipper(),
                                child: Container(
                                  height: 80,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orangeAccent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            side: BorderSide(
                                                color: Colors.white))),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedBloodGroup == null ||
                                              _selectedBloodGroup.isEmpty
                                          ? _validBloodGroup = false
                                          : _validBloodGroup = true;
                                      _selectedGender == null ||
                                              _selectedGender.isEmpty
                                          ? _validGender = false
                                          : _validGender = true;
                                      _birthday == null || _birthday.isEmpty
                                          ? _validBirthday = false
                                          : _validBirthday = true;
                                    });
                                    submitForm();
                                  },
                                  child: Text(
                                    "Create Profile",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipPath(
                    clipper: BackgroundCustomClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width - 80,
                      color: Colors.orangeAccent,
                      padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tell us about yourself.",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 40,
                    child: Card(
                      elevation: 5,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(
                              "https://image.flaticon.com/icons/png/512/1160/1160040.png",
                              width: 60,
                              fit: BoxFit.fill),
                        ),
                        radius: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    right: 35,
                    child: Card(
                      elevation: 5,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        child: ClipOval(
                          child: Image.network(
                            "https://image.flaticon.com/icons/png/512/1250/1250615.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                        radius: 18,
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void customAlertDialog(BuildContext context, List list, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: CustomAlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1.8,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 140,
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: TextButton(
                                  child: Text(
                                    list[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: _selectedItem == list[index]
                                          ? Colors.white
                                          : Colors.grey[800],
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        _selectedItem == list[index]
                                            ? MaterialStateProperty.all<Color>(
                                                Colors.orangeAccent)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.white))),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedItem = list[index];
                                      title == "Blood Group"
                                          ? _selectedBloodGroup = list[index]
                                          : _selectedGender = list[index];
                                    });
                                  },
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text(
                              "Select",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          GestureDetector(
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedItem = "";
                              });
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void getAllergies() async {
    _selectedAllergies = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GetData(
                comorbidities: _comorbidities,
                title: "Add Allergies.",
              )),
    );
    setState(() {
      _selectedAllergies;
    });
  }

  void getComorbidities() async {
    _selectedComorbidities = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GetData(
                comorbidities: _comorbidities,
                title: "Add Comorbidities.",
              )),
    );
    setState(() {
      _selectedComorbidities;
    });
  }

  void _showDatePicker() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      height: MediaQuery.of(context).size.height / 2.5,
      theme: ThemeData(primarySwatch: Colors.orange),
    );

    setState(() {
      _birthday = '${newDateTime.day}/${newDateTime.month}/${newDateTime.year}';
    });

    // print('${newDateTime.day}/${newDateTime.month}/${newDateTime.year}');
  }

  void submitForm() {
    print("in here");
    final isValid = _formKey.currentState.validate();
    if (!isValid || !_validBloodGroup || !_validGender) {
      return;
    }
    print("_selectedAllergies");
    _formKey.currentState.save();

    ///mapping data into firebase...
    Map<String, dynamic> data = {
      "f_name": _firstnameController.text,
      "l_name": _lastnameController.text,
      "gender": _selectedGender,
      "birthday": _birthday,
      "pincode": _pincodeController.text,
      "phone": _phoneController.text,
      "blood_group": _selectedBloodGroup,
      "allergies": _selectedAllergies,
      "comorbidities": _selectedComorbidities
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Patient Info");
    collectionReference.add(data);

    String userName =
        '${_firstnameController.text} ${_lastnameController.text}';
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileCreated(
                userName: userName,
              )),
    );
  }
}
