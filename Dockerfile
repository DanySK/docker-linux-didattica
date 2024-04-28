FROM danysk/docker-manjaro-programming-cli-tools:251.20240425.1545
RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
RUN pacman-key --lsign-key 3056513887B78AEB
RUN pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
COPY chaotic-aur-config chaotic-aur-config
RUN cat chaotic-aur-config >> /etc/pacman.conf
RUN rm chaotic-aur-config
RUN yay-install gradle
RUN yay-install visual-studio-code-bin
RUN yay-install intellij-idea-community-edition
# From AUR
RUN yay-install diffutils
# RUN yay -Syu --noconfirm && yay-install eclipse-java
# # System configuration
# RUN eclipse -nosplash -application org.eclipse.equinox.p2.director\
#  -repository http://download.eclipse.org/releases/2020-12/,\
# http://download.eclipse.org/releases/2021-03/,\
# http://download.eclipse.org/releases/2021-06/,\
# http://download.eclipse.org/releases/2021-09/,\
# http://download.eclipse.org/releases/2021-12/,\
# http://protelis-eclipse.surge.sh/,\
# http://www.acanda.ch/eclipse-pmd/release/latest/,\
# https://checkstyle.org/eclipse-cs-update-site/,\
# https://spotbugs.github.io/eclipse/\
#  -installIU protelis.parser.feature.feature.group,\
# ch.acanda.eclipse.pmd.feature.feature.group,\
# net.sf.eclipsecs.feature.group,\
# com.github.spotbugs.plugin.eclipse.feature.group
# User configuration
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint
ENV XAUTHORITY=/.Xauthority
RUN useradd -ms /bin/zsh user
RUN passwd -d user
RUN printf 'user ALL=(ALL) ALL\n' | tee -a /etc/sudoers
USER user
RUN code --install-extension redhat.java
RUN code --install-extension vscjava.vscode-gradle
RUN code --install-extension mathiasfrohlich.Kotlin
RUN code --install-extension ms-azuretools.vscode-docker
RUN code --install-extension ms-python.python
RUN sudo echo this is to avoid the 'We trust you have received blah blah blah print'
WORKDIR /home/user
ENTRYPOINT ["/entrypoint"]
