class PaymentInfoModel {
  final String uid;
  final String donationAmount;
  final String projectName;
  final String image;

  const PaymentInfoModel(
      this.uid, this.donationAmount, this.projectName, this.image);

  Map<String, dynamic> toMap() {
    return {
      'userUID': uid,
      'projectName': projectName,
      'donationAmount': donationAmount,
      'image': image
    };
  }
}
