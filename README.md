# Isaac Sim と ROS 2 Humble

このリポジトリには、Docker コンテナ内で NVIDIA Isaac Sim 4.5.0 と ROS 2 Humble 統合をセットアップするための設定ファイルとスクリプトが含まれています。

## 前提条件

- 最新ドライバーがインストールされた NVIDIA GPU
- NVIDIA Container Toolkit がインストールされた Docker
- 少なくとも 30GB の空きディスク容量
- Ubuntu 20.04 以降（推奨）

## インストール方法

### 1. このリポジトリをクローンする

```bash
git clone https://github.com/umegan/Isaacsim_humble.git
cd Isaacsim_humble
```

### 2. Docker イメージをビルドする

```bash
cd docker
docker build -t isaac-sim:custom .
```

これにより、NVIDIA の Isaac Sim 4.5.0 イメージをベースに、ROS 2 Humble 統合を含むカスタム Docker イメージがビルドされます。

### 3. 永続ストレージ用の必要なディレクトリを作成する

```bash
mkdir -p ~/docker/isaac-sim/{cache/kit,cache/ov,cache/pip,cache/glcache,cache/computecache,logs,data,documents}
```

## 使用方法

### Docker Compose を使用して Isaac Sim を実行する

このリポジトリには Docker Compose の設定ファイルが含まれています。これを使用して簡単に Isaac Sim コンテナを起動できます。

1. まず、Docker Compose がインストールされていることを確認してください:

```bash
sudo apt-get update
sudo apt-get install docker-compose-plugin
```

2. Docker Compose で Isaac Sim コンテナを起動します:

```bash
cd /home/$USER$/sim
docker compose up
```

これにより、バックグラウンドで実行したい場合は `-d` フラグを追加します:

```bash
docker compose up -d
```

3. コンテナを停止するには:

```bash
docker compose down
```

4. コンテナのログを表示するには:

```bash
docker compose logs
```

5. 実行中のコンテナに接続するには:

```bash
docker exec -it isaac-sim bash
```

### Isaac Sim の実行

1. RemoteからIsaac Sim を起動するには:

```bash
cd /isaac-sim
./runoldstreaming.sh
```

2. Omniver Streaming Client から接続を行う:

https://docs.isaacsim.omniverse.nvidia.com/latest/installation/download.html

### ROS 2 Humble の操作

コンテナには ROS 2 Humble が事前にインストールされています。以下の環境変数が既に設定されています:

- RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
- ループバックでのマルチキャストが有効化されています
- ROS 2 のソースは .bashrc に追加されています

コンテナ内の `/root/colcon_ws` に ROS 2 ワークスペースを作成できます。

## プロジェクト構造

```
.
├── LICENSE - MIT ライセンス
├── README.md - このファイル
├── docker-compose.yml - Docker Compose 設定ファイル
├── runoldstreaming.sh - Isaac Sim ストリーミングサーバーを起動するスクリプト
├── isaac_sim_docker.sh - Isaac Sim コンテナを実行するスクリプト（ルートディレクトリのコピー）
└── docker/
    ├── Dockerfile - Isaac Sim + ROS 2 Humble イメージをビルドする
    └── isaac_sim_docker.sh - Isaac Sim コンテナを実行するスクリプト
```

## 注意事項

- Docker イメージは公式の NVIDIA Isaac Sim 4.5.0 イメージをベースに ROS 2 Humble を追加しています
- コンテナはホストの X11 サーバーを使用して GUI を表示します
- データの永続性はホストファイルシステムへのボリュームマウントによって管理されています
- RViz2 および一般的な ROS 2 ツールがコンテナにインストールされています

## ライセンス

このプロジェクトは MIT ライセンスの下で提供されています - 詳細はライセンスファイルをご覧ください。
