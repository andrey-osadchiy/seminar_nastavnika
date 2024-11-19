#: Создайте скрипт, который выполняет следующие действия:
#1.	Читает данные из файла input.txt.
#2.	Перенаправляет вывод команды wc -l (подсчет строк) в файл output.txt.
#3.	Перенаправляет ошибки выполнения команды ls для несуществующего файла в файл error.log.
#!/bin/bash



file="input.txt"

line_count=$(wc -l < "$file")
echo "Количество строк: $line_count" >> output.txt

ls nonexistent_file 2> error.log