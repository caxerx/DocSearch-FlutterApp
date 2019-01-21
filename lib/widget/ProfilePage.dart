import 'package:docsearch/widget/AppointmentTimeSelectionPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var rootCtx = context;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              title: Text("Doctor Profile"),
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Dr. Chan Tai Man",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 110,
                                  child: Text(
                                    "BDS, MDS - Oral Medicine and Radiology",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text("Dentist",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text("21 years experience"),
                  ),
                  Divider(
                    height: 1,
                  ),
                  GestureDetector(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          ListTile(
                            leading: Icon(Icons.home),
                            title: Text("Tak Po Clinic"),
                            subtitle: Text(
                                "9/F, Hing Wai Building, 36 Queen's Road Central (MTR Exit D2), Central"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 72, right: 15),
                            child: Image.network(
                              "https://maps.googleapis.com/maps/api/staticmap?markers=small|red|9/F,%20Hing%20Wai%20Building,%2036%20Queen%27s%20Road%20Central%20(MTR%20Exit%20D2),%20Central&center=9/F,%20Hing%20Wai%20Building,%2036%20Queen%27s%20Road%20Central%20(MTR%20Exit%20D2),%20Central&zoom=13&size=700x150&maptype=roadmap%20&key=AIzaSyCkKfWny99Hef150nPJULVQx4MUXwDbe7w&scale=2",
                              fit: BoxFit.cover,
                              width: 400,
                              height: 150,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  GestureDetector(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text("Open Time"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, left: 72, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Mon",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Tue",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Wed",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Thu",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Fri",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Sat",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Sun",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "00:00 - 23:59",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Divider(height: 1),
        ListTile(
          title: OutlineButton(
            child: Text("Book Appointment"),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          AppBar(
                            title: Text("Select Appointment Type"),
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () =>
                                    Navigator.of(context).pop(null),
                              ),
                            ],
                            automaticallyImplyLeading: false,
                          ),
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                ListTile(
                                  title: Text("Clinic Consultation"),
                                  subtitle: Text("Meet doctor in clinic."),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentTimeSelectionPage()));
                                  },
                                ),
                                ListTile(
                                  title: Text("Online Consultation"),
                                  subtitle: Text(
                                      "Meet doctor through online consultation."),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentTimeSelectionPage()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
          ),
        )
      ],
    ));
  }
}
