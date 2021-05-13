--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-01-15 16:58:38

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
-- TOC entry 3016 (class 1262 OID 24829)
-- Name: SDP; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "SDP" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE "SDP" OWNER TO postgres;

\connect "SDP"

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
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 3016
-- Name: DATABASE "SDP"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "SDP" IS 'Base de dados para o projecto de SDP';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 24937)
-- Name: depositos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.depositos (
    id integer NOT NULL,
    quantidade integer NOT NULL,
    id_item integer
);


ALTER TABLE public.depositos OWNER TO postgres;

--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE depositos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.depositos IS 'Representa os depósitos feitos no armazém';


--
-- TOC entry 206 (class 1259 OID 33175)
-- Name: depositos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.depositos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.depositos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- TOC entry 202 (class 1259 OID 24922)
-- Name: entrega_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrega_items (
    id_entrega integer NOT NULL,
    id_item integer NOT NULL,
    quantidade integer NOT NULL
);


ALTER TABLE public.entrega_items OWNER TO postgres;

--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE entrega_items; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.entrega_items IS 'Indica que items pertencem a cada entrega (e a respetiva quantidade)';


--
-- TOC entry 201 (class 1259 OID 24914)
-- Name: entregas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entregas (
    id integer NOT NULL,
    local_entrega character varying NOT NULL
);


ALTER TABLE public.entregas OWNER TO postgres;

--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE entregas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.entregas IS 'Representa as entregas que a empresa faz aos locais';


--
-- TOC entry 205 (class 1259 OID 33172)
-- Name: entregas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.entregas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.entregas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE
);


--
-- TOC entry 200 (class 1259 OID 24903)
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    id integer NOT NULL,
    nome character varying NOT NULL,
    quantidade integer,
    descricao character varying
);


ALTER TABLE public.items OWNER TO postgres;

--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE items; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.items IS 'Representa o armazém central da empresa';


--
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN items.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.items.id IS 'id do item';


--
-- TOC entry 204 (class 1259 OID 33170)
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.items ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 255
    CACHE 1
    CYCLE
);


--
-- TOC entry 2877 (class 2606 OID 24941)
-- Name: depositos Depositos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.depositos
    ADD CONSTRAINT "Depositos_pkey" PRIMARY KEY (id);


--
-- TOC entry 2875 (class 2606 OID 24926)
-- Name: entrega_items Entrega_Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega_items
    ADD CONSTRAINT "Entrega_Items_pkey" PRIMARY KEY (id_entrega, id_item);


--
-- TOC entry 2873 (class 2606 OID 24921)
-- Name: entregas Entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT "Entregas_pkey" PRIMARY KEY (id);


--
-- TOC entry 2869 (class 2606 OID 24910)
-- Name: items Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT "Items_pkey" PRIMARY KEY (id);


--
-- TOC entry 2871 (class 2606 OID 33154)
-- Name: items unique_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT unique_name UNIQUE (nome);


--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 2871
-- Name: CONSTRAINT unique_name ON items; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT unique_name ON public.items IS 'faz com que o nome de cada item tenha de ser único';


--
-- TOC entry 2878 (class 2606 OID 24927)
-- Name: entrega_items fk_entrega; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega_items
    ADD CONSTRAINT fk_entrega FOREIGN KEY (id_entrega) REFERENCES public.entregas(id);


--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 2878
-- Name: CONSTRAINT fk_entrega ON entrega_items; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT fk_entrega ON public.entrega_items IS 'id de entrega como foreign key';


--
-- TOC entry 2879 (class 2606 OID 24932)
-- Name: entrega_items fk_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega_items
    ADD CONSTRAINT fk_item FOREIGN KEY (id_item) REFERENCES public.items(id);


--
-- TOC entry 2880 (class 2606 OID 24942)
-- Name: depositos fk_items; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.depositos
    ADD CONSTRAINT fk_items FOREIGN KEY (id_item) REFERENCES public.items(id);


-- Completed on 2021-01-15 16:58:38

--
-- PostgreSQL database dump complete
--
