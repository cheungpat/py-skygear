FROM python:3.6-stretch

RUN \
    apt-get update && apt-get install -y dumb-init && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools

COPY requirements.txt /tmp/py-skygear/
RUN pip install --no-cache-dir -r /tmp/py-skygear/requirements.txt

COPY . /tmp/py-skygear
RUN (cd /tmp/py-skygear; pip install ".[zmq]") && rm -rf /tmp/py-skygear

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ENV PYTHONUNBUFFERED 0
ENTRYPOINT ["dumb-init"]
CMD ["py-skygear"]
