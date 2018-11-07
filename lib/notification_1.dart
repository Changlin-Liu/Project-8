import 'package:flutter/material.dart';
import 'global.dart';
import 'package:intl/intl.dart';
class Notification1Page extends StatefulWidget {

  @override createState() => Notification1State();
}
class Notification1State extends State {

  var canCreate = false;
  var nMap = {};
  @override
  void initState() {
    super.initState();
    getRoles().then((_) => getNotification1());
  }

  void getNotification1() {
    Set roleSet, forumSet;
    if (roles1 != null) {
      roleSet = roles1.values.toSet();
      forumSet = roles1.keys.toSet();
    } else {
      roleSet = Set();
      forumSet = Set();
    }
    forumSet.add('renting');
    canCreate = roleSet.contains('student')
        || roleSet.contains('administrator')
        || roleSet.contains('teacher');
    for (var f in forumSet) {
      var nRef = dbRef.child('forum/$f/notifications');
      nRef.onValue.listen((event) {
        if (event.snapshot.value == null) nMap.remove(f);
        else nMap[f] = (event.snapshot.value as Map).values.toList();
        if (mounted) setState(() {});
      });
    }
  }



  @override Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    var data = List();
    for (List f in nMap.values)
      data.addAll(f);
    data.sort((a, b) => b['createdAt'] - a['createdAt']);
// for (var i = 1; i <= 20; i++) {
// var item = 'Notification $i';
    for (var i=0; i<data.length; i++){
      var item = data[i];
      var title = item['title'];
      var forum = item['forum'];
      var datetime = DateTime.fromMillisecondsSinceEpoch(item['createdAt']);
      var createdAt = DateFormat('EEE, MMMM d, y H:m:s',
          'en_US').format(datetime);

      widgetList.add(
          ListTile(
              leading: Icon(Icons.forum,color: Colors.red),
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
              trailing: Text(forum.replaceAll(' ', '\n'),
                textAlign: TextAlign.right,),
              onTap: () {
                notificationSelection = item;
                Navigator.pushNamed(context, '/notification3');
              }
          )
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Forum'),),
      body: ListView(
        children: widgetList,
        padding: EdgeInsets.all(20.0),
      ),
      floatingActionButton: (canCreate)?
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context, '/notification2'),
      ) : null,
    );
  }
}