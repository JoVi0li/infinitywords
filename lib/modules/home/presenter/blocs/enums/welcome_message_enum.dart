enum WelcomeMessageEnum {
  goodMorning('Bom\nDia'),
  goodAfternoon('Boa\nTarde'),
  goodNight('Boa\nNoite');

  const WelcomeMessageEnum(this.value);
  final String value;
}
