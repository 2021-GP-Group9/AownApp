import 'dart:convert';

import 'package:aownapp/appointment/appointment_model.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aownapp/constant.dart';
import 'package:intl/intl.dart';

class BookAppointmentController extends GetxController {

  // that should be inside onInit method
  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 0, minute: 0).obs;
  Map<String, List<Event>> selectedEvents =
      {}; // to save appointment information

  Future<AppointementModel?> getAppointmentApi(
      String charityId, String donorId) async {
//getting appointments from database using api
    try {
      print('call api');
      final response =
          await http.post(Uri.parse(constant.getBookAppointmentUrl), body: {
        'charityId': charityId,
      });
      Map map = jsonDecode(response.body);
      if (map['ResponseCode'] == "200") {
        //store json date in appointmentModel which will bring data from the database
        AppointementModel appointementModel =
            AppointementModel.fromJson(jsonDecode(response.body));
        selectedEvents = {};
        // to store events in selectedEvents Map
        for (Datum item in appointementModel.data) {
          //selectedEvents map is not empty
          if (selectedEvents.isNotEmpty) {
            // local variable : eventList
            // if appointment date is not available in the map it will return null  then the value is null is converted into [] because of ??
            List<Event> eventList = selectedEvents[
                    DateFormat('yyyy-MM-dd').format(item.appointmentDate)] ??
                [];
            // eventList is not empty
            if (eventList.isNotEmpty) {
              // add event in eventList variable
              eventList.add(Event(
                  time: item.appointmentTime,
                  reserved: item.reserved,
                  appointmentId: item.appointmentId));
            } else {
              //if eventList is empty against appointment date it  will assign a list of single event to it
              selectedEvents[
                  DateFormat('yyyy-MM-dd').format(item.appointmentDate)] = [
                Event(
                    time: item.appointmentTime,
                    reserved: item.reserved,
                    appointmentId: item.appointmentId)
              ];
            }
          } else {
            selectedEvents[
                DateFormat('yyyy-MM-dd').format(item.appointmentDate)] = [
              Event(
                  time: item.appointmentTime,
                  reserved: item.reserved,
                  appointmentId: item.appointmentId),
            ];
          }
        }
        return appointementModel;
      } else {
        return null;
      }
    } on Exception catch (e, stk) {
      debugPrint(e.toString());
      debugPrint(stk.toString());
    }

    return null;
  }
}
