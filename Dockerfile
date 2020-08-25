FROM ubuntu:18.04

WORKDIR /SOFT

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y wget xz-utils autoconf automake \
	make gcc perl zlib1g-dev libbz2-dev liblzma-dev \
 	libcurl4-gnutls-dev libssl-dev libncurses5-dev && \
	apt-get clean && apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	wget https://github.com/samtools/htslib-plugins/archive/201712.tar.gz && \
	tar xzf 201712.tar.gz && rm 201712.tar.gz && \
	wget https://github.com/ebiggers/libdeflate/archive/v1.5.tar.gz && \
	tar xzf v1.5.tar.gz && rm v1.5.tar.gz && cd libdeflate-1.5 && \
	make && make install && cd .. && \
    wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
	tar jxf samtools-1.10.tar.bz2 && \
	rm samtools-1.10.tar.bz2 && \
	cd samtools-1.10 && \
	./configure --enable-configure-htslib --enable-plugins --with-libdeflate --prefix $(pwd) \
	--enable-libcurl --enable-gcs --enable-s3 --with-plugin-path=/SOFT/htslib-plugins-201712/ &&  \
	make all all-htslib && cd ..

RUN wget https://gitlab.com/german.tischler/biobambam2/uploads/178774a8ece96d2201fcd0b5249884c7/biobambam2-2.0.146-release-20191030105216-x86_64-linux-gnu.tar.xz && \
	tar xf biobambam2-2.0.146-release-20191030105216-x86_64-linux-gnu.tar.xz && \
	rm biobambam2-2.0.146-release-20191030105216-x86_64-linux-gnu.tar.xz

ENV LD_LIBRARY_PATH=/SOFT/libdeflate-1.5
ENV PATH=${PATH}:/SOFT/samtools-1.10:/SOFT/biobambam2/x86_64-linux-gnu/2.0.146/bin/:/SOFT/libdeflate-1.5:/SOFT/samtools-1.10/htslib-1.10



