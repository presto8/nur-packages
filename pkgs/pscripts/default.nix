{
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation(finalAttrs: rec {
  pname = "pscripts";
  version = "2024-12-10";

  src = fetchFromGitHub {
    owner = "presto8";
    repo = "pscripts";
    rev = "v${version}";
    hash = "sha256-36j+d+CWwBd9nilNXD0FOzH3dEh9TfmC4su/6ckrVOs=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mapfile -d $'\0' matches < <(find -maxdepth 1 -mindepth 1 -type d -printf "%f\0")
    for exe in "''${matches[@]}"; do
      install -D -m 755 "$exe"/"$exe" $out/bin/"$exe"
    done

    runHook postInstall
  '';
})
