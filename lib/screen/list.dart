import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ListScreen extends StatelessWidget {
  final GlobalKey<ListState> _key = GlobalKey();

  _onTapButton() {
    _key.currentState._addItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListScreen"),
        ),
        body: ListWidget(key: _key,),
        floatingActionButton: FloatingActionButton(
          child: Text("ADD"),
          onPressed: () {
            _onTapButton();
          },
        ));
  }
}

class ListWidget extends StatefulWidget {
   ListWidget({Key key}) : super(key: key);
   List selectList = [];
  var europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Georgia',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kazakhstan',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Malta',
    'Moldova',
    'Monaco',
    'Montenegro',
    'Netherlands',
    'Norway',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'San Marino',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden',
    'Switzerland',
    'Turkey',
    'Ukraine',
    'United Kingdom',
    'Vatican City'
  ];
  Widget _myListView(BuildContext context) {
    // backing data
    return ListView.builder(
      itemCount: selectList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Image.file(selectList[index]),
        );
      },
    );
  }


  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<ListWidget> {



 Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
        widget.selectList.add(image);
    });
  }

Future openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
        widget.selectList.add(image);
    });
  }

  Future<void> _optionsDialogBox() {
  return showDialog(context: context,
    builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                GestureDetector(
                  child: new Text('Take a picture'),
                  onTap: () {getImage();},
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: new Text('Select from gallery'),
                  onTap: () {openGallery();
                  Navigator.pop(context); },
                ),
              ],
            ),
          ),
        );
      });
}

  _addItem() {
    _optionsDialogBox();
    setState(() {
      this.widget.europeanCountries.add("NEW VALUE");
    });
  }
  _renderBody(context) {
    return widget._myListView(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column
    (children: <Widget>[
      Expanded(child:widget._myListView(context)),
      MaterialButton(child: Text("ADD"),onPressed: (){
        getImage();
      },)
    ],);
  }
}
