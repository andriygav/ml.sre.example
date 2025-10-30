FROM docker.io/jupyter/base-notebook:x86_64-ubuntu-22.04

COPY ./config /config
COPY ./settings /root/.jupyter/lab/user-settings
COPY ./shell/.bashrc /root/.bashrc

USER root

RUN mkdir /workspace
WORKDIR /workspace

CMD ["python3", "-m", "jupyterlab", "--config", "/config/jupyter_lab_config.py"]
