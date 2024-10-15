# Отчёт по лабораторной работе №2

## Реализация

Давайте рассмотрим из каких блоков состоит скрипт:

```bash
#!/bin/bash
```
Указывается путь ĸ bash-интерпретатору, используя последовательность символов shebang.

```bash
# функция перевода десятичного числа в двоичное
function bin() {
  local decimal=$1
  local binary=$(echo "obase=2; $decimal" | bc)
  printf "%08d" $binary
}
```
Реализация функции перевода десятичного числа в двоичное. "возвращает" число в двоичной системе счисления, при необходимости добавляя незначащие нули.

```bash
#функция вызова ошибки
function rise_error() {
    local RED='\033[0;31m'
    local NC='\033[0m'
    echo -e "${RED}not valid ip address${NC}" >&2
    exit 1
}
```
Функция, обрабатывающая ошибки. При вызове инициализирует локальные переменные для вывода сообщений об обшике, выделенных красным цветом. Ошибки передаются в stderr - поток вывода ошибок.

```bash
ip=$1

# первичная проверка валидности IP адреса
if [[ ! $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    rise_error
fi
```
Присваиваем переменной ip IP адрес введённый пользователем и первично валидируем его с помощью регулярного выражения. В случае несовпадения с шаблоном вызываем ошибку.

```bash
# считывание IP адреса в массив
IFS="." read -r -a ip_arr <<< "$ip"
```
Считываем введённый IP адрес в массив

```bash
# цикл поэлементной конвертации октетов IP адреса
bin_ip_arr=()
for oct in "${ip_arr[@]}"; do
  if [[ $oct -le 255 ]]; then
    bin_ip_arr+=("$(bin $oct)")
  else
    rise_error
  fi
done
```
Создаём массив bin_ip_arr для сохранения каждого из октетов в двоичной записи. Для этого проходимся по всем элементам массива, убеждаемся, что каждый из них меньше 255 и переводим в двоичную форму записи. В случае возникновения ошибок обрабатываем их.

```bash
# вывод конвертированного IP адреса
echo "${bin_ip_arr[@]}" | sed 's/ /./g'
```
С помощью команды echo выводим элементы массива через символ "."

## Примеры использования

![image](https://github.com/user-attachments/assets/8a24e0a4-d998-401e-88d9-6a438de890d6)
![image](https://github.com/user-attachments/assets/77978fba-b3bd-4ad4-97d1-d2aff9057b49)
![image](https://github.com/user-attachments/assets/ed2c073a-3aed-4932-ac2f-e661ed843365)
![image](https://github.com/user-attachments/assets/d6407cb0-fd34-4854-baa5-e9137bedee4d)
![image](https://github.com/user-attachments/assets/be9694c5-dede-4d41-bc7b-53f642ffb9a7)
![image](https://github.com/user-attachments/assets/2d884298-0525-4a2a-9817-284abb9cdd72)
![image](https://github.com/user-attachments/assets/db98cd0c-8908-4e3e-9066-2fa6484dea6d)
![image](https://github.com/user-attachments/assets/af775de2-ecf8-4c7d-bc12-42301a68f315)
![image](https://github.com/user-attachments/assets/9171966d-f187-4549-8e9e-ff5305c6b463)
![image](https://github.com/user-attachments/assets/95a53868-5e1c-400c-9342-47ebdaff609b)








