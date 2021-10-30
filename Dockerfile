FROM ubuntu:20.04
RUN mkdir war_file
COPY /target/*.war /war_file/
CMD ["/bin/bash"]


