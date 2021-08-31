FROM danysk/docker-manjaro-programming-cli-tools:25.20210831.1853
RUN yay-install code
RUN yay-install gradle
RUN yay-install intellij-idea-community-edition
RUN yay-install spyder
# From AUR
RUN yay-install diffutils
RUN pacman-key --keyserver hkp://keyserver.ubuntu.com -r 3056513887B78AEB 8A9E14A07010F7E3
RUN pacman-key --lsign-key 3056513887B78AEB
RUN pacman-key --lsign-key 8A9E14A07010F7E3
COPY chaotic-aur-config /etc/pacman.d/chaotic-aur-config
RUN cat /etc/pacman.d/chaotic-aur-config >> /etc/pacman.conf
RUN yay -Syu --noconfirm && yay-install eclipse-java
# System configuration
RUN eclipse -nosplash -application org.eclipse.equinox.p2.director\
 -repository http://download.eclipse.org/releases/2020-12/,\
http://download.eclipse.org/releases/2021-03/,\
http://download.eclipse.org/releases/2021-06/,\
http://protelis-eclipse.surge.sh/,\
http://www.acanda.ch/eclipse-pmd/release/latest/,\
https://checkstyle.org/eclipse-cs-update-site/,\
https://spotbugs.github.io/eclipse/\
 -installIU protelis.parser.feature.feature.group,\
ch.acanda.eclipse.pmd.feature.feature.group,\
net.sf.eclipsecs.feature.group,\
com.github.spotbugs.plugin.eclipse.feature.group
# RUN yay-install xorg-xauth
ENV XAUTHORITY=/.Xauthority
CMD useradd user\
 && passwd -d user\
 && printf 'user ALL=(ALL) ALL\n' | tee -a /etc/sudoers\
 && cp -r /etc/skel/. /home/user\
 && chown user /home/user\
 && chmod 666 $XAUTHORITY\
 && cd /home/user/\
 && sudo -u user zsh
