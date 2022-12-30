import 'package:aktientool/webpage/components/carousel.dart';
import 'package:aktientool/webpage/components/cv_section.dart';
import 'package:aktientool/webpage/components/footer.dart';
import 'package:flutter/material.dart';

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Carousel(),
          const SizedBox(
            height: 40.0,
          ),
          CvSection(),
          //IosAppAd(),
          /*const SizedBox(
            height: 70.0,
          ),
          WebsiteAd(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: PortfolioStats(),
          ),
          const SizedBox(
            height: 50.0,
          ),
          EducationSection(),
          const SizedBox(
            height: 50.0,
          ),
          SkillSection(),
          const SizedBox(
            height: 50.0,
          ),
          Sponsors(),
          const SizedBox(
            height: 50.0,
          ),
          TestimonialWidget(), */
          Footer(),
        ],
      ),
    );
  }
}
