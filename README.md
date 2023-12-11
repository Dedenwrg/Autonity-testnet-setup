# Autonity Testnet Setup

This is a guide to setting up Autonity Testnet.

## Requirements

Here are the minimum recommended specifications for an Autonity node:

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| OS | Ubuntu 20.04 LTS | Ubuntu 20.04 LTS |
| CPU | 3.10 GHz with 8 CPUs | 3.10 GHz with 16 CPUs |
| RAM | 8GB | 16GB |
| Storage | 1024GB free space for full nodes and Validators | 1024 GB free space for full nodes and validators |
| Network Interface | 200 Mbit/s | 200 Mbit/s |

## Installation Steps

1. **Install Required Packages**

```bash
sudo apt install curl -y && curl -sO https://raw.githubusercontent.com/Dedenwrg/Autonity-testnet-setup/main/tools.sh && chmod +x tools.sh && bash tools.sh
```

2. **Install Autonity Go Client Node and Docker Image**

- Pull the Autonity Go Client image from Github Container Registry:

```bash
docker pull ghcr.io/autonity/autonity:latest
```

- Run Autonity as a Docker image:

Create the autonity-chaindata directory to store Autonity's working data:

```bash
mkdir autonity-chaindata
```

- Start the node:

```bash
curl -sO https://raw.githubusercontent.com/Dedenwrg/Autonity-testnet-setup/main/autonity.yml && docker-compose -f autonity.yml up -d --remove-orphans
```

- Useful commands:

Check Node logs:

```bash
docker compose -f "autonity.yml" logs -f --tail=200
```

Stop the node:

```bash
docker compose -f "autonity.yml" down --remove-orphans
```

Start the node:

```bash
docker-compose -f autonity.yml up -d --remove-orphans
```

3. **Setup Autonity Utility Tool (aut)**

Here's how to install and configure the aut command line tool on your local machine.

- Installation:

```bash
pipx install --force https://github.com/autonity/aut/releases/download/v0.3.0.dev3/aut-0.3.0.dev3-py3-none-any.whl
```

- Configuration using .autrc file:

Create a configuration file that holds the rpc endpoint.

```bash
echo '[aut]' > .autrc
echo 'rpc_endpoint = http://127.0.0.1:8545/' >> .autrc
```
