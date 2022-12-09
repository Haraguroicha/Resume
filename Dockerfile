# syntax = docker/dockerfile:1.3-labs

FROM ruby:slim as builder
ADD config/ /etc/nginx/
RUN <<EOF
    export TARGET=/etc/nginx
    erb "${TARGET}/nginx.conf.erb" > "${TARGET}/nginx.conf"
    erb "${TARGET}/allowed.conf.erb" > "${TARGET}/allowed.conf"
    erb "${TARGET}/locations.conf.erb" > "${TARGET}/locations.conf"
    rm "${TARGET}/nginx.conf.erb" "${TARGET}/allowed.conf.erb" "${TARGET}/locations.conf.erb"
    cd "${TARGET}/sites.conf.d"
    for site in ./*.conf.erb
    do
        erb "$site" > "${site%.*}"
        rm "$site"
    done
EOF

FROM fabiocicerchia/nginx-lua
RUN <<EOF
    apk add --no-cache bash
EOF
ADD entrypoint.sh /app/entrypoint.sh
COPY --from=builder /etc/nginx/ /etc/nginx/
ADD build/public/ /app/public/
WORKDIR /app
EXPOSE 8080
CMD []
ENTRYPOINT ["/app/entrypoint.sh"]