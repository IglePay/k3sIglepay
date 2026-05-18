--
-- PostgreSQL database dump
--

\restrict UTfwuAn3EiVxnoBAmvg2hBCa8rfabBI0SMPAvdMvzAAFMQXzMJsQMNoJvXx5l3k

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.11 (Debian 16.11-1.pgdg13+1)

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
-- Name: procedimiento_api(text); Type: FUNCTION; Schema: public; Owner: 10enconta
--

CREATE FUNCTION public.procedimiento_api(p_token_hash text) RETURNS TABLE(token_id integer, active boolean, expires_at timestamp without time zone, requests_count integer, plan_code text, plan_description text, usuario_email text, usuario_nombre text)
    LANGUAGE sql
    AS $$
    SELECT
        t.id,
        t.active,
        t.expires_at,
        t.requests_count,
        tp.code,
        tp.description,
        u.email,
        u.nombreuser
    FROM tb_tokens t
    INNER JOIN tb_token_plan tp ON t.plan_id = tp.id
    LEFT JOIN tb_usuario u ON t.usuario_id = u.id
    WHERE t.token_hash = p_token_hash;
$$;


ALTER FUNCTION public.procedimiento_api(p_token_hash text) OWNER TO "10enconta";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO "10enconta";

--
-- Name: tb_empresa; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_empresa (
    nombre text NOT NULL,
    "emailEmpre" text NOT NULL,
    direccion text NOT NULL,
    fcreacion date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    idempresa integer NOT NULL,
    nit text,
    telefono text,
    dpi text
);


ALTER TABLE public.tb_empresa OWNER TO "10enconta";

--
-- Name: tb_empresa_idempresa_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_empresa_idempresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_empresa_idempresa_seq OWNER TO "10enconta";

--
-- Name: tb_empresa_idempresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_empresa_idempresa_seq OWNED BY public.tb_empresa.idempresa;


--
-- Name: tb_permisos; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_permisos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255)
);


ALTER TABLE public.tb_permisos OWNER TO "10enconta";

--
-- Name: tb_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_permisos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_permisos_id_seq OWNER TO "10enconta";

--
-- Name: tb_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_permisos_id_seq OWNED BY public.tb_permisos.id;


--
-- Name: tb_role_permissions; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_role_permissions (
    role_id integer NOT NULL,
    permiso_id integer NOT NULL
);


ALTER TABLE public.tb_role_permissions OWNER TO "10enconta";

