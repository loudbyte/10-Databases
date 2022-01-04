SELECT * FROM students s WHERE s.name = 'some name';

SELECT * FROM students s WHERE s.surname LIKE '%some%';

SELECT s.* 
FROM students s 
JOIN phone_numbers pn 
ON s.id = pn.student_id 
WHERE pn.phone LIKE '%100%';

SELECT s."name", s.surname, er.mark 
FROM students s 
JOIN exam_results er 
ON s.id = er.student_id 
WHERE s.surname = 'Surname';