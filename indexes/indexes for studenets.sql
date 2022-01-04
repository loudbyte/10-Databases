ALTER TABLE public.students ADD tsvector tsvector NULL;

CREATE FUNCTION insert_100000_students() RETURNS void AS $$
BEGIN
   for counter in 1..100000 loop
	INSERT INTO public.students
		("name", surname, date_of_birth, created_datetime, updated_datetime, tsvector)
		VALUES('some name', 'some surename', '1970-01-01', '1970-01-01 06:01:40.000 +0600', '1970-01-01 06:01:40.000 +0600', '1');
   end loop;
END;
$$ LANGUAGE 'plpgsql'

SELECT insert_100000_students();

DROP INDEX IF EXISTS students_name_idx;
DROP INDEX IF EXISTS students_tsvector_idx;
TRUNCATE phone_numbers , exam_results , students ;

CREATE INDEX students_name_idx
    ON public.students USING hash
    (name);
   
CREATE INDEX students_name_idx
    ON public.students USING btree
    (name ASC NULLS LAST);
   
CREATE INDEX students_tsvector_idx
    ON public.students USING gin(tsvector);   

CREATE INDEX students_tsvector_idx
    ON public.students USING gist(tsvector);
   
   
SELECT pg_size_pretty(pg_table_size('students_name_idx'));
