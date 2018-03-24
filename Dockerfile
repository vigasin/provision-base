FROM alpine:3.7

RUN set -ex \
    && apk add --update openssh-client ansible

COPY ansible.cfg /etc/ansible/ansible.cfg
COPY entrypoint.sh /entrypoint.sh
COPY merge_config.py /usr/local/bin/

ONBUILD COPY playbooks /playbooks
ONBUILD RUN [ -f /playbooks/requirements.yml ] && ansible-galaxy install -r /playbooks/requirements.yml

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/playbooks/main.yml"]
