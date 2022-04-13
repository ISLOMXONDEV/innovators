class Service {
  String? serviceDetails;
  String? serviceLocation;
  String? serviceName;
  int? servicePayment;
  String? serviceProvider;
  String? serviceContactNumber;
  String? serviceTgAccount;
  String? serviceProviderID;

  Service({
    this.serviceDetails,
    this.serviceLocation,
    this.serviceName,
    this.servicePayment,
    this.serviceProvider,
    this.serviceContactNumber,
    this.serviceTgAccount,
    this.serviceProviderID,
  });

  factory Service.fromMap(map) {
    return Service(
      serviceDetails: map['serviceDetails'],
      serviceLocation: map['serviceLocation'],
      serviceName: map['serviceName'],
      serviceProviderID: map['serviceProviderID'],
      servicePayment: map['servicePayment'],
      serviceProvider: map['serviceProvider'],
      serviceContactNumber: map['serviceContactNumber'],
      serviceTgAccount: map['serviceTgAccount'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'serviceDetails': serviceDetails,
      'serviceLocation': serviceLocation,
      'serviceName': serviceName,
      'serviceProviderID': serviceProviderID,
      'servicePayment': servicePayment,
      'serviceProvider': serviceProvider,
      'serviceContactNumber': serviceContactNumber,
      'serviceTgAccount': serviceTgAccount,
    };
  }
}
