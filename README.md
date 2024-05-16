# brash_demonstrations
A few demonstrations using BRASH with a few different robots

More complete/updated documentation for this repo here: https://traclabs-brash.bitbucket.io/brash_docker_spaceros.html


Build spaceros-ros robots brash images (for rosfsw)
===================================================

1. Clone cFS, brash and juicer:

   ```
   $ cd brash_demonstrations
   $ ./scripts/clone_repos.sh
   ```
1. Build base images :
   ```
   $ ./scripts/build_images.sh
   ```
3. Build cfe/brash and pride:
   ```
   $ ./scripts/build_cfe.sh
   $ ./scripts/build_brash.sh
   ```
  
   
Raspberry PI nodes:
===================

Install with these instructions: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview .
Note that they use the snap version of the imager instead of the one that you can download. Do that! When I tried to use the
downloaded version, it did strange things to my SD card. I had to reboot, delete and re-write Ubuntu 22.04, Server using the snap imager.

Network: Put your password in /etc/netplan/50-xxxx.yaml

If you cannot SSH: https://askubuntu.com/questions/1495190/how-to-enable-ssh-23-10-raspberry-pi . Look at the answer of teeks99 on Jan 1, 2024: In short: Seems that raspberry has an additional
ssh file /etc/ssh/sshd_config.d/50-cloud-init.conf (mine is 60-xxxx). Set password auth to true here. Seems this file overrrides the other ssh config files.

If takes like 2 minutes for a network service to timeout: https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/2036358 (in short: I changed optional to false). I arrived to that link from: https://www.reddit.com/r/Ubuntu/comments/16xi5h0/how_do_i_fix_systemdnetworkdwaitonlineservice/


