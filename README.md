# 사전 설치

## Nix
- [nix determinate](https://docs.determinate.systems/)

## Brew
- [brew.sh](https://brew.sh/ko/)

# 실행 순서

```sh
    brew install gh
    gh auth login
    sudo nix run nix-darwin -- switch --flake .
    # or sudo darwin-rebuild switch --flake .
```