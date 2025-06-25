import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  final ScrollController scrollController3 = ScrollController();
  final ScrollController scrollController4 = ScrollController();
  bool _isFirstScrolling = false;
  bool _isSecondScrolling = false;
  bool _isThirdScrolling = false;
  bool _isFourthScrolling = false;

  @override
  void initState() {
    // first ScrollView listener
    scrollController1.addListener(() {
      if (!_isSecondScrolling && scrollController1.hasClients) {
        _isFirstScrolling = true;
        scrollController2.jumpTo(scrollController1.offset);
        _isFirstScrolling = false;
      }
    });

    // Second ScrollView listener
    scrollController2.addListener(() {
      if (!_isFirstScrolling && scrollController2.hasClients) {
        _isSecondScrolling = true;
        scrollController1.jumpTo(scrollController2.offset);
        _isSecondScrolling = false;
      }
    });

    // third ScrollView listener
    scrollController3.addListener(() {
      if (!_isFourthScrolling && scrollController3.hasClients) {
        _isThirdScrolling = true;
        scrollController4.jumpTo(scrollController3.offset);
        _isThirdScrolling = false;
      }
    });

    // Fourth ScrollView listener
    scrollController4.addListener(() {
      if (!_isThirdScrolling && scrollController4.hasClients) {
        _isFourthScrolling = true;
        scrollController3.jumpTo(scrollController4.offset);
        _isFourthScrolling = false;
      }
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(),
                  color: Colors.amber,
                  height: 100,
                  width: 80,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: DisableScrollEffects(),
                    child: SingleChildScrollView(
                      controller: scrollController1,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var i = 0; i < 11; i++)
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              color: Colors.black,
                              width: 80,
                              height: 100,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ScrollConfiguration(
                    behavior: DisableScrollEffects(),
                    child: SingleChildScrollView(
                      controller: scrollController4,
                      child: Column(
                        children: [
                          for (var i = 0; i < 5; i++)
                            Container(
                              color: Colors.green,
                              width: 80,
                              height: 100,
                              margin: const EdgeInsets.only(top: 5),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: ScrollConfiguration(
                    behavior: DisableScrollEffects(),
                    child: SingleChildScrollView(
                      controller: scrollController2,
                      scrollDirection: Axis.horizontal,
                      child: ScrollConfiguration(
                        behavior: DisableScrollEffects(),
                        child: SingleChildScrollView(
                          controller: scrollController3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < 11; i++)
                                Column(
                                  children: [
                                    for (var j = 0; j < 5; j++)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 5,
                                          left: 10,
                                        ),
                                        width: 80,
                                        height: 100,
                                        color: Colors.purple,
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisableScrollEffects extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}
