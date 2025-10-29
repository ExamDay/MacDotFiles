MANGOBIN=/Users/M279922/bin; PATH=${MANGOBIN}:${PATH}; export PATH
# LLVM:
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/M279922/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(/opt/homebrew/bin/brew shellenv bash)"
export PATH=${PATH}:/opt/homebrew/opt/python/libexec/bin

eval "$(/opt/homebrew/bin/brew shellenv bash)"

# -------------------------------------------------------
# for AFNI: auto-inserted by init_user_dotfiles.py

# add AFNI abin to PATH
export PATH=${PATH}:/Users/gml/abin
# -------------------------------------------------------

export R_LIBS=/Users/gml/sw/R-4.3.1
