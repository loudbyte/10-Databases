-- 5. Add trigger that will update column updated_datetime to current date in case of updating any of student. (0.3 point)

CREATE FUNCTION update_timestamp() RETURNS TRIGGER AS $$
BEGIN
	OLD.updated_datetime := current_timestamp;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_timestamp_trigger BEFORE UPDATE ON public.students FOR EACH ROW EXECUTE FUNCTION update_timestamp();


-- 6. Add validation on DB level that will check username on special characters (reject student name with next characters '@', '#', '$'). (0.3 point)

CREATE OR REPLACE FUNCTION check_name() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.name ~ '^[@,#,$]*$' THEN 
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Characters are not allowed: $,@ or #';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_name BEFORE INSERT OR UPDATE ON public.students FOR EACH ROW EXECUTE PROCEDURE check_name();


-- 8. Create function that will return average mark for input user. (0.3 point)

CREATE OR REPLACE FUNCTION avg_mark(student int)
  RETURNS TABLE ("name" text, surname text, avg_mark numeric)
  LANGUAGE plpgsql AS
$$
BEGIN
	RETURN QUERY
    SELECT s."name", s.surname, AVG(er.mark::int)::NUMERIC(10,2) avg_mark
	FROM exam_results er 
	INNER JOIN students s 
	ON s.id = er.student_id
	WHERE s.id = student
	GROUP BY s."name", s.surname;
END
$$;
