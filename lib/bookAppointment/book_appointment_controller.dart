import 'dart:convert';

import 'package:aownapp/appointment/appointment_model.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aownapp/constant.dart';
import 'package:intl/intl.dart';
class BookAppointmentController extends GetxController{
  Rx<TimeOfDay> selectedTime=TimeOfDay(hour: 0, minute: 0).obs;
   Map<String, List<Event>> selectedEvents={};
  Future<AppointementModel?> getAppointmentApi(String charityId,String donorId)async{

    try {
      print('call api');
      final response =await http.post(Uri.parse(constant.getBookAppointmentUrl),body: {
        'charityId':charityId,
      });
      Map map=jsonDecode(response.body);
      print('outside if');
      print(map['ResponseCode'].runtimeType);
      if(map['ResponseCode']== "200"){
        print('inside if');
        AppointementModel  appointementModel= AppointementModel.fromJson(jsonDecode(response.body));
        selectedEvents={};
        for(Datum item in appointementModel.data){
          if(selectedEvents.isNotEmpty){
            List<Event> eventList=selectedEvents[DateFormat('yyyy-MM-dd').format(item.appointmentDate)] ?? [];
            if(eventList.isNotEmpty){
              eventList.add(Event(time: item.appointmentTime, reserved: item.reserved, appointmentId: item.appointmentId));
            }else{
              selectedEvents[DateFormat('yyyy-MM-dd').format(item.appointmentDate)]=[Event(time: item.appointmentTime,reserved: item.reserved,appointmentId: item.appointmentId)];
            }
          }else{
            selectedEvents[DateFormat('yyyy-MM-dd').format(item.appointmentDate)]=[
              Event(time: item.appointmentTime,reserved: item.reserved,appointmentId: item.appointmentId),
            ];
          }

        }
        return appointementModel;
      }else{
        return null;
      }

    } on Exception catch (e,stk) {
      debugPrint(e.toString());
      debugPrint(stk.toString());
    }

    return null;
  }

}