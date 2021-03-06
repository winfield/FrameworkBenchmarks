FROM ubuntu:18.04

RUN apt-get update -yqq && \
	apt-get install -yqq cmake git uuid-dev gcc g++ autoconf

ENV IASIO=/asio/asio
ENV CINATRA_HOME=/cinatra
ENV CINATRA=/cinatra/example

RUN git clone https://github.com/chriskohlhoff/asio.git
RUN git checkout 8087252a0c3c2f0baad96ddbd6554db17a846376

WORKDIR $IASIO

RUN ./autogen.sh && ./configure
RUN make -j && make install

WORKDIR /

RUN git clone https://github.com/qicosmos/cinatra.git
RUN git checkout 3f2d75fa8d249ccecce56530a67205793caeb18a

WORKDIR $CINATRA

RUN mkdir build && cd build && cmake .. && make

EXPOSE 8090

CMD ./build/cinatra_example
