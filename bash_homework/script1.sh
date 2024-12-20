#!/bin/bash

# 1. Создаёт список всех файлов в текущей директории, указывая их тип
echo "Список всех файлов и каталогов в текущей директории:"
for item in *; do
    if [ -f "$item" ]; then
        echo "$item - обычный файл"
    elif [ -d "$item" ]; then
        echo "$item - каталог"
    else
        echo "$item - другой тип"
    fi
done

# 2. Проверяет наличие определённого файла, переданного как аргумент скрипта
if [ -z "$1" ]; then
    echo "Необходимо указать имя файла в качестве аргумента."
else
    if [ -e "$1" ]; then
        echo "Файл '$1' существует в текущей директории."
    else
        echo "Файл '$1' не найден в текущей директории."
    fi
fi

# 3. Вывод информации о каждом файле: его имя и права доступа
echo "Информация о каждом файле и его правах доступа:"
for file in *; do
    if [ -e "$file" ]; then
        permissions=$(ls -l "$file" | awk '{print $1}')
        echo "$file - Права доступа: $permissions"
    fi
done