--
-- Name: tb_roles; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_roles (
    id_rol integer NOT NULL,
    nombrerol character varying(50) NOT NULL,
    descripcion character varying(255),
    fcreacion date DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.tb_roles OWNER TO "10enconta";

--
-- Name: tb_roles_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_roles_id_rol_seq OWNER TO "10enconta";

--
-- Name: tb_roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_roles_id_rol_seq OWNED BY public.tb_roles.id_rol;


--
-- Name: tb_token_plan; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_token_plan (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    description character varying(100),
    duration_days integer,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tb_token_plan OWNER TO "10enconta";

--
-- Name: tb_token_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_token_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_token_plan_id_seq OWNER TO "10enconta";

--
-- Name: tb_token_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_token_plan_id_seq OWNED BY public.tb_token_plan.id;


--
-- Name: tb_tokens; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_tokens (
    id integer NOT NULL,
    token_hash character varying(64) NOT NULL,
    token_prefix character varying(10) NOT NULL,
    plan_id integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    expires_at timestamp without time zone,
    requests_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    usuario_id integer
);


ALTER TABLE public.tb_tokens OWNER TO "10enconta";

--
-- Name: tb_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_tokens_id_seq OWNER TO "10enconta";

--
-- Name: tb_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_tokens_id_seq OWNED BY public.tb_tokens.id;


--
-- Name: tb_usuario; Type: TABLE; Schema: public; Owner: 10enconta
--

CREATE TABLE public.tb_usuario (
    nombreuser text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "rolId" integer NOT NULL,
    fcreacion date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "empresaId" integer NOT NULL,
    id integer NOT NULL,
    password_temp boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tb_usuario OWNER TO "10enconta";

--
-- Name: tb_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: 10enconta
--

CREATE SEQUENCE public.tb_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_usuario_id_seq OWNER TO "10enconta";

--
-- Name: tb_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: 10enconta
--

ALTER SEQUENCE public.tb_usuario_id_seq OWNED BY public.tb_usuario.id;


--
-- Name: tb_empresa idempresa; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_empresa ALTER COLUMN idempresa SET DEFAULT nextval('public.tb_empresa_idempresa_seq'::regclass);


--
-- Name: tb_permisos id; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_permisos ALTER COLUMN id SET DEFAULT nextval('public.tb_permisos_id_seq'::regclass);


--
-- Name: tb_roles id_rol; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_roles ALTER COLUMN id_rol SET DEFAULT nextval('public.tb_roles_id_rol_seq'::regclass);


--
-- Name: tb_token_plan id; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_token_plan ALTER COLUMN id SET DEFAULT nextval('public.tb_token_plan_id_seq'::regclass);


--
-- Name: tb_tokens id; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_tokens ALTER COLUMN id SET DEFAULT nextval('public.tb_tokens_id_seq'::regclass);


--
-- Name: tb_usuario id; Type: DEFAULT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_usuario ALTER COLUMN id SET DEFAULT nextval('public.tb_usuario_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
a8220575-a25c-40c7-b0da-fd5ed8bdfe3e	c9a3c1dc045ec806dcd0c18f8a8123937275cef843d365200477052e07b38b6d	2025-12-11 17:44:05.988063-06	20251209220417_init_schema	\N	\N	2025-12-11 17:44:05.967264-06	1
16f665a1-c8b7-4249-9ec5-9392b5f34540	53f470dc4b90c1bdb0718e11f8818678576f03448022f423dc2ce8f5c2279d28	2025-12-11 17:44:05.997122-06	20251210152747_add_fcreacion	\N	\N	2025-12-11 17:44:05.988862-06	1
4a167aa6-8d60-4dbc-b656-4c194b5325ed	1985d760f83755cef80d0e739ce091812e6db576a9bb1e7aa352c413335ea19b	2025-12-11 17:44:06.011957-06	20251210165130_fix_empresa_id	\N	\N	2025-12-11 17:44:05.998158-06	1
c206ea7d-1cdd-416c-85bd-d85c94910ec8	5201a3c2e7f855d2369ebe1dbe6d399c5d5867c33aff6645fb20e35225a3eaf4	2025-12-11 17:44:06.036341-06	20251210172554_change_usuario_id_autoincrement	\N	\N	2025-12-11 17:44:06.013017-06	1
\.


--
-- Data for Name: tb_empresa; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_empresa (nombre, "emailEmpre", direccion, fcreacion, idempresa, nit, telefono, dpi) FROM stdin;
Empresa 10enconta	10enconta@empresa.com	direccion coban zona 12	2025-12-11	1	\N	\N	\N
Empresa Piloto	correo@empresa.com	Carcha zona 2	2025-12-11	2	106286447	51247453	2891572831601
\.


--
-- Data for Name: tb_permisos; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_permisos (id, nombre, descripcion) FROM stdin;
1	ver_empresas	Permite ver las empresas
2	ver_usuarios	Permite ver los usuarios
4	ver_permisos	Faculta de crear permisos
5	ver_reportes	ver las graficas 
6	ver_xml-ventas	acceso al modulo de ventas xml
7	ver_xml-compras	acceso modulo de compras
8	ver_xml-compras2	acceso compras
9	ver_generador	acceso al modulo de generar claves
\.


--
-- Data for Name: tb_role_permissions; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_role_permissions (role_id, permiso_id) FROM stdin;
1	1
1	2
1	4
1	5
1	7
1	8
1	6
2	6
2	7
1	9
\.


--
-- Data for Name: tb_roles; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_roles (id_rol, nombrerol, descripcion, fcreacion) FROM stdin;
1	Admin	\N	2025-12-11
2	Contador	\N	2025-12-11
\.


--
-- Data for Name: tb_token_plan; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_token_plan (id, code, description, duration_days, active, created_at) FROM stdin;
1	sinlimite	Token sin expiración	\N	t	2026-02-04 12:01:35.381175
2	mensual	Token mensual	30	t	2026-02-04 12:01:35.381175
3	anual	Token anual	365	t	2026-02-04 12:01:35.381175
\.


--
-- Data for Name: tb_tokens; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_tokens (id, token_hash, token_prefix, plan_id, active, expires_at, requests_count, created_at, usuario_id) FROM stdin;
1	b64b6fa4b148d7fc6bad19bbd5065469fad944e34d3cfddec47a737a7944e6b2	917ace	1	t	\N	0	2026-02-10 17:41:47.02	1
2	fda21193a47e98c56a10ed908cfc052abf2957f06194e47c964e82f2d4f6f839	717548	1	t	\N	0	2026-02-10 21:18:15.276	2
\.


--
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: public; Owner: 10enconta
--

COPY public.tb_usuario (nombreuser, email, password, "rolId", fcreacion, "empresaId", id, password_temp) FROM stdin;
Romeo Teni	romeo@10.com	$2b$10$pT3qU9rkWZwIbQ9n9fI8/eOJX/SakOB54bcntnji3lx1YOifgFZ76	1	2025-12-11	2	1	f
Melvin Torres	melvintorresg@gmail.com	$2b$12$ySXBPpe.dKjnnd51.EKNpuHI8GoPwjTNig9PdVmiuRgJgPtH2FK.a	1	2025-12-11	1	2	f
Marta	icontaclientes@gmail.com	$2b$12$zz20NGI9lIfhkcYivMLCpOAKGlu1jRm5TON.Q7n6z9dQqpmxWGXEq	2	2026-01-27	1	7	f
\.


--
-- Name: tb_empresa_idempresa_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_empresa_idempresa_seq', 2, true);


--
-- Name: tb_permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_permisos_id_seq', 9, true);


--
-- Name: tb_roles_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_roles_id_rol_seq', 2, true);


--
-- Name: tb_token_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_token_plan_id_seq', 3, true);


--
-- Name: tb_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_tokens_id_seq', 2, true);


--
-- Name: tb_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: 10enconta
--

SELECT pg_catalog.setval('public.tb_usuario_id_seq', 7, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: tb_empresa tb_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_empresa
    ADD CONSTRAINT tb_empresa_pkey PRIMARY KEY (idempresa);


--
-- Name: tb_permisos tb_permisos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_permisos
    ADD CONSTRAINT tb_permisos_nombre_key UNIQUE (nombre);


--
-- Name: tb_permisos tb_permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_permisos
    ADD CONSTRAINT tb_permisos_pkey PRIMARY KEY (id);


--
-- Name: tb_role_permissions tb_role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_role_permissions
    ADD CONSTRAINT tb_role_permissions_pkey PRIMARY KEY (role_id, permiso_id);


--
-- Name: tb_roles tb_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_roles
    ADD CONSTRAINT tb_roles_pkey PRIMARY KEY (id_rol);


--
-- Name: tb_token_plan tb_token_plan_code_key; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_token_plan
    ADD CONSTRAINT tb_token_plan_code_key UNIQUE (code);


--
-- Name: tb_token_plan tb_token_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_token_plan
    ADD CONSTRAINT tb_token_plan_pkey PRIMARY KEY (id);


--
-- Name: tb_tokens tb_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_tokens
    ADD CONSTRAINT tb_tokens_pkey PRIMARY KEY (id);


--
-- Name: tb_tokens tb_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_tokens
    ADD CONSTRAINT tb_tokens_token_hash_key UNIQUE (token_hash);


--
-- Name: tb_usuario tb_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_pkey PRIMARY KEY (id);


--
-- Name: tb_roles_nombrerol_key; Type: INDEX; Schema: public; Owner: 10enconta
--

CREATE UNIQUE INDEX tb_roles_nombrerol_key ON public.tb_roles USING btree (nombrerol);


--
-- Name: tb_usuario_email_key; Type: INDEX; Schema: public; Owner: 10enconta
--

CREATE UNIQUE INDEX tb_usuario_email_key ON public.tb_usuario USING btree (email);


--
-- Name: tb_role_permissions fk_role_permissions_permiso; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_role_permissions
    ADD CONSTRAINT fk_role_permissions_permiso FOREIGN KEY (permiso_id) REFERENCES public.tb_permisos(id) ON DELETE CASCADE;


--
-- Name: tb_role_permissions fk_role_permissions_role; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_role_permissions
    ADD CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES public.tb_roles(id_rol) ON DELETE CASCADE;


--
-- Name: tb_tokens fk_tb_tokens_plan; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_tokens
    ADD CONSTRAINT fk_tb_tokens_plan FOREIGN KEY (plan_id) REFERENCES public.tb_token_plan(id);


--
-- Name: tb_tokens fk_tb_tokens_usuario; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_tokens
    ADD CONSTRAINT fk_tb_tokens_usuario FOREIGN KEY (usuario_id) REFERENCES public.tb_usuario(id) ON DELETE SET NULL;


--
-- Name: tb_usuario tb_usuario_empresaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT "tb_usuario_empresaId_fkey" FOREIGN KEY ("empresaId") REFERENCES public.tb_empresa(idempresa) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tb_usuario tb_usuario_rolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: 10enconta
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT "tb_usuario_rolId_fkey" FOREIGN KEY ("rolId") REFERENCES public.tb_roles(id_rol) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict UTfwuAn3EiVxnoBAmvg2hBCa8rfabBI0SMPAvdMvzAAFMQXzMJsQMNoJvXx5l3k

