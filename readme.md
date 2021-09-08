# haiku
gentoo linux with

system configurations

and some eye candy

# branches
There are two branches in this repo, desktop and laptop. Each branch being for
configuration for a specific computer.

# repo layout
There are three directories in this repo each representing a btrfs subvolume.
The two distros I have installed, Gentoo and Void, are setup in a way that I can boot
from either without any issue.

# current hardware
Lenovo ThinkPad X1 Yoga Gen 6

# Gentoo
I use Gentoo with musl libc and Clang systemwide. GCC is not installed on this system.
Configuration specific to Gentoo is located in the `gentoo` directory.

Many of the patches in this repo do not belong to me. I will provide a link where I
find these patches in the future to give proper credit.

# Void
For applications that require glibc, I have a chroot where Void is installed.
This chroot is bootable incase I ever need it. Configuration specific to Void
are located in the `void` directory.

# home directory structure
My home directory is read-only and contains seven directories.
| Directory | Description                                                            |
| :-------: | :--------------------------------------------------------------------- |
| bin       | Contains mostly scripts.                                               |
| cfg       | The XDG_CONFIG_HOME directory.                                         |
| data      | The XDG_DATA_HOME directory.                                           |
| doc       | Contains documents and repos.                                          |
| media     | Contains videos and images.                                            |
| opt       | Contains software not installed system wide.                           |
| tmp       | Contains cache (XDG_CACHE_HOME is ~/tmp/cache) and other random files. |

These directories can be changed in home/cfg/loksh/profile and home/cfg/user-dirs.dirs.

# notable things i use
| Category | Application | 
| :------: | :---------: | 
| wm       | wayfire     |
| terminal | foot        |
| editor   | Kakoune     |
| shell    | loksh       |
| launcher | bemenu      |

Some of the scripts used can be found in my [scripts repo](https://gitlab.com/yemou/scripts)
and others can be found in home/bin. [This repo](https://github.com/yemouu/setup) as well as
the [scripts repo](https://github.com/yemouu/scripts) can also be found on GitHub.

# note
These configurations are specific to my system and are not guaranteed to work on yours.
