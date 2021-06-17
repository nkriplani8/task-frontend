import 'package:create_profile_app/Screens/components/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfileCreated extends StatelessWidget {
  final String userName;
  const ProfileCreated({key, @required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            ClipPath(
              clipper: BackgroundCustomClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width - 50,
                color: Colors.blueAccent,
                padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
              ),
            ),
            Positioned(
              top: 180,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 180,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Card(
                        elevation: 5,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.network(
                                "https://image.flaticon.com/icons/png/512/1160/1160040.png",
                                width: 80,
                                fit: BoxFit.fill
                            ),
                          ),
                          radius: 70,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[600]
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                                color: Colors.grey[600]
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.all(32),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            'Lets get started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
