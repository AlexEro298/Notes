# Banner
```html
nano /etc/profile.d/motd.sh

/etc/motd.d/11-custom
```
```html
#!/bin/sh

# Text Color Variables http://misc.flogisoft.com/bash/tip_colors_and_formatting
COLOR_LIGHT_GRAY="\033[00;37m"
COLOR_DARK_GRAY="\033[01;30m"
COLOR_LIGHT_RED="\033[01;31m"
COLOR_LIGHT_GREEN="\033[01;32m"
COLOR_LIGHT_BLUE="\033[01;34m"
COLOR_LIGHT_PURPLE="\033[01;35m"
COLOR_LIGHT_CYAN="\033[01;36m"
COLOR_WHITE="\033[01;37m"
COLOR_RESET="\033[0m"
COLOR_ORANGE="\033[38;5;209m"

# Функция для определения времени суток
get_time_greeting() {
    local hour=$(date +"%H")
    if [ $hour -lt 12 -a $hour -ge 4 ]; then
        echo "Доброе утро!"
    elif [ $hour -lt 17 -a $hour -ge 12 ]; then
        echo "Добрый день!"
    elif [ $hour -lt 23 -a $hour -ge 17 ]; then
        echo "Добрый вечер!"
    else
        echo "Доброй ночи!"
    fi
}

# Получить время работы системы
get_uptime() {
    local uptime_seconds=$(cat /proc/uptime | cut -f1 -d.)
    local days=$((uptime_seconds/60/60/24))
    local hours=$((uptime_seconds/60/60%24))
    local minutes=$((uptime_seconds/60%60))
    echo "$days дней $hours часов $minutes минут"
}

# Получить информацию о системе
get_system_info() {
    # Загрузка системы
    local load_average=$(cat /proc/loadavg | awk '{print $1}')
    local process_count=$(ps aux | wc -l)
    local memory_used=$(free -h | grep Mem | awk '{print $3}')
    local memory_total=$(free -h | grep Mem | awk '{print $2}')
    local swap_used=$(free -h | grep Swap | awk '{print $3}')
    local swap_total=$(free -h | grep Swap | awk '{print $2}')
    local whoami_user=$(whoami)
    
    # Сетевые данные
    local ip_address=$(hostname --all-ip-addresses)

    if [ $whoami_user != "root" ]; then
    # Вывод информации
    printf "%b\n" "$COLOR_DARK_GRAY================================================================================$COLOR_RESET"
    printf "%b %-80s %b%s%b\n" "$COLOR_LIGHT_GRAY" "$(get_time_greeting)" "$COLOR_ORANGE" "$(logname)" "$COLOR_RESET"
    printf "%b\n" "$COLOR_DARK_GRAY================================================================================$COLOR_RESET"
    
    printf "%b * Хост             :%b %-50s%b\n" "$COLOR_LIGHT_GRAY" "$COLOR_WHITE" "$(hostname -f)" "$COLOR_RESET"
    printf "%b * IP Адрес         :%b %-50s%b\n" "$COLOR_LIGHT_GRAY" "$COLOR_WHITE" "$ip_address" "$COLOR_RESET"
    printf "%b * Версия           :%b %-50s%b\n" "$COLOR_LIGHT_GRAY" "$COLOR_WHITE" "$(lsb_release -s -d)" "$COLOR_RESET"
    printf "%b * Ядро             : %-50s%b\n" "$COLOR_LIGHT_GRAY" "$(uname -a | awk '{print $1" "$3" "$12}')" "$COLOR_RESET"
    printf "%b * Пользователи     : Авторизованных пользователей - %-30s%b\n" "$COLOR_LIGHT_GRAY" "$(users | wc -w)" "$COLOR_RESET"
    printf "%b * Время на сервере : %-50s%b\n" "$COLOR_LIGHT_GRAY" "$(date +"%A, %d %B %Y г., %T")" "$COLOR_RESET"
    printf "%b * Загрузка системы : %-50s%b\n" "$COLOR_LIGHT_GRAY" "$load_average / $process_count запущенных процессов" "$COLOR_RESET"
    printf "%b * Память, RAM      : Исп.: %-4s Мб / Всего: %-4s Мб%b\n" "$COLOR_LIGHT_GRAY" "$memory_used" "$memory_total" "$COLOR_RESET"
    printf "%b * SWAP             : Исп.: %-4s Мб / Всего: %-4s Мб%b\n" "$COLOR_LIGHT_GRAY" "$swap_used" "$swap_total" "$COLOR_RESET"
    printf "%b * После включения  : %-50s%b\n" "$COLOR_LIGHT_GRAY" "$(get_uptime)" "$COLOR_RESET"
    printf "%b\n" "$COLOR_DARK_GRAY================================================================================$COLOR_RESET"
    printf "%b * Диски:%b\n" "$COLOR_LIGHT_GRAY" "$COLOR_RESET"
    df -h | awk 'NR==1 || ($1 ~ /^\/dev\// && $6 !~ /^\/run|\/dev|\/sys|\/proc|\/snap/)' | sed "s/^/   /"
    printf "%b\n" "$COLOR_DARK_GRAY================================================================================$COLOR_RESET"
    printf "%b * ОЗУ:%b\n" "$COLOR_LIGHT_GRAY" "$COLOR_RESET"
    free -h
    printf "%b\n" "$COLOR_DARK_GRAY================================================================================$COLOR_RESET"
    printf "%b\n" "$COLOR_RESET"
    fi
}

# Основной вызов
get_system_info


```