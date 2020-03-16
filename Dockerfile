
FROM gitpod/workspace-full:latest


RUN yes | sudo apt install apt-transport-https software-properties-common
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

RUN sudo apt-get update
RUN sudo apt install r-base

USER gitpod

WORKDIR /myapp
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.6.5"
COPY Gemfile .
COPY Gemfile.lock .
RUN /bin/bash -l -c "rvm use --default 2.6.5"
RUN /bin/bash -l -c "bundle install"
