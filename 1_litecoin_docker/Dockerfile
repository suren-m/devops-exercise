FROM debian:stable-slim
WORKDIR /litecoin-setup

# Required tools: gpg and a http client
RUN apt update -y && apt install gnupg2 curl -y

#####------------------------------#####
# PGP Pub Key needed for verifaction
# Downloaded from http://pgp.mit.edu/pks/lookup?op=get&search=0xFE3348877809386C
# https://download.litecoin.org/README-HOWTO-GPG-VERIFY-TEAM-MEMBERS-KEY.txt
#####------------------------------#####
COPY pgp_pub_key litecoin_pgp_pub_key
RUN gpg --import litecoin_pgp_pub_key

# Download the signatures that are required for checksum and gpg verification
RUN curl -O https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc

#####------------------------------#####
# 1. Download litecoin tar ball
# 2. Verify checksum
# 3. Verfiy signature using the imported pgp_pub_key
# 4. Extract binary
# 5. Move binary to /usr/local/bin
# 6. Provide execute permissions
# 7. Check if litecoin daemon is correctly installed
#####------------------------------#####
RUN curl -O https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz \
    && grep 'litecoin-0.18.1-x86_64-linux-gnu.tar.gz' litecoin-0.18.1-linux-signatures.asc | sha256sum --check \
    && gpg --verify litecoin-0.18.1-linux-signatures.asc \
    && tar xzvf litecoin-0.18.1-x86_64-linux-gnu.tar.gz litecoin-0.18.1/bin/litecoind \
    && mv litecoin-0.18.1/bin/litecoind /usr/local/bin/ \
    && chmod +x /usr/local/bin/litecoind \
    && litecoind -version

RUN groupadd -r litecoin && useradd -r litecoin --create-home -g litecoin
USER litecoin
RUN mkdir -p /home/litecoin/.litecoin/data

EXPOSE 9332 9333 19332 19333 19444
WORKDIR /home/litecoin
ENTRYPOINT ["/usr/local/bin/litecoind", "-datadir=/home/litecoin/.litecoin/data"]

#####------------------------------#####
# References:
# https://github.com/uphold/docker-litecoin-core/tree/master/0.18
#####------------------------------#####