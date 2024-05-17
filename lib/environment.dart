enum IPGEnvironment {
  dev,
  qa,
  sandbox,
  live,
}

String getEndpoint(IPGEnvironment? environment) {
  switch (environment) {
    case IPGEnvironment.dev:
      return "https://payable-ipg-dev.web.app/ipg/dev";
    case IPGEnvironment.qa:
      return "https://qaipgpayment.payable.lk/ipg/qa";
    case IPGEnvironment.sandbox:
      return "https://sandboxipgpayment.payable.lk/ipg/sandbox";
    case IPGEnvironment.live:
      return "https://ipgpayment.payable.lk/ipg/pro";
    case null:
      return "https://payable-ipg-dev.web.app/ipg/dev";
  }
}
