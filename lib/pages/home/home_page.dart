import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:waste_application/model/carousel_model_sheetbar.dart';
import 'package:waste_application/pages/edit_profile.dart';
import 'package:waste_application/pages/sheet_education.dart';
import 'package:waste_application/pages/view_article.dart';
import 'package:waste_application/services_and_dataclass/username_login.dart';
import 'package:waste_application/theme.dart';
import 'package:waste_application/widgets/customtext_education.dart';
import 'package:waste_application/widgets/education.dart';
import 'package:waste_application/widgets/tutorial.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String testing = "x";
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];

    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  String getEmailUsername(String email_name) {
    //untuk ngambil username dari email
    int i = 0;
    while (i < email_name.length) {
      if (email_name[i] == "@") {
        return email_name.substring(0, i);
      }
      i++;
    }
    return "get_username_from_email";
  }

  int balanceBalance = 0;

  @override
  Widget build(BuildContext context) {
    var getUsername = ModalRoute.of(context)!.settings.arguments as LoginInfo;
    var LoggedUsername = getEmailUsername(getUsername.email.toString());
    var EmailSend = getUsername.email.toString();
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KonekSub',
                    style: button_TextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  Text(
                    'Halo, ${EmailSend}',
                    style: sub_nameuser_TextSyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget SheetIcon() {
      return Padding(
        padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: MyColors.green,
                    offset: Offset(0, 1),
                    blurRadius: 4,
                    spreadRadius: 0)
              ]),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    height: 16,
                    width: 2,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 90,
                width: 150,
                decoration: BoxDecoration(
                    color: MyColors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "850",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: MyFontSize.large3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Your Point",
                      style: TextStyle(
                        color: MyColors.softGrey,
                        fontSize: MyFontSize.medium2,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/education');
                  },
                  child: Image.asset(
                    'assets/icon_redem.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/droppoint');
                  },
                  child: Image.asset(
                    'assets/icon_drop.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile',
                        arguments: LoginInfo(getUsername.email.toString()));
                  },
                  child: Image.asset(
                    'assets/icon_profil.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      );
    }

    Widget Barsheet() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Swiper(
                onIndexChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                autoplay: false,
                layout: SwiperLayout.DEFAULT,
                itemCount: carousels.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          carousels[index]!.image.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    children: map(carousels, (index, image) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? primaryColor
                            : subtitleTextColor),
                  );
                })),
              ],
            )
          ],
        ),
      );
    }

    Widget EducationTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Customtext_education(
            iconPath: "assets/ic_indoclub.png",
            iconText: "Waste education",
            subtitle: "Education Waste Surabaya",
            caption: "Berita tentang daur ulang sampah di sekitar mu~"),
      );
    }

    Widget Eduction_sheet() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        // child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("artikel").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return education(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RemakeSheetEducation(
                                    imageLink: snapshot.data?.docs[index]
                                        ['image_link'],
                                    textJudul: snapshot.data?.docs[index]
                                        ['judul'],
                                    textKeterangan: snapshot.data?.docs[index]
                                        ['konten'],
                                  )));
                    }, snapshot.data?.docs[index]);
                  }),
                );
              }
              return Text("asd");
            }),
        // ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.green,
          title: header(),
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  SheetIcon(),
                  Barsheet(),
                  EducationTitle(),
                  Eduction_sheet(),
                ],
              ),
            ),
          ),
        ]));
  }
}

//DI BLOCK BUAT BECKEND
//   return SingleChildScrollView(
//     child: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection("artikel").snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasData) {
//             // print(snapshot.data?.docs.length);
//             // for (var i =0; i< snapshot.data!.docs.length; i++){
//             //   return education((){}, snapshot.data?.docs[i]);
//             // }
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: ((context, index) {
//                 return education(() {
//                   showArticle(
//                       context,
//                       snapshot.data?.docs[index]['image_link'],
//                       snapshot.data?.docs[index]['judul'],
//                       snapshot.data?.docs[index]['konten']);
//                 }, snapshot.data?.docs[index]);
//               }),
//             );
//           }
//           return Text("asd");
//         }),
//   );
// }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: (settings) {
//         final arguments = settings.arguments;
//         print("Arguments Passed : " + arguments.toString());
//       },
//       home: Scaffold(
//           // body: ListView(
//           //   children: [
//           //     _header(),
//           //     bar_sheet(),
//           //     Barsheet(),
//           //     EducationTitle(),
//           //     Eduction_sheet(),
//           //   ],
//           // ),
//           body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 _header(),
//                 bar_sheet(),
//                 Barsheet(),
//                 EducationTitle(),
//                 Eduction_sheet(),
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
