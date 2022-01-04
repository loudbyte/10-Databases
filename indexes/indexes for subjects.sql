CREATE FUNCTION insert_1000_subjects() RETURNS void AS $$
BEGIN
   for counter in 1..1000 loop
	INSERT INTO public.subject
	("name", tutor)
	VALUES('some name', 'some tutor');
end loop;
END;
$$ LANGUAGE 'plpgsql'

SELECT insert_1000_subjects(); 

DROP INDEX IF EXISTS subject_name_idx;
TRUNCATE phone_numbers , exam_results , students ;

CREATE INDEX subject_name_idx
    ON public.subject USING hash
    (name); -- 16 ms, 64 kb
   
CREATE INDEX subject_name_idx
    ON public.subject USING btree
    (name ASC NULLS LAST); -- 8 ms, 16 kb    
   
SELECT pg_size_pretty(pg_table_size('subject_name_idx'));
