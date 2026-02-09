[![CD](https://github.com/JingYiJun/ubuntu-sshd/actions/workflows/cd.yml/badge.svg)](https://github.com/JingYiJun/ubuntu-sshd/actions/workflows/cd.yml)

# ubuntu-sshd

基于 Ubuntu 的 SSH 服务器 Docker 镜像，支持 **Ubuntu 22.04** 和 **Ubuntu 24.04**。

- 仅允许 **root** 用户登录
- 禁止密码登录，仅允许 **公钥认证**
- 必须通过 `AUTHORIZED_KEYS` 环境变量提供公钥

## 镜像地址

```
ghcr.io/jingyijun/ubuntu-sshd:24.04   # Ubuntu 24.04 (latest)
ghcr.io/jingyijun/ubuntu-sshd:22.04   # Ubuntu 22.04
ghcr.io/jingyijun/ubuntu-sshd:latest  # 等同于 24.04
```

## 快速开始

```bash
docker run -d \
  -p 2222:22 \
  -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" \
  ghcr.io/jingyijun/ubuntu-sshd:latest
```

然后通过 SSH 连接：

```bash
ssh -p 2222 root@localhost
```

## 环境变量

| 变量 | 必需 | 说明 |
|---|---|---|
| `AUTHORIZED_KEYS` | **是** | SSH 公钥内容（支持多个，每行一个） |
| `SSHD_CONFIG_ADDITIONAL` | 否 | 追加到 sshd_config 的额外配置 |
| `SSHD_CONFIG_FILE` | 否 | 包含额外 SSHD 配置的文件路径（需挂载） |

## 本地构建

```bash
# 构建 Ubuntu 24.04 版本（默认）
docker build -t ubuntu-sshd:24.04 .

# 构建 Ubuntu 22.04 版本
docker build -t ubuntu-sshd:22.04 --build-arg UBUNTU_VERSION=22.04 .
```

## 多架构支持

CI/CD 流程会为 `linux/amd64` 和 `linux/arm64` 两种架构构建镜像。

## License

[MIT License](LICENSE)
