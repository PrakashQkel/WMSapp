import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/MQTTClientWrapper.dart';

class InputTextBox extends StatelessWidget {

  final bool number;
  final String label;
  final Controller = TextEditingController();
  InputTextBox(this.label, this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        keyboardType: number ? TextInputType.number : TextInputType.text,
        controller: Controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
        ),
        onChanged: (value){
          if(label=='Broker')
            Provider.of<MQTTManager>(context, listen: false).broker=value;
          if(label=='Port')
            Provider.of<MQTTManager>(context, listen: false).port=int.parse(value);
          if(label=='Client ID')
            Provider.of<MQTTManager>(context, listen: false).clientID=value;
          if(label=='Topic')
            Provider.of<MQTTManager>(context, listen: false).topic=value;
        },
      ),
    );
  }
}
