FROM ubuntu

RUN apt update
RUN apt -y install sudo git

CMD git clone https://github.com/gelegele/dotfiles && cd dotfiles && ./installer/100_execute-me.sh
