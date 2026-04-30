import 'package:flutter/material.dart';

import 'list_screen.dart';
import 'grid_screen.dart';
import 'prefs_screen.dart';
import 'async_screen.dart';
import 'isolate_screen.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Week 4 Exercises"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem(
            context,
            "ListView",
            Icons.list,
            Colors.blue,
            ListScreen(),
          ),
          _buildItem(
            context,
            "GridView",
            Icons.grid_view,
            Colors.green,
            GridScreen(),
          ),
          _buildItem(
            context,
            "SharedPreferences",
            Icons.save,
            Colors.orange,
            PrefsScreen(),
          ),
          _buildItem(
            context,
            "Async",
            Icons.timer,
            Colors.purple,
            AsyncScreen(),
          ),
          _buildItem(
            context,
            "Isolate",
            Icons.memory,
            Colors.red,
            IsolateScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
      ),
    );
  }
}
