FROM scratch
COPY --from=traefik:${VERSION}-alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=traefik:${VERSION}-alpine /usr/share/zoneinfo /usr/share/
COPY --from=traefik:${VERSION}-alpine /usr/local/bin/traefik /

EXPOSE 80
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]

# Metadata
LABEL org.opencontainers.image.vendor="Containous" \
	org.opencontainers.image.url="https://traefik.io" \
	org.opencontainers.image.title="Traefik" \
	org.opencontainers.image.description="A modern reverse-proxy" \
	org.opencontainers.image.version="$VERSION" \
	org.opencontainers.image.documentation="https://docs.traefik.io"

## Fix nssswitch not looking at hosts file (See https://github.com/containous/traefik/pull/6012)
RUN echo "hosts: files dns" > /etc/nsswitch.conf
