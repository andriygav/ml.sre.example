ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
RUN apt-get install -y \
    git \
    nano \
    dnsutils \
    iputils-ping \
    htop \
    s3cmd \
    python3-pip
    
RUN apt-get install -y ca-certificates curl gnupg lsb-release \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update -y \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

COPY src/jupyter/requirements.txt /tmp/
RUN cat /tmp/requirements.txt | xargs --no-run-if-empty -l python3 -m pip install \
    && rm -rf /tmp/* /root/.cache/*

COPY src/trainer/requirements.txt /tmp/
RUN cat /tmp/requirements.txt | xargs --no-run-if-empty -l python3 -m pip install \
    && rm -rf /tmp/* /root/.cache/*

COPY ./config /config
COPY ./settings /root/.jupyter/lab/user-settings
COPY ./shell/.bashrc /root/.bashrc

RUN mkdir /workspace
WORKDIR /workspace

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini
ENTRYPOINT ["/bin/tini", "--"]

CMD ["python3", "-m", "jupyterlab", "--config", "/config/jupyter_lab_config.py"]
