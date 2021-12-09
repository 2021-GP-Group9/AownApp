import 'dart:convert';
import 'package:aownapp/appointment/appointment_model.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aownapp/constant.dart';
import 'package:intl/intl.dart';

class BookAppointmentController extends GetxController {
  Map<String, List<Event>> selectedEvents =
      {};

  Future<AppointementModel?> getAppointmentApi(
      String charityId, String donorId) async {

    try {
      final response =
          await http.post(Uri.parse(constant.getBookAppointmentUrl), body: {
        'charityId': charityId,
      });
      Map map = jsonDecode(response.body);
      if (map['ResponseCode'] == "200") {
//to store json date in appointmentModel which will bring data from the database
        AppointementModel appointementModel =
            AppointementModel.fromJson(jsonDecode(response.body));
        selectedEvents = {};
        // to store events in selectedEvents Map
        for (Datum item in appointementModel.data) {
            if (selectedEvents.isNotEmpty) {
              // if appointment date is not available in the map it will return null  then the value is null is converted into [] because of ??
            List<Event> eventList = selectedEvents[
                    DateFormat('yyyy-MM-dd').format(item.appointmentDate)] ??
                [];
                        if (eventList.isNotEmpty) {
                            eventList.add(Event(
                  time: item.appointmentTime,
                  reserved: item.reserved,
                  appointmentId: item.appointmentId));
            } else {
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
