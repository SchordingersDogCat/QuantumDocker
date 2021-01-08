FROM gcc:latest
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
				vim \
				cmake \
				pkg-config \ 
				uuid-dev \
				python3-pip
RUN pip3 install -U pip
RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple
RUN pip3 config set install.trusted-host mirrors.aliyun.com
RUN pip3 install jupyter
RUN pip3 install qiskit
WORKDIR /home
RUN git clone https://github.com/OriginQ/QPanda-2.git
WORKDIR /home/QPanda-2
RUN mkdir -p build
RUN cmake -DFIND_CUDA=OFF -DUSE_CHEMIQ=OFF -DUSE_PYQPANDA=OFF .
RUN make
RUN make install
