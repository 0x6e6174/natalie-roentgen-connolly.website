#!/bin/bash

declare -A status_code

status_code[200]="OK"
status_code[204]="No Content"
status_code[206]="Partial Content"
status_code[301]="Moved Permanently"
status_code[400]="Bad Request"
status_code[401]="Unauthorized"
status_code[403]="Forbidden"
status_code[404]="Not Found"
status_code[405]="Method Not Allowed"
status_code[418]="I'm a teapot"
status_code[429]="Too Many Requests"
