import 'package:flutter/material.dart';
import 'global.dart';
import 'package:intl/intl.dart';
class NotificationFormationPage extends StatefulWidget {
  @override createState() => NotificationFormationState();
}
class NotificationFormationState extends State {


  var canCreate = false;
  var nMap = {};
  @override
  void initState() {
    super.initState();
    getRoles().then((_) => getNotificationFormation());
  }

  void getNotificationFormation() {
    Set roleSet, groupSet;
    if (roles != null) {
      roleSet = roles.values.toSet();
      groupSet = roles.keys.toSet();
    } else {
      roleSet = Set();
      groupSet = Set();
    }
    groupSet.add('Group 1');
    canCreate = roleSet.contains('teacher')
        || roleSet.contains('administrator');
    for (var g in groupSet) {
      var nRef = dbRef.child('formation/$g/notifications');
      nRef.onValue.listen((event) {
        if (event.snapshot.value == null) nMap.remove(g);
        else nMap[g] = (event.snapshot.value as Map).values.toList();
        if (mounted) setState(() {});
      });
    }
  }



  @override Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    var data = List();
    for (List g in nMap.values)
      data.addAll(g);
    data.sort((a, b) => b['createdAt'] - a['createdAt']);
// for (var i = 1; i <= 20; i++) {
// var item = 'Notification $i';
    for (var i=0; i<data.length; i++){
      var item = data[i];
      var title = item['title'];
      var group = item['group'];
      var datetime = DateTime.fromMillisecondsSinceEpoch(item['createdAt']);
      var createdAt = DateFormat('EEE, MMMM d, y H:m:s',
          'en_US').format(datetime);

      widgetList.add(
          ListTile(
              leading: Icon(Icons.group, color: Colors.greenAccent),
// title: Text('Item $i'),
// trailing: Icon(Icons.face),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(createdAt,
                    style: TextStyle(fontSize: 10.0, color: Colors.blueGrey),),
                ],
              ),
              trailing: Text(group.replaceAll(' ', '\n'),
                textAlign: TextAlign.right,),
              onTap: () {
                notificationSelection = item;
                Navigator.pushNamed(context, '/notificationGroup');
              }
          )
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Group Formation'),),
      body: ListView(
        children: widgetList,
        padding: EdgeInsets.all(20.0),
      ),
      floatingActionButton: (canCreate)?
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, '/notificationAdd'),
      ) : null,
    );
  }
}