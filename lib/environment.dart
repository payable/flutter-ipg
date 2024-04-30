enum IPGEnvironment {
  production,
  sandbox,
}

String getEndpoint(IPGEnvironment? environment) {
  if (environment == IPGEnvironment.sandbox) {
    return 'https://payable-ipg-dev.web.app/ipg/dev';
  } else {
    return 'https://payable-ipg-dev.web.app/ipg/dev'; //TODO: add live
  }
}
