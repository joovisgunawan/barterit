import 'package:barterit/onboardmodel.dart';
import 'package:barterit/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var screen = [1, 2, 3, 4, 5, 7, 8, 9, 10];
  int currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  Container dotIndicator(int index) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.blue : Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  currentIndex = value;
                  setState(() {});
                },
                itemCount: onBoardingContent.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        onBoardingContent[index].title,
                        style: const TextStyle(
                          fontSize: 36,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(onBoardingContent[index].image)
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  currentIndex == onBoardingContent.length - 1
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()));
                          },
                          child: const Text('getStarted'))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnBoardBtn(
                                name: 'Skip',
                                onPressed: () {
                                  _pageController.previousPage(
                                      duration: const Duration(microseconds: 400),
                                      curve: Curves.easeInOut);
                                }),
                            Row(
                              children: List.generate(onBoardingContent.length,
                                  (index) => dotIndicator(index)),
                            ),
                            OnBoardBtn(
                                name: 'Next',
                                onPressed: () {
                                  _pageController.nextPage(
                                      duration: const Duration(microseconds: 400),
                                      curve: Curves.easeInOut);
                                }),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    // appBar: AppBar(
    //   title: const Text('On Board Screen'),
    //   actions: [
    //     TextButton(
    //       onPressed: () {},
    //       child: Text('Skip'),
    //     ),
    //   ],
    // ),
    // body: Container(
    //   padding: EdgeInsets.all(8.0),
    //   color: Colors.amber,
    //   width: double.infinity,
    //   child: PageView.builder(
    //     itemCount: screen.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Column(
    //         children: [
    //           //image
    //           Container(
    //             height: 350,
    //             color: Colors.blue,
    //           ),
    //           //dot dot
    //           Container(
    //             height: 10,
    //             color: Colors.white,
    //             child: ListView.builder(
    //               itemCount: 3,
    //               scrollDirection: Axis.horizontal,
    //               shrinkWrap: true,
    //               itemBuilder: (context, index) {
    //                 return Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       margin: EdgeInsets.symmetric(horizontal: 3),
    //                       width: 8,
    //                       height: 8,
    //                       decoration: BoxDecoration(
    //                           color: Colors.blue,
    //                           borderRadius: BorderRadius.circular(10)),
    //                     )
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //           //text
    //           Text(
    //             "ini title",
    //             style: TextStyle(fontSize: 27),
    //           ),
    //           Text(
    //             "ini description",
    //             style: TextStyle(fontSize: 14),
    //           ),
    //           TextButton(
    //             onPressed: () {},
    //             child: Text("next"),
    //           )
    //         ],
    //       );
    //     },
    //   ),
    // ),
    // );
  }

  Future setSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool gas = await prefs.setBool('seenOnBoard', true);
    print('seen on board is');
    print(gas);
  }
}

class OnBoardBtn extends StatefulWidget {
  final String name;
  final VoidCallback onPressed;

  const OnBoardBtn({super.key, required this.name, required this.onPressed});

  @override
  State<OnBoardBtn> createState() => _OnBoardBtnState();
}

class _OnBoardBtnState extends State<OnBoardBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Text(widget.name),
      // child: Text('skip'),
    );
  }
}
