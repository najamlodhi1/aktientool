// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:js' as js;

import 'constants/responsive.dart';

class FilterArea extends StatefulWidget {
  const FilterArea({super.key});

  @override
  State<FilterArea> createState() => _FilterAreaState();
}

class _FilterAreaState extends State<FilterArea> {
  List listquality = [
    "Warren Buffett,Hagstrom Screen,1,https://amzn.to/3AyNoYv",
    "Ronald Muhlenkamp,ROE Screen,2,url,https://amzn.to/3AyvwwK",
    "Joseph Piotroski,High F-Score Screen,3,https://amzn.to/3oSgvDy",
  ];

  List listgrowth = [
    "Jim Slater,ZULU Screen,4,url",
    "William O'Neil,CAN-SLIM Screen,5,url",
    "Martin Zweig,Growth Screen,6,url",
    "T Rowe Price,T Rowe Price Screen,7,url",
    "Philip Fisher,Growth Screen,8,url",
    "Peter Lynch,Growth Screen,9,url",
  ];

  List listvalue = [
    "Benjamin Graham,Enterprising Screen,10,url",
    "Ludwig Chincarini,Neglected Firms Screen,11,url",
    "Bill Miller,Contrarian Value Screen,12,url",
    "John Templeton,Bargain Screen,13,url",
  ];

  List shapeList = [
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect",
    "unselect"
  ];

  var addThis = ["Country|=|AR", "Marketcap|>=|-200"];
  var addThis2 = ["Country|=|US", "Ebit Wachstum|<=|3"];

  var searchVisible = false;
  var addVisible = false;

  List<String> operators = [">=", "=", "<="];
  List<String> operatorsIs = ["=", "!="];

  List<String> country = [
    "AR",
    "CH",
    "CN",
    "IE",
    "NL",
    "CR",
    "GR",
    "PE",
    "IM",
    "BS",
    "CL",
    "FI",
    "HK",
    "MC",
    "ID",
    "SE",
    "LU",
    "CO",
    "ZA",
    "AE",
    "KZ",
    "MU",
    "ES",
    "TW",
    "UY",
    "KY",
    "NO",
    "PA",
    "MY",
    "JO",
    "JP",
    "FR",
    "SG",
    "DK",
    "BM",
    "DE",
    "MX",
    "PR",
    "JE",
    "CY",
    "US",
    "IT",
    "IL",
    "RU",
    "CK",
    "BR",
    "GB",
    "IN",
    "AU",
    "NZ",
    "TR",
    "TH",
    "KR",
    "VG",
    "CA",
    "BE",
    "IS",
    "PH",
    "GI",
    "GG",
  ];

  List<String> valueList = [
    "Marketcap",
    "Country",
    "Industry",
    "EV-> Enterprise",
    "KGV-> Kurs Gewinn Verhältnis",
    "KGV-> Kurs Umsatz Verhältnis",
    "EV/Sales-> Enterprise Value / Sales Verhältnis",
    "KBV-> Kurs Buchwert Verhältnis",
    "PEG-> Price Earnings Growth",
    "EV/FCF-> Enterprise Value/Free Cashflow Verhältnis",
    "Ebit Marge",
    "Brutto Marge",
    "Free Cashflow Marge",
    "Umsatzwachstum",
    "Ebit Wachstum",
    "Eigenkapitalrendite",
    "Eigenkapitalquote",
    "Verschuldungsgrad",
    "Dividendenrendite",
    "Ausschüttungsquote",
    "Dividendenwachstum",
  ];

