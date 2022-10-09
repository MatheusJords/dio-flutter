import 'package:brasil_fields/brasil_fields.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_page.dart';
import 'package:trilhaapp/service/dark_mode_service.dart';
import 'package:trilhaapp/shared/widgets/custon_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'brasil_fields_page/brasil_fields_page.dart';
import 'contador/contador_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      drawer: const CustonDrawer(),
      appBar: AppBar(
        title: Text(
          "APP_TITLE".tr(),
          style: GoogleFonts.roboto(),
        ),
        actions: [
          Center(child: Text("Dark Mode")),
          Consumer<DarkModeService>(builder: (_, darkModeService, widget) {
            return Switch(
                value: darkModeService.darkMode,
                onChanged: (bool value) {
                  darkModeService.darkMode = !darkModeService.darkMode;
                });
          })
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ContadorPage(),
          TarefaPage(),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.red,
          ),
          const BrasilFieldsPage()
        ],
      ),
      bottomNavigationBar: ConvexAppBar.badge(
        const {0: '99+', 1: Icons.assistant_photo, 2: Colors.redAccent},
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: 'Brasil'),
        ],
        onTap: (int i) => tabController.index = i,
        controller: tabController,
      ),
    );
  }
}
