class Client{
  final int ? id;
  final String name;
  final String ? identificationNumber;
  final String ? phoneNumber;


  const Client({
    this.id,
    required this.name,
    this.identificationNumber,
    this.phoneNumber
  });


}