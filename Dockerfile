FROM danysk/manjaro-programming-cli-tools
RUN yay-install code
RUN yay-install gradle
RUN yay-install intellij-idea-community-edition
RUN yay-install spyder
# From AUR
RUN yay-install diff eclipse-java
# System configuration
CMD zsh
