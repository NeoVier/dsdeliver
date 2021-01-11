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

--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: henrique
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1610373779283	FirstMigration1610373779283
2	1610374682578	FirstMigration1610374682578
3	1610374806278	CreateDatabase1610374806278
4	1610374865982	CreateDatabase1610374865982
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: henrique
--

COPY public."order" (id, address, latitude, longitude, status, moment) FROM stdin;
1	Avenida Paulista, 1500	-23.56168	-46.656139	pending	2021-01-11 11:35:44.00197
2	Avenida Paulista , 1500	-22.946779	-43.217753	delivered	2021-01-11 11:35:44.00197
3	Avenida Paulista, 1500	-25.439787	-49.237759	pending	2021-01-11 11:35:44.00197
4	Avenida Paulista, 1500	-23.56168	-46.656139	pending	2021-01-11 11:35:44.00197
5	Avenida Paulista, 1500	-23.56168	-46.656139	delivered	2021-01-11 11:35:44.00197
6	Avenida Paulista, 1500	-23.56168	-46.656139	pending	2021-01-11 11:35:44.00197
7	Avenida Paulista, 1500	-23.56168	-46.656139	pending	2021-01-11 11:35:44.00197
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: henrique
--

COPY public.product (id, name, price, description, "imageUri") FROM stdin;
1	Pizza Bacon	49.9	Pizza de bacon com mussarela, orégano, molho especial e tempero da casa.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_bacon.jpg
2	Risoto de Carne	52	Risoto de carne com especiarias e um delicioso molho de acompanhamento.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_carne.jpg
3	Pizza Moda da Casa	59.9	Pizza à moda da casa, com molho especial e todos ingredientes básicos, e queijo à sua escolha.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_moda.jpg
4	Risoto Funghi	59.95	Risoto Funghi feito com ingredientes finos e o toque especial do chef.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_funghi.jpg
5	Macarrão Penne	37.9	Macarrão penne fresco ao dente com tempero especial.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_penne.jpg
6	Pizza Portuguesa	45	Pizza Portuguesa com molho especial, mussarela, presunto, ovos e especiarias.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_portuguesa.jpg
7	Macarrão Espaguete	35.9	Macarrão fresco espaguete com molho especial e tempero da casa.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_espaguete.jpg
8	Macarrão Fusili	38	Macarrão fusili com toque do chef e especiarias.	https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_fusili.jpg
\.


--
-- Data for Name: order_products_product; Type: TABLE DATA; Schema: public; Owner: henrique
--

COPY public.order_products_product ("orderId", "productId") FROM stdin;
1	1
1	2
2	3
2	4
2	5
3	6
3	2
4	3
4	7
5	2
5	8
6	1
6	4
7	4
7	8
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: henrique
--

SELECT pg_catalog.setval('public.migrations_id_seq', 4, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: henrique
--

SELECT pg_catalog.setval('public.order_id_seq', 7, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: henrique
--

SELECT pg_catalog.setval('public.product_id_seq', 8, true);


--
-- PostgreSQL database dump complete
--

