import 'global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class NotificationAddPage extends StatefulWidget {
  @override createState() => NotificationAddState();
}
class NotificationAddState extends State {
  var images = [];
  var selectedGroup = roles.keys.first;
  var title = '';
  var content = '';




  @override
  Widget build(BuildContext context) {
    var items = <DropdownMenuItem>[];
    for (var k in roles.keys) {
      var v = roles[k];
      if (['teacher', 'administrator'].contains(v))
        items.add(DropdownMenuItem(value: k, child: Text(k)));
    }
    var ddButton = DropdownButton(
      value: selectedGroup,
      items: items,
      onChanged: (course) => setState(() => selectedGroup = course),
    );

    var widgets = <Widget>[
      Text('Post to'),
      ddButton,
      TextField(
        decoration: InputDecoration(hintText: 'Group xx',),
        onChanged: (text) => setState(() => title = text),
      ),
      Divider(color: Colors.transparent,),
      TextField(
        decoration: InputDecoration(hintText: 'Members',),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) => setState(() => content = text),
      ),

    ];

    var width = MediaQuery
        .of(context)
        .size
        .width - 120;




    return Scaffold(
      appBar: AppBar(
        title: Text('Group Formation'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.send), onPressed: () => post(),),
          ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[Column(children: widgets)],
      ),
    );
  }

  void post() {
    var ref = dbRef.child('formation/$selectedGroup/notifications').push();
    ref.set({
      'key': ref.key,
      'group': selectedGroup,
      'title': title,
      'content': content,
      'createdAt': DateTime
          .now()
          .millisecondsSinceEpoch,
      'createdBy': userID,
    });

    for (var i = 0; i < images.length; i++) {
      var fRef = storageRef.child(ref.key + '/$i');
      var task = fRef.putFile(images[i]);
      task.future.then((snapshot) =>
          ref.child('images/$i').set(snapshot.downloadUrl.toString())
      );
    }


    Navigator.pop(context);
  }
}