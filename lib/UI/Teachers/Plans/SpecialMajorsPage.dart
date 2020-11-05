import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';

//plan pages for 6 majors
class SpecialMajorsPage extends StatefulWidget {
  @override
  _SpecialMajorsPageState createState() => _SpecialMajorsPageState();
}

class _SpecialMajorsPageState extends State<SpecialMajorsPage>  with TickerProviderStateMixin{
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
      _tabController = TabController(vsync: this, length: 6, initialIndex: 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: kAppBarColor,
          onPressed: (){},
        ),
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
            tabs:
            [
              Tab(text: 'مجال الانتباه والتركيز'),
              Tab(text: 'مجال التواصل'),
              Tab(text: 'المجال الإدراكي'),
              Tab(text: 'المجال الحركي الدقيق'),
              Tab(text: 'المجال الاجتماعي'),
              Tab(text: 'المجال الاستقلالي'),
            ],
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


