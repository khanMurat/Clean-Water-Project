enum AppBarEnum {
  project('Project'),
  cProject('Completed Project'),
  profile('Profile'),
  ourWork('Our Work'),
  detail('Detail'),
  donation('Donation History'),
  payment('Payment');

  final String title;
  const AppBarEnum(this.title);
}
