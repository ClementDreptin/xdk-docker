# First stage where we compile a very minimal version of wine
FROM ubuntu:24.04 AS builder

# Get the wine source code
RUN apt update && apt install -y git
RUN git clone --depth 1 https://gitlab.winehq.org/wine/wine.git /wine-source
WORKDIR /wine-source

# Install the build tools required to compile wine
RUN apt install -y --no-install-recommends \
    gcc-multilib \
    flex \
    bison \
    make \
    && rm -rf /var/lib/apt/lists/*

# Create a Makefile that will compile wine with basically nothing in it
RUN ./configure          \
    --disable-win16      \
    --disable-tests      \
    --disable-largefile  \
    --disable-year2038   \
    --without-alsa       \
    --without-capi       \
    --without-coreaudio  \
    --without-cups       \
    --without-dbus       \
    --without-ffmpeg     \
    --without-fontconfig \
    --without-freetype   \
    --without-gettext    \
    --without-gphoto     \
    --without-gnutls     \
    --without-gssapi     \
    --without-gstreamer  \
    --without-hwloc      \
    --without-inotify    \
    --without-krb5       \
    --without-mingw      \
    --without-netapi     \
    --without-opencl     \
    --without-opengl     \
    --without-oss        \
    --without-pcap       \
    --without-pcsclite   \
    --without-pthread    \
    --without-pulse      \
    --without-sane       \
    --without-sdl        \
    --without-udev       \
    --without-unwind     \
    --without-usb        \
    --without-v4l2       \
    --without-vulkan     \
    --without-wayland    \
    --without-xcomposite \
    --without-xcursor    \
    --without-xfixes     \
    --without-xinerama   \
    --without-xinput     \
    --without-xinput2    \
    --without-xrandr     \
    --without-xrender    \
    --without-xshape     \
    --without-xshm       \
    --without-xxf86vm    \
    --without-x

# Compile wine
RUN make -j$(nproc)

# Create a wine installation
RUN make install DESTDIR=/wine-install

# Strip everything we don't need from the wine installation
COPY ./scripts/keep-needed-files.sh /scripts/
RUN /scripts/keep-needed-files.sh


# Second stage where we use the previously built wine binary
FROM ubuntu:24.04 AS runner

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y --no-install-recommends libc6:i386 make && \
    rm -rf /var/lib/apt/lists/*

# Copy the wine installation
COPY --from=builder /wine-install /wine-install

# Users need to provide an XDK build arg which is the directory containing the XDK
ARG XDK
RUN test -n "$XDK" || (echo "XEDK variable is not set." && false)

# Copy the XDK files required for building apps

# Header files
COPY $XDK/include/xbox /xdk/include/xbox

# Always needed binaries
COPY $XDK/bin/win32/cl.exe /xdk/bin/win32/
COPY $XDK/bin/win32/dbghelp.dll /xdk/bin/win32/
COPY $XDK/bin/win32/1033/clui.dll /xdk/bin/win32/1033/
COPY $XDK/bin/win32/mspdbXX.dll /xdk/bin/win32/
COPY $XDK/bin/win32/msvcp100.dll /xdk/bin/win32/
COPY $XDK/bin/win32/msvcr100.dll /xdk/bin/win32/
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

# Other binaries, not always needed
# COPY $XDK/bin/win32/xbcp.exe /xdk/bin/win32/
# COPY $XDK/bin/win32/xbdm.dll /xdk/bin/win32/
# COPY $XDK/bin/win32/msvcp71.dll /xdk/bin/win32/
# COPY $XDK/bin/win32/msvcr71.dll /xdk/bin/win32/
# COPY $XDK/bin/win32/xbreboot.exe /xdk/bin/win32/

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

# The Xbox 360 toolchain expects an XEDK variable to be set to the directory containing the XDK.
# The variable is mostly used through wine so it contains the fake "Z:" drive that wine uses
ENV XEDK=Z:/xdk

# Make wine accessible in PATH
RUN ln -s /wine-install/usr/local/bin/wine /usr/local/bin
