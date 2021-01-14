--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: migrations; Type: TABLE; Schema: public
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: order; Type: TABLE; Schema: public
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    address character varying NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    status character varying NOT NULL,
    moment timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: order_products_product; Type: TABLE; Schema: public
--

CREATE TABLE public.order_products_product (
    "orderId" integer NOT NULL,
    "productId" integer NOT NULL
);


--
-- Name: product; Type: TABLE; Schema: public
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying NOT NULL,
    price double precision NOT NULL,
    description character varying NOT NULL,
    "imageUri" character varying NOT NULL
);


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: migrations id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: order PK_1031171c13130102495201e3e20; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);


--
-- Name: order_products_product PK_59f5d41216418eba313ed3c7d7c; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public.order_products_product
    ADD CONSTRAINT "PK_59f5d41216418eba313ed3c7d7c" PRIMARY KEY ("orderId", "productId");


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: product PK_bebc9158e480b949565b4dc7a82; Type: CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_bebc9158e480b949565b4dc7a82" PRIMARY KEY (id);


--
-- Name: IDX_1f9ea0b0e59e0d98ade4f2d5e9; Type: INDEX; Schema: public
--

CREATE INDEX "IDX_1f9ea0b0e59e0d98ade4f2d5e9" ON public.order_products_product USING btree ("orderId");


--
-- Name: IDX_d6c66c08b9c7e84a1b657797df; Type: INDEX; Schema: public
--

CREATE INDEX "IDX_d6c66c08b9c7e84a1b657797df" ON public.order_products_product USING btree ("productId");


--
-- Name: order_products_product FK_1f9ea0b0e59e0d98ade4f2d5e99; Type: FK CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public.order_products_product
    ADD CONSTRAINT "FK_1f9ea0b0e59e0d98ade4f2d5e99" FOREIGN KEY ("orderId") REFERENCES public."order"(id) ON DELETE CASCADE;


--
-- Name: order_products_product FK_d6c66c08b9c7e84a1b657797dff; Type: FK CONSTRAINT; Schema: public
--

ALTER TABLE ONLY public.order_products_product
    ADD CONSTRAINT "FK_d6c66c08b9c7e84a1b657797dff" FOREIGN KEY ("productId") REFERENCES public.product(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

