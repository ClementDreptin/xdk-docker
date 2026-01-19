#!/bin/bash

# This scripts runs during the build process of the light image after installing
# wine into the /wine-install directory.
# Its goal is to only keep the necessary files from the installation before copying
# it to the final image.

pushd /wine-install/usr/local

rm -r share/applications
rm -r share/man
rm -r include

# bin
mv bin bin-bkp
mkdir -p bin

mv bin-bkp/wine bin
mv bin-bkp/wineserver bin

rm -r bin-bkp


# share
mv share share-bkp
mkdir -p share/wine/nls

mv share-bkp/wine/wine.inf share/wine
mv share-bkp/wine/winmd share/wine
mv share-bkp/wine/nls/c_037.nls share/wine/nls
mv share-bkp/wine/nls/c_1252.nls share/wine/nls
mv share-bkp/wine/nls/c_20127.nls share/wine/nls
mv share-bkp/wine/nls/c_437.nls share/wine/nls
mv share-bkp/wine/nls/l_intl.nls share/wine/nls
mv share-bkp/wine/nls/locale.nls share/wine/nls
mv share-bkp/wine/nls/sortdefault.nls share/wine/nls

rm -r share-bkp


# lib/i386-unix
mv lib/wine/i386-unix lib/wine/i386-unix-bkp
mkdir -p lib/wine/i386-unix

mv lib/wine/i386-unix-bkp/advapi32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/advpack.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/atl100.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/bcrypt.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/combase.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/coml2.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/conhost.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/control.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/crypt32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/crypt32.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/cryptbase.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/dnsapi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/explorer.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/gdi32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/imagehlp.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/iphlpapi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/kernel32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/kernelbase.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/mpr.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/mscoree.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/msv1_0.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/msv1_0.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/msvcrt.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/msxml3.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/netapi32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/netutils.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/newdev.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/nsi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ntdll.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ntdll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ole32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/oleaut32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/psapi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/rpcrt4.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/rsaenh.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/rundll32.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/sechost.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/secur32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/services.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/setupapi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/shcore.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/shell32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/shlwapi.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ucrtbase.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/urlmon.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/user32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/wininet.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/win32u.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/win32u.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/wine lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/wineboot.exe.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/version.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ws2_32.dll.so lib/wine/i386-unix
mv lib/wine/i386-unix-bkp/ws2_32.so lib/wine/i386-unix

rm -r lib/wine/i386-unix-bkp


# lib/i386-windows
mv lib/wine/i386-windows lib/wine/i386-windows-bkp
mkdir -p lib/wine/i386-windows

mv lib/wine/i386-windows-bkp/advapi32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/advpack.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/atl100.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/bcrypt.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/combase.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/coml2.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/conhost.exe lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/cryptbase.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/crypt32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/dnsapi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/gdi32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/imagehlp.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/iphlpapi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/kernel32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/kernelbase.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/mpr.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/mscoree.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/msvcrt.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/msv1_0.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/msxml3.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/netapi32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/netutils.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/newdev.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/nsi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/oleaut32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/ole32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/psapi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/rpcrt4.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/rsaenh.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/sechost.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/secur32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/setupapi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/shcore.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/shell32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/shlwapi.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/ucrtbase.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/urlmon.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/user32.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/version.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/wininet.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/win32u.dll lib/wine/i386-windows
mv lib/wine/i386-windows-bkp/ws2_32.dll lib/wine/i386-windows

rm -r lib/wine/i386-windows-bkp

popd
