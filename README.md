![Homelab](./assets/homelab.png)
# Homelab

## 📖 Overview

This repository contains almost everything relating to my personal Homelab, including Infrastructure as Code, application manifests and more. Previosuly I had a repo for each app I deployed, and this resulted in a lot of relatively empty repos, that were interconnected and required updates to be made in multiple places.

I document my journey of building my Homelab on my [blog](https://joe.izzard.me/series/homelab/).

## 🖥️ Hardware

Currently, my homelab features three primary pieces of hardware:

### Minisforum MS01

My MS01 is the primary compute device in my Homelab. It's an amazing small form factor PC that features dual 2.5GB NICs, dual SFP+ ports and thunderbolt.

| Component | Specification |
| ----- | ----- |
| CPU | Intel i9-13900H |
| RAM | 96GB 5600MHz DDR5 |
| Boot Drive | 1 x 500GB M.2 |
| Storage | 2 x 4TB M.2 |

This machine is running Proxmox, allowing me to run Virtual Machines on it.

### Custom Build TrueNAS Server

My TrueNAS server is a custom build HL15. A lot of the choices for this build copy the choices made in the HL15 "fully built and burned in" configuration, but as I am UK based, it made more sense to buy from UK based suppliers instead of paying the import fees. Especially as I would have needed to upgrade the PSU to support the extra SSD drives. Being able to get a lot of the components second hand also helped reduce the cost of the build.

| Component | Specification |
| ----- | ----- |
| Case | 45Drives HL15, Black |
| Motherboard | Supermicro X11SPH-NCTPF |
| CPU | Intel Xeon Silver 4216 (16 Core, 2.10 GHz) |
| CPU Cooler | Noctua NH-D9 4U |
| RAM | 256GB DDR4 2400MHz ECC |
| HBA | LSI 9300-8i |
| Boot Drive | 2 x 64GB Innodisk SATADOM |
| Primary Storage | 15 x 20TB Western Digital (Shucked Elements) |
| SSD Storage | 6 x 2TB Samsung 870 EVO |
| PSU | Corsair RM850e |
| Cooling | 6 x Noctua NF-A12x25 120mm^ |

^ The Cooling is the same as the HL15 Noctua Upgrade, with the fan controller and hub.

### Home Assistant

For Home Assistant, I went with the Home Assistant Yellow. This purpose built device includes everything you need to run Home Assistant.

| Component | Specification |
| ----- | ----- |
| Compute Module | Raspberry Pi CM4 Lite 8GB |
| Storage | 1 x 500GB Samsung 970 EVO Plus M.2 |
| ZWave Module | Aeotec Z-Pi 7 |

## 🗃️ Folder Structure

```shell
.
├── 📂 infrstructure          # IaC for managing the infrastructure
│   ├── 📂 ansible            # Ansible playbook and inventory
│   ├── 📂 dns                # DNS Control code
│   └── 📂 terraform          # Terraform configuration
└── 📂 services               
    ├── 📂 argocd-apps        # ArgoCD App of Apps
    │    ├── 📂 projects
    │    ├── 📂 applications
    │    └── 📂 root
    ├── 📂 argocd             # ArgoCD Application Deployment
    └── 📂 ...                # Other services

```

The majority of this repository is split into two primary sections:

- 📂 infrstructure - IaC and Scripts for managing the infrastructure in my Homelab
- 📂 services - Code and manifests for the applications I deploy in the Homelab

## ⚙️ Components

- [OpenTofu](https://opentofu.org/) - IaC tool that I use to manage the infrastructure in my Homelab
- [Ansible](https://www.ansible.com/) - Automation tool that I use to manage the configuration of the hardware/services in my Homelab
- [DNSControl](https://stackexchange.github.io/dnscontrol/) - DNS management tool that I use to manage the DNS zones in my Homelab
- [1Password](https://1password.com/) - Password manager that I use to manage the credentials for the services in my Homelab

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details. Feel free to use the code as a starting point for your own homelab, you can use as much or as little as you want, although some parts are specific to my Homelab such as DNS.

