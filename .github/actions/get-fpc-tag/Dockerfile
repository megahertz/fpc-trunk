FROM alphine:3.10

LABEL "com.github.actions.name"="Get FPC Tag" \
"com.github.actions.description"="Get latest fpc version and revision from trunk" \
"com.github.actions.icon"="package" \
"com.github.actions.color"="orange" \
version="1.0.0" \
repository="https://github.com/megahertz/fpc-trunk" \
homepage="https://github.com/megahertz/fpc-trunk" \
maintainer="megahertz"

ADD entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
