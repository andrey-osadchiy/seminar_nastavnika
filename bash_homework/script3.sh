# Напишите скрипт, который запрашивает у пользователя ввод числа и затем:
#	Использует if, чтобы проверить, является ли число положительным, отрицательным или нулем, и выводит соответствующее сообщение.
#	Использует while для подсчёта от 1 до введенного числа (если оно положительное).
#!/bin/bash

i=1
echo "Введите число"
read num

if [ $num -gt 0 ]; then
    echo "Число больше нуля"
    while [ $num -gt $i ]; do
        echo "$i"
        ((i += 1))
    done
elif [ $num = 0 ]; then
    echo "Число равно нулю"
else
    echo "Число отрицательное"
fi
