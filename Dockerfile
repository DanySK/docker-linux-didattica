FROM danysk/docker-manjaro-programming-cli-tools:58.20220227.0957
RUN pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
RUN pacman-key --lsign-key FBA220DFC880C036
RUN pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
COPY chaotic-aur-config chaotic-aur-config
RUN cat chaotic-aur-config >> /etc/pacman.conf
RUN rm chaotic-aur-config
RUN yay-install code
RUN yay-install gradle
RUN yay-install intellij-idea-community-edition
RUN yay-install spyder
# From AUR
RUN yay-install diffutils
RUN yay -Syu --noconfirm && yay-install eclipse-java
# System configuration
RUN eclipse -nosplash -application org.eclipse.equinox.p2.director\
 -repository http://download.eclipse.org/releases/2020-12/,\
http://download.eclipse.org/releases/2021-03/,\
http://download.eclipse.org/releases/2021-06/,\
http://download.eclipse.org/releases/2021-09/,\
http://download.eclipse.org/releases/2021-12/,\
http://protelis-eclipse.surge.sh/,\
http://www.acanda.ch/eclipse-pmd/release/latest/,\
https://checkstyle.org/eclipse-cs-update-site/,\
https://spotbugs.github.io/eclipse/\
 -installIU protelis.parser.feature.feature.group,\
ch.acanda.eclipse.pmd.feature.feature.group,\
net.sf.eclipsecs.feature.group,\
com.github.spotbugs.plugin.eclipse.feature.group
# User configuration
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint
ENV XAUTHORITY=/.Xauthority
RUN useradd -ms /bin/zsh user
RUN passwd -d user
RUN printf 'user ALL=(ALL) ALL\n' | tee -a /etc/sudoers
USER user
RUN sudo echo this is to avoid the 'We trust you have received blah blah blah print'
WORKDIR /home/user
ENTRYPOINT ["/entrypoint"]
