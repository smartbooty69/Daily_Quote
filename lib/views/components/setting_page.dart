import 'package:animated_search/animated_search.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/theme_controller.dart';
import '../../utils/globals.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Center(
              child: CircleAvatar(
                foregroundImage: const AssetImage(
                  "",
                ),
                radius: height * 0.092,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.home_outlined),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Home Page",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.search),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.grid_view),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Browse",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/favoritePage');
              },
              child: Row(
                children: [
                  const Icon(Icons.favorite_border),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Favourite Page",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Divider(),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.person_outline),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(Icons.logout_outlined),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Divider(),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Theme",
                  style: TextStyle(
                    fontSize: height * 0.024,
                  ),
                ),
                Switch(
                  value:
                      Provider.of<ThemeController>(context).themeModel.isDark,
                  onChanged: (val) {
                    Provider.of<ThemeController>(context, listen: false)
                        .changeTheme(val: val);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
