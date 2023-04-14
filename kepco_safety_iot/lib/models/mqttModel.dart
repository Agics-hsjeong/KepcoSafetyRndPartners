import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:kepco_safety_iot/models/models.dart';

String FR_TOPIC = '/AI_KEPCO/AI_FACE_RECOGNIZE/REPORT',
    PPE_TOPIC = '/AI_KEPCO/AI_OD_PPE_DETECT/REPORT',
    WORK_TOPIC = '/AI_KEPCO/AI_OD_WORK_DETECT/REPORT',
    CON_TOPIC = '/AI_KEPCO/AI_OD_CON_SETUP_DETECT/REPORT',
    BI_TOPIC = '/AI_KEPCO/AI_BI_DETECT/REPORT',
    PL_TOPIC = 'PL_GW';

class AiMQTTClient {
  MqttServerClient client =
      MqttServerClient.withPort('$gwUrl', 'flutter_client', 1883);

  // MqttServerClient client =
  //     MqttServerClient.withPort('219.250.188.208', 'flutter_client', 50083);

  Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs("kepco", "!kepco1234")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    print('MQTTClient::Connected');
  }

  void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    print('MQTTClient::Ping response received');
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>> getMessagesStream() {
    return client.updates!;
  }
}

class GwMQTTClient {
  MqttServerClient client =
      MqttServerClient.withPort('$gwUrl', 'flutter_client', 1883);

  Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs("admin", "admin")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    print('MQTTClient::Connected');
  }

  void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    print('MQTTClient::Ping response received');
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>> getMessagesStream() {
    return client.updates!;
  }
}
