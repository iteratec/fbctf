FROM ubuntu:xenial

ENV HOME /home

ARG DOMAIN
ARG EMAIL
ARG MODE=dev
ARG TYPE=self
ARG KEY
ARG CRT

WORKDIR $HOME
COPY . $HOME


RUN apt-get update && apt-get -y install sudo apt-utils
RUN ./extra/provision.sh -m $MODE -c $TYPE -k $KEY -C $CRT -D $DOMAIN -e $EMAIL -s `pwd` --docker --multiple-servers --server-type cache

RUN addgroup ctf-user && \
    adduser --disabled-password --ingroup ctf-user -u 1001 ctf-user && \
    echo "%ctf-user ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers && \
    chown -R 1001 ./extra/cache/cache_startup.sh && \
    chmod +x ./extra/cache/cache_startup.sh
    # && \
    # chgrp -R 0 /juice-shop/ && \
    # chmod -R g=u /juice-shop/
USER 1001
# CMD ["ls -lha"]
CMD ["./extra/cache/cache_startup.sh"]
