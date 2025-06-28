# Docker Cron

![Debian](https://img.shields.io/badge/Debian-CCCCCC?logo=debian&logoColor=AD1544)
![Cron](https://img.shields.io/badge/Cron-198EBE?logo=cron&logoColor=CCCCCC)
![Docker](https://img.shields.io/badge/Docker-Compose-1658DB?logo=docker&logoColor=white)
![Make](https://img.shields.io/badge/Make-822322?logo=gnu&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

リポジトリを `clone` 後、`make` を実行するだけで、cron が動き出します。  
デフォルトでは、実行時の日時をログファイルに書き込む処理が毎分実行されます。

## ◯ 概要

`./cron.d/schedule` を編集したり `./cron.d/` 配下にファイルを配置することで任意の処理を実行させることが可能です。  
※ cron を再起動すると反映できます（`restartcron` エイリアスが使えます）  
※ コンテナ内で `./cron.d/` 配下に配置されるファイルの所有者は `root` ユーザーである必要があります。（`WRONG FILE OWNER` というエラーがでる）  
※ コンテナ内の `./cron.d/` は root 権限にしてあるから多分大丈夫だけどうまく動かない場合はそのへんの権限系を確認すること

また、コンテナ内の `/var/log/cron/` 配下に生成されたファイルはホストの `./logs/` 配下にマウントされるので永続化されます。

## ◯ build & up

- .env ファイルをコピーして、必要に応じて編集してください

特に、タイムゾーンを変更したい場合は、`TIMEZONE` の値を変更してください。  
（デフォルトは `Asia/Tokyo`）

```bash
$ cp -n .env.example .env
```

- `make` コマンドを実行して、コンテナをビルド＆起動します

```bash
$ make

# または、make コマンドが使えない方は以下

$ mkdir -p ./logs && \
  docker compose build && \
  docker compose up -d && \
  docker compose exec linux bash
```

## ◯ コンテナの起動や停止など

```bash
# コンテナの起動
$ make up
# コンテナに入る
$ make exec
# コンテナの停止
$ make down
```

## ◯ コンテナ内では以下のエイリアスでいろいろできる

```bash
# cron の起動
$ startcron

# cron の停止
$ stopcron

# cron の再起動
$ restartcron

# cron が動いてるか確認
$ cronstatus

# cron のログを tail -f 表示
$ cronlogs

# cron のログを less 表示
$ cronlogall
```
