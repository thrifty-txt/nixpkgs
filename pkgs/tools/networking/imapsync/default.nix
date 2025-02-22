{ lib
, fetchFromGitHub
, makeWrapper
, perl
, perlPackages
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "imapsync";
  version = "2.200";

  src = fetchFromGitHub {
    owner = "imapsync";
    repo = "imapsync";
    rev = "imapsync-${version}";
    sha256 = "sha256-EM8nT9v6ZHpEG33/ibPqvfgFoAF36nhq6Y+RUWK4vR0=";
  };

  postPatch = ''
    sed -i -e s@/usr@$out@ Makefile
    substituteInPlace INSTALL.d/prerequisites_imapsync --replace "PAR::Packer" ""
  '';

  postInstall = ''
    wrapProgram $out/bin/imapsync --set PERL5LIB $PERL5LIB
  '';

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = with perlPackages; [
    Appcpanminus
    CGI
    CryptOpenSSLRSA
    DataUniqid
    DistCheckConflicts
    EncodeIMAPUTF7
    FileCopyRecursive
    FileTail
    IOSocketInet6
    IOTee
    JSONWebToken
    LWP
    MailIMAPClient
    ModuleImplementation
    ModuleScanDeps
    NTLM
    PackageStash
    PackageStashXS
    Readonly
    RegexpCommon
    SysMemInfo
    TermReadKey
    TestDeep
    TestFatal
    TestMockGuard
    TestMockObject
    TestPod
    TestRequires
    UnicodeString
    perl
  ];

  meta = with lib; {
    description = "Mail folder synchronizer between IMAP servers";
    homepage = "https://imapsync.lamiral.info/";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ pSub ];
    platforms = platforms.unix;
  };
}