  List<String> industry = [
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

  List<ValuesModel> values = [
    // ValuesModel(
    //   controller: TextEditingController(),
    //   operator: null,
    //   value: null,
    //   result: null,
    // )
  ];

  String? filterValue;

  @override
  void initState() {
    super.initState();
  }

  loadCardQuality(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Quality",
            const Color.fromARGB(255, 132, 76, 175))
    ]);
  }

  loadCardGrowth(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Growth", Colors.blue)
    ]);
  }

  loadCardValue(var list) {
    return Wrap(children: [
      for (var i = 0; i < list.length; i++)
        createCard(list[i].toString(), "Value", Colors.red)
    ]);
  }

  createCard(String txt, String whichtype, var col) {
    List<String> result = txt.split(',');

    print(MediaQuery.of(context).size.width / 1.2);
    print(MediaQuery.of(context).size.width / 5.0);

    return SizedBox(
      height: 120,
      child: AspectRatio(
        aspectRatio: ScreenHelper.isMobile(context) ? (16 / 7) : (20 / 7),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            color: col,
            shape: (shapeList[int.parse(result[2])] == "select")
                ? const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 3))
                : null,
            elevation: 3,
            child: InkWell(
              onTap: () => setState(() {
                if (shapeList[int.parse(result[2])] == "select") {
                  shapeList[int.parse(result[2])] = "unselect";
                } else if (shapeList[int.parse(result[2])] == "unselect") {
                  shapeList = [
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect",
                    "unselect"
                  ];
                  shapeList[int.parse(result[2])] = "select";
                }
              }),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/${result[0]}.png'), // No matter how big it is, it won't overflow
                    ),
                    subtitle: Text(result[0]),
                    title: Text(result[1]),
                    trailing: IconButton(
                      icon: const FaIcon(FontAwesomeIcons.amazon),
                      color: Colors.white,
                      iconSize: 40,
                      onPressed: () async {
                        js.context.callMethod('open', [result[3]]);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(onPressed: null, child: Text(whichtype)),
                      const Spacer(),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text(
                          'READ STRATEGY',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //This is to print text after filtering
  getFilterValue() {
    setState(
      () {
        filterValue = "";
        for (int i = 0; i < values.length; i++) {
          if (isCountrySektorIndustrie(values[i].value)) {
            filterValue =
                "${filterValue!} ${values[i].value} ${values[i].operator} ${values[i].result},";
          } else {
            filterValue =
                "${filterValue!} ${values[i].value} ${values[i].operator} ${values[i].controller!.text.isNotEmpty ? values[i].controller!.text : 'null'},";
          }
        }
      },
    );
    return filterValue.toString();
  }

  Widget filterValueDropdown({String? value, Function(String?)? onChanged}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, //<-- SEE HERE
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        key: const Key("valueList"),
        isDense: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: valueList.map<DropdownMenuItem<String>>((String e) {
          return DropdownMenuItem<String>(value: e, child: Text(e));
        }).toList(),
      ),
    );
  }

  Widget operatorDropdown({String? value, Function(String?)? onChanged}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, //<-- SEE HERE
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        key: const Key("operators"),
        isDense: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: operators.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget operatorIsDropdown({String? value, Function(String?)? onChanged}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, //<-- SEE HERE
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        key: const Key("operatorsIs"),
        isDense: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: operatorsIs.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget countryDropdown({String? value, Function(String?)? onChanged}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, //<-- SEE HERE
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        key: const Key("Country"),
        isDense: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: country.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget industryDropdown({String? value, Function(String?)? onChanged}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, //<-- SEE HERE
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        key: const Key("Industry"),
        isDense: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: industry.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  refreshFilterValue() {
    if (getFilterValue().contains("null")) {
      searchVisible = false;
      addVisible = false;
    } else {
      searchVisible = true;
      addVisible = true;
    }
  }

  isCountrySektorIndustrie(String? currValue) {
    bool isCountrySektorIndustrie = false;

    try {
      if (currValue == "Country" ||
          currValue == "Sektor" ||
          currValue == "Industry") {
        isCountrySektorIndustrie = true;
      }
    } catch (err) {
      print(err);
    }

    return isCountrySektorIndustrie;
  }

  Widget filterWidget() {
    return GestureDetector(
      onTap: () {
        refreshFilterValue();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: values.length,
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Wrap(
                        children: [
                          // Expanded(child: test()),
                          filterValueDropdown(
                              value: values[i].value,
                              onChanged: (c) {
                                bool arg1 =
                                    isCountrySektorIndustrie(values[i].value);
                                bool arg2 = isCountrySektorIndustrie(c);
                                if (arg1 != arg2) {
                                  setState(() {
                                    values[i].value = c;
                                    values[i].operator = null;
                                  });
                                } else {
                                  setState(() {
                                    values[i].value = c;
                                  });
                                }
                                refreshFilterValue();
                              }),

                          const SizedBox(width: 10),

                          if (isCountrySektorIndustrie(values[i].value)) ...[
                            operatorIsDropdown(
                                value: values[i].operator,
                                onChanged: (c) {
                                  setState(() {
                                    values[i].operator = c;
                                  });
                                  refreshFilterValue();
                                }),
                          ] else ...[
                            operatorDropdown(
                                value: values[i].operator,
                                onChanged: (c) {
                                  setState(() {
                                    values[i].operator = c;
                                  });
                                  refreshFilterValue();
                                }),
                          ],

                          const SizedBox(width: 10),

                          //Text(values[i].value.toString()),
                          if (values[i].value == "Country") ...[
                            countryDropdown(
                                value: values[i].result,
                                onChanged: (c) {
                                  setState(() {
                                    values[i].result = c.toString();
                                  });
                                  refreshFilterValue();
                                }),
                          ] else if (values[i].value == "Industry") ...[
                            industryDropdown(
                                value: values[i].result,
                                onChanged: (c) {
                                  setState(() {
                                    values[i].result = c.toString();
                                  });
                                  refreshFilterValue();
                                }),
                          ] else ...[
                            Container(
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Colors.white, //<-- SEE HERE
                              ),
                              child: TextFormField(
                                // keyboardType: TextInputType.number,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                                controller: values[i].controller,
                                onChanged: (value) {
                                  refreshFilterValue();
                                },
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple.shade300),
                                    ),
                                    labelStyle: const TextStyle(
                                        color: Colors.deepPurple)),
                              ),
                            ),
                          ],

                          GestureDetector(
                            onTap: () {
                              if (values.length > 1) {
                                setState(() {
                                  values.removeAt(i);
                                });
                              } else {
                                setState(() {
                                  values.removeAt(i);
                                  // values.add(
                                  //   ValuesModel(
                                  //     value: null,
                                  //     operator: null,
                                  //     controller: TextEditingController(),
                                  //   ),
                                  // );
                                });
                              }

                              refreshFilterValue();
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.grey[400]!,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text("X",
                                    style: TextStyle(
                                        color: Colors.grey[300],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (values.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: addVisible,
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () {
                            setState(() {
                              values.add(ValuesModel(
                                  value: null,
                                  operator: null,
                                  controller: TextEditingController()));
                            });
                            refreshFilterValue();
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Visibility(
                      visible: searchVisible,
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () {
                              getFilterValue();
                            },
                            child: const Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            //if (values.length != 1) {
                            setState(() {
                              values = [];
                              // values.add(
                              //   ValuesModel(
                              //     value: null,
                              //     operator: null,
                              //     controller: TextEditingController(),
                              //   ),
                              // );
                            });

                            refreshFilterValue();
                            //}
                          },
                          child: const Text("DELETE ALL")),
                    ),
                    const SizedBox(
                      width: 35,
                    )
                  ],
                ),
              if (filterValue != null)
                Row(
                  children: [
                    Text(filterValue.toString()),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            const Align(
              alignment: FractionalOffset.topLeft,
              child: Text(
                "  Invest like a GURU",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              //margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 110.0,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  loadCardQuality(listquality),
                  loadCardGrowth(listgrowth),
                  loadCardValue(listvalue),
                ],
              ),
            ),
            const Text(
              " ",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: [
                  const Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      "  Or select MANUAL",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (values.isEmpty)
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            //if (values.length != 1) {

                            setState(() {
                              //Remove all
                              // values.removeRange(0, values.length);
                              // addThis = ["Country|is|Germany", "Marketcap|>=|-200"];
                              values.add(
                                ValuesModel(
                                  value: "Country",
                                  operator: "=",
                                  result: "TR",
                                  controller: TextEditingController(),
                                ),
                              );
                              // values.add(
                              //   ValuesModel(
                              //     value: "Marketcap",
                              //     operator: ">=",
                              //     controller: TextEditingController(
                              //       text: "-200",
                              //     ),
                              //   ),
                              // );
                            });
                            refreshFilterValue();
                            //}
                          },
                          child: const Text("ADD Field1")),
                    ),
                  if (values.length == 1)
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            //if (values.length != 1) {
                            setState(() {
                              //Remove all
                              // values.removeRange(0, values.length);
                              //   var addThis2 = ["Ebit Wachstum|<=|3", "Land|ist|USA"];
                              values.add(
                                ValuesModel(
                                  value: "Ebit Wachstum",
                                  operator: "<=",
                                  controller: TextEditingController(
                                    text: "3",
                                  ),
                                ),
                              );
                              // values.add(
                              //   ValuesModel(
                              //     value: "Country",
                              //     operator: "=",
                              //     result: "US",
                              //   ),
                              // );
                            });
                            refreshFilterValue();
                            //}
                          },
                          child: const Text("ADD Field2")),
                    ),
                ],
              ),
            ),
            filterWidget()
          ],
        ),
      ),
    );
  }
}

class ValuesModel {
  String? value;
  String? operator;
  String? result;

  TextEditingController? controller;

  ValuesModel({this.value, this.operator, this.result, this.controller});
}
