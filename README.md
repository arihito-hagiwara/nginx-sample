# nginx-sample

ECS(Fargate)上でnginxを動かすTerraform構成。VPCは`terraform-aws-modules/vpc/aws`を利用して新規作成する。

## 構成

```
modules/
  vpc/         terraform-aws-modules/vpc/aws をラップしたVPCモジュール
  ecs_nginx/   ECSクラスタ・nginxタスク・ALB一式を作るモジュール
staging/       staging環境から上記モジュールをcall
production/    production環境から上記モジュールをcall
```

- `staging/` と `production/` はそれぞれ独立したroot moduleで、`modules/vpc` と `modules/ecs_nginx` を呼び出す。
- ネットワーク: ALBはpublic subnet、ECSタスクはprivate subnet(NAT Gateway経由)に配置。
- コンテナイメージ: `modules/ecs_nginx`が作成するECRリポジトリを使う想定。初回applyではブートストラップ用に`public.ecr.aws/nginx/nginx`を使い、以降はCI/CDがECRへpushしたイメージで更新する(`container_definitions`の変更はTerraformで無視する設定にしている)。
- LB: 各環境ごとに新規ALBを作成(HTTPのみ。HTTPS化する場合はACM証明書を用意して`modules/ecs_nginx/lb.tf`にリスナーを追加する)。
- state: 現状はlocal backend。運用開始時は`staging/terraform.tf` / `production/terraform.tf`内のコメントアウトされているS3 backendを有効化する。

## 使い方

```sh
cd staging   # または production
terraform init
terraform plan
terraform apply
```
