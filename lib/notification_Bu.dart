import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'global.dart';

class NotificationBuPage extends StatefulWidget {
  @override createState() => NotificationBuState();
}


class NotificationBuState extends State {

  var imgBytes = null;


  @override
  Widget build(BuildContext context) {
    var childWidgets = <Widget>[];

    childWidgets.add(Text(' '));


    if (imgBytes != null)
      childWidgets.add(Image.memory(imgBytes,
          width: MediaQuery.of(context).size.width - 50));




    var title = 'Hong Kong Baptist University';
    var content = '\n       In 1956, Hong Kong Baptist College was founded by the Baptist Convention of Hong Kong as a post-secondary college committed to the provision of whole person education. In 1983, Hong Kong Baptist College became a fully-funded public tertiary institution. It gained university status in 1994 and was renamed Hong Kong Baptist University (HKBU).\n\n        Today HKBU encompasses eight Faculties/Schools offering a range of undergraduate programmes, associate degree and higher diploma programmes as well as taught postgraduate programmes and research postgraduate programmes leading to the award of master and doctoral degrees.  It prides itself on its dual focus on teaching and research and encourages service to society among its staff and students.  Over the years, HKBU has remained committed to academic excellence and the development of the whole person, and has gained a reputation as one of Asia’s finest institutions of higher learning.';
    var content2 = 'Contact us\n\nGeneral Enquiries \nTel: (852) 3411 7400 \nFax: (852) 2338 7644 \n\nAddress: \nHong Kong Baptist University \nKowloon Tong Kowloon \nHong Kong';
    return Scaffold(
      appBar: AppBar(
        title: Text('About HKBU'),),

      body:
      Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,


          children: <Widget>[

            Text(title, style: TextStyle(fontSize: 24.0, fontFamily:
            'Times New Roman'), textAlign: TextAlign.center,),
            Text(content, style: TextStyle(fontSize: 14.0, fontFamily:
            'Times New Roman'), textAlign: TextAlign.left,),




            Text('', style: TextStyle(fontSize: 24.0, fontFamily:
            'Times New Roman'), textAlign: TextAlign.center,),

            Row(
              children: childWidgets,
            ),

            Text('', style: TextStyle(fontSize: 24.0, fontFamily:
            'Times New Roman'), textAlign: TextAlign.center,),

            Text(content2, style: TextStyle(fontSize: 14.0, fontFamily:
            'Times New Roman'), textAlign: TextAlign.left,),


          ],
        ),
      ),
    );
  }






  @override void initState() {
    super.initState();
    var url1 = 'http://www.junsun.com.tw/images/application/HKBU.jpg';
    http.get(url1).then((response) {
      print('download complete!');
      setState(() => imgBytes = response.bodyBytes);
    });}







}
