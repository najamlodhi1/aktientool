import 'package:flutter/material.dart';

import '../datenschutz/datenschutzerklaerung.dart';
import '../datenschutz/impressum.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.black,
      //height: 100.0,
      child: Center(
        child: Wrap(
          children: [
            Center(
              child: SizedBox(
                width: 1000,
                child: Center(
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Datenschutzerklaerung(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Datenschutz"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Impressum(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Impressum"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                width: 1000,
                child: Center(
                  child: Text(
                    """Provisionshinweis: Die Nutzung des Brokers ist für Sie vollkommen kostenlos und unverbindlich. Wenn Sie die Seite von Scallable Capital aufrufen und ein Depot eröffnen, erhalten wir von diesem Anbieter eine kleine Vergütung. Die Vergütung hat keinerlei Einfluss auf die Konditionen Ihres Depots. Gleiches gilt beim Aufrufen des Amazons Links, wenn Sie einen Kauf tätigen. Affiliatelinks wurden mit einem * gekennzeichnet.""",
                    style: TextStyle(
                      color: Color.fromARGB(255, 80, 79, 79),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
