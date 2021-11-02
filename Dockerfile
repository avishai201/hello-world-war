FROM ubuntu:20.04
ADD /target/*.war /war_file/
CMD ["/bin/bash"]



