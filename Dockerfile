FROM google/cloud-sdk:latest

RUN set -x && apt-get -y update && apt-get -y upgrade

WORKDIR /root
ENTRYPOINT ["/bin/bash"]
CMD ["--login", "-i"]
