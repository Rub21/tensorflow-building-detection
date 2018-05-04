FROM ubuntu:16.04
LABEL maintainer="Rub21"

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    software-properties-common \
    python-software-properties \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    libsqlite3-dev \
    zlib1g-dev \
    wget \
    git

RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz && tar xvf Python-3.6.0.tar.xz && cd Python-3.6.0/ && ./configure && make install

RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y python3.6-dev
RUN apt-get install -y libssl-dev libcurl4-openssl-dev

RUN ln -s -f /usr/local/bin/python3 /usr/bin/python
RUN ln -s -f /usr/local/bin/pip3 /usr/bin/pip
RUN pip install --upgrade pip && pip install -U pip && pip install -U setuptools
RUN pip install \
        Cerberus==1.1 \
        click==6.7 \
        geojson==2.3.0 \
        homura==0.1.5 \
        humanize==0.5.1 \
        mapbox-vector-tile==1.2.0 \
        mbutil==0.3.0 \
        mercantile==1.0.0 \
        numpy==1.13.3 \
        olefile==0.44 \
        Pillow==4.3.0 \
        protobuf==3.5.0.post1 \
        pyclipper==1.0.6 \
        pycurl==7.43.0.1 \
        pyproj==1.9.5.1 \
        rasterio==1.0a12 \
        requests==2.11.0 \
        Shapely==1.6.3 \
        six==1.10.0 \
        tilepie==0.2.1 \
        label-maker==0.3.1

RUN git clone https://github.com/mapbox/tippecanoe.git && cd tippecanoe && make -j && make install
WORKDIR /app
COPY . /app
CMD ["bash", "script.sh"]

