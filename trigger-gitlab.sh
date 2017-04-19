#!/bin/sh

usage() {
	printf "Usage: \n"
	printf "  -t token to trigger the build TOKEN=$TOKEN \n"
	printf "  -r ref to trigger REF=$REF \n"
	printf "  -u trigger url URL=$URL \n"
}

trigger() {
  echo Triggering build ${URL} for ref: ${REF}
  curl --silent -X POST \
       -F token=${TOKEN} \
       -F ref=${REF} \
       ${URL}
}

while getopts ":u:t:r:h" opt; do
  case $opt in
    u)
      export URL=${OPTARG:-${URL}}
      ;;
    t)
      export TOKEN=${OPTARG:-${TOKEN}}
      ;;
    r)
      export REF=${OPTARG:-${REF}}
      ;;
    h)
      usage
      exit 0
      ;;
  esac
done
shift $((OPTIND-1))

env
trigger
