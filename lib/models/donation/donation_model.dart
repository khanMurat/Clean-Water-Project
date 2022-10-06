class DonationInfo {
  String? projectName;
  String? imageURL;
  String? amount;

  DonationInfo({
    required this.projectName,
    required this.amount,
    required this.imageURL,
  });

  factory DonationInfo.fromMap(Map<String, dynamic> map) {
    return DonationInfo(
      projectName: map['projectName'] as String,
      amount: map['donationAmount'],
      imageURL: map['image'] as String,
    );
  }
}
