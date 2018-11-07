import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }



}

class HomeState extends State {



  @override
  Widget build(BuildContext context) {

    if (userID != null)
      return menuScreen();
    else
      return splashScreen();





  }

  Widget splashScreen() {
    var title = 'HKBU\nREACH';
    var content = '\nuniversity, teachers, \nclassmates and group mates.\n\n';
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: null,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 48.0, fontFamily:
              'Times New Roman'), textAlign: TextAlign.center,),
              Text(content, style: TextStyle(fontSize: 20.0, fontFamily:
              'Times New Roman'), textAlign: TextAlign.center,),
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),],),
                color: Colors.grey ,
                onPressed: () => signIn(context).then((success){
                  if (success) setState((){});
                }),
              ),

            ],
          ),
        )
    );
  }


  Widget menuScreen() {

    return Scaffold(
      appBar: AppBar(
        title: Text('REACH'),
        actions: <Widget>[
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Signout',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9.0, color: Colors.white),
                ),],),
            color: Colors.blue ,
              onPressed: (){signOut();setState((){});}
          ),

        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.notifications, size: 48.0, color: Colors.white,),


                Text('Notifications',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),

              ],
            ),
            color: Colors.blue ,
            onPressed:
                () => Navigator.pushNamed(context, '/notificationList'),
          ),

          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.people, size: 48.0, color: Colors.white,),


                Text('Group Formation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),

              ],
            ),
            color: Colors.lightBlueAccent ,
            onPressed:
                () => Navigator.pushNamed(context, '/notificationFormation'),
          ),

          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.forum, size: 48.0, color: Colors.white,),


                Text('Forum',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),

              ],
            ),
            color: Colors.indigoAccent,
            onPressed:    () => Navigator.pushNamed(context, '/notification1'),
          ),

          FlatButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.school, size: 48.0, color: Colors.white,),


                Text('About HKBU',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),

              ],
            ),
            color: Colors.lightBlue,
            onPressed:    () => Navigator.pushNamed(context, '/notificationBu'),
          ),



        ], // <Widget>[]
      ), // GridView.count
    ); // Scaffold
  } // end of the menuScreen() method




}