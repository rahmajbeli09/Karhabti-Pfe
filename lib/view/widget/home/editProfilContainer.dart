import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/client/editprofilcntroller.dart';

class EditProfilContainer extends StatelessWidget {
  final String title ;
  final String text;
  final String id;
   EditProfilContainer({Key? key, required this.title, required this.text, required this.id}) : super(key: key);
    final EditController editController = Get.put(EditController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 215, 204, 204),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(title,style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , fontFamily: "Comfortaa")),
          Row(
            children: [
              Text(text,style:const TextStyle(fontWeight: FontWeight.w400 , fontSize: 15 , fontFamily: "Comfortaa")),
              Spacer(),
              MaterialButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  editController.isEditing.toggle();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
