// ignore_for_file: non_constant_identifier_names, deprecated_member_use, duplicate_ignore, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/responsive.dart';

var sp_generatedIndustryFromList = StateProvider((ref) {
  return [];
});

var sp_industry_url = StateProvider((ref) {
  return "";
});

var sp_sector_url = StateProvider((ref) {
  return "";
});

// ignore: must_be_immutable
class Industry extends ConsumerWidget {
  List<Map> generatedIndustryFromList = [];

  Industry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndustrySelect()),
        );
      },
      child: SizedBox(
        width: 180,
        height: 120,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage("assets/images/Industry.png"),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class IndustrySelect extends ConsumerWidget {
  List Industry = [
    "Oil & Gas Integrated",
    "Beverages Wineries & Distilleries",
    "Internet Retail",
    "Specialty Industrial Machinery",
    "Restaurants",
    "REIT Mortgage",
    "Specialty Retail",
    "Insurance Diversified",
    "Specialty Business Services",
    "Copper",
    "Electrical Equipment & Parts",
    "Apparel Manufacturing",
    "Furnishings, Fixtures & Appliances",
    "Oil & Gas Drilling",
    "Utilities Independent Power Producers",
    "Conglomerates",
    "Metal Fabrication",
    "Uranium",
    "Security & Protection Services",
    "Business Services",
    "Electric Utilities",
    "Computer Hardware",
    "Discount Stores",
    "Banks Diversified",
    "Diagnostics & Research",
    "Medical Instruments & Supplies",
    "Specialty Chemicals",
    "Consulting Services",
    "Communication Equipment",
    "Utilities Regulated Gas",
    "REIT Office",
    "REIT Residential",
    "Department Stores",
    "Waste Management",
    "Farm & Heavy Construction Machinery",
    "Semiconductor Equipment & Materials",
    "Medical Care Facilities",
    "Lumber & Wood Production",
    "Recreational Vehicles",
    "Airports & Air Services",
    "Coking Coal",
    "Auto Parts",
    "Paper & Paper Products",
    "Utilities Regulated Electric",
    "Resorts & Casinos",
    "Utilities Renewable",
    "Software Infrastructure",
    "Closed-End Fund - Foreign",
    "Utilities Regulated Water",
    "Rental & Leasing Services",
    "Beverages Non-Alcoholic",
    "Healthcare Plans",
    "Insurance Specialty",
    "Confectioners",
    "Education & Training Services",
    "Packaging & Containers",
    "Consumer Packaged Goods",
    "Industrial Metals & Minerals",
    "General Contractors",
    "Asset Management",
    "Utilities Diversified",
    "Insurance Life",
    "Drug Manufacturers Specialty & Generic",
    "Telecom Services",
    "Banks Regional",
    "Auto & Truck Dealerships",
    "Building Materials",
    "Insurance Brokers",
    "Electronic Components",
    "Entertainment",
    "Railroads",
    "Farm Products",
    "Gambling",
    "Agricultural Inputs",
    "Drug Manufacturers General",
    "Insurance",
    "Marine Shipping",
    "Closed-End Fund - Equity",
    "Utilities Regulated",
    "N/A",
    "Financial Conglomerates",
    "Textile Manufacturing",
    "Building Materials Wholesale",
    "Infrastructure Operations",
    "Software Application",
    "Insurance Property & Casualty",
    "Oil & Gas Midstream",
    "Financial Data & Stock Exchanges",
    "Oil & Gas Refining & Marketing",
    "Oil & Gas E&P",
    "Biotechnology",
    "Health Information Services",
    "Auto Manufacturers",
    "Apparel Retail",
    "Electronic Gaming & Multimedia",
    "Steel",
    "Beverages Brewers",
    "Broadcasting",
    "Thermal Coal",
    "Tobacco",
    "Tools & Accessories",
    "Insurance Reinsurance",
    "CATV Systems",
    "Independent Oil & Gas",
    "Communication Services",
    "Real Estate Services",
    "Gold",
    "Medical Distribution",
    "Food Distribution",
    "Trucking",
    "Capital Markets",
    "Information Technology Services",
    "Industrial Distribution",
    "Credit Services",
    "Pharmaceutical Retailers",
    "Lodging",
    "Luxury Goods",
    "Electronics & Computer Distribution",
    "Advertising Agencies",
    "Silver",
    "Business Equipment & Supplies",
    "Home Improvement Retail",
    "Footwear & Accessories",
    "Insurance Specialty",
    "Diversified Communication Services",
    "Technical & System Software",
    "Broadcasting - TV",
    "Shell Companies",
    "Other Industrial Metals & Mining",
    "Oil & Gas Equipment & Services",
    "Internet Content & Information",
    "REIT Specialty",
    "Packaged Foods",
    "REIT Diversified",
    "Residential Construction",
    "Medical Devices",
    "Building Products & Equipment",
    "REIT Retail",
    "REIT Industrial",
    "Staffing & Employment Services",
    "Travel Services",
    "Engineering & Construction",
    "Personal Services",
    "Pollution & Treatment Controls",
    "Leisure",
    "Real Estate Diversified",
    "Real Estate Development",
    "REIT Hotel & Motel",
    "Mortgage Finance",
    "Application Software",
    "REIT - Diversified",
    "General Building Materials",
    "Aerospace & Defense",
    "Grocery Stores",
    "Semiconductors",
    "REIT Healthcare Facilities",
    "Scientific & Technical Instruments",
    "Airlines",
    "Chemicals",
    "Integrated Freight & Logistics",
    "Household & Personal Products",
    "Solar",
    "Publishing",
    "Consumer Electronics",
    "Other Precious Metals & Mining",
    "Aluminum",
    "Banks",
    "Marketing Services",
    "Utilities Diversified",
  ];

  IndustrySelect({Key? key}) : super(key: key);

  checkDevice(context) {
    if (Responsive.isDesktop(context) == true) {
      return 7;
    }
    if (Responsive.isTablet(context) == true) {
      return 4;
    }
    if (Responsive.isMobile(context) == true) {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var generatedIndustryFromList = ref.watch(sp_generatedIndustryFromList);

    if (generatedIndustryFromList.toString() == "[]") {
      generatedIndustryFromList = List.generate(
          Industry.length,
          (index) => {
                'id': index,
                'name': Industry[index].toString(),
                'isSelected': false,
                Color: Colors.black,
              });
    }

    //print(generatedCountrieFromList.toString());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Industry auswählen'),
      ),
      body: GridView.builder(
        itemCount: 169,
        itemBuilder: (ctx, index) {
          return Card(
              key: ValueKey(generatedIndustryFromList[index]['name']),
              margin: const EdgeInsets.all(11),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: generatedIndustryFromList[index][Color],
              child: ListTile(
                onTap: () {
                  generatedIndustryFromList[index]['isSelected'] =
                      !generatedIndustryFromList[index]['isSelected'];

                  if (generatedIndustryFromList[index]['isSelected'] == true) {
                    generatedIndustryFromList[index][Color] = Colors.grey;
                    // ignore: deprecated_member_use
                    ref.watch(sp_industry_url.state).state +=
                        // ignore: prefer_interpolation_to_compose_strings
                        ":" + generatedIndustryFromList[index]['name'];
                  }
                  if (generatedIndustryFromList[index]['isSelected'] == false) {
                    generatedIndustryFromList[index][Color] = Colors.black;
                    // ignore: deprecated_member_use
                    ref.watch(sp_industry_url.state).state = ref
                        // ignore: deprecated_member_use
                        .watch(sp_industry_url.state)
                        .state
                        .replaceAll(
                            // ignore: prefer_interpolation_to_compose_strings
                            ":" + generatedIndustryFromList[index]['name'],
                            '');
                  }

                  // ignore: deprecated_member_use
                  ref.refresh(sp_generatedIndustryFromList.state).state =
                      generatedIndustryFromList;

                  print(ref.watch(sp_industry_url.state).state);
                },
                leading: ClipRRect(
                  //borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20),
                    child: Image.asset(
                      "assets/images/${index + 39}.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  generatedIndustryFromList[index]['name'],
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: checkDevice(context),
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 70,
        ),
      ),
    );
  }
}
