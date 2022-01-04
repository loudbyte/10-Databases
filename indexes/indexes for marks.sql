INSERT INTO public.students
		(id, "name", surname, date_of_birth, created_datetime, updated_datetime, tsvector)
		VALUES(0, 'some name', 'some surename', '1970-01-01', '1970-01-01 06:01:40.000 +0600', '1970-01-01 06:01:40.000 +0600', '1');


CREATE FUNCTION insert_1000000_exam_results() RETURNS void AS $$
BEGIN
   for counter in 1..1000000 LOOP
   	INSERT INTO public.exam_results
	(student_id, mark)
	VALUES(0, 'some mark');
end loop;
END;
$$ LANGUAGE 'plpgsql'

SELECT insert_1000000_exam_results();


DROP INDEX IF EXISTS exam_results_mark_idx;
TRUNCATE phone_numbers , exam_results , students ;

CREATE INDEX exam_results_mark_idx
    ON public.exam_results USING hash
    (mark);  -- 7 min, 47 mb
   
CREATE INDEX exam_results_mark_idx
    ON public.exam_results USING btree
    (mark ASC NULLS LAST); -- 5 s, 6904 kB   
   
SELECT pg_size_pretty(pg_table_size('exam_results_mark_idx'));
