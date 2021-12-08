import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:math';
import 'package:safecrackerpro/utils/translations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'), // English
        const Locale('ru'), // Russian
      ],
      title: 'Safecracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> numbers = [];
  List<int> rNum = [];
  int level = 4;

  int countSteps = 0;
  List<String> dataString = [];
  List<int> data_image_1 = [];
  List<int> data_image_2 = [];

  bool start = true;

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-6576238597063244/9980833237',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      startGame();
    });

    myBanner.load();
  }

  Future<void> startGame() async {
    _showStartGameDialog().then((value) {
      numbers.clear();
      rNum.clear();

      dataString.clear();
      data_image_1.clear();
      data_image_2.clear();

      countSteps = 0;

      var rng = Random();

      for (int i = 0; i < level; i++) {
        numbers.add(i);
        rNum.add(rng.nextInt(10));

        bool found = false;

        do {
          found = false;

          rNum[i] = rng.nextInt(10);

          for (int n = 0; n < rNum.length - 1; n++) {
            if (rNum[n] == rNum[i]) {
              found = true;
            }
          }
        } while (found);
      }

      setState(() {});
    });
  }

  Future<void> _showStartGameDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(Translations.of(context).text('Choose level')),
          actions: <Widget>[
            TextButton(
              child:  Text(Translations.of(context).text('Beginner')),
              onPressed: () {
                level = 4;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text(Translations.of(context).text('Intermediate')),
              onPressed: () {
                level = 5;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text(Translations.of(context).text('Expert')),
              onPressed: () {
                level = 6;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final AdWidget adWidget = AdWidget(ad: myBanner);

    List<Widget> numbersWidget = [];
    List<Widget> resultWidget = [];


    for (int i = 0; i < numbers.length; i++) {
      numbersWidget.add(
        NumberPicker(
          value: numbers[i],
          minValue: 0,
          maxValue: 9,
          step: 1,
          itemWidth: 60,
          haptics: true,
          onChanged: (value) {
            numbers[i] = value;

            setState(() {});
          },
        ),
      );
    }

    for (int i = 0; i < dataString.length; i++) {
      List<Widget> rowWidget = [];

      rowWidget.add(Text(dataString[i]));

      if (data_image_1[i] == 1)
        rowWidget.add(Image.asset(
          'assets/coin_gold_1.png',
          height: 60,
        ));
      else if (data_image_1[i] == 2)
        rowWidget.add(Image.asset(
          "assets/coin_gold_2.png",
          height: 60,
        ));
      else if (data_image_1[i] == 3)
        rowWidget.add(Image.asset(
          "assets/coin_gold_3.png",
          height: 60,
        ));
      else if (data_image_1[i] == 4)
        rowWidget.add(Image.asset(
          "assets/coin_gold_4.png",
          height: 60,
        ));
      else if (data_image_1[i] == 5)
        rowWidget.add(Image.asset(
          "assets/coin_gold_5.png",
          height: 60,
        ));
      else if (data_image_1[i] == 6)
        rowWidget.add(Image.asset(
          "assets/coin_gold_6.png",
          height: 60,
        ));
      else {
        //image1.setVisibility(View.INVISIBLE);
      }

      if (data_image_2[i] == 1)
        rowWidget.add(Image.asset(
          "assets/coin_silver_1.png",
          height: 60,
        ));
      else if (data_image_2[i] == 2)
        rowWidget.add(Image.asset(
          "assets/coin_silver_2.png",
          height: 60,
        ));
      else if (data_image_2[i] == 3)
        rowWidget.add(Image.asset(
          "assets/coin_silver_3.png",
          height: 60,
        ));
      else if (data_image_2[i] == 4)
        rowWidget.add(Image.asset(
          "assets/coin_silver_4.png",
          height: 60,
        ));
      else if (data_image_2[i] == 5)
        rowWidget.add(Image.asset(
          "assets/coin_silver_5.png",
          height: 60,
        ));
      else if (data_image_2[i] == 6)
        rowWidget.add(Image.asset(
          "assets/coin_silver_6.png",
          height: 60,
        ));
      else {
        //image2.setVisibility(View.INVISIBLE);
        //rowWidget.add(Text(dataString[i]));
      }

      resultWidget.add(Row(
        children: rowWidget,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('Safecracker')),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text(Translations.of(context).text('New game')),
                onPressed: () {
                  startGame();
                },
              ),
              const Spacer(),
              TextButton(
                child: Text(Translations.of(context).text('Move')),
                onPressed: numbers.isEmpty ? null :  () {
                  bool hasDub = false;

                  for (int i = 0; i < numbers.length; i++) {
                    for (int n = i + 1; n < numbers.length; n++) {
                      if (numbers[i] == numbers[n]) {
                        hasDub = true;
                        break;
                      }
                    }
                  }

                  if (hasDub) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Warning'),
                          content:
                          Text(Translations.of(context).text('You need have different numbers.')),
                          actions: <Widget>[
                            TextButton(
                              child:  Text(Translations.of(context).text('OK')),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    int count_full_com = 0;
                    int count_part_com = 0;

                    for (int i = 0; i < numbers.length; i++) {
                      for (int n = 0; n < numbers.length; n++) {
                        if (rNum[i] == numbers[n]) {
                          if (i == n) {
                            count_full_com++;
                          } else {
                            count_part_com++;
                          }
                        }
                      }
                    }

                    String strItem = '';

                    countSteps++;

                    strItem = "$countSteps ";

                    for (int i = 0; i < numbers.length; i++) {
                      strItem = strItem + "${numbers[i]} ";
                    }

                    dataString.insert(0, strItem);
                    data_image_1.insert(0, count_full_com);
                    data_image_2.insert(0, count_part_com);

                    if (count_full_com == numbers.length) {
                      strItem = Translations.of(context).text("The end game. You found right number ");
                      for (int i = 0; i < numbers.length; i++) {
                        strItem = strItem + "${rNum[i]} ";
                      }
                      dataString.insert(0, strItem);
                      data_image_1.insert(0, -1);
                      data_image_2.insert(0, -1);

                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text(Translations.of(context).text('The end')),
                            content: Text(strItem),
                            actions: <Widget>[
                              TextButton(
                                child: Text(Translations.of(context).text('OK')),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    setState(() {});
                  }
                },
              ),
              const Spacer(),
              TextButton(
                child:  Text(Translations.of(context).text('About')),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                       // title: const Text('Warning'),
                        content:
                        Text(Translations.of(context).text('Safecracker is a game where you must use your logic in order to guess a 4-digit secret number selected by the computer at the beginning of the game. The number is from 0 to 9. Each digit appears once at most. How many digits have you guessed on the same position will show by gold coins. How many digit shave you guessed on a different position will show by silver coins. Good luck!')),
                        actions: <Widget>[
                          TextButton(
                            child: Text(Translations.of(context).text('OK')),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: numbersWidget),
          ),
          (resultWidget.isNotEmpty
              ? Flexible(
                  child: ListView(
                  children: resultWidget,
                  // padding: EdgeInsets.fromLTRB(0, appAdsH.toDouble(), 0, 0),
                  shrinkWrap: true,
                ))
              :  Text(Translations.of(context).text('No move yet'))),
          adWidget,
        ],
      ),
    );
  }
}
