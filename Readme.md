# docker-mirakurun-epgstation-with-nvenc

[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

# Fork 元との差分

- NVENC 対応の FFMPEG を別コンテナに切り出すことでバージョンアップ等の利便性を向上

  - WSL2 上では DinD の re-mount ができない(バグ?)ため常時 ffmpeg 用コンテナをホスト側から起動して必要時に exec している

- nvenc 用の live 配信 m2tsll 設定の追加
- nvenc 用エンコード設定の追加(h264, h265, av1)

## 前提条件

- Docker, docker-compose の導入が必須
- ホスト上の pcscd は停止する
- チューナーのドライバが適切にインストールされていること
- NVENC 対応 GPU のドライバ等がインストールされていること

## インストール手順

```sh
curl -sf https://raw.githubusercontent.com/l3tnun/docker-mirakurun-epgstation/v2/setup.sh | sh -s
cd docker-mirakurun-epgstation

#チャンネル設定
vim mirakurun/conf/channels.yml

#コメントアウトされている restart や user の設定を適宜変更する
vim docker-compose.yml
```

## 起動

```sh
sudo docker-compose up -d
```

## チャンネルスキャン地上波のみ(取得漏れが出る場合もあるので注意)

```sh
curl -X PUT "http://localhost:40772/api/config/channels/scan"
```

mirakurun の EPG 更新を待ってからブラウザで http://DockerHostIP:8888 へアクセスし動作を確認する

## 停止

```sh
sudo docker-compose down
```

## 更新

```sh
# mirakurunとdbを更新
sudo docker-compose pull
# epgstationを更新
sudo docker-compose build --pull
# 最新のイメージを元に起動
sudo docker-compose up -d
```

## 設定

### Mirakurun

- ポート番号: 40772

### EPGStation

- ポート番号: 8888
- ポート番号: 8889

### 各種ファイル保存先

- 録画データ

`./recorded`

- サムネイル

`./epgstation/thumbnail`

- 予約情報と HLS 配信時の一時ファイル

`./epgstation/data`

- EPGStation 設定ファイル

`./epgstation/config`

- EPGStation のログ

`./epgstation/logs`

## v1 からの移行について

[docs/migration.md](docs/migration.md)を参照
