import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class ChatMenuTypeMessage extends StatelessWidget {
  final Widget child;

  const ChatMenuTypeMessage({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      child: child,
      onPressed: () {},
      menuItems: [
        FocusedMenuItem(
            title: const Text('Vị trí'),
            trailingIcon: const Icon(Icons.location_off_outlined),
            onPressed: () {}),
        FocusedMenuItem(
            title: const Text('Tài liệu'),
            trailingIcon: const Icon(Icons.document_scanner),
            onPressed: () {}),
        FocusedMenuItem(
            title: const Text('Chuyển tiền'),
            trailingIcon: const Icon(Icons.money),
            onPressed: () {})
      ],
      blurSize: 0,
      blurBackgroundColor: Colors.black,
      menuItemExtent: 50,
      duration: const Duration(milliseconds: 500),
      animateMenuItems: true,
      menuOffset: 12,
      openWithTap: true,
      menuWidth: MediaQuery.of(context).size.width * 0.6,
    );
  }
}

// FocusedMenuHolder(
//         menuItems: [
//           FocusedMenuItem(
//             title: Text('Favourite'),
//             trailingIcon: Icon(Icons.favorite_border),
//             onPressed: () =>
//                 SnackBarUtils.showSnackbar(context, 'Selected: Favourite'),
//           ),
//           FocusedMenuItem(
//             title: Text('Bookmark'),
//             trailingIcon: Icon(Icons.bookmark_border),
//             onPressed: () =>
//                 SnackBarUtils.showSnackbar(context, 'Selected: Bookmark'),
//           ),
//           FocusedMenuItem(
//             title: Text('Share'),
//             trailingIcon: Icon(Icons.share),
//             onPressed: () =>
//                 SnackBarUtils.showSnackbar(context, 'Selected: Share'),
//           ),
//           FocusedMenuItem(
//             title: Text('Delete', style: TextStyle(color: Colors.white)),
//             trailingIcon: Icon(Icons.delete_forever, color: Colors.white),
//             backgroundColor: Colors.red,
//             onPressed: () =>
//                 SnackBarUtils.showSnackbar(context, 'Selected: Delete'),
//           ),
//         ],
        // blurSize: 8,
        // blurBackgroundColor: Colors.black,
//         menuWidth: MediaQuery.of(context).size.width * 0.5,
        // menuItemExtent: 50,
        // duration: Duration(milliseconds: 500),
        // animateMenuItems: true,
        // menuOffset: 12,
        // openWithTap: true,
//         onPressed: () {},
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(19),
//             child: Image.network(urlImage, fit: BoxFit.cover),
//           ),
//         ),
//       );
