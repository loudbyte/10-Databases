CREATE TABLE public.students
(
    id bigserial NOT NULL,
    name text,
    surname text,
    date_of_birth date,
    created_datetime timestamp without time zone,
    updated_datetime time without time zone,
    PRIMARY KEY (id)
);

CREATE TABLE public.phone_numbers (
    student_id bigint,
    phone TEXT,
    CONSTRAINT fk_phone_numbers_stident_id FOREIGN KEY (student_id)
        REFERENCES public.students (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE public.subject
(
    id bigserial NOT NULL,
    name text,
    tutor text,
    PRIMARY KEY (id)
);

CREATE TABLE public.exam_results
(
    id bigserial NOT NULL,
    student_id bigint NOT NULL,
    mark text,
    PRIMARY KEY (id),
    CONSTRAINT fk_exam_results_stident_id FOREIGN KEY (student_id)
        REFERENCES public.students (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE INDEX students_name_idx
    ON public.students USING btree
    (name ASC NULLS LAST);

CREATE INDEX students_surname_idx
    ON public.students USING btree
    (surname ASC NULLS LAST);