FROM nginx:1.19.10-alpine
#FROM nginx
LABEL version="1.0.0" description="Disponibilizando site - Desafio VIVO" maintainer="Danilo Pacheco<danilopacheco93@hotmail.com>"

RUN cd / && mkdir Arquivos && chmod 777 -R Arquivos/
COPY ./site/index.html /usr/share/nginx/html/
#COPY ./site/arquivos/vivo.png /Arquivos/
COPY ./site/arquivos/vivo.png /usr/share/nginx/html/

#VOLUME /Arquivos/

EXPOSE 80
EXPOSE 443

ENV API_URL=http://localhost:8008/api/
ENV API_BANCO=meu_site

WORKDIR /usr/share/nginx/html/

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]