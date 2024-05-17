enum IPGEnvironment {
  dev,
  qa,
  sandbox,
  live,
}

String getEndpoint(IPGEnvironment? environment) {
  switch (environment) {
    case IPGEnvironment.dev:
      "https://payable-ipg-dev.web.app/ipg/dev";
      break;
    case IPGEnvironment.qa:
      "https://qaipgpayment.payable.lk";
      break;
    case IPGEnvironment.sandbox:
      "https://sandboxipgpayment.payable.lk";
      break;
    case IPGEnvironment.live:
      "https://ipgpayment.payable.lk";
      break;
    case null:
      "https://payable-ipg-dev.web.app/ipg/dev";
      break;
  }
  return "https://payable-ipg-dev.web.app/ipg/dev";
}
