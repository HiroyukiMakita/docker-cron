# Docker Cron

![Debian](https://img.shields.io/badge/Debian-CCCCCC?logo=debian&logoColor=AD1544)
![Cron](https://img.shields.io/badge/Cron-198EBE?logo=cron&logoColor=CCCCCC)
![Docker](https://img.shields.io/badge/Docker-Compose-1658DB?logo=docker&logoColor=white)
![Make](https://img.shields.io/badge/Make-822322?logo=gnu&logoColor=white)

リポジトリを `clone` 後、`make` を実行するだけで、cron が動き出します。  
デフォルトでは、実行時の日時をログファイルに書き込む処理が毎分実行されます。  
`./cron.d/schedule` を編集したり `./cron.d/` 配下にファイルを配置することで、`restartcron` で任意の処理を実行させることが可能です。  
※ コンテナ内で `./cron.d/` 配下に配置されるファイルの所有者は `root` ユーザーである必要があります。（`WRONG FILE OWNER` というエラーがでる）  
※ コンテナ内の `./cron.d/` は root 権限にしてあるから多分大丈夫だけどうまく動かない場合はそのへんの権限系を確認すること

また、コンテナ内の `/var/log/cron/` 配下に生成されたファイルはホストの `./logs/` 配下にマウントされるので永続化されます。

## build & up

```bash
$ make

# または、make コマンドが使えない方は以下

$ mkdir -p ./logs && \
  touch ./logs/schedule.log && \
  touch ./logs/schedule-error.log \
  docker compose build && \
  docker compose up -d && \
  docker compose exec linux bash
```

## cron が動いてるか確認する

```:bash
# コンテナに入る
$ make exec

# コンテナ内では以下のコマンドでいろいろできる
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
