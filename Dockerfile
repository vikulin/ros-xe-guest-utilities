FROM debian:12-slim

# Install curl and ca-certificates
RUN apt-get update \
 && apt-get install -y curl ca-certificates \
 && curl -L -o xe-guest-utilities.deb \
    https://github.com/xenserver/xe-guest-utilities/releases/download/v8.4.0/xe-guest-utilities_8.4.0-1_amd64.deb \
 && dpkg -i xe-guest-utilities.deb || apt-get -f install -y \
 && rm -f xe-guest-utilities.deb \
 && apt-get clean

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/xe-daemon"]
