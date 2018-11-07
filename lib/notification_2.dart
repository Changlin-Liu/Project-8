import 'global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Notification2Page extends StatefulWidget {
  @override createState() => Notification2State();
}
class Notification2State extends State {
  var images = [];
  var selectedForum = roles1.keys.first;
  var title = '';
  var content = '';

  void attach(source) {
    ImagePicker.pickImage(source: source).then((file){
      if (file != null)
        setState(() => images.add(file));
    });
  }


  @override
  Widget build(BuildContext context) {


    var items = <DropdownMenuItem>[];
    for (var k in roles1.keys) {
      var v = roles1[k];
      if (['teacher','student' ,'administrator'].contains(v))
        items.add(DropdownMenuItem(value: k, child: Text(k)));
    }
    var ddButton = DropdownButton(
      value: selectedForum,
      items: items,
      onChanged: (forum) => setState(() => selectedForum = forum),
    );

    var widgets = <Widget>[
      Text('Post to'),
      ddButton,
      TextField(
        decoration: InputDecoration(hintText: 'Title',),
        onChanged: (text) => setState(() => title = text),
      ),
      Divider(color: Colors.transparent,),
      TextField(
        decoration: InputDecoration(hintText: 'Content',),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (text) => setState(() => content = text),
      ),
    ];

    var width = MediaQuery.of(context).size.width - 120;

    for (var f in images) {
      widgets.add(Divider(color: Colors.transparent,));
      widgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(f, width: width),
              IconButton(icon: Icon(Icons.cancel), iconSize: 32.0,
                onPressed: () => setState(() => images.remove(f)),
              )
            ],
          )
      );
    }




    return Scaffold(
      appBar: AppBar(
        title: Text('Sharing'),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => attach(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () => attach(ImageSource.gallery),
          ),


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
    var ref = dbRef.child('forum/$selectedForum/notifications').push();
    ref.set({
      'key' : ref.key,
      'forum' : selectedForum,
      'title' : title,
      'content' : content,
      'createdAt' : DateTime.now().millisecondsSinceEpoch,
      'createdBy' : userID,
    });

    for (var i=0; i < images.length; i++) {
      var fRef = storageRef.child(ref.key + '/$i');
      var task = fRef.putFile(images[i]);
      task.future.then((snapshot) =>
          ref.child('images/$i').set(snapshot.downloadUrl.toString())
      );
    }


    Navigator.pop(context);
  }



}