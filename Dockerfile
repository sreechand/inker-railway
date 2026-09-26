FROM wojooo/inker:0.6.0

RUN printf '%s\n' \
    '#!/command/with-contenv sh' \
    'set -eu' \
    'rm -f /etc/nginx/sites-enabled/default' \
    > /etc/cont-init.d/99-disable-nginx-default \
    && chmod +x /etc/cont-init.d/99-disable-nginx-default