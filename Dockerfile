FROM manjarolinux/base
RUN pacman -Syu --noconfirm
RUN pacman -S git fakeroot nano binutils make gcc gettext --noconfirm
RUN pacman -S --needed --noconfirm sudo
RUN useradd builduser -m
# Delete the buildusers password
RUN passwd -d builduser
# Allow the builduser passwordless sudo
RUN printf 'root ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
COPY install_yay.sh /usr/bin/install_yay.sh
RUN chmod +x /usr/sbin/install_yay.sh
# Normal user operations
RUN sudo -u builduser install_yay.sh
RUN sudo -u builduser yay -Syu \
firefox \
--noconfirm
# Clean up packages
RUN pacman -Sc
CMD bash
