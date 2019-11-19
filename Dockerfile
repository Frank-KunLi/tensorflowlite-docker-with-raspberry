FROM ubuntu:18.04
ADD download.sh /root/

LABEL maintainer="amir.mahjoubi@esprit.tn"

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3 python3-pip python3-opencv -qq && \
    apt-get install -y -qq --no-install-recommends usbutils git && \
    apt install curl && \
    apt-get install unzip && \
    pip3 install requests flask && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists && \
    cd /root/ && \
    ./download.sh && \
    curl -O https://storage.googleapis.com/download.tensorflow.org/models/tflite/mobilenet_v1_1.0_224_quant_and_labels.zip && \
    unzip mobilenet_v1_1.0_224_quant_and_labels.zip -d /tmp/ && \
    rm mobilenet_v1_1.0_224_quant_and_labels.zip && \
    curl https://dl.google.com/coral/canned_models/mobilenet_v1_1.0_224_quant_edgetpu.tflite -o /tmp/mobilenet_v1_1.0_224_quant_edgetpu.tflite



RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

COPY . /root/example-opencv

CMD ["/root/example-opencv/app.py", "80", "640", "480", "4"]

