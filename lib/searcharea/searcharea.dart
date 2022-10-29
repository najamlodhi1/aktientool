import 'package:flutter/material.dart';

class SearchArea extends AppBar {
  SearchArea({Key key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchfieldState();
}

class _SearchfieldState extends State<SearchArea> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('AktienTool');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      title: customSearchBar,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = const ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Aktie eingeben',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = const Text('AktienTool');
              }
            });
          },
          icon: customIcon,
        )
      ],
      centerTitle: true,
    );
  }
}
