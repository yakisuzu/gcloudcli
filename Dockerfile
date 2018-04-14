FROM google/cloud-sdk:latest

RUN set -x && apt-get -y update && apt-get -y upgrade
ADD ./Dockerrc.sh /Dockerrc.sh
RUN chmod u+x /Dockerrc.sh

ENTRYPOINT ["/Dockerrc.sh"]

# ENTRYPOINT ["/bin/bash"]
# CMD ["--login", "-i"]
