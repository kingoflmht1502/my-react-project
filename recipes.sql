--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    user_id integer NOT NULL,
    full_name character varying(124) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    last_login timestamp without time zone,
    phone character varying(20),
    address character varying(255)
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts.user_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meals (
    meal_id integer NOT NULL,
    meal_name character varying(50) NOT NULL,
    meal_description text
);


ALTER TABLE public.meals OWNER TO postgres;

--
-- Name: meals_meal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meals_meal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meals_meal_id_seq OWNER TO postgres;

--
-- Name: meals_meal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meals_meal_id_seq OWNED BY public.meals.meal_id;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    rating_id integer NOT NULL,
    user_id integer NOT NULL,
    recipe_id integer NOT NULL,
    score numeric(10,2),
    review text,
    date_added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT rating_score_check CHECK ((((score)::double precision >= (0.0)::double precision) AND ((score)::double precision <= (5.0)::double precision)))
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- Name: rating_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_rating_id_seq OWNER TO postgres;

--
-- Name: rating_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_rating_id_seq OWNED BY public.rating.rating_id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipes (
    recipe_id integer NOT NULL,
    recipe_name character varying(255) NOT NULL,
    recipe_description text,
    meal_id integer NOT NULL,
    category_id integer NOT NULL,
    prep_time interval NOT NULL,
    cook_time interval NOT NULL,
    date_added timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cook_time_check CHECK ((cook_time > '00:00:00'::interval)),
    CONSTRAINT prep_time_check CHECK ((prep_time > '00:00:00'::interval))
);


ALTER TABLE public.recipes OWNER TO postgres;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recipes_recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_recipe_id_seq OWNER TO postgres;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recipes_recipe_id_seq OWNED BY public.recipes.recipe_id;


