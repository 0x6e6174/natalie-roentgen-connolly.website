#!/bin/bash

source status_codes.sh

declare -A request_headers
declare -A response_headers

write_response_headers() {
  local status=$1
  echo -ne "HTTP/1.1 ${status} ${status_code[${status}]}\r\n"
  for header in "${!response_headers[@]}"; do
    echo -ne "${header}: ${response_headers["${header}"]}\r\n"
  done
  echo -ne "\r\n"
}

IFS=' ' read -r method route version;

echo $method $route >/dev/stderr
if [ "${method}" != 'GET' ]; then
  write_response_headers 405
  ./error-page.sh 405
fi

IFS=$'\n'
while read -r line; do
  [[ "$line" == $'\r' ]] && break
  header=${line%%:*}
  value=${line#:*}
  request_headers["${header}"]="${value}"
done

for header in "${!request_headers[@]}"; do
  echo "${header} -> ${request_headers["${header}"]}" >/dev/stderr
done

if [[ "${route}" == "/" ]]; then
  response_headers["Content-Type"]="text/html"
  write_response_headers 200 
  echo "$(www/index.sh)";
fi

if [[ -f "www${route}" ]]; then
  if [[ "www${route}" == *.sh ]]; then
    write_response_headers 200 
    echo "$(www"${route}")"
  else 
    write_response_headers 200 
    cat "www${route}"
  fi
else 
  if [[ "${route}" != "/" ]]; then
    write_response_headers 404
    ./error-page.sh 404
  fi
fi
