[![DOWNLOAD](./downlaod-v0.1.svg)](https://github.com/gilberto-009199/MyOS/releases/tag/v0.1)

# Caramelo OS

<img width="255px" src="home.png" alt="Tela de home"> <img width="255px" src="home-terminal-thunar.png" alt="Tela de home term thunar">

<img width="600px" src="boot-os.png" alt="Tela de Boot">

Distro Meme baseada em Debian.


```bash
$ ./start_workspace.bash

=== Wokspace Build Environment ===
Comandos disponíveis:
  lb clean    - Limpar build anterior
  lb config   - Configurar live build
  lb build    - Construir ISO
  lb bootstrap - Inicializar chroot
  lb chroot_install-packages install <package> - instala pacote

Exemplo de uso:
  # lb config --arch amd64 --distribution bookworm
  # lb build
 
|root@wokspace-build:~/wokspace/debian-version# lb clean
|root@wokspace-build:~/wokspace/debian-version# lb config
|root@wokspace-build:~/wokspace/debian-version# lb build

$ sudo qemu-system-x86_64 debian-version/caramelos-amd64.hybrid.iso -m 2048 -enable-kvm
```