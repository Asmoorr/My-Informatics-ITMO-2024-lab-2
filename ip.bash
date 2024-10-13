#!/bin/bash

# функция перевода десятичного числа в двоичное
function bin() {
  local decimal=$1
  local binary=$(echo "obase=2; $decimal" | bc)
  printf "%08d" $binary
}

#функция вызова ошибки
function rise_error() {
    local RED='\033[0;31m'
    local NC='\033[0m'
    echo -e "${RED}not valid ip address${NC}" >&2
    exit 1
}


ip=$1

#первичная проверка валидности IP адреса
if [[ ! $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    rise_error
fi

#считывание IP адреса в массив
IFS="." read -r -a ip_arr <<< "$ip"

#цикл поэлементной конвертации октетов IP адреса
bin_ip_arr=()
for oct in "${ip_arr[@]}"; do
  if [[ $oct -le 255 ]]; then
    bin_ip_arr+=("$(bin $oct)")
  else
    rise_error
  fi
done

#вывод конвертированного IP адреса
echo "${bin_ip_arr[@]}" | sed 's/ /./g'
