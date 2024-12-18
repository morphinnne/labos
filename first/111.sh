show_users() {
    echo "Перечень пользователей и их домашних директорий:"
    awk -F':' '{print $1 " -> " $6}' /etc/passwd | sort
}



# Обработка аргументов
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -u|--users)
            ACTION="show_users"
            ;;
        -p|--processes)
            ACTION="show_processes"
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -l|--log)
            shift
            log_output "$1"
            ;;
        -e|--errors)
            shift
            log_errors "$1"
            ;;
        *)
            echo "Неизвестный аргумент: $1" >&2
            show_help
            exit 1
            ;;
    esac
    shift
done

# Выполнение действия
if [[ -n "$ACTION" ]]; then
    $ACTION
else
    echo "Ошибка: Не указано действие. Используйте -h для справки." >&2
    exit 1
fi
