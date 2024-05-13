class CheckoutFormData {
  // checkout
  String? amount;
  String? currency;

  // billing details
  String? billingFirstName;
  String? billingLastName;
  String? billingMobile;
  String? billingPhone;
  String? billingEmail;
  String? billingCompanyName;
  String? billingStreetAddress1;
  String? billingStreetAddress2;
  String? billingTownCity;
  String? billingProvince;
  String? billingCountry;
  String? billingPostcode;

  // shipping details
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingMobile;
  String? shippingPhone;
  String? shippingEmail;
  String? shippingCompanyName;
  String? shippingStreetAddress1;
  String? shippingStreetAddress2;
  String? shippingTownCity;
  String? shippingProvince;
  String? shippingCountry;
  String? shippingPostcode;

  // recurring payments
  int paymentType;
  String? startDate;
  String? endDate;
  String? recurringAmount;
  String? interval;
  int? isRetry = 0;
  int? retryAttempts = 0;
  int? doFirstPayment = 0;

  CheckoutFormData({
    this.amount,
    this.currency,
    this.billingFirstName,
    this.billingLastName,
    this.billingMobile,
    this.billingEmail,
    this.billingStreetAddress1,
    this.billingTownCity,
    this.billingCountry,
    this.billingPostcode,
    this.billingPhone = '',
    this.billingStreetAddress2 = '',
    this.billingProvince = '',
    this.billingCompanyName = '',
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingMobile,
    this.shippingPhone,
    this.shippingEmail,
    this.shippingCompanyName,
    this.shippingStreetAddress1,
    this.shippingStreetAddress2,
    this.shippingTownCity,
    this.shippingProvince,
    this.shippingCountry,
    this.shippingPostcode,
    this.paymentType = 1,
    this.startDate,
    this.endDate,
    this.recurringAmount,
    this.interval,
    this.isRetry,
    this.retryAttempts,
    this.doFirstPayment
  });
}

