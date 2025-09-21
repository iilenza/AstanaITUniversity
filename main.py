import psycopg2
import pandas as pd


conn = psycopg2.connect(
    host="localhost",       
    port="5432",            
    database="dv_project",  
    user="postgres",        
    password="0708"   
)


# 1. 
query_avg_total = """
SELECT g.course, AVG(g.total) AS avg_total
FROM dv.grades_raw g
GROUP BY g.course
ORDER BY avg_total DESC;
"""

# 2. 
query_total_students = """
SELECT s.op, COUNT(*) AS total_students
FROM dv.students_raw s
GROUP BY s.op
ORDER BY total_students DESC;
"""

# 3. 
query_avg_attendance = """
SELECT s.gruppa, AVG(a.attendance) AS avg_attendance
FROM dv.students_raw s
JOIN dv.attendance a ON s.email = a.email
GROUP BY s.gruppa
ORDER BY avg_attendance DESC;
"""

df_avg_total = pd.read_sql_query(query_avg_total, conn)
df_total_students = pd.read_sql_query(query_total_students, conn)
df_avg_attendance = pd.read_sql_query(query_avg_attendance, conn)


print("AVG by courses:")
print(df_avg_total.head(10), "\n")

print("Amount of students in each educational program:")
print(df_total_students.head(10), "\n")

print("Attendance by groups:")
print(df_avg_attendance.head(10), "\n")



df_avg_total.to_csv("avg_total_by_course.csv", index=False)
df_total_students.to_csv("total_students_per_program.csv", index=False)
df_avg_attendance.to_csv("avg_attendance_by_group.csv", index=False)


with pd.ExcelWriter("results.xlsx") as writer:
    df_avg_total.to_excel(writer, sheet_name="AvgTotal", index=False)
    df_total_students.to_excel(writer, sheet_name="TotalStudents", index=False)
    df_avg_attendance.to_excel(writer, sheet_name="AvgAttendance", index=False)


conn.close()
print("Done! The results are saved in CSV and Excel.")
