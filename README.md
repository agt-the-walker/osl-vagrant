# Purpose

This small project shows how to successfully build then test the development
version of
[OpenShogiLib](https://gps.tanaka.ecc.u-tokyo.ac.jp/gpsshogi/index.php?OpenShogiLib).

Indeed it doesn't currently compile on Arch Linux 64-bit with latest updates.

# Requirements

* [Git](https://git-scm.com/)
* [Vagrant](https://www.vagrantup.com/) 1.5+

# Walkthrough

    $ cd ~/src/git  # or wherever you put your cloned github repos
      git clone https://github.com/agt-the-walker/osl-vagrant
      cd osl-vagrant/

    $ vagrant up
      ./test.sh
    [...]
    *** No errors detected

That's all folks!
