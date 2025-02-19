#!/bin/bash 

source status_codes.sh

echo ${1} >/dev/stderr
echo ${status_code[404]} >/dev/stderr

cat << EOF
<!DOCTYPE html>
<html>
  <head>
    <title>NRC website</title>
    <meta charset="UTF-8" />
  </head>
  <body>
    <main>
      <h1>${1}</h1>
      <div>${status_code[${1}]}</div>
    </main>
  </body>
</html>
EOF
