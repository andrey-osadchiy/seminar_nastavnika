# Создайте alias для команды ls -la и назовите его ll. Напишите команду, чтобы сделать alias постоянным, и объясните, где она должна быть добавлена

#Чтобы alias был доступен после перезапуска терминала, нужно добавить эту команду в конфигурационный файл терминала. 
#То есть в  .bashrc
#!/bin/bash


echo "Создаем alias для команды ls -la с именем ll."
alias ll='ls -la'

echo "Добавляем alias в файл ~/.bashrc, чтобы он был постоянным."
echo "alias ll='ls -la'" >> ~/.bashrc

echo "Чтобы изменения вступили в силу, надо закрыть и открыть терминал, или выполнить:"
echo "source ~/.bashrc"
echo "Поздравляю, вы - великолепны"