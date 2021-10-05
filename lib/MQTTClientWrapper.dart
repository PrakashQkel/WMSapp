import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//just a collection of connection statuses
enum MqttAppState{
  connected,
  connecting,
  disconnected,
  subscribed
}

//this class contains the functions for connecting, subscribing and listening to the MQTT server
class MQTTManager extends ChangeNotifier{

  MqttAppState appState = MqttAppState.disconnected; //initial state is disconnected
  MqttAppState previousState = MqttAppState.disconnected;

  late String receivedData;
  late String currentPage = 'Connection_page';

  late MqttServerClient client;
  late String broker;
  late String clientID;
  late int port;
  late String topic;

  double L1=0, L2=0, F1=0, F2=0, F3=0;

 /* void Change({newBroker, newClientID, newPort, newTopic}){
    broker = newBroker;
    clientID = newClientID;
    port = newPort;
    topic = newTopic;
    notifyListeners();
  }*/

  //function to initialize the MQTT client using provided broker, port and clientID
  void initializeClient(){
    client = MqttServerClient(broker, clientID);
    client.port = port;
    client.keepAlivePeriod = 100;
    client.secure = false;
    client.logging(on: true);

    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(clientID)
        .withWillTopic('willtopic')
        .withWillMessage("My will message")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
  }

  //function to connect to the MQTT broker
  void connect() async{
    assert(client != null);
    try{
      print('Start client connecting...');
      setConnectionState(MqttAppState.connecting);
      await client.connect();
    }
    on Exception catch(e){
      print('Client exception - $e');
      disconnect();
    }
  }

  //function to subscribe to a topic
  void subscribe(){
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  //function to disconnect from MQTT broker
  void disconnect(){
    client.disconnect();
  }

  //function to publish data to the broker
  void publish(String message){
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  //sets the connection status to Connected once the connection is successful
  void onConnected(){
    print('Connection successful');
    setConnectionState(MqttAppState.connected);
  }

  void onSubscribed(String topic){
    print('Subscription confirmed for topic: $topic');

    //listening for data from topic after successful subscription
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
      setReceivedData(pt);
    });
    //setting connection status to subscribed
    if(appState!=MqttAppState.subscribed)
      setConnectionState(MqttAppState.subscribed);
  }

  //setting connection status to Disconnected
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    setConnectionState(MqttAppState.disconnected);
  }

  //deserializing the received JSON data and storing them in floating point variables
  void setReceivedData(text){
    receivedData = text;
    Map<String, dynamic> data = jsonDecode(receivedData);
    L1 = double.parse(data['L1']);
    L2 = double.parse(data['L2']);
    F1 = double.parse(data['FM1']);
    F2 = double.parse(data['FM2']);
    F3 = double.parse(data['FM3']);
    notifyListeners();
  }

  //function to change the connection status
  void setConnectionState(state){
    appState = state;
    notifyListeners();
  }
}

