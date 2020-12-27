FROM debian:buster
MAINTAINER tgagor, https://github.com/tgagor

# Install required packages
RUN apt-get update && \
    apt-get install -y php-cli php-mysql php-readline curl unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV WP_CLI_VERSION 0.24.0
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN if [ "$WP_CLI_VERSION" == "latest" ]; then \
      curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    else \
      curl -L -o wp-cli.phar https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar; \
    fi && \
    mv wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    wp --allow-root --version

CMD ["/usr/local/bin/wp"]
