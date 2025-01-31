FROM r-base:4.4.2

# Python is requried for R's argparse library!
RUN apt-get update && apt-get install --no-install-recommends -y \
    python3

WORKDIR /tmp

ARG gs2="genomescope2.0"
ARG RELEASE="2.0.2-1"
ARG rel_dir="$gs2-$RELEASE"
RUN wget -O - "https://github.com/jgrg/$gs2/archive/refs/tags/$RELEASE.tar.gz" | tar xzf - \
    && cd "$rel_dir" \
    && Rscript ./install.R \
    && cp genomescope.R /usr/local/bin \
    && cd .. && rm -r "$rel_dir"

ENTRYPOINT ["genomescope.R"]
