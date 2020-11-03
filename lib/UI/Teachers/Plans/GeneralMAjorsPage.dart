import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';


//plan pages for 6 majors
class GeneralMajorsPage extends StatefulWidget {
  final String studentId;
  final List<dynamic> tabs;

  const GeneralMajorsPage({this.studentId, this.tabs});

  @override
  _GeneralMajorsPageState createState() => _GeneralMajorsPageState();
}

class _GeneralMajorsPageState extends State<GeneralMajorsPage>  with TickerProviderStateMixin{
  int _currentIndex =0;


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabController = TabController(vsync: this, length: widget.tabs.length, initialIndex: 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: kAppBarColor,
          toolbarHeight: 75,
          bottom: TabBar(
            isScrollable: true,
            controller:_tabController,
            labelColor: kSelectedItemColor,
            indicatorColor: kSelectedItemColor,
            unselectedLabelColor: kUnselectedItemColor,
            onTap: (index) {

              setState(() {
                _currentIndex = index;
              });
            },
            tabs: widget.tabs.map((location){
              return Tab(text: location,);
            }).toList()

          ),
        ),

        body: Container(
          color: kBackgroundPageColor,
          child: Text(
              'Page number : $_currentIndex '
          ),
        ),
      ),
    );
  }
}


