import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_application/theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_image/firebase_image.dart';

// class EducationSheet extends StatelessWidget {
//   const EducationSheet({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, '/education');
//       },
//       child: Container(
//         margin: EdgeInsets.only(
//           left: defaultMargin,
//           right: defaultMargin,
//           bottom: defaultMargin,
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.asset(
//                 'assets/education.png',
//                 width: 120,
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(
//               width: 12,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Judul Berita Education',
//                     style: text_barStyle.copyWith(
//                       fontSize: 16,
//                       fontWeight: semiBold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 6,
//                   ),
//                   Text(
//                     '9-8-2022',
//                     style: secondaryTextStyle.copyWith(
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget education(Function()? onTap, QueryDocumentSnapshot? getDataFirebase){
  return GestureDetector(
      onTap: onTap, //{
        //Navigator.pushNamed(context, '/education');
      //},
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: Image.asset(
              //   //'assets/education.png',
              //   width: 120,
              //   height: 120,
              //   fit: BoxFit.cover,
              // ),
              child: Image.network(
                getDataFirebase!['image_link'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //'Judul Berita Education',
                    getDataFirebase!['judul'],
                    style: text_barStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    //'9-8-2022',
                    'Click to view',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}





















//BLOCK SEMENTARA BUAT FRONTEND
//   @override
//   Widget build(BuildContext context) {
//     return education();
//   }
// Function()? onTap, QueryDocumentSnapshot? getDataFirebase
// showArticle(BuildContext context, String imgLink, String articleTitle, String articleMessage){
//   Widget popImage = Image.network(imgLink, width: 200, height: 200,);
//   Widget okButton = TextButton(
//     child: Text("OK"),
//     onPressed: (() => Navigator.of(context, rootNavigator: true).pop()),
//   );

//   AlertDialog showingArticle = AlertDialog(
//     title: Text(articleTitle),
//     content: Text(articleMessage),
//     actions: [
//       popImage, okButton
//     ],
//   );

//   showDialog(context: context, builder: (BuildContext context){
//       return showingArticle;
//     });
// }
// Widget education(Function()? onTap, QueryDocumentSnapshot? getDataFirebase) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       margin: EdgeInsets.only(
//         left: defaultMargin,
//         right: defaultMargin,
//         bottom: defaultMargin,
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.network(
//               // 'assets/education.png',
//               getDataFirebase!['image_link'],
//               width: 120,
//               height: 120,
//               fit: BoxFit.cover,
//             ),
//             // child : Image(
//             //   image: FirebaseImage(getDataFirebase!['fb_img']),
//             //   width: 120,height: 120, fit: BoxFit.cover,
//             // )
//           ),
//           SizedBox(
//             width: 12,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   // 'Judul Berita Education',
//                    getDataFirebase!['judul'],
//                   style: text_barStyle.copyWith(
//                     fontSize: 16,
//                     fontWeight: semiBold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   //'Text Main berita educatio texttexttexttexttexttext'
//                    getDataFirebase!['konten'],
//                   style: secondaryTextStyle.copyWith(
//                     fontSize: 12,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 48,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// // }
