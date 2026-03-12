_jdk_set() {
    export JAVA_HOME="$(/usr/libexec/java_home -v $1)"
}

jdk() {
  if [[ $# -eq 0 ]]; then
    /usr/libexec/java_home -V 2>&1
    return
  fi

  _jdk_set "$1"

  mkdir -p ~/.local/state
  echo "$1" > ~/.local/state/.jdk_version # save to file

  java -version 2>&1 | head -1 # printout for verification
}

# On load (when sourced) restore saved JDK version silently
[[ -f ~/.local/state/.jdk_version ]] && _jdk_set "$(< ~/.local/state/.jdk_version)"
