SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;
COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';

SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE IF NOT EXISTS "records" (
    id integer NOT NULL,
    url character varying(255),
    note character varying(255),
    type character varying(255),
    seen boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

DROP SEQUENCE IF EXISTS "records_id_seq" CASCADE;

CREATE SEQUENCE "records_id_seq" START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE records_id_seq OWNED BY records.id;

ALTER TABLE ONLY "records" ALTER COLUMN id SET DEFAULT nextval('records_id_seq'::regclass);

ALTER TABLE ONLY "records" ADD CONSTRAINT records_pkey PRIMARY KEY (id);

SET search_path TO "$user",public;
