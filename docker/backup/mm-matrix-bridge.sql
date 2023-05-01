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
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mm-matrix-bridge
--

COPY public.posts (eventid, postid, rootid) FROM stdin;
$ws9UuWLPn8VzHbofyg3g8AQK-aYsdD2iv6woyWt3sEw	qpybi5a1tff9u81mgtngeuhkro	qpybi5a1tff9u81mgtngeuhkro
$ls5AzJlLTu3Alykxvj5L99HqOQsi7cUGH7wVb-IqErQ	xcginserxtyab8q7dtajc43fwr	xcginserxtyab8q7dtajc43fwr
$nFwL1txBnk2dj72aBWqthTGHrC-kv7CYWMt3cwz8qgw	i3rgzbuhdpn73conyzd7zw6sbc	i3rgzbuhdpn73conyzd7zw6sbc
$hXzRSYfNTLUmjRz8EgsrekOmklfOoUQ9NKx0vS1AmTk	ma8t73u6cbnkdy4gsyue5rrd9h	ma8t73u6cbnkdy4gsyue5rrd9h
$ggCddRubeCPps5yMhlY-9Ib0RvBhwUJy716vZvf32Oo	jqbf9g91b3neteabf1378kf6ao	jqbf9g91b3neteabf1378kf6ao
$v3jGyApp70gdwh4Il9oB6nRxdyr-zF1Nt9w5VRI1Em4	man1grukefr4jmityxs3z4z8te	man1grukefr4jmityxs3z4z8te
$95vJ25qtpsri2l4-Ft6bN-NMw1uq9NjdTcLLt_v-cdE	hz71npt4spyr9gesejj34pynkc	hz71npt4spyr9gesejj34pynkc
$cy5KlfdXxrxwsh3JYgCvSt79RGqs9e0nqUdGznRRG7c	xaoe948b4idp3jutbshjkri7wo	xaoe948b4idp3jutbshjkri7wo
$0s6lqq-j-E9Nm_LFwUEpeeLWBeDQ75ZYmwrYMoexDwc	b3ep6go787gpufiweug9qmwoyr	b3ep6go787gpufiweug9qmwoyr
$XmrlogapQqYj1VfKlSL8vSO2sxNBExeByFQ5f7h9OEU	king6u1yi7ffxghigtd9jphdmr	king6u1yi7ffxghigtd9jphdmr
$ZbStQfXya3r8-aGQzgeyjM1XexpMdB05yqudqOItZ7Y	n7snuo6bu3fx9dggi79hf5sw6y	n7snuo6bu3fx9dggi79hf5sw6y
$4SCBWPaw9DfE1F8UhlHU8tcCgyNMGrdohneVcLXuYzc	mqe4d7586j893g7h7m8d6q75jh	mqe4d7586j893g7h7m8d6q75jh
$s5oiTl_9b6K-IKMmuviFRxmIeO-uX2MJWYo7ws0AvWs	rk4fdirw8tbf5esp5u4ujrxw3y	rk4fdirw8tbf5esp5u4ujrxw3y
$PLSJo_YuSdhcp8Qc1EtpopguS8UaiOZGkIcs_HYhOj4	rk4fdirw8tbf5esp5u4ujrxw3y	rk4fdirw8tbf5esp5u4ujrxw3y
$COjzubYZc9gp1UYu3MF9optOH1hKuh6ZOLrP1vwiaW4	4cgemgmbpf8g5yy571phx7pa4e	4cgemgmbpf8g5yy571phx7pa4e
$keJQHXWi-ZiK2B2FdzQ1IUZ0fzfFBax-gHNp7AR9UWo	dtrsppfpmpfzzetkxdirz8f6io	dtrsppfpmpfzzetkxdirz8f6io
$mmPSR9VqhO1noWGYGbl2whlFTsU1V3PHK_ncCUGnqTc	n5b1g7hkb7fjicpakx9wa9ht6y	n5b1g7hkb7fjicpakx9wa9ht6y
$5_XiqIyj_mv3JlnyqfoTpIDIQ2tdPu3N8U7by84mBXE	mmgsgno1ztb9xy9nxkz31dsa9h	mmgsgno1ztb9xy9nxkz31dsa9h
$a7zOXKjjr_ueVtYDoa7MhlNoILAsxHrEuNyaJeMg6HQ	p8xxnnebtbdmfmub5izhr6sk4e	p8xxnnebtbdmfmub5izhr6sk4e
$DOZehhyD4JGGFtEd922b5xVLGdup3v_MzKBeEQ_JzFE	ase8kxerfbbrjy669mi479x96w	ase8kxerfbbrjy669mi479x96w
$a4Ou4JTKZxwllI40a4CS36DcmTYOyQFqH-r06D49gAg	ipt473jec3ryxbwh9cnmfi6xge	ipt473jec3ryxbwh9cnmfi6xge
$ytekxng1JXi96Xdmn-7AeF1m8VLkPtS78IihXa3WZ84	ikdic8s8ajbw8x3khspqntf4yo	ikdic8s8ajbw8x3khspqntf4yo
$lVGc_wB1P8VGJaykW33htFubukWDizH4Xwu5SfKGbn0	7dfsq3iaxbd3pbustja3xsenfc	7dfsq3iaxbd3pbustja3xsenfc
$oXOzZ4Ab8mINVphaBVipRGmM3Z5L676RivBDayNaxj8	b5fnqbwt4f8q7rxkq7iikr7mte	b5fnqbwt4f8q7rxkq7iikr7mte
$8QUU4rDWLA_FAyy233e5yz-RKoRz1MMD2e3Dmuyueno	msro55a3qpdbtc4zi6nxn8y4oo	msro55a3qpdbtc4zi6nxn8y4oo
$BQVp9srvRZxHcxl1NQzXpHjcHVZub1wZMinz-XO9KJE	8m5ddq14n3bptkjtamybeu4kzo	8m5ddq14n3bptkjtamybeu4kzo
$r5MeySk4n_UL67iTjPp-RpDnYLITxLfuuSFi65ef9NQ	sfg34yaxn3yaxkhfmqj5c5nuxc	sfg34yaxn3yaxkhfmqj5c5nuxc
$ZeOHUFxCYyrcXwwm5xcXycqdVTRt5tdY0zbyZ-uR_fQ	3k7a1gszqtgejrxykkeuw3goir	3k7a1gszqtgejrxykkeuw3goir
$h_nukybUUUM97KIexy-iMvsAatn74tnaz5IRgopPmkc	5y6yiqc1ztdf9c1xjpb4rbk86h	5y6yiqc1ztdf9c1xjpb4rbk86h
$fxfMGOp0AHYZy5pmcMgdjV1cy_kcfuMgBbWYzp84Rbk	o9r858nntiy4pr8ktp4xkixrcc	o9r858nntiy4pr8ktp4xkixrcc
$6gxkrvEOHIMVYq7kxmB942wCBkaZKqIC95Jzk-CISp0	guyqtkyqzfbbteo9rgigiqr9zr	guyqtkyqzfbbteo9rgigiqr9zr
$Bo4JLPALQcShbeeEkpMatIB_6vxlLouq8IJQ55O6b-A	own1mrrtufgrpb3uzzi16zm9sa	own1mrrtufgrpb3uzzi16zm9sa
$-HKoRby_s8G544Ao_KR_BtaomPp7O4vgmWHflG33bX4	sf9izwzykprzxespmqd6g5djne	sf9izwzykprzxespmqd6g5djne
$sDuUX7k_nGFrr68aq6q-Se4v7PS0UHtb9DCgicckLOk	uhmc1pepubbzmkio4fsgrt9euc	uhmc1pepubbzmkio4fsgrt9euc
$-QKjIvbRegc7FLNn1N3abJ7hKjwMdoQrmX6Zbw-ctHA	d6xz98s36ifamb8bgb7i33q4ge	d6xz98s36ifamb8bgb7i33q4ge
$w7lOH1dKKeKeCs6DlAaGGp3yF_P0vEQ3pNmCTx8FcJ8	gx1ws9z9r7grxdesidhhk8kpqe	gx1ws9z9r7grxdesidhhk8kpqe
$cdRz_XhX8_p6tBso0AzQXZq3nCx7Bp6Z2iH-h23-rbc	58ihks1x7fgzxr61webaxf4rsw	58ihks1x7fgzxr61webaxf4rsw
$F3NqPu2Spf8K4XLXu_0jprZ1pzX7OQgH7jxSdNoTiBc	8ytu3cqxabg37pmncnmtkrigta	8ytu3cqxabg37pmncnmtkrigta
$XVRcXTt62fYwFNjltQCDR4KYxVR2Y5736Y99u4u_Yp8	owjaoo6kdiyfdr51zxtpzbq9or	owjaoo6kdiyfdr51zxtpzbq9or
$rA5PRb7MjCz1lqKGVcHLZ_4eIRh_5slNnGazl-q0F4w	3ohnrepi77rstqr8kiqjgda1gy	3ohnrepi77rstqr8kiqjgda1gy
$R_BTpdLAD-BfJUNWA0gDdMNG4gc8RNi-4QhdtrCsz24	ebs1stec9pympyu6s6bmzfbwna	ebs1stec9pympyu6s6bmzfbwna
$AI66VCbPMZvt2b3tqwhViAQXHs18twqgZhVW103z2sc	zqa6ppxuifd49qb3qq8h1rgnwe	zqa6ppxuifd49qb3qq8h1rgnwe
$FWpqQbXQShRFgQ2vWg29OuQTSkDuwx17c6DhUQAfIb8	z5h47be8ppyytje8fnicwjuwcr	z5h47be8ppyytje8fnicwjuwcr
$Vhe96m7lCNGvQXgtlabnFhr_GUgPVpqYOsLd5pxMxxc	6r9dqg8egpgj8kyn4xn76yikwy	6r9dqg8egpgj8kyn4xn76yikwy
$IurhFVNgogJHFAFqnmsFHryn2y9ekYNHC2LacVsFPKQ	rzzjyo8j3jnbictk5d1rhpd7ry	rzzjyo8j3jnbictk5d1rhpd7ry
$ZWtfV6VN7cYag1OsVvbeuTNCtBCvyfsFry92Cbxe5AY	5cftof5o33ncb8eb59rtjq8c4c	5cftof5o33ncb8eb59rtjq8c4c
$cI11OnGjm7vGIw5vs-oij_wEGItyOPwW6hFOZiala1Q	b9ba1f3ag3dcurxdcg18snpj7o	b9ba1f3ag3dcurxdcg18snpj7o
$UIptzRMGcHo-OdPEz9kdRsBN7PEYO2a9bhjTwYzL5TU	m4pkwajmcfrkzfy189omzwjoey	m4pkwajmcfrkzfy189omzwjoey
$y4Zq-mQV8ITLLsmk81629YkH48k3sCXvXh5FoYbVOGY	g6wyjbhip3y3fm5zeo8x4z68ca	g6wyjbhip3y3fm5zeo8x4z68ca
$hk2qqJ34X4qWuX7eZb4q6W6b5kNrxuBrwH3SisbvDBQ	rdhrz9rrsi87bjynzzwmzxyqwy	rdhrz9rrsi87bjynzzwmzxyqwy
$yYy1a36oDtzrMDiTwh7uc7Bx82F1eFeXdlJabc2T8dE	sfst8obffbfexn6tzfrsio8nur	sfst8obffbfexn6tzfrsio8nur
$Nw5Wuu0OoUpf0cHK-TKfm2IURzfvyK0cpHbWzIVglAI	oy8bqgfpxby6mcbbw56dhqqyhh	oy8bqgfpxby6mcbbw56dhqqyhh
$9NlNwKmZDjoqogDVy2hZdDSxrN1Ym0PpxzQkDT8d8ec	4qq4a1iw1tft9qncsjcmk3sihc	4qq4a1iw1tft9qncsjcmk3sihc
$FZY2YQfeg4cYxqoshkRnnBUid1d9KREJ3X0Wv9Smdsw	s3n6jg4yupde9kaskm5sod1w9c	s3n6jg4yupde9kaskm5sod1w9c
$YcGhCF84tKbnPaz9krrZnukDNeATkB6J7bb8wLPCWfY	eyzs5k4p4387zqsjgqq3oeq4kr	eyzs5k4p4387zqsjgqq3oeq4kr
$rN52jjTQyCeH49OS7jRIGlRM4F2NQBFEB0C0lEaUb3c	uouh79iypp8b3pade834ox9f7w	uouh79iypp8b3pade834ox9f7w
$jtHjsfRhxitvwMV8TSM3JIyCvz76sKCXvcoHIjY5Biw	sntjqaj5wjy5umyebw181hcayw	sntjqaj5wjy5umyebw181hcayw
$XskQ0UvJR_qsbOkdYKA3xVWeAA04SaIC-09Je7FO19o	8n8ep6go7inzmppbofcxqdk6ow	8n8ep6go7inzmppbofcxqdk6ow
$UMNKGVS1qBZupa86BKhjq27beYhYVjRC5huKAZaNeiE	9ru7heb8itngbxxau75sobdx6r	9ru7heb8itngbxxau75sobdx6r
$3M9Rh6NNQIvmu5O8hk4-efo2zau0BS4bP3lP_3SmCXY	7nbdnm9uufdo3y5qjm6jdrdmoy	7nbdnm9uufdo3y5qjm6jdrdmoy
$HLQUAxqFJuCJ_kIl5bp_zpUmFEDPQuiLYU_A9VOPRcw	goqcp95733rwdbehw61j76nufo	goqcp95733rwdbehw61j76nufo
$SmN77flnQr15OQrbedna9Y4S9VTlBui7MoJtlRZZyvs	u3yy4srsxfb5t8qb6h3cjqdwmc	u3yy4srsxfb5t8qb6h3cjqdwmc
$E3YxLtlKW-VCWr_s1TimfgRJbwpp-TO5B9i7By9o7vI	n596gmzzwigb8ko3wq4s5dkcqy	n596gmzzwigb8ko3wq4s5dkcqy
$NaLQE3UGkmLRlNIjT28M4dfpaSuC-qBNE64EdnlMj98	1zm79ep3qbfopxuuxnhgya46ww	1zm79ep3qbfopxuuxnhgya46ww
$WS3p_ef116wO_3hAZwFWmgGZdeox1f-nJZbVEtn_hd8	smtafzhzf3dufni7j1epeyhehr	smtafzhzf3dufni7j1epeyhehr
$qloo_Uai9std99VdsNyxGQIM_zu8qGtBrprCgdp0PAY	957i1mmqdpb4i8tjszhs3beqcy	957i1mmqdpb4i8tjszhs3beqcy
$IQFxW2AclXyjBa4DyFGxJw7vGiSY-6crlHx35kVV0Yg	s7d8k8qda7n9bdmajbdxuhfica	s7d8k8qda7n9bdmajbdxuhfica
$eywY0l5kWTEBz26-Hh06J6ga7FkE4g5_haF5bjF0vyc	eshrq1e7wtd48rexx68s465z7o	eshrq1e7wtd48rexx68s465z7o
$TgYiQwU7HI440WE1IRkSFM2oCf9soNp8N2n6mGfFoxc	1fszhkwxqtrk9qfz44m6ynrfzh	1fszhkwxqtrk9qfz44m6ynrfzh
$UUX6nQgpqX9ZxPHKKk9TcREeMdyXgPbjlLKPBusGp7k	71h6n8tw5jfezrqqftp7z58wyr	71h6n8tw5jfezrqqftp7z58wyr
$KNXtG5NPeJbc6Udn7TLr_7niQICqXf2UYPVCug1SRQ0	dqab4t77z7di3bz5ztbnjw3wrc	dqab4t77z7di3bz5ztbnjw3wrc
$RScLBOnv-rQ5Qfl4VMpgepVrZ9jKgZ2bNwKGx6SWAXs	8sdruebf1bgommicre8wsffmnw	8sdruebf1bgommicre8wsffmnw
$17sdx6T-nBaF6BZozfbYq5OYq1vk1-7hAFKSQn8PQEI	qdzo9feif7dhmx8ed941gn1a1e	qdzo9feif7dhmx8ed941gn1a1e
$eVodFlz-qcHRs2HA7v5TyRtQ-xxsPPfOP98xijAxX-4	szabytnmgtgximchtz6f5gymcr	szabytnmgtgximchtz6f5gymcr
$ugRvFN42G03CJ_rhXrfPqKHK81OC25L9BNWRbQSt_mg	tnrskf5tufdz38mgotxhhfux6r	tnrskf5tufdz38mgotxhhfux6r
$0vEu8AcFRX2gjRW4L-sa1MbVV2gxpjt4gG3XSnbj-50	3p8hmbuj1pbipftkk439b519gh	3p8hmbuj1pbipftkk439b519gh
$4pQu8JKobBFh8PHCnw6hT0zc36PkLKiyg-1m9_yoNpc	qirujudpgp89mr8rq7ogo9ktgc	qirujudpgp89mr8rq7ogo9ktgc
$K8CVgzJac1qkVh9PHbaS-uKkANN90QwbzBPOVVHimSA	84jygo7te3r19pkweapf81opga	84jygo7te3r19pkweapf81opga
$LqTgr4WhVFqPLToPBp6g5JzmDeejTollvhGZw6693yw	mjh9j49ryjgqxcu17qje5ciiuo	mjh9j49ryjgqxcu17qje5ciiuo
$UVzWEAffRbpgq0ADvBSCvafZo4zQdZSwKDVw_VAcUos	39cbdngkhjr15jsgoejdyfeyme	39cbdngkhjr15jsgoejdyfeyme
$HAnBRjR5dMWM48mEkzHxKNUIGwieMrjJYKVxf-jld6w	9qhoih3c6inm78fkuboa9t9tye	9qhoih3c6inm78fkuboa9t9tye
$Mtw7jI8ectw5DF0ks0bCL_3QfpD6-XksFma3q3nV8mE	a3r4t96rxty93rzomtrsn9yzsa	a3r4t96rxty93rzomtrsn9yzsa
$tiExyp2ktofh9R_Wk7_3AEFm82VMfJABZLDh8vMLhjk	oht9esbuhjfj3ymmqwaxeooena	oht9esbuhjfj3ymmqwaxeooena
$ul8BTE-1Nc3CLcB503BKbUS1VW1vpy0XLCxSja1Rvto	f6o9o5du5jyx3jknuid5p8k18y	f6o9o5du5jyx3jknuid5p8k18y
$ttYMJgKpyS0mp56EbIsjPNgKM0gcBpoWTMo5sejfX2g	9wo84cbg9brfjc34bosn3eh9ue	9wo84cbg9brfjc34bosn3eh9ue
$9TBKaZfQChwRJu7jdlL59C1UWk_tvoeFbqOaqupv_k4	nhn1865bu3n6unx8gox65ychnr	nhn1865bu3n6unx8gox65ychnr
$07syF-ENeRr3l3lFZcCEm3nTRPfHWEbn4NMb1J1iJFA	h7zmtg91u3yuzkk44wb7wjsufa	h7zmtg91u3yuzkk44wb7wjsufa
$E6HWpvoyu74jsOxXc_KLC9oG6Sg8rEwIQXoX-Hf5mxg	garfgr99ujyixfrdkyykgfu1ko	garfgr99ujyixfrdkyykgfu1ko
$UoM_MmftgNhl-hvF8RlKsZIRKT_iG82cBMd_uojs5M0	ewiabjpc5bd4xecrzg7yg7653c	ewiabjpc5bd4xecrzg7yg7653c
$kO4xSu80VL_oqUaKrfuWX9B80NtdhvfDonn_ZFnO-jM	afo55faruidoix3qnmt7icke8o	afo55faruidoix3qnmt7icke8o
$WK3NVZIhsdUMb-agpfePDX4roP42B-TO_-eUSah_GKA	maxdnsck67d5pdz6kjg69haw5e	maxdnsck67d5pdz6kjg69haw5e
$8NGP843DjUo_HOYMA7v0yH7eKafZFt6613FwXLrqGho	ow611168sby87gjukfxcrehrzo	ow611168sby87gjukfxcrehrzo
$qbY2LOEAVAemI51LPAjDllWtEIM_FyAln3eBHz3ntr4	h5fx6rqd67rffkk76zodofm4to	h5fx6rqd67rffkk76zodofm4to
$yjRzNi0Lf7YmTrvl8PJ27dIagbzxpdQAxu1a2qnpVRE	e7iiuai6d7dgxnexogb68gxdfa	e7iiuai6d7dgxnexogb68gxdfa
$pWCKYU5wjXosAj-f4nMebqvLjfePvbeiPtYlOuoteRs	x5n3urnmgin67xg3obwm6d9s7c	x5n3urnmgin67xg3obwm6d9s7c
$OHbQDOKirY2HtHqvTX-hws4Xu-DzdC13hfbrGtYAgXw	epgieupoeifciq6xfds7hn11na	epgieupoeifciq6xfds7hn11na
$37mr-j9ODzNjk_XaJ1av3S0LpmfAkQWiCCBrOZx1LjA	s4fc1ryk4f8fjjakfggqna5xee	s4fc1ryk4f8fjjakfggqna5xee
$wQnou8r6NCWwzNJfjat0e1R6VzxjW9q35Rww3oI8pqo	ibkfxtu3f3faugqbrioztt5uuo	ibkfxtu3f3faugqbrioztt5uuo
$oWART5TE3bFd7omOgO63F-io8ZB1H3hKjq1thGjFEwM	whzpjgs3hbdz5komizrah7fxch	whzpjgs3hbdz5komizrah7fxch
$e8srpJcKwv7bubgAQF9exPSNzf1vFXTDHPe3jfY5Aek	fjfrd31wdtdt7b18un6cxsutoo	fjfrd31wdtdt7b18un6cxsutoo
$yAZlyrgetJNCY8nW6Qlt3gZ-sraBcR9VKSu1UhD0bvo	gukfwpdgaifpue5n7x5wa4gczh	gukfwpdgaifpue5n7x5wa4gczh
$wNkgTMblKbEiPZ2uultuC8xuzaaO_dwV9Q8unY79IxA	qpwgsx7sf7rr8jmuggzqb4onxo	qpwgsx7sf7rr8jmuggzqb4onxo
$YVXyaByz7fhy150xdruNE879BtW5klj_WDKoS4XsGnY	866omeytapgwf8uraxqskyi6aw	866omeytapgwf8uraxqskyi6aw
$kSqtOez012ZpmELHtRmRLAcZ6eDqPtMtZFwVzIjXOJQ	jtgaz61xujffxf9az19t8kcjdy	jtgaz61xujffxf9az19t8kcjdy
$3pr6w-dY4LFA1bq0gZJI9yrK3dxo4o6SKQ-LcJnPBz4	4bx8u9wijibx3p1pbq4c65p5ma	4bx8u9wijibx3p1pbq4c65p5ma
$AbRCYXMFmAubdqYq-s4VEZvnYEk9YieIxBpZIfPngoE	aeh7a41fq3gktfc4me3aj9mmcw	aeh7a41fq3gktfc4me3aj9mmcw
$xzWO5ZmteWX1dLWjKshaJF_959fM5XPV_j63exi7Rg4	icj8y6g8kbrkmgmxcjbny3kguy	icj8y6g8kbrkmgmxcjbny3kguy
$vLDNkGntU6Y1RdLCW57mxo33y2ZtPcq-KuirRs_ApqY	81whphpzoir13bbat867pdntqh	81whphpzoir13bbat867pdntqh
$dgPQn7GA_1KgjySM5CP1IL_4OuwK1IJtNUBu0_jp6zM	qoykzxt7jbg9pknaxj98baa9ra	qoykzxt7jbg9pknaxj98baa9ra
$QNn9T_HFWnhOe7BXWvbFMq9DBHxXuKjmzymaM-vIiC4	uap5hupe6tbbjq1jjqkm79autr	uap5hupe6tbbjq1jjqkm79autr
$umtVW0TIOZdMzYcqYXh59oCW3-xahvo0QC6nHCFJdaU	75i5ktoziigitybytig9qub4wh	75i5ktoziigitybytig9qub4wh
$Jk6uXXHtYUyycNgfTD6YDfc1VLTRVMYI9-NWPZi_j1E	h3wgrtemubyntfrszdmzjmtm4h	h3wgrtemubyntfrszdmzjmtm4h
$2HJKtb5qLapQNnGC7PlC2pKGMyM6OP0yvE8t6tNFXFU	37ntqszjebbojbbztyaqdkwkco	37ntqszjebbojbbztyaqdkwkco
$f-cHtS029jrBTsUD6jwaGZsRf9sa7w0m8jeo8fCcib0	iwf9qjrqm7g1pxjtfrotp1izuo	iwf9qjrqm7g1pxjtfrotp1izuo
$7rWHCcfCCs49gXzf9aXyT9Btiu-gLyqrBEstoRvUtXk	gb5ukga4utnu5jhexzezm4yhda	iwf9qjrqm7g1pxjtfrotp1izuo
$h3_C07WVa1Kq-qJ6qyYbJ0LdG9gKQAxFu7lEK-p3_tc	8nn6f9s95pfg7qd4i9yipsdxbc	iwf9qjrqm7g1pxjtfrotp1izuo
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

