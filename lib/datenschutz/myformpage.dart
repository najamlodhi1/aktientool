import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants/responsive.dart';
import '../webpage/footer1.dart';

class MyFormPage extends StatelessWidget {
  MyFormPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  double sendRating = 0.0;

  CollectionReference feedback =
      FirebaseFirestore.instance.collection('feedback');

  Future<void> addFeedback(
      String email, String title, String feedbacks, double rating) {
    return feedback
        .doc(DateTime.now().toString())
        .set({
          'email': email,
          'title': title,
          'feedback': feedbacks,
          'rating': rating,
          'created': DateTime.now()
        })
        .then((value) => print("feedback Added"))
        .catchError((error) => print("feedback couldn't be added."));
  }

  succesMessage(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          children: const [
            Text("Ihre Nachricht wurde erfolgreich übermittelt"),
          ],
        ),
        //content: const Icon(Icons.done, size: 50),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
              //Navigator.of(context).pop();
            },
            child: const Icon(Icons.done,
                size: 50, color: Color.fromARGB(255, 105, 240, 179)),
          ),
        ],
      ),
    );
  }

  Widget rating(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Sind Sie mit dem AktienTool zufrieden?\n',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          RatingBar(
            initialRating: 0,
            minRating: 0,
            maxRating: 5,
            allowHalfRating: true,
            itemSize: ScreenHelper.isDesktop(context) ? 70 : 50,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: kPrimaryColor),
              half: const Icon(Icons.star_half, color: kPrimaryColor),
              empty: const Icon(Icons.star_border, color: kPrimaryColor),
            ),
            onRatingUpdate: (rating) {
              // Rating is updated
              log('rating update to: $rating');
              sendRating = rating;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController nachrichtController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Feedback",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: [
                    rating(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                          width: 0,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(255, 150, 150, 150),
                                hintText: 'Email zur Kontaktaufnahme'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Bitte E-Mail eingeben';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                filled: true, //<-- SEE HERE
                                fillColor: Color.fromARGB(255, 150, 150, 150),
                                hintText: 'Titel'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Bitte den Titel eingeben';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 80),
                        TextFormField(
                          controller: nachrichtController,
                          maxLines: 10,
                          maxLength: 2000,
                          decoration: const InputDecoration(
                              filled: true, //<-- SEE HERE
                              fillColor: Color.fromARGB(255, 150, 150, 150),
                              hintText:
                                  'Was können wir besser machen?\nHaben Sie neue Ideen, Vorschläge oder Fehler entdeckt?\n',
                              hintStyle: TextStyle(fontSize: 20)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte Feedback schreiben';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                      onPressed: () {
                        // Wenn alle Validatoren der Felder des Formulars gültig sind.
                        if (_formKey.currentState!.validate()) {
                          print(
                              "Formular ist gültig und kann verarbeitet werden");
                          addFeedback(
                              emailController.text.toString(),
                              titleController.text.toString(),
                              nachrichtController.text.toString(),
                              sendRating);
                          print("erfolgreich gespeichert");
                          succesMessage(context);
                        } else {
                          print("ungültig");

                          if (kDebugMode) {
                            print("Formular ist nicht gültig");
                          }
                        }
                      },
                      child: const Icon(
                        Icons.local_post_office_outlined,
                        size: 70,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                    ),
                    const SizedBox(height: 100),
                    const FooterWidget()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
