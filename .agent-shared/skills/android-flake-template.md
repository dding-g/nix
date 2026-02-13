# Android/React Native 프로젝트 Flake 템플릿

## 기본 템플릿

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          platformVersions = [ "34" "33" ];
          buildToolsVersions = [ "34.0.0" ];
          includeNDK = true;
          ndkVersions = [ "26.1.10909125" ];
          includeEmulator = true;
          includeSystemImages = true;
          systemImageTypes = [ "google_apis_playstore" ];
          abiVersions = [ "arm64-v8a" ];
        };
        
        androidSdk = androidComposition.androidsdk;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            androidSdk
            jdk17
            gradle
            nodejs_22
            pnpm
            watchman
          ];
          
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          JAVA_HOME = "${pkgs.jdk17}";
          
          shellHook = ''
            export PATH="$ANDROID_HOME/platform-tools:$PATH"
          '';
        };
      }
    );
}
```

## 사용법

```bash
# 프로젝트 디렉토리에서
nix develop

# 또는 direnv 사용
echo "use flake" > .envrc
direnv allow
```

## Android SDK 옵션

| 옵션 | 설명 | 예시 |
|------|------|------|
| platformVersions | API 레벨 | `[ "34" "33" ]` |
| buildToolsVersions | 빌드 도구 | `[ "34.0.0" ]` |
| ndkVersions | NDK 버전 | `[ "26.1.10909125" ]` |
| includeEmulator | 에뮬레이터 포함 | `true` |
| systemImageTypes | 시스템 이미지 | `[ "google_apis_playstore" ]` |
| abiVersions | CPU 아키텍처 | `[ "arm64-v8a" "x86_64" ]` |

## 에뮬레이터 실행

```bash
# AVD 생성
avdmanager create avd -n pixel6 -k "system-images;android-34;google_apis_playstore;arm64-v8a"

# 에뮬레이터 실행
emulator -avd pixel6
```
