{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "esphome-dashboard";
  version = "20220925.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jlHS+Hdu1FWV/nJiiferOdyThWyIc21uAFFlh4BD+M4=";
  };

  # no tests
  doCheck = false;

  pythonImportsCheck = [
    "esphome_dashboard"
  ];

  meta = with lib; {
    description = "ESPHome dashboard";
    homepage = "https://esphome.io/";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ hexa ];
  };
}
