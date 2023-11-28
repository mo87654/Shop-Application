import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/component/colors.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingModel {
  final Image? image;
  final String? title;
  final String? body;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.body
});
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  var onBoardingController = PageController();
  bool isLast = false;
  List<OnboardingModel> onBoardingList = [
    OnboardingModel(
        image: Image(
          image: AssetImage('assets/images/onboarding1.png'),
        ),
        title: 'OnBoarding Title 1',
        body: 'OnBoarding body 1'
    ),
    OnboardingModel(
        image: Image(
          image: AssetImage('assets/images/onboarding2.png'),
        ),
        title: 'OnBoarding Title 2',
        body: 'OnBoarding body 2'
    ),
    OnboardingModel(
        image: Image(
          image: AssetImage('assets/images/onboarding3.png'),
        ),
        title: 'OnBoarding Title 3',
        body: 'OnBoarding body 3'
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                CachHelper.savaData(key: 'onBoarding', value: true).then((value){
                    navigateToAndReplace(context, LoginScreen());
                });
              },
              child: Text(
                'SKIP',
                style: TextStyle(

                ),
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: onBoardingController,
                itemBuilder: (BuildContext context, int index)=>onboardingBuilder(onBoardingList[index]),
                itemCount: onBoardingList.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if(index == onBoardingList.length-1)
                    {
                      isLast = true;
                    }else
                      {
                        isLast = false;
                      }
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: onBoardingList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 2,
                    spacing: 7
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                     if(isLast == true)
                       {
                         CachHelper.savaData(key: 'onBoarding', value: true).then((value){
                           navigateToAndReplace(context, LoginScreen());
                         });
                       }else
                         {
                           onBoardingController.nextPage(
                               duration: const Duration(milliseconds: 900),
                               curve: Curves.fastLinearToSlowEaseIn
                           );
                         }
                    },
                    child: Icon(
                      Icons.arrow_forward,
                    ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }
  Widget onboardingBuilder(model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: model.image,
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 23,
          fontFamily: 'Janna',
        ),
      ),
      SizedBox(
        height: 25,
      ),
      Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Janna'
          )
      )
    ],
  );
}
