#Создайте скрипт с функцией, которая принимает в качестве аргумента строку и выводит её с префиксом "Hello, ". 
#Напишите ещё одну функцию, которая принимает два числа и возвращает их сумму. Вызовите обе функции в скрипте и продемонстрируйте результат.
#!/bin/bash

hello() {
    local input_string="$1" # Принимаем первый аргумент функции
    echo "Hello $input_string"
}

sum() {
	local input_num1="$1"
	local input_num2="$2"
	sum=$((input_num1 + input_num2))  # Сложение чисел
	echo "Сумма: $sum"
}

echo 'введите строку'
read user_string
hello "$user_string" 


echo 'Введите число 1:'
read user_num1
echo 'Введите число 2:'
read user_num2
sum "$user_num1" "$user_num2"