--
-- Name: wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wishlist (
    wishlist_id integer NOT NULL,
    user_id integer NOT NULL,
    recipe_id integer NOT NULL,
    date_added timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wishlist OWNER TO postgres;

--
-- Name: wishlist_wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wishlist_wishlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wishlist_wishlist_id_seq OWNER TO postgres;

--
-- Name: wishlist_wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wishlist_wishlist_id_seq OWNED BY public.wishlist.wishlist_id;


--
-- Name: accounts user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN user_id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: meals meal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals ALTER COLUMN meal_id SET DEFAULT nextval('public.meals_meal_id_seq'::regclass);


--
-- Name: rating rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN rating_id SET DEFAULT nextval('public.rating_rating_id_seq'::regclass);


--
-- Name: recipes recipe_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes ALTER COLUMN recipe_id SET DEFAULT nextval('public.recipes_recipe_id_seq'::regclass);


--
-- Name: wishlist wishlist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist ALTER COLUMN wishlist_id SET DEFAULT nextval('public.wishlist_wishlist_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (user_id, full_name, password, email, created_on, last_login, phone, address) FROM stdin;
32	L├¬ Thß╗ï Lan	$2b$10$8Z0zHQ6Sg63vOWW5OhcEm.yUil5SG4QwAqGPYLZFTl.sln3o/3OWq	lethiln@gmail.com	2023-10-27 14:55:17.454998	2023-10-27 14:55:17.454998	\N	\N
35	L├¬ Thß╗ï Lan	$2b$10$0ysXwQwmdjkgpmRpCL/aoOMLLjjrQYn5.FZort21fRjhGd1APiw7W	lethil@gmail.com	2023-10-27 14:58:56.073367	2023-10-27 14:58:56.073367	\N	\N
37	Qu├╜ Nguyß╗àn Mß║ính Ph├║	$2b$10$NyfJABtatvT5TV80rbZRqeUxgRo5vAQTfcVjSHLCS/v.4FFJy2BiS	test6@gmail.com	2023-10-27 15:21:48.467752	2023-10-27 15:21:48.467752	\N	\N
38	Nguyen Quy	$2b$10$3k2JJY0NbaRSRd.uAcGP...l6mAsxXwQ.23i8/Dpp9c43cQRG4Uyu	test7@gmail.com	2023-10-27 15:22:59.648823	2023-10-27 15:22:59.648823	\N	\N
39	Nguyen Quy	$2b$10$45BZ/zA2DD.eHie4ygmRQ.blfpyCL7WOUBe/V6bX.ppDhIHeIW3li	test8@gmail.com	2023-10-27 15:23:17.959252	2023-10-27 15:23:17.959252	\N	\N
41	Nguyen Quy	$2b$10$x0rQMzIml34OJkh5DE6FeO7/ILgfbU9lPDtfm/CPRfidaN1iiA2Z.	test10@gmail.com	2023-10-27 15:30:25.393786	2023-10-27 15:30:25.393786	\N	\N
43	Nguyen Quy	$2b$10$.nNVhvTN691Oze/44gc32esfhyEtky/RcYTkfdINoQKs7A5mWNzTm	test11@gmail.com	2023-10-27 15:36:51.465352	2023-10-27 15:36:51.465352	\N	\N
22	Trß║ºn  Minh	$2b$10$GTa/Mvv4mF4k0bM9cWthnOx48VBnxZg6QbfqvQzbBjGcDi3a5Nxby	test1@gmail.com	2023-10-18 09:42:05.45579	2023-10-20 14:42:50.446199	\N	\N
16	Nguyß╗àn Quy├╜	$2b$10$okEIS4w0a.8bggiXMvYwiOBLPYDSt.Kn22RxC/8GSNeoI.XQ3Mujq	manhphuquynguyen@gmail.com	2023-10-17 14:50:17.601692	2023-10-17 14:50:17.601692	\N	\N
18	Le Ha	$2b$10$PSDUSMdfEXEWPUEnCzDgf.Q9.y5bQifo/68KExqGkgqrh/9RUvDZa	test2@gmail.com	2023-10-17 14:52:04.811527	2023-10-17 14:54:04.498882	\N	\N
27	Nguyen Quy	$2b$10$KEcsEh4Vjspf2DWOUqWwdO5kMMbuTSVkEz2uJG1x/W7ahH7/5gYp2	test5@gmail.com	2023-10-18 09:55:41.236485	2023-10-24 09:30:50.140681	\N	\N
26	Nguyß╗àn Mß║ính Ph├║ Qu├╜	$2b$10$LiUFQUjoIZPb5HRm9vN9wu49KyH.Uvasfo5TutuDfuIisN5N7nzda	test4@gmail.com	2023-10-18 09:48:24.487703	2023-11-24 11:45:38.139998	0971183209	46 HT35, Hiep Thanh Ward, District 12, HCM City, Vietnam
28	Nguyß╗àn V─ân A	$2b$10$irLmkKXSvyKjvJpuqkkPH.en9yvyZNNSFkplq.IkqB63F331vvmMy	nguyenvana@gmail.com	2023-10-25 10:28:03.909457	2023-10-25 16:01:20.361666	\N	\N
29	L├¬  V─ân A	$2b$10$j2bHGC15Xjej34v3UGzvaeRpya0FtUqqIF.e2btQbTWOtDHlhxqx2	levana@gmail.com	2023-10-25 16:35:00.778581	2023-10-25 16:35:00.778581	\N	\N
30	L├¬ Thß╗ï Lan	$2b$10$f2s4Tnp9usqe0mtH7iixcu6/QQQd7lfvGHJ2P9ItWpiWnx0xYuR2O	lethilan@gmail.com	2023-10-27 14:51:23.623308	2023-10-27 14:51:23.623308	\N	\N
20	John Doe	$2b$10$H7ErZfA9SWnpT4hkYrtxTuug1i7PCfoBoiSmCVMv3PS.DMEguQeq6	john.doe2@gmail.com	2023-10-17 14:56:30.696975	2023-10-18 09:36:20.299193	\N	\N
21	L├¬ Qu├╜	$2b$10$xfMQcxw/jlazpcKVRnh6FOOL6JnFFYIATpawlQgjBihsQlTt6VIP6	phuquyphukhanh@gmail.com	2023-10-18 09:38:02.229742	2023-10-18 09:38:02.229742	\N	\N
23	Nguyß╗àn Qu├╜	$2b$10$EE5n4oreoadb0ds36e7OFuaSBHPHfTYB7LI/7LfYVOSqhSe2iXpHa	test3@gmail.com	2023-10-18 09:47:00.935984	2023-10-18 09:47:00.935984	\N	\N
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name) FROM stdin;
1	Main
2	Soups
3	Desserts
4	Salads
5	Appetizers
6	Sandwiches
7	Pizza
8	Pasta dishes
9	Breads
10	Sweet
11	Baking
12	Egg
13	Beef
14	Chicken
15	Seafood
\.


--
-- Data for Name: meals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meals (meal_id, meal_name, meal_description) FROM stdin;
1	Breakfast	A nutritious and balanced meal that provides energy and nourishment for the day. It may include cereals, such as oatmeal, granola, or cornflakes, fruits, such as bananas, apples, or berries, eggs, cooked in various ways, such as scrambled, boiled, or poached, toast, with butter, jam, or cheese, milk, either plain or flavored, coffee, either black or with cream and sugar, etc.
2	Lunch	A light and satisfying meal that helps to maintain productivity and focus in the afternoon. It may include sandwiches, made with bread, cheese, ham, turkey, or tuna, salads, tossed with lettuce, tomatoes, cucumbers, carrots, and dressing, soups, such as chicken noodle, tomato, or vegetable, wraps, filled with chicken, beef, beans, cheese, or salsa, pasta, cooked with sauce, cheese, meatballs, or vegetables, etc.
4	Dinner	A hearty and delicious meal that marks the end of the day and allows for socializing and relaxing. It may include meat such as steak pork chops or lamb chops fish such as salmon tuna or cod poultry such as chicken turkey or duck vegetables such as potatoes carrots broccoli or corn rice either white brown or wild bread either white wheat or sourdough etc.
5	Desserts	Sweet and indulgent treats that are enjoyed after the main course or as a snack. They may include cakes such as chocolate vanilla or carrot pies such as apple cherry or pecan ice cream either plain or with toppings such as chocolate syrup whipped cream or nuts cookies either chocolate chip oatmeal raisin or peanut butter chocolate either bars candies or truffles etc.
3	Appetizers	Small and tasty dishes that are served before the main course to stimulate the appetite. They may include cheese, such as cheddar, brie, or mozzarella, crackers, either plain or flavored with herbs or spices, dips, such as hummus, guacamole, or salsa, nuts, such as almonds, cashews, or pistachios, olives, either green or black and pitted or stuffed with garlic or cheese etc.
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (rating_id, user_id, recipe_id, score, review, date_added) FROM stdin;
15	26	9	4.00	Good	2023-11-22 11:53:33.347657
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipes (recipe_id, recipe_name, recipe_description, meal_id, category_id, prep_time, cook_time, date_added) FROM stdin;
2	Chips		1	3	00:10:00	00:30:00	2023-11-22 09:27:24.086035
7	Banh mi	First get the 2 pieces of bread, then add some toppings between 2 pieces like tomato, cucumber, beef, butter, pat├⌐,...	1	9	01:00:00	00:10:00	2023-11-22 09:27:24.086035
6	Salad Potato	First slice the potato, then add the salad and add some ginger or vinegar, mix it up and we got the yummy salad	1	4	00:30:00	00:01:00	2023-11-22 09:27:24.086035
1	Hamburger	This is a delicious hamburger with tomato, cheese inside, with the additional layered of beef	2	5	01:30:00	00:10:00	2023-11-22 09:27:24.086035
8	Spaghetti Carbonara	A classic Italian pasta dish made with eggs, bacon, and cheese.	1	8	00:10:00	00:20:00	2023-11-22 09:27:24.086035
9	Chicken Tikka Masala	A popular Indian curry dish made with marinated chicken and a creamy tomato sauce.	2	1	00:15:00	00:30:00	2023-11-22 09:27:24.086035
10	Beef Stroganoff	A hearty Russian dish made with beef and sour cream sauce.	4	1	00:20:00	00:40:00	2023-11-22 09:27:24.086035
3	Fried Chicken	A crispy, juicy, and flavorful meat that can be eaten as a main course or a snack, popular in many cuisines around the world, such as American, Korean, Chinese, and Indian.	1	1	01:00:00	00:30:00	2023-11-22 09:27:24.086035
11	Honey-Sriracha Glazed Meatballs	These meatballs are spicy, sweet and savory, and can be served with rice, noodles or salad. They are easy to make and freeze well for meal prep	2	1	00:10:00	00:20:00	2023-11-22 09:27:24.086035
12	Raspberry Glazed Chicken Breasts	This dish is not only quick and delicious, but also gorgeous. The chicken breasts are coated with a tangy raspberry sauce and baked in the oven. You can serve them with asparagus or green beans for a colorful and healthy meal	4	14	00:05:00	00:25:00	2023-11-22 09:27:24.086035
13	Pesto Pasta	 This is a simple and fresh pasta dish that only requires five ingredients: pasta, pesto, cherry tomatoes, mozzarella and basil. ItΓÇÖs perfect for a busy weeknight or a casual dinner with friends	3	8	00:10:00	00:15:00	2023-11-22 09:27:24.086035
14	MomΓÇÖs Chicken Pot Pie	 This is a creamy and cozy dish that consists of chicken, vegetables, and gravy baked in a pie crust. It is a family favorite that can be made with store-bought ingredients for convenience	3	11	00:10:00	00:45:00	2023-11-22 09:27:24.086035
15	Cajun Seafood Pasta	This is a spicy and flavorful dish that combines shrimp, scallops, and pasta in a creamy sauce. It is easy to make in a skillet or a casserole dish, and can be adjusted to your taste 	1	15	00:15:00	00:30:00	2023-11-22 09:27:24.086035
16	Molten Chocolate Mug Cake	This is a rich and gooey cake that you can make in just three minutes using a microwave. All you need are some basic ingredients like chocolate chips, butter, sugar, eggs, flour, and cocoa powder. You can also add some vanilla extract or salt for extra flavor	3	5	00:02:00	00:01:00	2023-11-22 09:27:24.086035
17	Vanilla No-Bake Cheesecake	This is a creamy and smooth cheesecake that does not require any baking. You just need to make a crust with chocolate cookies and butter, and then fill it with a mixture of cream cheese, whipped cream, sugar, and vanilla. You can also top it with some fresh fruits or chocolate shavings	3	5	00:20:00	04:00:00	2023-11-22 09:27:24.086035
20	Chicken breast peanut	This is a good	4	1	01:00:00	01:00:00	2023-11-24 17:00:53.572513
\.


--
-- Data for Name: wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wishlist (wishlist_id, user_id, recipe_id, date_added) FROM stdin;
54	26	1	2023-11-17 16:27:53.698836
67	26	11	2023-11-21 16:59:13.598654
68	26	10	2023-11-22 09:54:36.085718
69	26	9	2023-11-24 10:06:28.6364
\.


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 43, true);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 17, true);


--
-- Name: meals_meal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meals_meal_id_seq', 7, true);


--
-- Name: rating_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_rating_id_seq', 19, true);


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipes_recipe_id_seq', 20, true);


--
-- Name: wishlist_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wishlist_wishlist_id_seq', 69, true);


--
-- Name: accounts accounts_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_key UNIQUE (email);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (user_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (meal_id);


--
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (rating_id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: rating unique_user_recipe_pair; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT unique_user_recipe_pair UNIQUE (user_id, recipe_id);


--
-- Name: wishlist user_recipe_constraint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT user_recipe_constraint UNIQUE (user_id, recipe_id);


--
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (wishlist_id);


--
-- PostgreSQL database dump complete
--

