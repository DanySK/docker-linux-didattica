FROM danysk/manjaro-programming-cli-tools:336.20250318.1443
USER build

RUN paru -Sy\
    diffutils\
    intellij-idea-community-edition-jre\
    visual-studio-code-bin\
    --noconfirm
RUN paru -Sccd --noconfirm

USER root
RUN ln -s /usr/sbin/idea-ce /usr/sbin/idea
RUN paccache -rk 0
COPY entrypoint /entrypoint
RUN sudo chmod +x /entrypoint
ENV XAUTHORITY=/.Xauthority
ENTRYPOINT ["/entrypoint"]

USER user
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
RUN code --install-extension vscjava.vscode-java-pack
RUN code --install-extension vscjava.vscode-gradle
RUN code --install-extension mathiasfrohlich.Kotlin
RUN code --install-extension ms-azuretools.vscode-docker
RUN code --install-extension ms-python.python
RUN sudo echo this is to avoid the 'We trust you have received blah blah blah print'
WORKDIR /home/user
