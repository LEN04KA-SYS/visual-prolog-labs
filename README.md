# Visual Prolog Labs

Лабораторные работы по дисциплине **«Введение в искусственный интеллект и логическое программирование»**.

Темы: внутренние базы данных, рекурсивные структуры данных, отсечение в логическом выводе, обработка строк и файловый ввод-вывод.

## Содержание

| Тема | Код | Отчёт |
|------|-----|-------|
| Внутренняя БД Visual Prolog: языки и магазин игрушек | [`internal-database/`](internal-database/) | [PDF](internal-database/report.pdf) |
| Рекурсивные структуры: операции над множествами | [`recursive-structures/`](recursive-structures/) | [PDF](recursive-structures/report.pdf) |
| Изоморфизм деревьев и упрощение логических формул | [`isomorphism-and-simplify/`](isomorphism-and-simplify/) | [PDF](isomorphism-and-simplify/report.pdf) |
| Обработка строк: выравнивание по ширине | [`string-processing/`](string-processing/) | [PDF](string-processing/report.pdf) |

## Стек

- **Visual Prolog** (диалект Turbo Prolog: `domains`, `predicates`, `database`, `clauses`, `goal`)
- Внутренняя база данных (`assert`, `retract`, `consult`, `save`)
- Рекурсивные структуры данных: списки, деревья, логические формулы
- Отсечение (`!`), механизм возврата, файловый ввод-вывод

## Как запустить

1. Установить Visual Prolog (5.x или совместимую среду).
2. Открыть нужный `.pro` из `src/` в папке работы.
3. Скомпилировать и запустить цель `goal`.
4. Для работ с файлами — положить `data/*` рядом с исполняемым файлом.

## Подробности

Описание каждой работы — в `README.md` внутри её папки.
