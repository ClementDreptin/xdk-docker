PROJECT_NAME := example-app

WINDOWS_SHIM := wine

CONFIG ?= Debug

BUILD_DIR := build
OUT_DIR := $(BUILD_DIR)/$(CONFIG)/bin
INT_DIR := $(BUILD_DIR)/$(CONFIG)/obj

SRCS := $(shell find . -name '*.cpp')
OBJS := $(SRCS:%.cpp=$(INT_DIR)/%.obj)

XDK_BIN_DIR := $(XEDK)/bin/win32
CXX := "$(XDK_BIN_DIR)/cl.exe"
LD := "$(XDK_BIN_DIR)/link.exe"
IMAGEXEX := "$(XDK_BIN_DIR)/imagexex.exe"
XDK_INC_DIR := "$(XEDK)/include/xbox"
XDK_LIB_DIR := "$(XEDK)/lib/xbox"

CXX_FLAGS := -c -Zi -nologo -W4 -MP -D _XBOX -Gm- -EHsc -GS -fp:fast -fp:except- \
			 -Zc:wchar_t -Zc:forScope -GR- -openmp- -Fd"$(INT_DIR)/vc100.pdb" -TP \
			 -FI"$(XDK_INC_DIR)/xbox_intellisense_platform.h"

LD_FLAGS := -ERRORREPORT:QUEUE -NOLOGO -MANIFESTUAC:"level='asInvoker' uiAccess='false'" \
			-DEBUG -PDB:"$(OUT_DIR)/$(PROJECT_NAME).pdb" -STACK:"262144","262144" \
			-TLBID:1 -RELEASE -IMPLIB:"$(OUT_DIR)/$(PROJECT_NAME).pdb" -XEX:NO

IMAGEXEX_FLAGS := -nologo

ifeq ($(CONFIG),Debug)
	CXX_FLAGS += -WX- -Od -D _DEBUG -MTd -Gy- -GF-
else ifeq ($(CONFIG),Release)
	CXX_FLAGS += -WX -Ox -Oi -Os -D NDEBUG -MT -Gy -GF
	LD_FLAGS += -OPT:REF
else
	$(error Unknown CONFIG=$(CONFIG))
endif

all: $(OUT_DIR)/$(PROJECT_NAME).xex

$(OUT_DIR)/$(PROJECT_NAME).xex: $(OUT_DIR)/$(PROJECT_NAME).exe
	@echo "Creating XEX..."
	@mkdir -p $(@D)
	@$(WINDOWS_SHIM) $(IMAGEXEX) $(IMAGEXEX_FLAGS) -out:"$@" "$^"

$(OUT_DIR)/$(PROJECT_NAME).exe: $(OBJS)
	@echo "Linking..."
	@mkdir -p $(@D)
	@LIB=$(XDK_LIB_DIR) $(WINDOWS_SHIM) $(LD) $(LD_FLAGS) -OUT:"$@" $^

$(INT_DIR)/%.obj: %.cpp
	@mkdir -p $(@D)
	@INCLUDE=$(XDK_INC_DIR) $(WINDOWS_SHIM) $(CXX) $(CXX_FLAGS) -Fo"$@" $<

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all build copy clean
