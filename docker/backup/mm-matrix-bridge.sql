\c  mm-matrix-bridge
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

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
-- Name: mapping; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.mapping (
    mattermost_channel_id text NOT NULL,
    matrix_room_id text NOT NULL,
    is_private boolean DEFAULT true NOT NULL,
    is_direct boolean DEFAULT true NOT NULL,
    from_mattermost boolean DEFAULT true NOT NULL,
    info character varying(255)
);


ALTER TABLE public.mapping OWNER TO "mm-matrix-bridge";

--
-- Name: posts; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.posts (
    eventid text NOT NULL,
    postid character(26) NOT NULL,
    rootid character(26) NOT NULL
);


ALTER TABLE public.posts OWNER TO "mm-matrix-bridge";

--
-- Name: typeorm_metadata; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.typeorm_metadata (
    type character varying NOT NULL,
    database character varying,
    schema character varying,
    "table" character varying,
    name character varying,
    value text
);


ALTER TABLE public.typeorm_metadata OWNER TO "mm-matrix-bridge";

--
-- Name: users; Type: TABLE; Schema: public; Owner: mm-matrix-bridge
--

CREATE TABLE public.users (
    matrix_userid text NOT NULL,
    mattermost_userid character(26) NOT NULL,
    access_token text NOT NULL,
    is_matrix_user boolean NOT NULL,
    mattermost_username text NOT NULL,
    matrix_displayname text NOT NULL,
    email_match character varying(128),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO "mm-matrix-bridge";

--
-- Data for Name: mapping; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.mapping (mattermost_channel_id, matrix_room_id, is_private, is_direct, from_mattermost, info) FROM stdin;
k17btosn9bbniczjj96ttnzido	!CZMvztYPoMDXZghGjm:localhost	t	t	f	Channel display name: matrix.bridge, matrix_user1.matrix, matrix_user2.matrix, user1.m
xnbbfxbs1i87z8xp5mc5pxo3yw	!mjuhEfzSkeOAWJqsoF:localhost	t	t	f	Channel display name: matrix.bridge, matrix_user2.matrix, user2.mm
8tmxnejrb3fhxb6p91b7358y3c	!mOsaATLFknhUVKMKbF:localhost	t	f	f	Channel display name: A Private Channel for admins
wh1q4dxuhig5xdh5ouomzoeyjc	!puqobzhQaCAiNOjLcB:localhost	t	f	f	Channel display name: Private friends
77zccg7ddfnwu8odwj5r58i9hw	!nllwNxAePFlmipofLp:localhost	t	f	f	Channel display name: Private demo for team
fgicoxbdrb8r3884cjx7bbjyue	!EofCjJlPqVGGkmiiRY:localhost	t	f	f	Channel display name: Demo - Private Federated channel
imj88twwh7rzz84sa66akb4ssa	!JiDtQxxvPlscllynUi:localhost	t	t	f	Channel display name: jan.ostgren, matrix.bridge, matrix_jan.ostgren
c66na98stfrs7goij6gc1hdbzw	!VRDtvhDRJCQaqfmGXz:localhost	t	f	f	Channel display name: Secret Channel 666
w1bem8ojdidaxjt9uzznhc186y	!OwTNnVNmIMIDCGllRY:localhost	t	f	f	Channel display name: Private with foo
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.posts (eventid, postid, rootid) FROM stdin;
$og51kRH8SuNqsFQNosdBOBxETIwB8FB5kzG8d1eFdfg	8qy8hamxop8y9qnf6e3tbmrq7o	8qy8hamxop8y9qnf6e3tbmrq7o
$izJVy1IrPeG9uw-jzAwerUWmCrzlimtRy4MRTVzczYQ	h9qzaagsefn87rg1xe83c6om9r	8qy8hamxop8y9qnf6e3tbmrq7o
$QwRFm65tMMELbQCsW3P6ybEk5l4e2FjlMSVKvvlo1bo	jcjjt8q6fjdmjkd6zb8jayktze	jcjjt8q6fjdmjkd6zb8jayktze
$L9_BEkUSX8KWaRNZYlEytIBFnnxbXPGB6fWobi3JrAM	f1ax1fxpj7ya8cdrfxnfneygpy	f1ax1fxpj7ya8cdrfxnfneygpy
$N0j0AwhPRlsTlL8SiiHGeLE-sNucBEV2Nm98mvtsUfk	sy8sdoq7wbb7fmssxb9wkhqp3o	sy8sdoq7wbb7fmssxb9wkhqp3o
$JBer8LN2_BFW045Tnxz1654CEpd-GPfHpdFn9pPnQcM	riinuzhydfyjtgaangjgctq6ce	riinuzhydfyjtgaangjgctq6ce
$gt11gnOuFFjdPjK3YMbUw8U4rU0gKes7XiAFV3wyzd8	p9dw1sykjpnzdpysq5ooim38fa	p9dw1sykjpnzdpysq5ooim38fa
$8GRGY8kEapq5uZRR96qJGvE72vngB7PvGvgw2Zu20ag	6tcez1c997b9x8k5tqg4wx3khh	6tcez1c997b9x8k5tqg4wx3khh
$4Z5QY02QDAk4PJCCZ9UkvlZ3IC9TzZsUn9FupLmn3Ik	7ggmcxj9opr83mx575z6mjpdww	7ggmcxj9opr83mx575z6mjpdww
$m0fwV7r4DzTklLx7UOTqbmzBW21joM--yFj-ykJVp5s	dr9cuyc9oiyx78fresajkty6fa	7ggmcxj9opr83mx575z6mjpdww
$b4xF28i4qVBh4RszZHIHY2jYb-uXh6cEmOxrlpomq68	j51r5coyktd4fq1izkz15mx9hr	j51r5coyktd4fq1izkz15mx9hr
$LbhDlkHNqUY2Q5-3nw5pSirWV27QJaLJhSsrLTzxHAg	bcop4o4cdbnnfjb7jauh83xh8a	bcop4o4cdbnnfjb7jauh83xh8a
$Vp1aLQfJ7LzctRMxwqWhea0OGfOX3TjvoGD6LaTR9qI	cuq8yizzijf4jd1hdx757bh88y	cuq8yizzijf4jd1hdx757bh88y
$3QJE0ZNwQB-5F4mbQ8h4OKVVJPm7hbSiHZIwkQH4CN8	m6hykau14fy5zpuc535sjrchba	m6hykau14fy5zpuc535sjrchba
$jYMJiSz77ru7G_1uG1As9xbvCzC1cWq-OZPU69stCHI	s1siykjd9iyxpkxaah5nfej4dc	s1siykjd9iyxpkxaah5nfej4dc
$c7kx05Y10s3JDtCeMpBzGHy3l4p15ar2HcA-g51RF6c	she54bioifdh5cffq9ena59suw	she54bioifdh5cffq9ena59suw
$Ad6-JFdncNwTlKSNHpkmsNo-5m3Y6hHNEcgmf2LLfOI	j17ay6gqsi8upeuz3pxxrhbz1y	j17ay6gqsi8upeuz3pxxrhbz1y
$HANwWM4u2N_YR7MakaZRv21Sfdmedf16Rql9BDshmZg	5z3yu9oypirstbd9u58tgghe6w	5z3yu9oypirstbd9u58tgghe6w
$s87CXP9JVWhgrIBI-fooURdgJbaSi0f0wJtakjx-i8o	9irt8g7typfj8rsctf91ohfhnc	9irt8g7typfj8rsctf91ohfhnc
$JIT4PX0VSVoDfE66avVag03RZ1-1y6IsJtN3rESJC-k	znn6w6dox3y4bcexfxwsxhmwfy	znn6w6dox3y4bcexfxwsxhmwfy
$vZ9G7TooBF1VNMrMfUBJxAhozGtgRrTIK7bLZBvhdHY	pn4z9w5hdjri3m7nx94j7zp6we	pn4z9w5hdjri3m7nx94j7zp6we
$x1VitYFmkkfe8R2J-2KBXjxDd2byCT7kYZ0Uz8wJA9o	k84dtiqen3nttcz8n6egcp81fh	k84dtiqen3nttcz8n6egcp81fh
$jVF2dhaoKTX-LAZvNHh0JCiA19RDxSYZG8LdMuyGZHc	wao8cpy7i7yq8nxbunuswhg6kc	wao8cpy7i7yq8nxbunuswhg6kc
$h9nFZGR46v8UebUTinAD_DQGEToB_WjD0t_CcaIN5hQ	xrt8f6rnxtyi3fcgnxe6erm77o	xrt8f6rnxtyi3fcgnxe6erm77o
$6TMt4HpgJe7BZ5ttBP6Z173SUJQ-Kdv8uHpy9PipE-Y	pyceswe3bfgmfc5osrp5xsuywc	pyceswe3bfgmfc5osrp5xsuywc
$cPxS3i2zijtPc6_1QuMw8EwhbkzO_tt5WizGPzGGIgg	4wojgx49pfdwirg8gmp7t7n8iw	4wojgx49pfdwirg8gmp7t7n8iw
$6IoiZaIIKOIpM7WH4dpLvBP3CmD4L_Kj_yjZdHDBrWY	tez4k8rjj7bg5q7bdx7wgiqbze	tez4k8rjj7bg5q7bdx7wgiqbze
$Vg7wlBn8Hgqdtnh72er2IMr9wS1JITCagT5-XKR99gA	x8dfswhu53rxppjdw5zrs6cg7y	x8dfswhu53rxppjdw5zrs6cg7y
$7qKC_XyRPYddHJo5G-xbvRdnE90OIet--43prHorfY4	9tn7tispajgtufxpbdni9oxqhy	9tn7tispajgtufxpbdni9oxqhy
$_CnHh8K-94TlGYgDlsDpXH8FUqLIQ6LXkXOr7o4Y_YA	kxrqkqinsircmf74wtjatsg5io	kxrqkqinsircmf74wtjatsg5io
$RhR9DnuQbMNQocWUbuGM4VG7eJbhWuuu2_g-71q_3gA	yhm3j6m15fge7cz3jw4i8ptsxr	yhm3j6m15fge7cz3jw4i8ptsxr
$zC5D2NLQvk6H8HZCB_z4l6j1_Bx5u3ckk6OzkuKBXTI	zfkb1b4t6p8afbny4t855w4nbc	zfkb1b4t6p8afbny4t855w4nbc
$yCxrG4WEVOSpMpy0Z__fprEeWQJlbGGeBTGGZgWO5zc	9skqs18nqbdotmoe7o9fcpyh1h	9skqs18nqbdotmoe7o9fcpyh1h
$4yLothuX5SVurXVXCxdz2cld8YrgT_WyCidrGXNkjc8	xr3eo4hocbrefm1gsjs4tt8eoa	9skqs18nqbdotmoe7o9fcpyh1h
$NAdmKMroNta1gWYiWEzXBsQIVZJ8jNJoj3Vvw7vrozU	qcdpuba4hby8pd5pwy3ieehheh	qcdpuba4hby8pd5pwy3ieehheh
$Fonvg7PsYJXkYehyIeqY7vB0PgsdnYwSP7n5Y7Y-esE	rze167a517rw5drshqkrb6ydpr	rze167a517rw5drshqkrb6ydpr
$ODIhtyRfWCdX73fBdSritO9BtZhFT3oFd6Rqco9m57Q	su11q7dbt7r85ci6nfwaq8pnmw	su11q7dbt7r85ci6nfwaq8pnmw
$od0OVaC8RiuHlzegTskGx3Gd0-CWD0uLUY1XJezhaNA	dwsa7mnizpb6jfuhnrf5sap47a	dwsa7mnizpb6jfuhnrf5sap47a
$7VfVqIcpRfFAKV7GRBghZ0yG91LrkWOJ-rJf-X8KQiY	hfsdse3bbjdyjygygkatooztna	hfsdse3bbjdyjygygkatooztna
$_79-LOkThCAd9fcUhXVGt1ml2rTK8H1ZK9wSgQ-dJvk	rm7gkr417p8xumw8unrumnew7a	rm7gkr417p8xumw8unrumnew7a
\.


--
-- Data for Name: typeorm_metadata; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.typeorm_metadata (type, database, schema, "table", name, value) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.users (matrix_userid, mattermost_userid, access_token, is_matrix_user, mattermost_username, matrix_displayname, email_match, created_at, updated_at) FROM stdin;
@user1.matrix:localhost	bgct5icpib883fx619bh3cfu6h	zbobs1dw5jgrtby9hkcz3dkpjy	t	matrix_user1.matrix	user1.matrix	\N	2023-03-21 09:30:31.056147	2023-03-21 09:30:31.056147
@mm_user1.mm:localhost	ygmycw6rnff7igko8gwbqchujr	deges64nuprjdrke65zqfp7fkw	f	user1.mm	user1.mm [mm]	\N	2023-03-21 09:30:31.056147	2023-03-21 09:30:31.056147
@mm_user2.mm:localhost	e343y5ecu7dyujwqm7yfimh1je	s34w4m8qw7dybmn4qb8qfwyhfr	f	user2.mm	user2.mm [mm]	\N	2023-03-21 09:30:31.056147	2023-03-21 09:30:31.056147
@user2.matrix:localhost	wq6i7sbf4tnqzbssbn7gy7cjcc	i8bz3eaobffm7rgwfrohhjobwa	t	matrix_user2.matrix	user2.matrix	\N	2023-03-21 09:30:31.056147	2023-03-21 09:30:31.056147
@user3.matrix:localhost	596q88qz87nbzbddntjm5xi6fh	ikt4wiy53brdzyt7hn4dad77ch	t	matrix_user3.matrix		\N	2023-03-21 15:34:44.434864	2023-03-21 15:34:44.434864
@mm_jan.ostgren:localhost	u53sd36877djmjrqfo9n5e1p3o	9pu76pj41fnuu8scsdmhnu6erh	f	jan.ostgren	jan.ostgren [mm]	\N	2023-06-22 06:57:34.416711	2023-06-22 06:57:34.453218
@jan.ostgren:localhost	stmjik91m7rsdg6q4fcjtitfhr	kt6uhnoqs3bu8kumq8wp3r86so	t	matrix_jan.ostgren		jan.ostgren@localhost.com	2023-06-22 07:37:13.392449	2023-06-22 07:37:13.392449
@foo.bar:localhost	o1y7dsw4rbrg5xrrtpeqezhwqr	s11ug9ysmf8qzjmiijoq617kwo	t	matrix_foo.bar		\N	2023-06-22 07:52:29.785496	2023-06-22 07:52:29.785496
\.


--
-- Name: posts PK_4c80ebd45fc8d2779b82a183713; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "PK_4c80ebd45fc8d2779b82a183713" PRIMARY KEY (eventid);


--
-- Name: mapping PK_9b3d7f9178c4476a1f0da53195d; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.mapping
    ADD CONSTRAINT "PK_9b3d7f9178c4476a1f0da53195d" PRIMARY KEY (mattermost_channel_id);


--
-- Name: users PK_a857f41bae47ffe29abb14bc31d; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a857f41bae47ffe29abb14bc31d" PRIMARY KEY (matrix_userid);


--
-- Name: mapping UQ_0e4c898c29b678849086653e2cd; Type: CONSTRAINT; Schema: public; Owner: mm-matrix-bridge
--

ALTER TABLE ONLY public.mapping
    ADD CONSTRAINT "UQ_0e4c898c29b678849086653e2cd" UNIQUE (matrix_room_id);


--
-- PostgreSQL database dump complete
--

