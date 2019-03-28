import 'package:flutter/material.dart';
import 'package:login/footer/articles_showcase.dart';
import 'package:login/footer/portfolio_showcase.dart';
import 'package:login/footer/skills_showcase.dart';
import 'package:login/Pages/Buddies/buddy.dart';

class BuddyShowcase extends StatefulWidget {
  BuddyShowcase(this.buddy);

  final Buddy buddy;

  @override
  _BuddyShowcaseState createState() => new _BuddyShowcaseState();
}

class _BuddyShowcaseState extends State<BuddyShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'Portfolio'),
      new Tab(text: 'Skills'),
      new Tab(text: 'Articles'),
    ];
    _pages = [
      new PortfolioShowcase(),
      new SkillsShowcase(),
      new ArticlesShowcase(),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
