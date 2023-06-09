import 'package:flutter/material.dart';
import 'package:ogr_takip/core/firebaseOperations.dart';
import 'package:ogr_takip/main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  
  final _formKey = GlobalKey<FormState>();
  final kayitEmailController = TextEditingController();
  final kayitParolaController = TextEditingController();
  final isimController = TextEditingController();
  final parolaTekrarController = TextEditingController();
  FirebaseService authService = FirebaseService();
  bool hidePass = true;
  String dropdownValue = 'Öğrenci';
  String forgotPassword = 'Üye Değil Misiniz? Hemen Kayıt Olun...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /////////////////////  ARKADAKİ RENK VE ÖNPLANDAKİ BEYAZ CONTAINER  ////////////////////////
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SingleChildScrollView(
                ///////////////////////////////     CONTAINER ÜZERİNDEKİ KOMPONENTLER     /////////////////////////////////
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 15),
                          child: Text('Üye Değil Misiniz? Hemen Kayıt Olun...',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 30, right: 30),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Kullanıcı Adı *',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: isimController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Kullanıcı adı Boş bırakılamaz!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'E-mail *',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: kayitEmailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Lütfen geçerli mail adresi giriniz!';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: TextFormField(
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                hintText: 'Parola *',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: kayitParolaController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Parola boş bırakılamaz!';
                              } else if (value.length < 6) {
                                return 'Parolanız en az 6 karakter uzunluğunda olmalıdır!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: TextFormField(
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                hintText: 'Parola Tekrar *',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: parolaTekrarController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Parola boş bırakılamaz!';
                              } else if (value.length < 6) {
                                return 'Parolanız en az 6 karakter uzunluğunda olmalıdır!';
                              } else if (kayitParolaController.text != value) {
                                return 'Parolalar eşleşmiyor, lütfen kontrol ediniz.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: Row(
                            children: [
                              Text('Statü Seçiniz : '),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                              ),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.blueAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Öğrenci',
                                  'Öğretmen'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 20),
                            child: ListTile(
                              leading: Icon(Icons.remove_red_eye),
                              title: Text('Şifreyi Göster'),
                              onTap: () {
                                setState(() {
                                  hidePass = false;
                                });
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 130, right: 130),
                          child: RaisedButton(
                            color: Colors.blue[500],
                            child: Text('Kayıt ol'),
                            onPressed: () {
                              validateForm();
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ////////////////////////////   FIREBASE AUTH KAYIT İŞLEMLERİ /////////////////////////////
  Future<void> validateForm() async {
    var formState = _formKey.currentState;

    if (formState.validate()) {
      formState.reset();

      if (kayitParolaController.text.trim() ==
          parolaTekrarController.text.trim()) {
        var catchError = authService
            .createUser(isimController.text, kayitEmailController.text,
                kayitParolaController.text)
            .catchError((hata) => debugPrint('HATA: ' + hata.toString()));

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
    }
  }
}
