import 'package:create_profile_app/Screens/components/custom_clipper.dart';
import 'package:create_profile_app/Screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetData extends StatefulWidget {
  List<String> comorbidities;
  String title;
  GetData({Key key, @required this.comorbidities, @required this.title}) : super(key: key);
  @override
  _GetDataState createState() => _GetDataState(comorbidities, title);
}

class _GetDataState extends State<GetData> {

  List<String> comorbidities;
  String title;
  _GetDataState(this.comorbidities, this.title);
  List<String> _selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context, _selectedList);
          },
        ),
        actions: [
          Container(
            width: 80,
            color: Colors.white,
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(30, 190, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 30, 30),
                    height: 50,
                    child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.search_sharp, color: Colors.black,),
                      ),
                    ),
                    decoration : BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],),
                    padding: new EdgeInsets.symmetric(horizontal: 16),

                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Please Choose Symptoms",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15,),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List<Widget>.generate(comorbidities.length, (int index)
                      {
                        return Chip(
                          label: Text(
                              comorbidities[index],
                            style: TextStyle(
                              color: _selectedList.contains(comorbidities[index]) ? Colors.white : Colors.black,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: _selectedList.contains(comorbidities[index]) ? Colors.blueAccent : Colors.white,
                          deleteIcon: _selectedList.contains(comorbidities[index]) ? Icon(Icons.remove_circle_outline_sharp) : Icon(Icons.add_circle_outline_sharp),
                          onDeleted: () {
                            setState(() {
                              _selectedList.contains(comorbidities[index]) ? _selectedList.remove(comorbidities[index]) : _selectedList.add(comorbidities[index]);

                            });
                          },
                        );
                      }),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 120,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)
                              )
                          ),
                        ),
                          onPressed: (){
                            Navigator.pop(context, _selectedList);
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),
                          ),
                      ),
                    ),
                  )
                ],
              ),

            ),
          ClipPath(
            clipper: BackgroundCustomClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width - 80,
              color: Colors.orangeAccent,
              padding: EdgeInsets.fromLTRB(20, 10, 50, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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
        ],
      ),
    );
  }



}
