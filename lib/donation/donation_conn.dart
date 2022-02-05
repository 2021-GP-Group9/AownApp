import 'package:http/http.dart' as http;

class DonationConnection {
  static String donorId = "";

  Future uploadDonation(String donationId, List<bool> option) async {
    var data = <String, dynamic>{
      'donationId': donationId,
      'donorId': donorId,
      'type': option[0].toString(),
      'count': option[1].toString(),
      'color': option[2].toString(),
      'size': option[3].toString()
    };

    var response = await http.post(
      Uri.parse("https://awoon.000webhostapp.com/get_donor.php"),
      body: data,
    );
    print(response.body);
    return response.body;
  }
}
