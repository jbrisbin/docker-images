RUN \
  git config --global url."ssh://git@github.com/".insteadOf https://github.com/ && \
  git config --global url."ssh://git@github.com".insteadOf git://github.com
RUN \
  mkdir -p /etc/ssh/ && \
  echo "StrictHostKeyChecking no" >>/etc/ssh/ssh_config
