FROM wojooo/inker:0.6.0

RUN node -e 'const fs = require("fs"); const path = "/app/dist/main.js"; let source = fs.readFileSync(path, "utf8"); const from = "const plugin = instance.plugin;\n        const settings = this.getDecryptedSettings(instance);\n        const { width, height } = this.getDimensionsForLayout(layout);"; const to = "const plugin = instance.plugin;\n        const settings = this.getDecryptedSettings(instance);\n        const baseDimensions = this.getDimensionsForLayout(layout);\n        const width = Number(settings.screen_width) || baseDimensions.width;\n        const height = Number(settings.screen_height) || baseDimensions.height;"; if (!source.includes(to)) { if (!source.includes(from)) throw new Error("Could not find plugin render dimension block"); source = source.replace(from, to); fs.writeFileSync(path, source); }'

RUN printf '%s\n' \
    '#!/command/with-contenv sh' \
    'set -eu' \
    'rm -f /etc/nginx/sites-enabled/default' \
    > /etc/cont-init.d/99-disable-nginx-default \
    && chmod +x /etc/cont-init.d/99-disable-nginx-default
