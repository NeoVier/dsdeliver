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
-- Name: comment; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    message character varying NOT NULL,
    user_id bigint
);


ALTER TABLE public.comment OWNER TO dsdeliver;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO dsdeliver;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: email; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public.email (
    id bigint NOT NULL,
    email character varying NOT NULL,
    user_id bigint,
    verkey character varying
);


ALTER TABLE public.email OWNER TO dsdeliver;

--
-- Name: email_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_id_seq OWNER TO dsdeliver;

--
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.email_id_seq OWNED BY public.email.id;


--
-- Name: order; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public."order" (
    id bigint NOT NULL,
    address character varying NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    moment timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying NOT NULL
);


ALTER TABLE public."order" OWNER TO dsdeliver;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO dsdeliver;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: order_product; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public.order_product (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    order_id bigint NOT NULL
);


ALTER TABLE public.order_product OWNER TO dsdeliver;

--
-- Name: order_product_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.order_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_product_id_seq OWNER TO dsdeliver;

--
-- Name: order_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.order_product_id_seq OWNED BY public.order_product.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public.product (
    id bigint NOT NULL,
    name character varying NOT NULL,
    price double precision NOT NULL,
    description character varying NOT NULL,
    image_uri character varying NOT NULL
);


ALTER TABLE public.product OWNER TO dsdeliver;

--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO dsdeliver;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: dsdeliver
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    ident character varying NOT NULL,
    password character varying
);


ALTER TABLE public."user" OWNER TO dsdeliver;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: dsdeliver
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO dsdeliver;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dsdeliver
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: email id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.email ALTER COLUMN id SET DEFAULT nextval('public.email_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: order_product id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.order_product ALTER COLUMN id SET DEFAULT nextval('public.order_product_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_product order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: email unique_email; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: user unique_user; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT unique_user UNIQUE (ident);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: email email_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: order_product order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: order_product order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dsdeliver
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- PostgreSQL database dump complete
--

