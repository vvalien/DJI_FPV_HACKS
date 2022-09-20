FROM node:lts-buster

# the args that are used in our script
ARG BASE_PATH=/wtfos

# make our basepath
RUN mkdir $BASE_PATH

# get required packages
# RUN apt-get update && apt-get -y install curl wget unzip git

# get wtfos-configurator
RUN cd $BASE_PATH && git clone https://github.com/fpv-wtf/wtfos-configurator.git
# Build so its not in debug mode
RUN cd $BASE_PATH/wtfos-configurator && yarn add react-scripts --force 
RUN cd $BASE_PATH/wtfos-configurator && yarn build && yarn global add serve
RUN cp -r $BASE_PATH/wtfos-configurator/build /wtfos_config_compiled

# CMD will run when container starts :)
CMD serve -s wtfos_config_compiled

# save this as Dockerfile in a empty dir, run following commands.
# docker build -t wtfos_config .
# docker container run --name wtfos_config -d -it -p 3000:3000 wtfos_config
