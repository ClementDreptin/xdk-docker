FROM alpine:3.23.2

# Install wine and other useful development dependencies
RUN apk add --no-cache \
    wine \
    bash \
    make

# Users need to provide an XDK build arg which is the directory containing the XDK
ARG XDK
RUN test -n "$XDK" || (echo "XEDK variable is not set." && false)

# Copy the XDK
COPY $XDK /xdk

# The Xbox 360 toolchain expects an XEDK variable to set to the directory containing the XDK.
# The variable is mostly used through wine so it contains the fake "Z:" drive that wine uses
ENV XEDK=Z:/xdk

ENTRYPOINT ["/bin/bash"]
