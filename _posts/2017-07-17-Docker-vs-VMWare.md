---
layout: post
title: "Docker vs VMWare"
date: 2017-07-17
categories: [Ml]
tags: [docker,vmware]
icon: icon-html
---
# Docker vs VMWare

> 一直在用VMware，最近用自己的笔记本docker搭TensorFlow环境玩，想搞清楚感觉底层的区别，看到这篇文章写的挺好顺带翻译下，感兴趣的可以读[原文](https://www.upguard.com/articles/docker-vs.-vmware-how-do-they-stack-up) 。

这是虚拟化技术的一场战争:一者是虚拟机技术，另一者是容器化技术。实际上，二者是互补的，因为硬件虚拟化和容器化都有他们的特质，而且可以组合在一起优势互补。下面就看看这二者之间的区别，以及他们怎么组合在一起来实现最大的灵活性。
## 容器VS虚拟机
简单来说，容器提供了操作系统层的处理隔离，而虚拟机提供硬件抽象层的隔离（也就是硬件虚拟化）。所以在Iaas的用例上，虚拟机是个理想的选择，容器则更适合用在有移植方便，模块化需求的软件上。再次强调，这两项技术可以组合在一起——比如说，docker容器可以安装在虚拟机内部，来让一个解决方案更加轻便。  

<img src="{{ site.img_path }}/docker/containers-blog.png">

### VMware
对VMware大家都比较熟悉，就不多做介绍了。vSphere是VMware的主要虚拟化套件由一系列的工具和服务组成，如ESXi，vCenter Server，vSphere Client, VMFS, SDKs等.  
ESXi是vSphere的核心套件：它是主要的hypervisor（虚拟机监视器）技术，使硬件虚拟化成为可能。Hypervisor的出现，让一台宿主机上可以有多个操作系统同时存在，并且分配有他们专用的资源，也就是说各个客户系统都有CPU,内存，以及其他系统所需的资源。Esxi直接运行在裸机服务器上，不需要内置的操作系统。一旦安装了ESXi，就会创建并运行它自己的微内核，由以下3个接口组成：
- **硬件**
- **客户系统**
- **控制台操作系统/service console**  
  当然除了VMware以外，微软的Hyper-V，Citrix XenServer,Oracle的VirtualBox等都是流行的hyperVisor技术。近年来，不少企业开始使用docker作为VMware未来的替代品，可以说docker卷起了虚拟化技术的一股新浪潮。
### Docker
Docker项目的主要目的，是为了让开发者能够透过容器，更简单的创建，部署以及运行应用。显然，对于DevOps（开发运维人员）和CI/CD initiatives来说，应用的可移植性和一致性是至关重要的，而这一点docker做的相当棒。容器可以将一个应用和所有该应用所需的库，依赖文件，资源封装在一起，从而实现简单的部署。通过使用Linux内核特征如namespacing和control groups来在操作系统层之上创建容器，这样应用部署从开发到生产就可以实现自动化和流水化。  

<img src="{{ site.img_path }}/docker/docker-lxc.png" align="middle">
在docker 0.9版本之后，Docker使用Go语言实现的libcontainer库替换了LXC，允许不同的供应商提供更广泛的原生支持。除此以外，Docker现在提供Windows的原生支持，实现windows开发环境上的docker管理。  
Docker为开发者和运营商提供了以下的好处：

- **部署快捷**：Docker容器封装了运行一个应用程序需求的最小资源，从而可以快捷，轻量的部署。
- **可移植性**：因为容器本质上是独立的，自给自足的一个软件集（Bundles），所以可以跨主机运行而没有兼容性问题
- **重用性**：容器可以版本化，存档，共享，而且可以回滚到应用的上一个版本（就像git）。平台设置可以通过代码来实现（dockerfile）。
## 对比
尽管二者都可以归类为虚拟化技术，但他们的理想使用场景有很大区别。比如说，VMware模拟虚拟化硬件，而且必须负责所有底层系统的需求，因此，虚拟机镜像往往比容器大很多。即便如此，我们仍然可以在宿主机上同时跑许多虚拟机实例，用VMware来实现虚拟化云平台。  
因为Docker容器由Docker引擎（与Hypervisor不同）管理执行，容器之间并不是完全隔绝。但是这个tradeoff只是一个很小的代价：不像VMware，docker不创建整个虚拟操作系统，取而代之的是，将应用程序所需的，而在宿主机上没有的资源成份打包在容器中。由于宿主机的kernel被众多docker容器共享，每个应用运行时只取他需要的资源，不多不少。这使得docker的应用比起虚拟机，可以更轻量、快捷的部署和启动。  
Docker容器比起虚拟机通常更快，更少的占用资源，但是VMware的全虚拟化形式仍有它独特的优点，即安全性和隔离性。既然虚拟机实现了真正的硬件层隔离，那虚拟机之间干扰的概率比起docker容器来说大大降低。所以如果追求应用可移植性，那么docker是最好的选择，而如果关注的是机器可移植性和更好的隔离性的话，请使用VMware。

