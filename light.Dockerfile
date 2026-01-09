FROM alpine:3.23.2

# Install wine and other useful development dependencies
RUN apk add --no-cache \
    wine \
    bash \
    make

# Users need to provide an XDK build arg which is the directory containing the XDK
ARG XDK
RUN test -n "$XDK" || (echo "XEDK variable is not set." && false)

# Copy the XDK files required for building apps

# Header files
COPY $XDK/include/xbox /xdk/include/xbox

# Binaries
COPY $XDK/bin/win32/cl.exe /xdk/bin/win32/
COPY $XDK/bin/win32/1033/clui.dll /xdk/bin/win32/1033/
COPY $XDK/bin/win32/mspdbXX.dll /xdk/bin/win32/
COPY $XDK/bin/win32/tlbref.dll /xdk/bin/win32/
COPY $XDK/bin/win32/mspdbsrvx.exe /xdk/bin/win32/
COPY $XDK/bin/win32/msobjXX.dll /xdk/bin/win32/
COPY $XDK/bin/win32/c1xx.dll /xdk/bin/win32/
COPY $XDK/bin/win32/c1.dll /xdk/bin/win32/
COPY $XDK/bin/win32/c2.dll /xdk/bin/win32/
COPY $XDK/bin/win32/msdisXXX.dll /xdk/bin/win32/
COPY $XDK/bin/win32/pgodb100.dll /xdk/bin/win32/
COPY $XDK/bin/win32/link.exe /xdk/bin/win32/
COPY $XDK/bin/win32/lib.exe /xdk/bin/win32/
COPY $XDK/bin/win32/imagexex.exe /xdk/bin/win32/

# Always required libraries
COPY $XDK/lib/xbox/libcMTd.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/libcMT.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/libcpMTd.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/libcpMT.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/oldnames.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/xapilibd.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/xapilib.lib /xdk/lib/xbox/
COPY $XDK/lib/xbox/xboxkrnl.lib /xdk/lib/xbox/

# Other libraries, not always needed
# COPY $XDK/lib/xbox/d3d9d.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/d3d9.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/d3dx9d.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/d3dx9.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/dxerr9.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xgraphicsd.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xgraphics.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xjsond.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xjson.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xnetd.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xnet.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xonlined.lib /xdk/lib/xbox/
# COPY $XDK/lib/xbox/xonline.lib /xdk/lib/xbox/

# The Xbox 360 toolchain expects an XEDK variable to set to the directory containing the XDK.
# The variable is mostly used through wine so it contains the fake "Z:" drive that wine uses
ENV XEDK=Z:/xdk

ENTRYPOINT ["/bin/bash"]
