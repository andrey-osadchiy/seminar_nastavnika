#Напишите скрипт, который запускает три команды sleep с разными временами в фоновом режиме.
# Используйте команды jobs, fg, bg, чтобы продемонстрировать управление этими задачами.
#!/bin/bash

# Включаем мониторинг задач
set -m

# Запускаем три команды sleep в фоновом режиме с разными временами
sleep 3 &
sleep 6 &
sleep 10 &

# Отображаем список фоновых задач
echo "Список фоновых задач:"
jobs

echo "Переводим задачу с ID 1 в передний план:"
fg %1


echo "Переводим задачу с ID 1 обратно в фоновый режим:"
bg %1

# Отображаем снова список задач
echo "Обновленный список фоновых задач:"
jobs
