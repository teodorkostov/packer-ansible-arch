QEMU VM image with [Packer] and [Ansible].

### Build steps

1) Make sure you have packer installed (`$ packer-io`).
2) Prepare the `./images` folder.
3) Prepare credentials for a system user (`./resources/private/credentials.yaml`).
4) Run `build.sh`.

### Images

Needed files for the installation:
- Arch Linux ISO - can be downloaded from [here](https://www.archlinux.org/download/)
- OVMF binary - can be build from [here](https://aur.archlinux.org/packages/ovmf-git/)

### Credentials

Prepare a the credentials for the system user with the following syntax:
```yaml
---
username: terusus
password: {{ 'passwordsaresecret'|password_hash('sha512') }} # or hash it yourself ($6$<salt>$<hash>)
```

### Known issues

Unfortunately, it was not possible to use exclusively [Ansible] for the installation due to the following issues:
- Partitions are not created with the proper size: https://github.com/ansible/ansible/issues/23914
- No vfat support: https://github.com/ansible/ansible/pull/23527

### License (MIT)

Copyright 2017 Teodor Kostov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<!-- ## Links -->
[Packer]: https://www.packer.io/
[Ansible]: https://www.ansible.com/
