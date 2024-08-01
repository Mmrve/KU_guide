import 'package:flutter/material.dart';
import 'package:olmamis/generated/locale-keys.g.dart';
import 'package:url_launcher/url_launcher.dart'; //ikona link eklemek için kullnaıdm
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en', 'US'), const Locale('tr', 'TR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: InfoPages(),
    );
  }
}

/// BİLGİ SAYFALARI
class InfoPages extends StatefulWidget {
  @override
  _InfoPagesState createState() => _InfoPagesState();
}

class _InfoPagesState extends State<InfoPages> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.choice.tr(),textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.setLocale(Locale('tr', 'TR'));
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(LocaleKeys.turkish.tr()),
              ),
              SizedBox(height: 8,),
              ElevatedButton(
                onPressed: () {
                  context.setLocale(Locale('en', 'US'));
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(LocaleKeys.english.tr()),
              ),
            ],
          ),
          InfoPage(
            backgroundImage: 'assets/background1.jpg',
            title: 'welcome'.tr(),
            content: 'info_content'.tr(),
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          InfoPage(
            backgroundImage: 'assets/background1.jpg',
            title: 'title'.tr(),/////bunlar değişmiyor
            content: 'aciklama'.tr(),
            onNext: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String content;
  final VoidCallback onNext;

  InfoPage({
    required this.backgroundImage,
    required this.title,
    required this.content,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.5), // Burada opaklık değeri ayarlanır
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200, // Genişliği burada belirleyebilirsiniz
                child: ElevatedButton(
                  onPressed: onNext,
                  child: Text(LocaleKeys.button.tr()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
/////HOMEPAGE
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANA SAYFA'),///üstte yazan kısım
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg', // Arka plan resminin yolu
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              InfoCard(
                title: 'title_ilgoc'.tr(),
                image: 'assets/migration.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IlGocIdaresiPage()),
                  );
                },
              ),
              InfoCard(
                title: 'title_uni'.tr(),///bu isimde jsonda türkçe kısmında karşılık gelen veriyi alıyo
                image: 'assets/rector.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KastUniPage()),
                  );
                },
              ),
              InfoCard(
                title: 'title_konaklama'.tr(),
                image: 'assets/accommodation.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KonaklamaPage()),
                  );
                },
              ),
              InfoCard(
                title: 'title_doviz'.tr(),
                image: 'assets/exchange.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DovizBurelariPage()),
                  );
                },
              ),
              InfoCard(
                title: 'title_kentkart'.tr(),
                image: 'assets/kentKart.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ulasim_page()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///HOMEPAGELERDE BULUNAN İNFOCARDLARIN DÜZENİ
class InfoCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  InfoCard({required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: Container(
          child: Image.asset(
            image,
            alignment: Alignment.center,
          ),
        ),
        title: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
class ulasim_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            // Kaydırma özelliğini eklemek için SingleChildScrollView kullanıyoruz
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                          Text(
                            'KENTKART',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 1.0,
                                  color: Colors.black.withOpacity(0.9),
                                  offset: const Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ],
                      )
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('ulasim2'.tr(),//metin kısmı
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //ilk yazınnın altındaki linkler
                  ElevatedButton(
                    onPressed: () {
                      launch(//kent kart merkez
                          'https://www.google.com/maps/dir/41.3794304,33.7739776/41.3767289,33.7775354/@41.3765823,33.7774539,21z/data=!4m5!4m4!1m1!4e1!1m0!3e2?entry=ttu');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                            'ulasim1'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      launch(//kentkart kuzeykent
                          'https://www.google.com/maps/place/Kuzeykent+Mahallesi+Muhtarl%C4%B1%C4%9F%C4%B1/@41.4285985,33.7763581,21z/data=!4m6!3m5!1s0x4084fb04a4220637:0x1fc51dafe8a973a6!8m2!3d41.4285922!4d33.7762651!16s%2Fg%2F1tdxjbw6?entry=ttu');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                            'ulasim3'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),



                  /////ikinci metin kısmının oldupu yer.
                  const SizedBox(height: 20),
                  Container(
                    decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('ulasim4'.tr(),//metin kısmı
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //ilk yazınnın altındaki linkler
                  ElevatedButton(
                    onPressed: () {
                      launch(///otobüs hareket saatleri
                          'http://www.kastamonuozelhalkotobusu.com/otobus-hareket-saatleri/');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                            'ulasim5'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      launch(//
                          'https://play.google.com/store/apps/details?id=kentkart.mobile.cordova');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                            'ulasim6'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


////İL GÖÇ İDARESİ DÜZEN
class IlGocIdaresiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('İl Göç İdaresi'), appvbardaki metini yok ettim.
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            // Kaydırma özelliğini eklemek için SingleChildScrollView kullanıyoruz
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Text(
                    'infoilgoc1'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 1.0,
                          color: Colors.black.withOpacity(0.9),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ],
              )
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    padding: const EdgeInsets.all(8.0),
                    child: Text('infoilgoc2'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      launch(
                          'https://www.goc.gov.tr/kurumlar/goc.gov.tr/Kurumsal/Ikamet/ogrenci-ikamet-2024/1_Ogrenci_Ikamet_Basvuru_Sureci18032024.pdf');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                          'infoilgoc3'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      launch(
                          'https://gocislemleri.com/basvuru-danismanlik-servisi/?gad_source=1&gclid=Cj0KCQjwhb60BhClARIsABGGtw_wjvw5L9uFP6evuVXYsiIxCv-mBjZSq-DOGR6-rib3004n6C_-TPYaAjdCEALw_wcB');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text('\n'+
                          'infoilgoc4'.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'assets/http.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KastUniPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Kastamonu Üniversitesi'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg', // Arka plan resminin yolu
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Text(
                          'infouni'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black.withOpacity(0.9),
                                offset: const Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      _buildInfoCard(
                        title: 'uni1'.tr(),
                        image: 'assets/rktr.jpg',
                        onTap: () {
                          launch(
                              'https://www.kastamonu.edu.tr/index.php/tr/iletisim-new');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni2'.tr(),
                        image: 'assets/egitim.jpg',
                        onTap: () {
                          launch('https://egitim.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni3'.tr(),
                        image: 'assets/FenFK.jpeg',
                        onTap: () {
                          launch('https://fen.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni4'.tr(),
                        image: 'assets/gsf.jpg',
                        onTap: () {
                          launch('https://gstf.kastamonu.edu.tr/'); ///////////////////bu kısım değiştirildi
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni5'.tr(),
                        image: 'assets/iibf.jpg',
                        onTap: () {
                          launch('https://iibf.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni6'.tr(),
                        image: 'assets/ilahiyat.jpg',
                        onTap: () {
                          launch('https://ilahiyat.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni7'.tr(),
                        image: 'assets/iletisimFK.jpg',
                        onTap: () {
                          launch('https://iletisim.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni8'.tr(),
                        image: 'assets/insan.jpg',
                        onTap: () {
                          launch('https://itbf.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni9'.tr(),
                        image: 'assets/müh.jpg',
                        onTap: () {
                          launch(
                              'https://mmf.kastamonu.edu.tr/index.php/tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni10'.tr(),
                        image: 'assets/OrmanFK.jpg',
                        onTap: () {
                          launch('https://orman.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni11'.tr(),
                        image: 'assets/saglik.jpg',
                        onTap: () {
                          launch('https://sbf.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni12'.tr(),
                        image: 'assets/sporbilimlerFK.jpg',
                        onTap: () {
                          launch('https://sporbilimleri.kastamonu.edu.tr/');
                        },
                      ),

                      _buildInfoCard(
                        title: 'uni13'.tr(),
                        image: 'assets/TıpFK.jpg',
                        onTap: () {
                          launch('https://tip.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni14'.tr(),
                        image: 'assets/TurizmFK.jpg',
                        onTap: () {
                          launch('https://turizm.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni15'.tr(),
                        image: 'assets/VeterinerFK.jpg',
                        onTap: () {
                          launch('https://veteriner.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni16'.tr(),
                        image: 'assets/fen.jpg',
                        onTap: () {
                          launch('https://fbe.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni17'.tr(),
                        image: 'assets/sagens.jpg',
                        onTap: () {
                          launch('https://sagbe.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni18'.tr(),
                        image: 'assets/sosens.jpg',
                        onTap: () {
                          launch('https://sbe.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni19'.tr(),
                        image: 'assets/havacilik.jpg',
                        onTap: () {
                          launch(
                              'https://havacilik.kastamonu.edu.tr/index.php/tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni20'.tr(),
                        image: 'assets/yabancidil.jpg',
                        onTap: () {
                          launch('https://ydyo.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni21'.tr(),
                        image: 'assets/MYO.jpg',
                        onTap: () {
                          launch('https://kmyo.kastamonu.edu.tr/');
                        },
                      ),
                      _buildInfoCard(
                        title: 'uni22'.tr(),
                        image: 'assets/ayyildiz.jpg',
                        onTap: () {
                          launch(
                              'https://sks.kastamonu.edu.tr/index.php/component/sppagebuilder/page/237');
                        },
                      ),

                      // Diğer kartlar buraya eklenebilir
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class KonaklamaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Konaklama'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg', // Arka plan görseli yolu
            fit: BoxFit.cover,
          ),
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 8), // Divider ile Text arasında boşluk için
              Text(
                'konaklama1'.tr(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.9),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8), // Text ile Divider arasında boşluk için
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 16),
              _buildKonaklamaItem(
                title: 'konaklama2'.tr(),
                gender: 'gender'.tr(),
                url: 'https://www.instagram.com/pattabanoglu_residence/',
              ),
              _buildKonaklamaItem(
                title: 'konaklama3'.tr(),
                gender: 'gender'.tr(),
                url: 'https://www.facebook.com/Turkelresidence/?locale=tr_TR',
              ),
              _buildKonaklamaItem(
                title: 'konaklama4'.tr(),
                gender: 'woman'.tr(),
                url:
                    'https://www.google.com/maps/dir//41.4224811,33.7734517/@41.4224534,33.6913075,12z?entry=ttu',
              ),
              _buildKonaklamaItem(
                title: 'konaklama5'.tr(),
                gender: 'woman'.tr(),
                url:
                    'https://www.instagram.com/elit_apart_?igsh=MTkwc3ZvczB0dmZqZA==',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKonaklamaItem(
      {required String title, required String gender, required String url}) {
    return Card(
      color: Colors.black.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          launch(url);
        },
        child: ListTile(
          title: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                gender,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DovizBurelariPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Döviz Büroları'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.jpg', // Arka plan görseli yolu
            fit: BoxFit.cover,
          ),
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 8), // Divider ile Text arasında boşluk için
              Text(
                'doviz1'.tr(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.9),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8), // Text ile Divider arasında boşluk için
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 16),
              _dovizItem(
                title: 'doviz2'.tr(),
                url:
                    'https://www.google.com/maps/dir//Top%C3%A7uo%C4%9Flu,+KISMET+D%C3%96V%C4%B0Z+KASTAMONU,+Dumlup%C4%B1nar+Caddesi,+Kastamonu+Merkez%2FKastamonu/@41.3795449,33.7794555,16.18z/data=!4m8!4m7!1m0!1m5!1m1!1s0x4084f19aa028de03:0xc277dd39815ded86!2m2!1d33.7770738!2d41.3793371?entry=ttu',
              ),
              _dovizItem(
                title: 'doviz3'.tr(),
                url:
                    'https://www.google.com/maps/dir//Top%C3%A7uo%C4%9Flu,+G%C3%BCrol+D%C3%B6viz,+Tahtakale+Caddesi,+Kastamonu+Merkez%2FKastamonu/@41.3784686,33.6925628,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x4084fa09072017d3:0x448b895fa28c0f89!2m2!1d33.7749643!2d41.378498?entry=ttu',
              ),
              _dovizItem(
                title: 'doviz4'.tr(),
                url:
                    'https://www.google.com/maps/dir//Kuzeykent,+Hayri+Darende+Kuyumculuk+Kuzeykent+%C5%9Eubesi,+Kamil+Demircio%C4%9Flu+Caddesi,+Kastamonu+Merkez%2FKastamonu/@41.431236,33.7788771,15.65z/data=!4m8!4m7!1m0!1m5!1m1!1s0x4084fb1595e123a7:0x40243fcf24f324fc!2m2!1d33.7822714!2d41.4293743?entry=ttu',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dovizItem({required String title, required String url}) {
    return Card(
      color: Colors.black.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          launch(url);
        },
        child: ListTile(
          title: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDovizBuroCard(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      color: Colors.black.withOpacity(0.5),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8), //arada boşluk olsun diye ekledik
          const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 30,
          ),
        ],
      ),
    ),
  );
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  DetailPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
