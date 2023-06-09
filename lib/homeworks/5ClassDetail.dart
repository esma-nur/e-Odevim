import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FiveClassDetailsPage extends StatefulWidget {
  @override
  _FiveClassDetailsPageState createState() => _FiveClassDetailsPageState();
}

class _FiveClassDetailsPageState extends State<FiveClassDetailsPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('5. Sınıf Ödevleri')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) => print(doc[''])));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Ödevler'),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('5. Sınıf Ödevleri')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
              children: snapshot.data.docs
                  .map((doc) => ListTile(
                      tileColor: Colors.purple[100],
                      contentPadding: EdgeInsets.all(2.0),
                      leading: Icon(Icons.assignment),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(doc['ders'] ?? ''),
                          Text(doc['sinif'] ?? '')
                        ],
                      ),
                      subtitle: Text(doc['odevDetayi'] ?? ''),
                      onTap: () {}))
                  .toList());
        });
  }
}
