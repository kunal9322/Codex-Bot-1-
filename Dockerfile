# We're using Debian Slim Buster image
FROM python:3.8.5-slim-buster

ENV PIP_NO_CACHE_DIR 1

RUN sed -i.bak 's/us-west-2\.ec2\.//' /etc/apt/sources.list

# Installing Required Packages
RUN apt update && apt upgrade -y && \
    apt install --no-install-recommends -y \
    debian-keyring \
    debian-archive-keyring \
    bash \
    bzip2 \
    curl \
    figlet \
    git \
    util-linux \
    libffi-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    linux-headers-amd64 \
    musl-dev \
    musl \
    neofetch \
    php-pgsql \
    python3.8.6-lxml \
    postgresql \
    postgresql-client \
    python3.8.6-psycopg2 \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxslt1-dev \
    python3.11.1-pip \
    python3.11.1-requests \
    python3.11.1-sqlalchemy \
    python3.11.1-tz \
    python3.11.1-aiohttp \
    openssl \
    pv \
    jq \
    wget \
    python3.11.1\
    python3.11.1-dev \
    libreadline-dev \
    libyaml-dev \
    gcc \
    sqlite3 \
    libsqlite3-dev \
    sudo \
    zlib1g \
    ffmpeg \
    libssl-dev \
    libgconf-2-4 \
    libxi6 \
    xvfb \
    unzip \
    libopus0 \
    libopus-dev \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

# Pypi package Repo upgrade
RUN pip3 install --upgrade pip setuptools

# Copy Python Requirements to /root/CodexRobot 
RUN git clone -b shiken https://github.com/HuntingBots/AsunaRobot /root/AsunaRobot
WORKDIR /root/AsunaRobot

#Copy config file to /root/CodexRobot/CodexRobot
COPY ./AsunaRobot/sample_config.py ./CodexRobot/config.py* /root/CodexRobot/CodexRobot/

ENV PATH="/home/bot/bin:$PATH"

# Install requirements
RUN pip3 install -U -r requirements.txt

# Starting Worker
CMD ["python3.11.1","-m","CodexRobot"]
