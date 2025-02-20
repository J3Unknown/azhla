class OTPObject {
  int? otpCode;
  String? otpLink;

  OTPObject({this.otpCode, this.otpLink});

  OTPObject.fromJson(Map<String, dynamic> json) {
    otpCode = json['otp_code'];
    otpLink = json['otp_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp_code'] = this.otpCode;
    data['otp_link'] = this.otpLink;
    return data;
  }
}
