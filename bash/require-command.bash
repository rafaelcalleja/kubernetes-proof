function requireCommand {
# argument must be an array of dependencies command

# example
# commands=("docker" "jq")
# requireCommand "${commands[@]}"

  DEPENDENCIES=("$@")
  NOTFOUND=""
  COMMANDS=""
  for PACKAGE in ${DEPENDENCIES[@]}; do
  if [ "$(which "$PACKAGE")" = "" ]; then
    COMMANDS="${COMMANDS}${PACKAGE} "
    if [ "$(which brew)" ]; then
      NOTFOUND="${NOTFOUND}brew install $PACKAGE\n"
    elif [ "$(which port)" ]; then
      NOTFOUND="${NOTFOUND}port install $PACKAGE\n"
    elif [ "$(which apt-get)" ]; then
      NOTFOUND="${NOTFOUND}apt-get install $PACKAGE\n"
    elif [ "$(which yum)" ]; then
      NOTFOUND="${NOTFOUND}yum install $PACKAGE\n"
    elif [ "$(which rpm)" ]; then
      NOTFOUND="${NOTFOUND}rpm --install $PACKAGE\n"
    else
      cat <<EOF
MacOs User ?
Run first:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
EOF
    exit 1;
    fi
  fi
done

if [ ! -z "${NOTFOUND}" ]; then
  cat <<EOF
Commands ${COMMANDS}are required!!

Try install it running:

EOF

  echo -e ${NOTFOUND}
  exit 1
fi
}
