import 'package:flutter/material.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/modules/login/login_screen.dart';
import 'package:shopy_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController boardController;
  late List<BoardingModel> boarding;
  bool isLast = false;

  @override
  void initState() {
    super.initState();
    boardController = PageController();
    boarding = [
      BoardingModel(
        image: 'assets/images/onboard 1.png',
        title: 'Welcome to Shopy',
        body: 'Join us for a fantastic shopping journey at Shopy',
      ),
      BoardingModel(
        image: 'assets/images/onboard 2.png',
        title: 'Explore Endless Possibilities',
        body: 'Discover curated collections and exclusive deals tailored just for you.',
      ),
      BoardingModel(
        image: 'assets/images/onboard 3.png',
        title: 'Join the Shopy Community',
        body: 'Connect with fellow shoppers and explore new trends together!',
      ),
    ];

    CacheHelper.init();
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value!) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  setState(() {
                    isLast = index == boarding.length - 1;
                  });
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], context),
                itemCount: boarding.length,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.red,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model, context) => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          width: double.infinity,
          height: 400,
          image: AssetImage(model.image),
        ),
        const SizedBox(height: 30),
        Text(
          model.title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          model.body,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
      ],
    ),
  );
}