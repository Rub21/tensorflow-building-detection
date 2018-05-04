FROM ubuntu:16.04
LABEL maintainer="Rub21"
ENV workdir /usr/src/app
RUN mkdir $workdir
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
    libssl-dev \
    libcurl4-openssl-dev \
    wget \
    unzip \
    git
RUN wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz && tar xvf Python-3.6.0.tar.xz && cd Python-3.6.0/ && ./configure && make install
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

RUN git clone --progress --depth=1 https://github.com/mapbox/tippecanoe.git && cd tippecanoe && make -j && make install
# Install TensorFlow object detection
RUN apt-get install -y protobuf-compiler python-pil python-lxml python-tk
RUN pip install \
        bleach==1.5.0 \
        Cython==0.28.2 \
        lxml==4.2.1 \
        jupyter==1.0.0 \
        matplotlib==2.2.2 \
        pandas==0.22.0 
        # tensorflow==1.8.0


# Install TensorFlow CPU version from central repo
RUN pip --no-cache-dir install \
    http://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.0.0-cp27-none-linux_x86_64.whl

# Install Proto
RUN wget https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip -P $workdir
RUN unzip $workdir/protoc-3.2.0-linux-x86_64.zip -d $workdir/protoc3
RUN mv -f $workdir/protoc3/bin/* /usr/local/bin/
RUN mv -f $workdir/protoc3/include/* /usr/local/include/
RUN ln -s -f /usr/local/bin/protoc /usr/bin/protoc

# Setup TensorFlow Object Detection API
RUN git clone --progress --depth=1 https://github.com/tensorflow/models.git $workdir/models

WORKDIR $workdir
RUN cd $workdir/models/research && protoc object_detection/protos/*.proto --python_out=.
ENV PYTHONPATH=$PYTHONPATH:/usr/src/app/models/research:/usr/src/app/models/research/slim
RUN cd $workdir/models/research && python object_detection/builders/model_builder_test.py

# Create TFRecords for model training
RUN git clone --progress --depth=1 https://github.com/developmentseed/label-maker.git $workdir/label-maker

COPY . $workdir
CMD ["bash", "script.sh"]

