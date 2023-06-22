import 'dart:convert';

import 'package:airbnb_cost_calculator/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

//borough
//neighbourhood
//room type
//nights

class _HomeState extends State<Home> {
  Map<String, dynamic>? neighbourhoodGroupsDict;
  Map<String, dynamic>? neighbourhoodDict;
  Map<String, dynamic>? roomTypeDict;

  final _numOfNights = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _selectedBurough = '';
  String _selectedNeighbourhood = '';
  String _selectedRoomType = '';
  int _nights = 1;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Future<Map<String, dynamic>> _loadJsonData(String path) async {
    // Read the JSON file
    String jsonString = await rootBundle.loadString(path);

    // Parse the JSON string into a List<dynamic>
    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> _getBuroughs() async {
    late Map<String, dynamic> data;
    if (neighbourhoodGroupsDict != null) {
      data = neighbourhoodGroupsDict!;
    } else {
      data = await _loadJsonData(
          'assets/resources/encoded_neighbourhood_groups_dict.json');
      neighbourhoodGroupsDict = data;
    }
    return data;
  }

  Future<Map<String, dynamic>> _getNeighbourhoods() async {
    late Map<String, dynamic> data;
    if (neighbourhoodDict != null) {
      data = neighbourhoodDict!;
    } else {
      data = await _loadJsonData(
          'assets/resources/encoded_neighbourhoods_dict.json');
      neighbourhoodDict = data;
    }
    return data;
  }

  Future<Map<String, dynamic>> _getRoomTypes() async {
    late Map<String, dynamic> data;
    if (roomTypeDict != null) {
      data = roomTypeDict!;
    } else {
      data =
          await _loadJsonData('assets/resources/encoded_room_type_dict.json');
      roomTypeDict = data;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: LayoutBuilder(builder: (context, ctr) {
                return PageView(
                  controller: _pageController,
                  children: [
                    _slideOne(ctr),
                    _slideTwo(ctr),
                    _slideThree(ctr),
                    _slideFour(ctr),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _slideFour(BoxConstraints ctr) {
    return SizedBox(
      width: ctr.maxWidth,
      height: ctr.maxHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'How many nights',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                validator: (val) {
                  int? number = int.tryParse(val ?? '');
                  if (number != null) {
                    return null;
                  } else {
                    return 'please enter a number';
                  }
                },
                controller: _numOfNights,
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.8),
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                      right: 10, left: 25, top: 5, bottom: 5),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.5))),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  hintText: 'number of nights',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              if (_numOfNights.text == '') return;
              if (_formKey.currentState!.validate()) {
                //
              }
            },
            child: Container(
              width: ctr.maxWidth * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              decoration: BoxDecoration(
                  color: _numOfNights.text == '' ? Colors.grey : AppColors.red,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Get Estimated Cost",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox _slideThree(BoxConstraints ctr) {
    return SizedBox(
      width: ctr.maxWidth,
      height: ctr.maxHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Choose Room Type',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
              future: _getRoomTypes(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Error occured',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...snap.data!.keys
                        .map((e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRoomType = e;
                                });
                              },
                              child: Container(
                                width: ctr.maxWidth * 0.8,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: AppColors.red),
                                    color: _selectedRoomType == e
                                        ? AppColors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: _selectedRoomType == e
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedRoomType == '') return;
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        width: ctr.maxWidth * 0.8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(
                            color: _selectedRoomType == ''
                                ? Colors.grey
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  SizedBox _slideTwo(BoxConstraints ctr) {
    return SizedBox(
      width: ctr.maxWidth,
      height: ctr.maxHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Choose Neighbourhood',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
              future: _getNeighbourhoods(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Error occured',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    const Divider(),
                    Container(
                      height: ctr.maxHeight * 0.5,
                      padding: const EdgeInsets.all(10),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: snap.data!.keys
                            .map((e) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedNeighbourhood = e;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: AppColors.red),
                                      color: _selectedNeighbourhood == e
                                          ? AppColors.red
                                          : Colors.white,
                                    ),
                                    child: Center(
                                        child: Text(
                                      e,
                                      style: TextStyle(
                                        color: _selectedNeighbourhood == e
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedNeighbourhood == '') {
                          return;
                        }
                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        width: ctr.maxWidth * 0.8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(
                            color: _selectedNeighbourhood == ''
                                ? Colors.grey
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  SizedBox _slideOne(BoxConstraints ctr) {
    return SizedBox(
      width: ctr.maxWidth,
      height: ctr.maxHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Choose Borough',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
              future: _getBuroughs(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Error occured',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...snap.data!.keys
                        .map((e) => _pickBurrough(context, ctr, e))
                        .toList(),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedBurough == '') return;

                        if (_currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        width: ctr.maxWidth * 0.8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 12),
                        decoration: BoxDecoration(
                            color: _selectedBurough == ''
                                ? Colors.grey
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  GestureDetector _pickBurrough(
      BuildContext context, BoxConstraints size, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBurough = title;
        });
      },
      child: Container(
        width: size.maxWidth * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.red),
            color: _selectedBurough == title ? AppColors.red : Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: _selectedBurough == title ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
