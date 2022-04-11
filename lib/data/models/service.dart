class Service {
  String? serviceDetails;
  String? serviceLocation;
  String? serviceName;
  String? servicePayment;
  String? serviceProvider;

  Service(
      {this.serviceDetails,
      this.serviceLocation,
      this.serviceName,
      this.servicePayment,
      this.serviceProvider});

  factory Service.fromMap(map) {
    return Service(
      serviceDetails: map['serviceDetails'],
      serviceLocation: map['serviceLocation'],
      serviceName: map['serviceName'],
      servicePayment: map['servicePayment'],
      serviceProvider: map['serviceProvider'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'serviceDetails': serviceDetails,
      'serviceLocation': serviceLocation,
      'serviceName': serviceName,
      'servicePayment': servicePayment,
      'serviceProvider': serviceProvider,
    };
  }
}
