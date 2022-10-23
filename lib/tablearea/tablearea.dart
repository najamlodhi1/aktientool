import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

class TableArea extends StatefulWidget {
  const TableArea({Key? key}) : super(key: key);
  @override
  TableAreaState createState() => TableAreaState();
}

class TableAreaState extends State<TableArea> {
  late List<DatatableHeader> _headers;

  final List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> source = [];
  List<Map<String, dynamic>> selecteds = [];
  // ignore: unused_field
  String selectableKey = "id";

  String? sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;
  var random = Random();

  List<Map<String, dynamic>> _generateData({int n = 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "id": i,
        // ignore: unnecessary_string_escapes
        "sku": "$i\000$i",
        "name": "Product $i",
        "category": "Category-$i",
        "price": i * 10.00,
        "cost": "20.00",
        "margin": "${i}0.20",
        "in_stock": "${i}0",
        "alert": "5",
        "received": [i + 20, 150]
      });
      i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      sourceOriginal.clear();
      sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
      sourceFiltered = sourceOriginal;
      _total = sourceFiltered.length;
      source = sourceFiltered.getRange(0, _currentPerPage!).toList();
      setState(() => isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => isLoading = true);
    // ignore: no_leading_underscores_for_local_identifiers
    var _expandedLen =
        _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _expanded = List.generate(_expandedLen as int, (index) => false);
      source.clear();
      source = sourceFiltered.getRange(start, start + _expandedLen).toList();
      setState(() => isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => isLoading = true);

    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) => data[_searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = sourceFiltered.length;
      var rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(rangeTop, (index) => false);
      source = sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "ID",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "SKU",
          value: "sku",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Category",
          value: "category",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Margin",
          value: "margin",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "In Stock",
          value: "in_stock",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Alert",
          value: "alert",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Received",
          value: "received",
          show: true,
          sortable: false,
          sourceBuilder: (value, row) {
            List list = List.from(value);
            return Column(
              children: [
                SizedBox(
                  width: 85,
                  child: LinearProgressIndicator(
                    value: list.first / list.last,
                  ),
                ),
                Text("${list.first} of ${list.last}")
              ],
            );
          },
          textAlign: TextAlign.center),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(
            maxHeight: 700,
          ),
          child: Card(
            elevation: 1,
            shadowColor: Colors.black,
            clipBehavior: Clip.none,
            child: ResponsiveDatatable(
              title: TextButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.add),
                label: const Text("new item"),
              ),
              reponseScreenSizes: const [ScreenSize.xs],
              actions: [
                if (_isSearch)
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter search term based on ${_searchKey!
                            // ignore: unnecessary_new
                            .replaceAll(new RegExp('[\\W_]+'), ' ').toUpperCase()}',
                        prefixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                _isSearch = false;
                              });
                              _initializeData();
                            }),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.search), onPressed: () {})),
                    onSubmitted: (value) {
                      _filterData(value);
                    },
                  )),
                if (!_isSearch)
                  IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _isSearch = true;
                        });
                      })
              ],
              headers: _headers,
              source: source,
              selecteds: selecteds,
              showSelect: showSelect,
              autoHeight: false,
              dropContainer: (data) {
                if (int.tryParse(data['id'].toString())!.isEven) {
                  return const Text("is Even");
                }
                return _DropDownContainer(data: data);
              },
              onChangedRow: (value, header) {
                /// print(value);
                /// print(header);
              },
              onSubmittedRow: (value, header) {
                /// print(value);
                /// print(header);
              },
              onTabRow: (data) {
                // ignore: avoid_print
                print(data);
              },
              onSort: (value) {
                setState(() => isLoading = true);

                setState(() {
                  sortColumn = value;
                  sortAscending = !sortAscending;
                  if (sortAscending) {
                    sourceFiltered.sort(
                        (a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
                  } else {
                    sourceFiltered.sort(
                        (a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
                  }
                  // ignore: no_leading_underscores_for_local_identifiers
                  var _rangeTop = _currentPerPage! < sourceFiltered.length
                      ? _currentPerPage!
                      : sourceFiltered.length;
                  source = sourceFiltered.getRange(0, _rangeTop).toList();
                  _searchKey = value;

                  isLoading = false;
                });
              },
              expanded: _expanded,
              sortAscending: sortAscending,
              sortColumn: sortColumn,
              isLoading: isLoading,
              onSelect: (value, item) {
                // ignore: avoid_print
                print("$value  $item ");
                if (value!) {
                  setState(() => selecteds.add(item));
                } else {
                  setState(() => selecteds.removeAt(selecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value!) {
                  setState(() =>
                      selecteds = source.map((entry) => entry).toList().cast());
                } else {
                  setState(() => selecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text("Rows per page:"),
                ),
                if (_perPages.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton<int>(
                      value: _currentPerPage,
                      items: _perPages
                          .map((e) => DropdownMenuItem<int>(
                                value: e,
                                child: Text("$e"),
                              ))
                          .toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          _currentPerPage = value;
                          _currentPage = 1;
                          _resetData();
                        });
                      },
                      isExpanded: false,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$_currentPage - $_currentPerPage of $_total"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: _currentPage == 1
                      ? null
                      : () {
                          var nextSet = _currentPage - _currentPerPage!;
                          setState(() {
                            _currentPage = nextSet > 1 ? nextSet : 1;
                            _resetData(start: _currentPage - 1);
                          });
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: _currentPage + _currentPerPage! - 1 > _total
                      ? null
                      : () {
                          var nextSet = _currentPage + _currentPerPage!;

                          setState(() {
                            _currentPage = nextSet < _total
                                ? nextSet
                                : _total - _currentPerPage!;
                            _resetData(start: nextSet - 1);
                          });
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                )
              ],
              headerDecoration: const BoxDecoration(
                  color: Colors.pink,
                  border:
                      Border(bottom: BorderSide(color: Colors.red, width: 1))),
              selectedDecoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.green[300]!, width: 1)),
                color: Colors.green,
              ),
              headerTextStyle: const TextStyle(color: Colors.grey),
              rowTextStyle: const TextStyle(color: Colors.blue),
              selectedTextStyle: const TextStyle(color: Colors.yellow),
            ),
          ),
        ),
      ])),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          const Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Column(
      /// children: [
      ///   Expanded(
      ///       child: Container(
      ///     color: Colors.red,
      ///     height: 50,
      ///   )),
      /// ],
      children: children,
    );
  }
}
