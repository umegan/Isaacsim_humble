# Isaac Sim と ROS 2 Humble

このリポジトリには、Docker コンテナ内で NVIDIA Isaac Sim 4.5.0 と ROS 2 Humble 統合をセットアップするための設定ファイルとスクリプトが含まれています。

この環境を使用することで、Turllebot Limeのデモを含めたIsaac Sim 4.5.0の環境を構築することができます。

## 前提条件

- 最新ドライバーがインストールされた NVIDIA GPU
- NVIDIA Container Toolkit がインストールされた Docker
- 少なくとも 30GB の空きディスク容量
- Ubuntu 22.04 

## インストール方法

### 1. このリポジトリをクローンする

```bash
git clone https://github.com/umegan/Isaacsim_humble.git isaac_humble
cd isaac_humble
```

### 2. Docker イメージをビルドする

```bash
cd docker
docker build -t isaac_ws:latest .
```

これにより、NVIDIA の Isaac Sim 4.5.0 イメージをベースに、ROS 2 Humble 統合を含むカスタム Docker イメージがビルドされます。

### 3. 永続ストレージ用の必要なディレクトリを作成する

```bash
mkdir -p ~/docker/isaac-sim/{cache/kit,cache/ov,cache/pip,cache/glcache,cache/computecache,logs,data,documents}
```

## 使用方法


### Isaac Sim の実行

1. Docker containerを起動する
```bash
isaac_sim_docker.sh
```

2. RemoteからIsaac Sim を起動するには:

```bash
runheadless
```

3. Omniver Streaming Client から接続を行う:

https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/download.html

サーバ側のIPアドレスを記入して起動する

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
├── lime_ws - Isaac Sim用のTurtlebot Limeをこちら（）からCloneした物
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
