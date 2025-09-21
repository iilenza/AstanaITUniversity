-- Step 3
-- Подготовьтесь к первым заданиям: установите необходимые инструменты (MySQL/PostgreSQL, Python, Apache Superset). Создайте базу данных и проверьте соединение: убедитесь, что сервер запускается, таблицы доступны и данные видны. Покажите шаги через терминал.
-- Для того, чтобы убедиться, что сервер работает, надо открыть pgAdmin, подключись к серверу PostgreSQL 16 (localhost:5432) под пользователем postgres,  открыть Query Tool и выполнить SELECT version();.

-- Step 4 (пункт В)
-- Вывести первые 10 строк таблицы
SELECT * FROM dv.students_raw LIMIT 10;

-- Step 4 (пункт С)
-- 1. Средний итоговый балл по курсам
SELECT g.course, AVG(g.total) AS avg_total
FROM dv.grades_raw g
GROUP BY g.course
ORDER BY avg_total DESC;

-- 2. Количество студентов в каждой программе (ОП)
SELECT s.op, COUNT(*) AS total_students
FROM dv.students_raw s
GROUP BY s.op
ORDER BY total_students DESC;

-- 3. Посещаемость по группам
SELECT s.gruppa, AVG(a.attendance) AS avg_attendance
FROM dv.students_raw s
JOIN dv.attendance a ON s.email = a.email
GROUP BY s.gruppa
ORDER BY avg_attendance DESC;

-- 4. Минимальные и максимальные баллы по курсам
SELECT g.course, MIN(g.total) AS min_total, MAX(g.total) AS max_total
FROM dv.grades_raw g
GROUP BY g.course
ORDER BY g.course;

-- 5. Количество студентов, выбравших каждый элективный курс
SELECT e.course_id, COUNT(e.email) AS num_students
FROM dv.enrollment_raw e
GROUP BY e.course_id
ORDER BY num_students DESC;

-- 6. Распределение студентов по степеням
SELECT s.stepen, COUNT(*) AS total_students
FROM dv.students_raw s
GROUP BY s.stepen;

-- 7. Список студентов с посещаемостью меньше 70%
SELECT s.fio, s.email, a.attendance
FROM dv.students_raw s
JOIN dv.attendance a ON s.email = a.email
WHERE a.attendance < 70
ORDER BY a.attendance ASC;

-- 8. Средний итоговый балл по курсам
SELECT g.course, AVG(g.total) AS avg_total
FROM dv.grades_raw g
GROUP BY g.course
ORDER BY avg_total DESC;

-- 9. JOIN объединяем студентов и оценки
SELECT s.fio, s.email, g.course, g.total
FROM dv.students_raw s
JOIN dv.grades_raw g
ON s.email = g.email
LIMIT 20;

-- 10. Показать студентов группы SE-2423, отсортированных по ФИО
SELECT * 
FROM dv.students_raw
WHERE gruppa = 'SE-2423'
ORDER BY fio;


