import 'package:docsearch/widget/Search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DocSearch"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.search,
              size: 40,
            ),
            title: Text("Search"),
            subtitle: Text("Search for clinic and doctors"),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 40,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          Divider(
            height: 1,
          ),
          ListTile(
              leading: Icon(
                Icons.check_box,
                size: 40,
              ),
              title: Text("Appointment"),
              subtitle: Text("View and manage the reserved services"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              )),
          Divider(
            height: 1,
          ),
          ListTile(
              leading: Icon(
                Icons.assignment,
                size: 40,
              ),
              title: Text("Medical Records"),
              subtitle: Text("Manage the permission of medical records"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              )),
          Divider(
            height: 1,
          ),
          ListTile(
              leading: Icon(
                Icons.feedback,
                size: 40,
              ),
              title: Text("Feedback"),
              subtitle: Text("Share opinions to the development team."),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Profile"))
        ],
      ),
    );
  }
}
