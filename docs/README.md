![logo](https://github.com/Bash-it/media/raw/master/media/Bash-it.png)

Forked from [bash-it](https://github.com/Bash-it/bash-it) and customized it to my needs.

The `ups_master` branch is always synchronized with the [bash-it](https://github.com/Bash-it/bash-it)/`master`.

## Installation

1) Check out a clone of this repo to a location of your choice, such as
   ``git clone --depth=1 https://github.com/gatorliu/bash-it.git ~/.bash_it``
2) Run ``~/.bash_it/install.sh``

### custom configuration file location

By default the instller modifies/creates the actual ``~/.bashrc`` is updated.
If this is undesirable, you can create another file, by run the installer:
```bash
BASH_IT_CONFIG_FILE=path/to/my/custom/location.bash ~/.bash_it/install.sh
```
