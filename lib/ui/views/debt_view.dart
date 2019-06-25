import 'package:flutter/material.dart';
import 'package:valoro/ui/widgets/debt_list.dart';

class DebtView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "All Debts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: FittedBox(
                  child: Container(
                    color: Colors.red,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: DebtList(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Filtering",
                              style: Theme.of(context).textTheme.title,
                            ),
                            enabled: false,
                          ),
                          ListTile(
                            leading: Icon(Icons.sort_by_alpha),
                            title: Text("Sort by name"),
                          )
                        ],
                      ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
