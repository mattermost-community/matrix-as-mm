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

--
-- Name: channel_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.channel_type AS ENUM (
    'P',
    'G',
    'O',
    'D'
);


ALTER TYPE public.channel_type OWNER TO mattermost;

--
-- Name: team_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.team_type AS ENUM (
    'I',
    'O'
);


ALTER TYPE public.team_type OWNER TO mattermost;

--
-- Name: upload_session_type; Type: TYPE; Schema: public; Owner: mattermost
--

CREATE TYPE public.upload_session_type AS ENUM (
    'attachment',
    'import'
);


ALTER TYPE public.upload_session_type OWNER TO mattermost;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audits; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.audits (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    action character varying(512),
    extrainfo character varying(1024),
    ipaddress character varying(64),
    sessionid character varying(26)
);


ALTER TABLE public.audits OWNER TO mattermost;

--
-- Name: bots; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.bots (
    userid character varying(26) NOT NULL,
    description character varying(1024),
    ownerid character varying(190),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    lasticonupdate bigint
);


ALTER TABLE public.bots OWNER TO mattermost;

--
-- Name: channelmemberhistory; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channelmemberhistory (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    jointime bigint NOT NULL,
    leavetime bigint
);


ALTER TABLE public.channelmemberhistory OWNER TO mattermost;

--
-- Name: channelmembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channelmembers (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(256),
    lastviewedat bigint,
    msgcount bigint,
    mentioncount bigint,
    notifyprops jsonb,
    lastupdateat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    mentioncountroot bigint,
    msgcountroot bigint,
    urgentmentioncount bigint
);


ALTER TABLE public.channelmembers OWNER TO mattermost;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.channels (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    teamid character varying(26),
    type public.channel_type,
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250),
    lastpostat bigint,
    totalmsgcount bigint,
    extraupdateat bigint,
    creatorid character varying(26),
    schemeid character varying(26),
    groupconstrained boolean,
    shared boolean,
    totalmsgcountroot bigint,
    lastrootpostat bigint DEFAULT '0'::bigint
);


ALTER TABLE public.channels OWNER TO mattermost;

--
-- Name: clusterdiscovery; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.clusterdiscovery (
    id character varying(26) NOT NULL,
    type character varying(64),
    clustername character varying(64),
    hostname character varying(512),
    gossipport integer,
    port integer,
    createat bigint,
    lastpingat bigint
);


ALTER TABLE public.clusterdiscovery OWNER TO mattermost;

--
-- Name: commands; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.commands (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    teamid character varying(26),
    trigger character varying(128),
    method character varying(1),
    username character varying(64),
    iconurl character varying(1024),
    autocomplete boolean,
    autocompletedesc character varying(1024),
    autocompletehint character varying(1024),
    displayname character varying(64),
    description character varying(128),
    url character varying(1024),
    pluginid character varying(190)
);


ALTER TABLE public.commands OWNER TO mattermost;

--
-- Name: commandwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.commandwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    commandid character varying(26),
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    usecount integer
);


ALTER TABLE public.commandwebhooks OWNER TO mattermost;

--
-- Name: compliances; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.compliances (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    status character varying(64),
    count integer,
    "desc" character varying(512),
    type character varying(64),
    startat bigint,
    endat bigint,
    keywords character varying(512),
    emails character varying(1024)
);


ALTER TABLE public.compliances OWNER TO mattermost;

--
-- Name: db_lock; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.db_lock (
    id character varying(64) NOT NULL,
    expireat bigint
);


ALTER TABLE public.db_lock OWNER TO mattermost;

--
-- Name: db_migrations; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.db_migrations (
    version bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.db_migrations OWNER TO mattermost;

--
-- Name: drafts; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.drafts (
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    rootid character varying(26) DEFAULT ''::character varying NOT NULL,
    message character varying(65535),
    props character varying(8000),
    fileids character varying(300),
    priority text
);


ALTER TABLE public.drafts OWNER TO mattermost;

--
-- Name: emoji; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.emoji (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    name character varying(64)
);


ALTER TABLE public.emoji OWNER TO mattermost;

--
-- Name: fileinfo; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.fileinfo (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    postid character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    path character varying(512),
    thumbnailpath character varying(512),
    previewpath character varying(512),
    name character varying(256),
    extension character varying(64),
    size bigint,
    mimetype character varying(256),
    width integer,
    height integer,
    haspreviewimage boolean,
    minipreview bytea,
    content text,
    remoteid character varying(26),
    archived boolean DEFAULT false NOT NULL
);


ALTER TABLE public.fileinfo OWNER TO mattermost;

--
-- Name: focalboard_blocks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_blocks (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_id character varying(36),
    schema bigint,
    type text,
    title text,
    fields json,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    root_id character varying(36),
    modified_by character varying(36) NOT NULL,
    channel_id character varying(36) NOT NULL,
    created_by character varying(36) NOT NULL,
    board_id character varying(36)
);


ALTER TABLE public.focalboard_blocks OWNER TO mattermost;

--
-- Name: focalboard_blocks_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_blocks_history (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    parent_id character varying(36),
    schema bigint,
    type text,
    title text,
    fields json,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    root_id character varying(36),
    modified_by character varying(36),
    channel_id character varying(36),
    created_by character varying(36),
    board_id character varying(36)
);


ALTER TABLE public.focalboard_blocks_history OWNER TO mattermost;

--
-- Name: focalboard_board_members; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_board_members (
    board_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    roles character varying(64),
    scheme_admin boolean,
    scheme_editor boolean,
    scheme_commenter boolean,
    scheme_viewer boolean
);


ALTER TABLE public.focalboard_board_members OWNER TO mattermost;

--
-- Name: focalboard_board_members_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_board_members_history (
    board_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    action character varying(10),
    insert_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.focalboard_board_members_history OWNER TO mattermost;

--
-- Name: focalboard_boards; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_boards (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    created_by character varying(36),
    modified_by character varying(36),
    type character varying(1) NOT NULL,
    title text NOT NULL,
    description text,
    icon character varying(256),
    show_description boolean,
    is_template boolean,
    template_version integer DEFAULT 0,
    properties jsonb,
    card_properties jsonb,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    minimum_role character varying(36) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.focalboard_boards OWNER TO mattermost;

--
-- Name: focalboard_boards_history; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_boards_history (
    id character varying(36) NOT NULL,
    insert_at timestamp with time zone DEFAULT now() NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    created_by character varying(36),
    modified_by character varying(36),
    type character varying(1) NOT NULL,
    title text NOT NULL,
    description text,
    icon character varying(256),
    show_description boolean,
    is_template boolean,
    template_version integer DEFAULT 0,
    properties jsonb,
    card_properties jsonb,
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    minimum_role character varying(36) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.focalboard_boards_history OWNER TO mattermost;

--
-- Name: focalboard_categories; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_categories (
    id character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    user_id character varying(36) NOT NULL,
    team_id character varying(36) NOT NULL,
    channel_id character varying(36),
    create_at bigint,
    update_at bigint,
    delete_at bigint,
    collapsed boolean DEFAULT false,
    type character varying(64),
    sort_order bigint
);


ALTER TABLE public.focalboard_categories OWNER TO mattermost;

--
-- Name: focalboard_category_boards; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_category_boards (
    id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    category_id character varying(36) NOT NULL,
    board_id character varying(36) NOT NULL,
    create_at bigint,
    update_at bigint,
    sort_order bigint,
    hidden boolean
);


ALTER TABLE public.focalboard_category_boards OWNER TO mattermost;

--
-- Name: focalboard_file_info; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_file_info (
    id character varying(26) NOT NULL,
    create_at bigint NOT NULL,
    delete_at bigint,
    name text NOT NULL,
    extension character varying(50) NOT NULL,
    size bigint NOT NULL,
    archived boolean
);


ALTER TABLE public.focalboard_file_info OWNER TO mattermost;

--
-- Name: focalboard_notification_hints; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_notification_hints (
    block_type character varying(10),
    block_id character varying(36) NOT NULL,
    workspace_id character varying(36),
    modified_by_id character varying(36),
    create_at bigint,
    notify_at bigint
);


ALTER TABLE public.focalboard_notification_hints OWNER TO mattermost;

--
-- Name: focalboard_preferences; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_preferences (
    userid character varying(36) NOT NULL,
    category character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    value text
);


ALTER TABLE public.focalboard_preferences OWNER TO mattermost;

--
-- Name: focalboard_schema_migrations; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_schema_migrations (
    version bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.focalboard_schema_migrations OWNER TO mattermost;

--
-- Name: focalboard_sessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_sessions (
    id character varying(100) NOT NULL,
    token character varying(100),
    user_id character varying(100),
    props json,
    create_at bigint,
    update_at bigint,
    auth_service character varying(20)
);


ALTER TABLE public.focalboard_sessions OWNER TO mattermost;

--
-- Name: focalboard_sharing; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_sharing (
    id character varying(36) NOT NULL,
    enabled boolean,
    token character varying(100),
    modified_by character varying(36),
    update_at bigint,
    workspace_id character varying(36)
);


ALTER TABLE public.focalboard_sharing OWNER TO mattermost;

--
-- Name: focalboard_subscriptions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_subscriptions (
    block_type character varying(10),
    block_id character varying(36) NOT NULL,
    workspace_id character varying(36),
    subscriber_type character varying(10),
    subscriber_id character varying(36) NOT NULL,
    notified_at bigint,
    create_at bigint,
    delete_at bigint
);


ALTER TABLE public.focalboard_subscriptions OWNER TO mattermost;

--
-- Name: focalboard_system_settings; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_system_settings (
    id character varying(100) NOT NULL,
    value text
);


ALTER TABLE public.focalboard_system_settings OWNER TO mattermost;

--
-- Name: focalboard_teams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_teams (
    id character varying(36) NOT NULL,
    signup_token character varying(100) NOT NULL,
    settings json,
    modified_by character varying(36),
    update_at bigint
);


ALTER TABLE public.focalboard_teams OWNER TO mattermost;

--
-- Name: focalboard_users; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.focalboard_users (
    id character varying(100) NOT NULL,
    username character varying(100),
    email character varying(255),
    password character varying(100),
    mfa_secret character varying(100),
    auth_service character varying(20),
    auth_data character varying(255),
    props json,
    create_at bigint,
    update_at bigint,
    delete_at bigint
);


ALTER TABLE public.focalboard_users OWNER TO mattermost;

--
-- Name: groupchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupchannels (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.groupchannels OWNER TO mattermost;

--
-- Name: groupmembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupmembers (
    groupid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    createat bigint,
    deleteat bigint
);


ALTER TABLE public.groupmembers OWNER TO mattermost;

--
-- Name: groupteams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.groupteams (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.groupteams OWNER TO mattermost;

--
-- Name: incomingwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.incomingwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    displayname character varying(64),
    description character varying(500),
    username character varying(255),
    iconurl character varying(1024),
    channellocked boolean
);


ALTER TABLE public.incomingwebhooks OWNER TO mattermost;

--
-- Name: ir_category; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_category (
    id character varying(26) NOT NULL,
    name character varying(512) NOT NULL,
    teamid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    collapsed boolean DEFAULT false,
    createat bigint NOT NULL,
    updateat bigint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ir_category OWNER TO mattermost;

--
-- Name: ir_category_item; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_category_item (
    type character varying(1) NOT NULL,
    categoryid character varying(26) NOT NULL,
    itemid character varying(26) NOT NULL
);


ALTER TABLE public.ir_category_item OWNER TO mattermost;

--
-- Name: ir_channelaction; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_channelaction (
    id character varying(26) NOT NULL,
    channelid character varying(26),
    enabled boolean DEFAULT false,
    deleteat bigint DEFAULT 0 NOT NULL,
    actiontype character varying(65535) NOT NULL,
    triggertype character varying(65535) NOT NULL,
    payload json NOT NULL
);


ALTER TABLE public.ir_channelaction OWNER TO mattermost;

--
-- Name: ir_incident; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_incident (
    id character varying(26) NOT NULL,
    name character varying(1024) NOT NULL,
    description character varying(4096) NOT NULL,
    isactive boolean NOT NULL,
    commanderuserid character varying(26) NOT NULL,
    teamid character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    createat bigint NOT NULL,
    endat bigint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    activestage bigint NOT NULL,
    postid character varying(26) DEFAULT ''::text NOT NULL,
    playbookid character varying(26) DEFAULT ''::text NOT NULL,
    checklistsjson json NOT NULL,
    activestagetitle character varying(1024) DEFAULT ''::text,
    reminderpostid character varying(26),
    broadcastchannelid character varying(26) DEFAULT ''::text,
    previousreminder bigint DEFAULT 0 NOT NULL,
    remindermessagetemplate character varying(65535) DEFAULT ''::text,
    currentstatus character varying(1024) DEFAULT 'Active'::text NOT NULL,
    reporteruserid character varying(26) DEFAULT ''::text NOT NULL,
    concatenatedinviteduserids character varying(65535) DEFAULT ''::text,
    defaultcommanderid character varying(26) DEFAULT ''::text,
    announcementchannelid character varying(26) DEFAULT ''::text,
    concatenatedwebhookoncreationurls character varying(65535) DEFAULT ''::text,
    concatenatedinvitedgroupids character varying(65535) DEFAULT ''::text,
    retrospective character varying(65535) DEFAULT ''::text,
    messageonjoin character varying(65535) DEFAULT ''::text,
    retrospectivepublishedat bigint DEFAULT 0 NOT NULL,
    retrospectivereminderintervalseconds bigint DEFAULT 0 NOT NULL,
    retrospectivewascanceled boolean DEFAULT false,
    concatenatedwebhookonstatusupdateurls character varying(65535) DEFAULT ''::text,
    laststatusupdateat bigint DEFAULT 0,
    exportchannelonfinishedenabled boolean DEFAULT false NOT NULL,
    categorizechannelenabled boolean DEFAULT false,
    categoryname character varying(65535) DEFAULT ''::text,
    concatenatedbroadcastchannelids character varying(65535),
    channelidtorootid character varying(65535) DEFAULT ''::text,
    remindertimerdefaultseconds bigint DEFAULT 0 NOT NULL,
    statusupdateenabled boolean DEFAULT true,
    retrospectiveenabled boolean DEFAULT true,
    statusupdatebroadcastchannelsenabled boolean DEFAULT false,
    statusupdatebroadcastwebhooksenabled boolean DEFAULT false,
    summarymodifiedat bigint DEFAULT 0 NOT NULL,
    createchannelmemberonnewparticipant boolean DEFAULT true,
    removechannelmemberonremovedparticipant boolean DEFAULT true,
    runtype character varying(32) DEFAULT 'playbook'::character varying
);


ALTER TABLE public.ir_incident OWNER TO mattermost;

--
-- Name: ir_metric; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_metric (
    incidentid character varying(26) NOT NULL,
    metricconfigid character varying(26) NOT NULL,
    value bigint,
    published boolean NOT NULL
);


ALTER TABLE public.ir_metric OWNER TO mattermost;

--
-- Name: ir_metricconfig; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_metricconfig (
    id character varying(26) NOT NULL,
    playbookid character varying(26) NOT NULL,
    title character varying(512) NOT NULL,
    description character varying(4096) NOT NULL,
    type character varying(32) NOT NULL,
    target bigint,
    ordering smallint DEFAULT 0 NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.ir_metricconfig OWNER TO mattermost;

--
-- Name: ir_playbook; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbook (
    id character varying(26) NOT NULL,
    title character varying(1024) NOT NULL,
    description character varying(4096) NOT NULL,
    teamid character varying(26) NOT NULL,
    createpublicincident boolean NOT NULL,
    createat bigint NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    checklistsjson json NOT NULL,
    numstages bigint DEFAULT 0 NOT NULL,
    numsteps bigint DEFAULT 0 NOT NULL,
    broadcastchannelid character varying(26) DEFAULT ''::text,
    remindermessagetemplate character varying(65535) DEFAULT ''::text,
    remindertimerdefaultseconds bigint DEFAULT 0 NOT NULL,
    concatenatedinviteduserids character varying(65535) DEFAULT ''::text,
    inviteusersenabled boolean DEFAULT false,
    defaultcommanderid character varying(26) DEFAULT ''::text,
    defaultcommanderenabled boolean DEFAULT false,
    announcementchannelid character varying(26) DEFAULT ''::text,
    announcementchannelenabled boolean DEFAULT false,
    concatenatedwebhookoncreationurls character varying(65535) DEFAULT ''::text,
    webhookoncreationenabled boolean DEFAULT false,
    concatenatedinvitedgroupids character varying(65535) DEFAULT ''::text,
    messageonjoin character varying(65535) DEFAULT ''::text,
    messageonjoinenabled boolean DEFAULT false,
    retrospectivereminderintervalseconds bigint DEFAULT 0 NOT NULL,
    retrospectivetemplate character varying(65535),
    concatenatedwebhookonstatusupdateurls character varying(65535) DEFAULT ''::text,
    webhookonstatusupdateenabled boolean DEFAULT false,
    concatenatedsignalanykeywords character varying(65535) DEFAULT ''::text,
    signalanykeywordsenabled boolean DEFAULT false,
    updateat bigint DEFAULT 0 NOT NULL,
    exportchannelonfinishedenabled boolean DEFAULT false NOT NULL,
    categorizechannelenabled boolean DEFAULT false,
    categoryname character varying(65535) DEFAULT ''::text,
    concatenatedbroadcastchannelids character varying(65535),
    broadcastenabled boolean DEFAULT false,
    runsummarytemplate character varying(65535) DEFAULT ''::text,
    channelnametemplate character varying(65535) DEFAULT ''::text,
    statusupdateenabled boolean DEFAULT true,
    retrospectiveenabled boolean DEFAULT true,
    public boolean DEFAULT false,
    runsummarytemplateenabled boolean DEFAULT true,
    createchannelmemberonnewparticipant boolean DEFAULT true,
    removechannelmemberonremovedparticipant boolean DEFAULT true,
    channelid character varying(26) DEFAULT ''::character varying,
    channelmode character varying(32) DEFAULT 'create_new_channel'::character varying
);


ALTER TABLE public.ir_playbook OWNER TO mattermost;

--
-- Name: ir_playbookautofollow; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbookautofollow (
    playbookid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL
);


ALTER TABLE public.ir_playbookautofollow OWNER TO mattermost;

--
-- Name: ir_playbookmember; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_playbookmember (
    playbookid character varying(26) NOT NULL,
    memberid character varying(26) NOT NULL,
    roles character varying(65535)
);


ALTER TABLE public.ir_playbookmember OWNER TO mattermost;

--
-- Name: ir_run_participants; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_run_participants (
    userid character varying(26) NOT NULL,
    incidentid character varying(26) NOT NULL,
    isfollower boolean DEFAULT false NOT NULL,
    isparticipant boolean DEFAULT false
);


ALTER TABLE public.ir_run_participants OWNER TO mattermost;

--
-- Name: ir_statusposts; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_statusposts (
    incidentid character varying(26) NOT NULL,
    postid character varying(26) NOT NULL
);


ALTER TABLE public.ir_statusposts OWNER TO mattermost;

--
-- Name: ir_system; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_system (
    skey character varying(64) NOT NULL,
    svalue character varying(1024)
);


ALTER TABLE public.ir_system OWNER TO mattermost;

--
-- Name: ir_timelineevent; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_timelineevent (
    id character varying(26) NOT NULL,
    incidentid character varying(26) NOT NULL,
    createat bigint NOT NULL,
    deleteat bigint DEFAULT 0 NOT NULL,
    eventat bigint NOT NULL,
    eventtype character varying(32) DEFAULT ''::text NOT NULL,
    summary character varying(256) DEFAULT ''::text NOT NULL,
    details character varying(4096) DEFAULT ''::text NOT NULL,
    postid character varying(26) DEFAULT ''::text NOT NULL,
    subjectuserid character varying(26) DEFAULT ''::text NOT NULL,
    creatoruserid character varying(26) DEFAULT ''::text NOT NULL
);


ALTER TABLE public.ir_timelineevent OWNER TO mattermost;

--
-- Name: ir_userinfo; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_userinfo (
    id character varying(26) NOT NULL,
    lastdailytododmat bigint,
    digestnotificationsettingsjson json
);


ALTER TABLE public.ir_userinfo OWNER TO mattermost;

--
-- Name: ir_viewedchannel; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.ir_viewedchannel (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL
);


ALTER TABLE public.ir_viewedchannel OWNER TO mattermost;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.jobs (
    id character varying(26) NOT NULL,
    type character varying(32),
    priority bigint,
    createat bigint,
    startat bigint,
    lastactivityat bigint,
    status character varying(32),
    progress bigint,
    data jsonb
);


ALTER TABLE public.jobs OWNER TO mattermost;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.licenses (
    id character varying(26) NOT NULL,
    createat bigint,
    bytes character varying(10000)
);


ALTER TABLE public.licenses OWNER TO mattermost;

--
-- Name: linkmetadata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.linkmetadata (
    hash bigint NOT NULL,
    url character varying(2048),
    "timestamp" bigint,
    type character varying(16),
    data jsonb
);


ALTER TABLE public.linkmetadata OWNER TO mattermost;

--
-- Name: notifyadmin; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.notifyadmin (
    userid character varying(26) NOT NULL,
    createat bigint,
    requiredplan character varying(100) NOT NULL,
    requiredfeature character varying(255) NOT NULL,
    trial boolean NOT NULL,
    sentat bigint
);


ALTER TABLE public.notifyadmin OWNER TO mattermost;

--
-- Name: oauthaccessdata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthaccessdata (
    token character varying(26) NOT NULL,
    refreshtoken character varying(26),
    redirecturi character varying(256),
    clientid character varying(26),
    userid character varying(26),
    expiresat bigint,
    scope character varying(128)
);


ALTER TABLE public.oauthaccessdata OWNER TO mattermost;

--
-- Name: oauthapps; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthapps (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    clientsecret character varying(128),
    name character varying(64),
    description character varying(512),
    callbackurls character varying(1024),
    homepage character varying(256),
    istrusted boolean,
    iconurl character varying(512),
    mattermostappid character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oauthapps OWNER TO mattermost;

--
-- Name: oauthauthdata; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.oauthauthdata (
    clientid character varying(26),
    userid character varying(26),
    code character varying(128) NOT NULL,
    expiresin integer,
    createat bigint,
    redirecturi character varying(256),
    state character varying(1024),
    scope character varying(128)
);


ALTER TABLE public.oauthauthdata OWNER TO mattermost;

--
-- Name: outgoingwebhooks; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.outgoingwebhooks (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    triggerwords character varying(1024),
    callbackurls character varying(1024),
    displayname character varying(64),
    contenttype character varying(128),
    triggerwhen integer,
    username character varying(64),
    iconurl character varying(1024),
    description character varying(500)
);


ALTER TABLE public.outgoingwebhooks OWNER TO mattermost;

--
-- Name: pluginkeyvaluestore; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.pluginkeyvaluestore (
    pluginid character varying(190) NOT NULL,
    pkey character varying(150) NOT NULL,
    pvalue bytea,
    expireat bigint
);


ALTER TABLE public.pluginkeyvaluestore OWNER TO mattermost;

--
-- Name: postacknowledgements; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.postacknowledgements (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    acknowledgedat bigint
);


ALTER TABLE public.postacknowledgements OWNER TO mattermost;

--
-- Name: postreminders; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.postreminders (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    targettime bigint
);


ALTER TABLE public.postreminders OWNER TO mattermost;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.posts (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    originalid character varying(26),
    message character varying(65535),
    type character varying(26),
    props jsonb,
    hashtags character varying(1000),
    filenames character varying(4000),
    fileids character varying(300),
    hasreactions boolean,
    editat bigint,
    ispinned boolean,
    remoteid character varying(26)
);


ALTER TABLE public.posts OWNER TO mattermost;

--
-- Name: postspriority; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.postspriority (
    postid character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    priority character varying(32) NOT NULL,
    requestedack boolean,
    persistentnotifications boolean
);


ALTER TABLE public.postspriority OWNER TO mattermost;

--
-- Name: preferences; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.preferences (
    userid character varying(26) NOT NULL,
    category character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    value character varying(2000)
);


ALTER TABLE public.preferences OWNER TO mattermost;

--
-- Name: productnoticeviewstate; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.productnoticeviewstate (
    userid character varying(26) NOT NULL,
    noticeid character varying(26) NOT NULL,
    viewed integer,
    "timestamp" bigint
);


ALTER TABLE public.productnoticeviewstate OWNER TO mattermost;

--
-- Name: publicchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.publicchannels (
    id character varying(26) NOT NULL,
    deleteat bigint,
    teamid character varying(26),
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250)
);


ALTER TABLE public.publicchannels OWNER TO mattermost;

--
-- Name: reactions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.reactions (
    userid character varying(26) NOT NULL,
    postid character varying(26) NOT NULL,
    emojiname character varying(64) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    remoteid character varying(26),
    channelid character varying(26) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.reactions OWNER TO mattermost;

--
-- Name: recentsearches; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.recentsearches (
    userid character(26) NOT NULL,
    searchpointer integer NOT NULL,
    query jsonb,
    createat bigint NOT NULL
);


ALTER TABLE public.recentsearches OWNER TO mattermost;

--
-- Name: remoteclusters; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.remoteclusters (
    remoteid character varying(26) NOT NULL,
    remoteteamid character varying(26),
    name character varying(64) NOT NULL,
    displayname character varying(64),
    siteurl character varying(512),
    createat bigint,
    lastpingat bigint,
    token character varying(26),
    remotetoken character varying(26),
    topics character varying(512),
    creatorid character varying(26)
);


ALTER TABLE public.remoteclusters OWNER TO mattermost;

--
-- Name: retentionpolicies; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpolicies (
    id character varying(26) NOT NULL,
    displayname character varying(64),
    postduration bigint
);


ALTER TABLE public.retentionpolicies OWNER TO mattermost;

--
-- Name: retentionpolicieschannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpolicieschannels (
    policyid character varying(26),
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpolicieschannels OWNER TO mattermost;

--
-- Name: retentionpoliciesteams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.retentionpoliciesteams (
    policyid character varying(26),
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpoliciesteams OWNER TO mattermost;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.roles (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    permissions text,
    schememanaged boolean,
    builtin boolean
);


ALTER TABLE public.roles OWNER TO mattermost;

--
-- Name: schemes; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.schemes (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    scope character varying(32),
    defaultteamadminrole character varying(64),
    defaultteamuserrole character varying(64),
    defaultchanneladminrole character varying(64),
    defaultchanneluserrole character varying(64),
    defaultteamguestrole character varying(64),
    defaultchannelguestrole character varying(64),
    defaultplaybookadminrole character varying(64) DEFAULT ''::character varying,
    defaultplaybookmemberrole character varying(64) DEFAULT ''::character varying,
    defaultrunadminrole character varying(64) DEFAULT ''::character varying,
    defaultrunmemberrole character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.schemes OWNER TO mattermost;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sessions (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    expiresat bigint,
    lastactivityat bigint,
    userid character varying(26),
    deviceid character varying(512),
    roles character varying(256),
    isoauth boolean,
    props jsonb,
    expirednotify boolean
);


ALTER TABLE public.sessions OWNER TO mattermost;

--
-- Name: sharedchannelattachments; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelattachments (
    id character varying(26) NOT NULL,
    fileid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint
);


ALTER TABLE public.sharedchannelattachments OWNER TO mattermost;

--
-- Name: sharedchannelremotes; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelremotes (
    id character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    isinviteaccepted boolean,
    isinviteconfirmed boolean,
    remoteid character varying(26),
    lastpostupdateat bigint,
    lastpostid character varying(26)
);


ALTER TABLE public.sharedchannelremotes OWNER TO mattermost;

--
-- Name: sharedchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannels (
    channelid character varying(26) NOT NULL,
    teamid character varying(26),
    home boolean,
    readonly boolean,
    sharename character varying(64),
    sharedisplayname character varying(64),
    sharepurpose character varying(250),
    shareheader character varying(1024),
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    remoteid character varying(26)
);


ALTER TABLE public.sharedchannels OWNER TO mattermost;

--
-- Name: sharedchannelusers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sharedchannelusers (
    id character varying(26) NOT NULL,
    userid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint,
    channelid character varying(26)
);


ALTER TABLE public.sharedchannelusers OWNER TO mattermost;

--
-- Name: sidebarcategories; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarcategories (
    id character varying(128) NOT NULL,
    userid character varying(26),
    teamid character varying(26),
    sortorder bigint,
    sorting character varying(64),
    type character varying(64),
    displayname character varying(64),
    muted boolean,
    collapsed boolean
);


ALTER TABLE public.sidebarcategories OWNER TO mattermost;

--
-- Name: sidebarchannels; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.sidebarchannels (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    categoryid character varying(128) NOT NULL,
    sortorder bigint
);


ALTER TABLE public.sidebarchannels OWNER TO mattermost;

--
-- Name: status; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.status (
    userid character varying(26) NOT NULL,
    status character varying(32),
    manual boolean,
    lastactivityat bigint,
    dndendtime bigint,
    prevstatus character varying(32)
);


ALTER TABLE public.status OWNER TO mattermost;

--
-- Name: systems; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.systems (
    name character varying(64) NOT NULL,
    value character varying(1024)
);


ALTER TABLE public.systems OWNER TO mattermost;

--
-- Name: teammembers; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.teammembers (
    teamid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(256),
    deleteat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    createat bigint DEFAULT 0
);


ALTER TABLE public.teammembers OWNER TO mattermost;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.teams (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    displayname character varying(64),
    name character varying(64),
    description character varying(255),
    email character varying(128),
    type public.team_type,
    companyname character varying(64),
    alloweddomains character varying(1000),
    inviteid character varying(32),
    schemeid character varying(26),
    allowopeninvite boolean,
    lastteamiconupdate bigint,
    groupconstrained boolean,
    cloudlimitsarchived boolean DEFAULT false NOT NULL
);


ALTER TABLE public.teams OWNER TO mattermost;

--
-- Name: termsofservice; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.termsofservice (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    text character varying(65535)
);


ALTER TABLE public.termsofservice OWNER TO mattermost;

--
-- Name: threadmemberships; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.threadmemberships (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    following boolean,
    lastviewed bigint,
    lastupdated bigint,
    unreadmentions bigint
);


ALTER TABLE public.threadmemberships OWNER TO mattermost;

--
-- Name: threads; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.threads (
    postid character varying(26) NOT NULL,
    replycount bigint,
    lastreplyat bigint,
    participants jsonb,
    channelid character varying(26),
    threaddeleteat bigint,
    threadteamid character varying(26)
);


ALTER TABLE public.threads OWNER TO mattermost;

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.tokens (
    token character varying(64) NOT NULL,
    createat bigint,
    type character varying(64),
    extra character varying(2048)
);


ALTER TABLE public.tokens OWNER TO mattermost;

--
-- Name: trueupreviewhistory; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.trueupreviewhistory (
    duedate bigint NOT NULL,
    completed boolean
);


ALTER TABLE public.trueupreviewhistory OWNER TO mattermost;

--
-- Name: uploadsessions; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.uploadsessions (
    id character varying(26) NOT NULL,
    type public.upload_session_type,
    createat bigint,
    userid character varying(26),
    channelid character varying(26),
    filename character varying(256),
    path character varying(512),
    filesize bigint,
    fileoffset bigint,
    remoteid character varying(26),
    reqfileid character varying(26)
);


ALTER TABLE public.uploadsessions OWNER TO mattermost;

--
-- Name: useraccesstokens; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.useraccesstokens (
    id character varying(26) NOT NULL,
    token character varying(26),
    userid character varying(26),
    description character varying(512),
    isactive boolean
);


ALTER TABLE public.useraccesstokens OWNER TO mattermost;

--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.usergroups (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    source character varying(64),
    remoteid character varying(48),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    allowreference boolean
);


ALTER TABLE public.usergroups OWNER TO mattermost;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.users (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    username character varying(64),
    password character varying(128),
    authdata character varying(128),
    authservice character varying(32),
    email character varying(128),
    emailverified boolean,
    nickname character varying(64),
    firstname character varying(64),
    lastname character varying(64),
    roles character varying(256),
    allowmarketing boolean,
    props jsonb,
    notifyprops jsonb,
    lastpasswordupdate bigint,
    lastpictureupdate bigint,
    failedattempts integer,
    locale character varying(5),
    mfaactive boolean,
    mfasecret character varying(128),
    "position" character varying(128),
    timezone jsonb,
    remoteid character varying(26)
);


ALTER TABLE public.users OWNER TO mattermost;

--
-- Name: usertermsofservice; Type: TABLE; Schema: public; Owner: mattermost
--

CREATE TABLE public.usertermsofservice (
    userid character varying(26) NOT NULL,
    termsofserviceid character varying(26),
    createat bigint
);


ALTER TABLE public.usertermsofservice OWNER TO mattermost;

--
-- Data for Name: audits; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.audits (id, createat, userid, action, extrainfo, ipaddress, sessionid) FROM stdin;
rhn48zj797f9dry99r4niiw1qa	1675955707319	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ohbnmz3s43d6zmxyar5rg9yoge	1675955707411	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
8153118mr38u5raz5gjt56uwce	1675955707421	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
3atkiytc5ib8tkifimtusz5fny	1675955743974	whida44gqpyfierua1wfrnbxtr	/api/v4/teams/ebxg8q3pzbdrdjo7xx1qqw3guy/patch		172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
hpuhxi3mdib8zpqyeh7754zjie	1675956068388	whida44gqpyfierua1wfrnbxtr	/api/v4/users/logout		172.16.238.1	6tsp3x1o8jy5j8okhmjfwd36mo
34yf3ai8w3yq8dqkqfpi58jjje	1675956108661	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	attempt - login_id=	172.16.238.1	
brp6uq7wm3rafxhfc7cmsbf68c	1675956108753	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
hg7yrwk867g5xg5n5iiugpyzka	1675956108757	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	imcx9g55gff5mq96mu9iw14egc
1y8jzsxbwtfhiguqod43dpcqcy	1675956123989	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	imcx9g55gff5mq96mu9iw14egc
ksrhjssjzpdcidsx33q5i1cjty	1675956135651		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
mfoxiso69pb7zcjm94oh4efycw	1675956135757	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
iamygnrm4i8h3d36pr5b9suarr	1675956135766	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
4scqck4tebdj8fixhsecj7bjao	1675956222154	whida44gqpyfierua1wfrnbxtr	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/roles	user=geds3gxhdf81dccdrm8bfx37ry roles=system_user system_admin	172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
h4rr7y167fru9neqq4xi4ca43c	1675956299534	whida44gqpyfierua1wfrnbxtr	/api/v4/users/logout		172.16.238.1	6b19i3jrkfd5zmxebyikj1rf6e
g6hgsz1rfbrb8bsn7pos4jy8mr	1675956310153		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
finm6w4nqibk7m7nf6bjiogz3h	1675956310249	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
wzocniedfigpj813g8f1mkpdzw	1675956310255	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	qy444n649bgzib69a5atczyjxo
55gapndh6fyxigfgss8gy5euzr	1675956350427	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens		172.16.238.1	qy444n649bgzib69a5atczyjxo
ax3d8en3b7rife19kupt4apfac	1675956350455	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens	success - token_id=gshdfwp6ytf43pf5q9sra1cs5c	172.16.238.1	qy444n649bgzib69a5atczyjxo
9ieuq56rc7df9g1epbomzrc1fo	1675956396357	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	qy444n649bgzib69a5atczyjxo
wimwy453i3rqxxqc4kf8m8i6we	1675956418392	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	attempt - login_id=	172.16.238.1	
ndkxnuawebn3pe47mgfpxbzdco	1675956418483	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
9t1qc7qckjru5gfghdh6gmfx3c	1675956418487	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	rxnatzefbibc7kq8mhyoqr69zy
86usouqmjbguby1arkxctqe1fr	1676645977029		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
nh1dr6agfbfsjjzrexc738c71y	1676645977151	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
1wfjkcf63jd9dje33a5enqjwuo	1676645977164	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	ipi95so6z7by5r8e7jergii78o
heiugx3x3frs7cpwn1zxuwu1uc	1676646002094	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/tokens/revoke		172.16.238.1	ipi95so6z7by5r8e7jergii78o
7dfmpbbsd3r6xnxcp41d7eobkr	1676646002112	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/tokens/revoke	success - token_id=gshdfwp6ytf43pf5q9sra1cs5c	172.16.238.1	ipi95so6z7by5r8e7jergii78o
zxjankkttifkxbk1o7hx6wqj1e	1676646021595	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens		172.16.238.1	ipi95so6z7by5r8e7jergii78o
jigbyybfqfn55k3g8qi8jbxu5h	1676646021601	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/geds3gxhdf81dccdrm8bfx37ry/tokens	success - token_id=smw3ipoqajyrdxie69w464cy9e	172.16.238.1	ipi95so6z7by5r8e7jergii78o
gjxn3uhx5bbxudbte53sk3jukr	1676646213954	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e33dqoqi67bc7m1m93zegepxfo	1676646213972	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
imxwy56aqfnpufoh9inp9om89r	1676646214478	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/email/verify/member	user verified	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rd98qdccmt8ddykewgx14gpdih	1676646214488	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rczt9pdi1pdmbdyn1yjitjhq9h	1676646214506	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/tokens	success - token_id=gbrc7c89sbfepjfxyijj5bkwyh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wfwyxnkb47gm9eid58nwnzp38o	1676646214633	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
cjg14a5pwtf9inxubr5djas8pe	1676646214702	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
b4o7dc5edjgqzdsr3gjud15axa	1676646214941	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
3yrysrsgdib9bqqebt3t7ewziw	1676646214948	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens	success - token_id=1wnn4juj47nhuqu6rnbsknpqjh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mtc4cpmez7n4zbw97zyc6bnmyc	1676646295437	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
33nwux7deby1bfnynzepkrposw	1676646295439	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c9o3n163wi89dm6k3aqznregzr	1676646295584	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
zdpzducysifd788nt57dw4ajfy	1676646295613	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
oi3ykcg4efd9zrh84hxjatbf1w	1676646295630	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yzrrdinx3p8tdp9161edsaaifw	1676646295643	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yjmskucr63fs3kfo8mh9neqtjr	1676646295703	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6bxmoiohwfn38r6gbwjjambdsh	1676646295710	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/ygmycw6rnff7igko8gwbqchujr/tokens	success - token_id=mnr319koxbdzibwaihhtetpxsw	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
pj9nck67up8jjbf79t769egefc	1676646337586	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	ipi95so6z7by5r8e7jergii78o
ecumdh6xg3rxmbjmrdso44pepe	1676646349974		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ic46jko3abgpzqhhak9tj7ykto	1676646350078	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
sdpb9hqfj7dj7cne1s7ak39nmy	1676646350086	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	uh3yuor4itngzkmp4189tnx6pe
1ko6e8zmr3ye9xqxqfd344qzny	1678032788248	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jyymbhndnin88q5y75k8taoaih	1678032788283	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9qswsnr37jfsurihogii7pqz1y	1678032788475	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jij8mwej7pn7tetnwfshhxpdhh	1678032788483	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4ecm36rpupdodycys4irajmkor	1678032788499	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8nro8gi5t78qxr1tkb5a77bxna	1678032788509	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
u7rhaprbbiygjjxbjh8pcgzaiw	1678032922851		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
fr6xqmffu7ne8cuigu887wypfo	1678032922969	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
gh4ryy8sdtf49gxwtnosmca4ec	1678032922981	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	bhw8um8scfgu38j6o84j9ie7ur
sm4doamqdj8xuchkaeo994ykdr	1678033182631	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ow733ybf3jy7jdeob3h6dkwsxe	1678033182633	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bqrse5aaijg17ko74mmkemebqy	1678033182764	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hi1hxzx863b15b3dnaui5graee	1678033182796	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4j46um3j9byd3bo1xd3fbxidnc	1678033182816	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tcj77wtak7np7jy5d4mjqspmrw	1678033182813	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6spsjbzt6tbgfj3cmbj9w8qxmw	1678033205190	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
harci8epfjf5pjmd1u7rkaxwqr	1678033205192	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
un6odrmm1bbyujzdjzm86gtkjh	1678033205284	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wd5cxwbbi7rtfyimsqqwnuuxsw	1678033205299	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1mcn6431h3yz9yy1sp4khtcsta	1678033205320	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8g557urr1jgxiygu6hpik8fo7e	1678033205324	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9qg6a44hq3fo9fk48t5m4esrby	1678033376362	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	bhw8um8scfgu38j6o84j9ie7ur
n7jtfky9p3ywmgmopfmmnpr1zc	1678033386889		/api/v4/users/login	attempt - login_id=matrix.bridge	172.16.238.1	
bebg8ihymtbczgnjd4d1xyqq5y	1678033386980	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	authenticated	172.16.238.1	
uct6w7oiufn18ry4c3maeci31y	1678033386986	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/login	success session_user=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
1xg3dodrwjf3jx3unzesou7wzo	1678033387743	geds3gxhdf81dccdrm8bfx37ry	/api/v4/system/notices/view	attempt	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
h6t7ejfcstgjfxfu8kx99yiyjo	1678033545998	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels	name=after-work	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
gmgouprahffpxpa13j91edfgjc	1678033569438	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
toyfjy6ohiy4tcqdd8yzt8ee5c	1678033569438	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e58ifa3dojfqdbjjssmiwki3xe	1678033569535	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ppd4gajryifqupot7zxx4kjcko	1678033569551	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
etb6obehr7fj3gyfzw8so314sa	1678903731320	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yf69mih1n3bu5f46ppjzcx7jnc	1678033569560	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
45fjttesqb8wfme13kx5sj1c9a	1678033742784	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/logout		172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
qt5edfayxjfazqmiy1kjm85haa	1678033753100		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
r7337r4rzpgkicxezur53wtp5y	1678033753202	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
5tminsptiiyufm7xjozd8f37aw	1678033753208	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
fjitr916wb8z5jszazowmbg5tc	1678033923769	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels/rk4gdc4whjnupqoad46hwa9cme/members	name=my-public-room user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
91so4aeb93gxpmgansd3oxstta	1678033936545	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rsdmjor9k38xipgujehux4xwsr	1678033936650	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
4def8apmzjrhpgtseryoobw6ye	1678033936681	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
8f5eb6oactgr5pxo3a1wumkq8y	1678033569580	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
mddr448y8j8wpf44ms8wpg8bwa	1678033569823	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members/geds3gxhdf81dccdrm8bfx37ry	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tgg3qm8bb7b5bndynaaganeo4h	1678033632064	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
7qfjy4sf53y1z8rwbpxamey1cy	1678033632068	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wzcxf4inxtdpmxb5yokm6dhhrc	1678033632149	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
71mjtkozabf6jxndbk9at13qpr	1678033632176	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bdpzq7crxif18dc3bhrf3xb8mo	1678033632181	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dga3fcz5cjdhpkdm544riqnqmr	1678033632206	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
gnea45aetjncz8gqya3hjq8rue	1678033679032	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	7r3gi9ip8jr1bfsmctretdjqxe
ymkzn447t3835ftqstma456z1y	1678033706245	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
x69irux8i3dspcjyb8pyohxbby	1678033706248	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
igrkkicxgpyaj88a8p4qx578ir	1678033706366	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
r5wcktfx47rc5n8kd75fbsugbw	1678033706478	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bfic3ywwrtdx5jpf7uox48txth	1678033706480	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hwi9k7urtf8f5po8t47r83aibw	1678033706508	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8czi9b4qwj8ydktt1ooruit4my	1678033706508	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9okyjgmhhibdicn7ssbh85wnmy	1678033762207	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
wjtp1t4o9byqxe6uoes7wrzbke	1678033782612	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6pxmza89rpr75rp7k6zceyeuqh	1678033782828	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
uuk6fwt15fy4db3jfraiop7bny	1678033905164	ygmycw6rnff7igko8gwbqchujr	/api/v4/channels	name=my-public-room	172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
rngcudjoxb8qfxak7oxi8np77h	1678033936547	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dwni7jqfdifmzr9a3inzdfnn8y	1678033936552	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
gtehenpwyido5r5ewhw9xqi93h	1678033936648	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
85br3r8otb84xfuzih6gxu7zyc	1678033936653	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
7d7kh7sp8ife8cyhfrqamja6ih	1678033936671	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
sdrtr3q7kjr93jye4hjqbykf9c	1678033936690	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
bq1wrkcwf3rzfcqm1dzyjrxx4r	1678033937167	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/rk4gdc4whjnupqoad46hwa9cme/members/geds3gxhdf81dccdrm8bfx37ry	name=my-public-room user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
qnrfirp7i3f3zc9zas7ik8en1w	1681114916832	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
njoduqdfpfr1z8woqjye8mrd6r	1678033988125	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
9h1588pue3b59g46zmux6j84ew	1678033988129	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6q81mmxmk3nimjraweg678si7r	1678033988132	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
kkwjca8wytnh3bcqmwfxojnugy	1678033988224	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wndfs9hc9trnin63gdw8qof9ea	1678033988260	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
kkrrfkxos38x38tyyyzqqmrd9y	1678033988285	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c3p1i36ietrt8gaqyaoh3amt4o	1678033988293	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
nj4gj3nqxif3dka8xm7o8fr1gh	1678033988301	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
qgzepsbbgtgtjj4cjpei6gyf1c	1678033988343	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ei5z7fagkjfnzxxdq54uuo6awc	1678034021923	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	aaz1gspyt7fq8nu7p378hmmsyy
i4ibhrspftr8idaypjwq9dga5h	1678611343373	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9ojd5kbmgtb5bby1yg3hi8t8hh	1678611343406	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oh4sc1ikpbdw9njqa83c6wpmww	1678611343418	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5daey6un73rnug7zuk97piyu1o	1678611343546	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
nafxux46qt8bd8i773rrayxuoy	1678611343556	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
b7wsm59j17duipkbotbf5kaoeo	1678611343570	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8u8konx3rirwim95zagdj3r9gy	1678611343572	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5t7dag16s3yfpx38rto6kdz81w	1678611343597	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bkt1tif8rfg95k8fqq6e8357bh	1678611343609	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tf93rxkzmtfsdjp7ptcux14u7y	1678611367845	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/email/verify/member	user verified	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
siog3k6nz3g3dxzyed1idey8ay	1678611367865	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/tokens		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xyn8ggn7abgutjisoadiakpmic	1678611367875	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/tokens	success - token_id=nqkt9swge3n87xo18tsdutbryr	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jfbgbgd4fig7bgkc8skyqtyy6a	1678611369040	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members/wq6i7sbf4tnqzbssbn7gy7cjcc	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4idjrn3n5jdxumiy8c6jhktyoo	1678611369120	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oejb1rimbigj8k363e4y6zfhua	1678611392671	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	attempt - login_id=	172.16.238.1	
q84cd5znd3bytft6sfk3ykmh5o	1678611392771	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	authenticated	172.16.238.1	
1m7tg78abjd3tnopgs9yauxwsr	1678611392779	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	success session_user=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	6bo5tyfo4pbz9qygrgdhnangyh
7mdj5gnq17fjbkipnozzsjsk4y	1678611396880	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/e343y5ecu7dyujwqm7yfimh1je/tokens		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
pka1xbq4mjfj8fq67199x1bmsw	1678611396898	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/e343y5ecu7dyujwqm7yfimh1je/tokens	success - token_id=fst4r7d4ninxtexjknn4y4ooqa	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jup9sxxqcjfbicmbk3ut3pgnhh	1678611421794	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/logout		172.16.238.1	6bo5tyfo4pbz9qygrgdhnangyh
ss94451kibgifk3aynywio9exc	1678903731106	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
cr8a6b1i13djtqnpo83dq9z7fh	1678903731143	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dur7bepq8byf98y7ae5b4ud75o	1678903731164	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
99ekh9fkdfgyjj383zzrbnq3bh	1678903731267	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
8wurytadit8hpc46g35ks7fyqa	1678903731301	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
j3eth46fd7d75rnks6k1co3dda	1678903731309	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wgudwage8pgpimakr5n4qstima	1678903731317	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
75uu83juifd7mr6j3jnkr1434w	1681126420096		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
etwaropzb7r97xjxono94pja4h	1678903731322	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
nn8txpeg83rcfr6efkd7u51sde	1678903731336	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1ntckgo98pg3ucf5r8bwm6j7nw	1678903731360	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ya7a6tjohbgdfq5u3jqgtukysh	1679129597908	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
nr9k9y6t6b8cdrj7b1fh6jutga	1679129597932	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
zk13yzuobj8t78bye5az3bupqe	1679129597933	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e5gbio4kjjr3xc1hamaerqqsnw	1679129598100	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3dmjkupu5if4fpcnezmrdzy7ye	1679129598104	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dd368thxcjyk98wwxtwk7jdxcy	1679129598098	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
yuq87bzgpibepgod181zwzwt3w	1679129598117	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
qjoxehu957rstq1twk5qc7zcfr	1679129598131	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
utzh3s5dpjdk7xxzwsziswfkco	1679129598135	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
i6mtgazsnpf95j4n5q3z6ghcty	1679129598147	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
fn5o3egx3pnajk97pcs337wpio	1679129598179	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
c14ekex3nbdybxgn8wxtui3uqh	1679129642236	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3d7rzrgup7rx9nyic3oahc75zr	1679129642269	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
fnw6ruurqtrijedsat8mdfjhko	1679129642275	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dojggh1kxpdaxjc3iq1n9nq7cw	1679129642354	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9rafkmowc7b1uqar6n78ajx6do	1679129642360	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5fm6wi8t53ggxescx5t3hks77a	1679129642365	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ncy8msoa5pna5f6afgp3kwh7ah	1679129642384	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xtfa5zz43p8btm57x6y4oc6z3w	1679129642386	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
smfsideaopg3fdrhcaagc4n13y	1679129642386	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oshcpc7xkjdj3f8ywpu3n6oy3a	1679129642387	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wgm9dogsc3bs3merea1hc9tmny	1679129642413	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
fax1b3w94jrzxkhi9pmmmmin1e	1679129744333	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
pyh451hswiftdxkm5msx63xidc	1679129744374	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
scogsamq7fguzg1r9icaaeceye	1679129744378	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
a7853fybjiyczcbm59jo8f3k7c	1679129744512	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
zbbu5fsyyby88j93fbf7pnee8a	1679129744524	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
qzj9qihoyibijqkm3biorx4dsh	1679129744543	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
rek3e69eqi8o9dzwghr8ptx7er	1679129744550	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ycxdq7xu3ifa7ndnchoezey5pr	1679129744557	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3u1epbqtejdgjxhqw34xrebpcy	1679129744585	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1ooc9oinhirujjt9fcz6ozwx9w	1679129744591	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
o8qdtcnzxif17bq36gu1jx6foc	1679129744613	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
p9pnxf3qs7fembuz8yz179a6aa	1679129826824	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8cfji6cw8pgt8dnrmmwc97e6qh	1679129826847	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
rwramum8d3nxmnyihhzbpn6mpc	1679129826847	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
uj47syadhpdopx78m3a1rudn5c	1679129826950	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tw896rf16irhdf1iput1pxpn5c	1679129827005	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1p6b8wbedb8fxb1w3wxqrsp5uo	1679129826951	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oj49oh3pgtddfgmyodpcneqptr	1679129826984	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e8b3m3kkcidh3yy1yb5s5zgqrc	1679129826954	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
83gpjbc7hjrxtynw6ohrgej19e	1679129826984	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bcma4fa4rtncxc7a9nfjsp7eaa	1679129827028	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
si485hr8jiys8jsnrq51ek6eoy	1679129901496		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
m6r34c3i1pr47xnq4199yx39fa	1679129901636	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
iz98sdgxkpnqtywy5eabch7fwh	1679129901647	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	dzz9oi8n3p885etb9swkuy8rdc
jmrtci7oqbbx5qe3oirux91qja	1679129826979	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ce8161t1b7fn8ppbhqg9arnomh	1679130428278	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1pqhe4ii5pgfjfpody6go6cuje	1679130428308	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
3g8gez4dstyapnt1uizj9cnmsr	1679130428311	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
99oizf3h97gjud6d7a4moph4yy	1679130428394	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mipqihm56idbfxei9rd4ne5cuy	1679130428418	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
jz3or9yurt8iundcyu3uof9qoe	1679130428425	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
uagg565fe7n8mjgd7sucztg15w	1679130428445	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
g5f6oy6ti7nk7qnbht88iz5ngh	1679130428446	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
e637ro9oo3dkufaj6bce5okjgc	1679130428461	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
i5c9c5ng4fd47m7i4t5d89x8rr	1679130428513	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wp7azab1w7nujej8i8jpc84crw	1679130428513	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
g49d5tambbgw3d5yyixhri1rww	1679130437605	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
68qisxd6j7ndd8ihbh9rg64uja	1679130437647	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
g47439tucjrnjcjkq9bdskzugc	1679130437655	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
73eanijer7r79eimdssrfs5qnc	1679130437773	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c1ge5kpsmpdhpdy1n5uxqtr6iy	1679130437821	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
etf887s6wt8kunnn6uhp5herty	1679130437834	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mej587d3iprmugejeowswpsgfa	1679130437843	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/bgct5icpib883fx619bh3cfu6h/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
skxh6gozy3y68xz3jw66qyjita	1679130437847	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/wq6i7sbf4tnqzbssbn7gy7cjcc/patch		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
edewwpj7ytb68fsbm5fbehgqwa	1679130437869	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
i3pkuq9qytgp3gjmrpxjyx17ny	1679130437911	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ouqttwsbgpb3pdixk4e5t9to6a	1679130437919	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mfmgwhn5mpdqdf47p75x8oobah	1679234395738	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1cw919zpmpdn9czzw1ukahn4ph	1679234419054	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
uajrgnqmc7d8mnto85euefomne	1679234439014	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9cbd5u8dz3gqffi9ht4ghet55r	1679234493108	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ra9bag5i9irhbfuhkqmi8e71gy	1679234493141	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hfjikxw8sffnpdm1q3jtabq93y	1679234493143	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
q1h8ygdd8bb3jqozjo59x6onze	1679409982468	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dscwimu8wtdkifeq4un3kszqay	1679409982485	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
tgsdiuimk3fu8ekp9wgjk4u7ir	1679409982514	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
d5bceiedj3difeeaucoqw6rt3o	1679409982571	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ddkf6pnda3r9iqkx5yxny41fmr	1679409982784	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6pktbqz76i8o7ceskz88pwh4wc	1679409983001	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5qhgzonkc3ff7jpusrkd6tu4mr	1679409983032	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
f5o3farn7fdmigkyf6szo4h5aw	1679410009294		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
7cdiombqafncixcwu43zp4mx4o	1679410009393	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
i1e373edobydzg98rskhs4a4dc	1679410009399	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	3776ou8tejyodjr9d8sse5e5th
u9u1t9krafn988ncyia7zard5h	1679410201726	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
faptcpjp3jyh5b1x9gxwoee8ro	1679410283981		/api/v4/users/login	attempt - login_id=user2.mm	172.16.238.1	
e5ymnagzptfom8mgiwzig3y7jh	1679410284122	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	authenticated	172.16.238.1	
5q4yq7dz67d7mezyescebe7e9r	1679410284130	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	success session_user=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	ge6j8ahuz3f8xc44gr74snq1de
d3zm8q5jdp858rf88di1dfjqqr	1679410301963	e343y5ecu7dyujwqm7yfimh1je	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	ge6j8ahuz3f8xc44gr74snq1de
3gfkbyo98tgrd8diwzwyhc36ah	1679412566721	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
fttmg3ob1fd688ejgw8p8m9cro	1679412566738	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
eqbg741ssbbz7py7wff7p4dxxo	1679412566759	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
r6e8zzjzd3d3ueffucdx8johca	1679412566815	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
5oy79ra8pi8jx8i3brrcfcbi8w	1679412566844	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
jinfjzm413gfdbdgbs1bsr368y	1679412567091	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c3eam1zp7pntxxt4a5gnie7g7c	1679412567246	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mj37qyo4yiysm8s9xzfi33bcqy	1679412567259	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
zi4hrqqxkfbxmjxwhxnec8b3ea	1679412607793	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
5yxfehjqz7npdfyeqxnsgm37wo	1679412607812	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rkaj1rmddfdfpers1tzuoeqfhw	1679412607834	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
bre9r787uffw8miotm1qxqr7iy	1679412607874	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c5miahjesfrb9dze6xoitmihfh	1679412607898	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
bmaxk5jo6t81dretohnfh7dckc	1679412608119	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dif93fanxb8ppnfjmcw53m6d8a	1679412608261	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
iojmqtpagpno9cketayq1rofde	1679412608275	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
4fy6tyctht8yfexan9yon5ihcc	1679412884245	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/596q88qz87nbzbddntjm5xi6fh/email/verify/member	user verified	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
pkcha18rzig59e85tu5gezppch	1679412884311	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/596q88qz87nbzbddntjm5xi6fh/tokens		172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1t893nf9ajbhur1rh3m4c9ikuh	1679412884379	geds3gxhdf81dccdrm8bfx37ry	/api/v4/users/596q88qz87nbzbddntjm5xi6fh/tokens	success - token_id=fymei7fmxtfwpqc89g6a4egubc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
xcd48wwwrbb6zd3kfdtneq64gr	1679412902632	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
b755k8e3nf8die9dju1kwh71gr	1679412912116	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
4ymaupsjzbbc8qna4pfxdn7ksw	1679413187503	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ok9ejx4433fymbswppcqtrt1or	1680689086075		/api/v4/users/logout		172.16.238.1	
ybwodoxbbtgg9y9xshgi66pzee	1680689086124		/api/v4/users/logout		172.16.238.1	
ifabtigg4jypdpakdffiicbdae	1680689086337		/api/v4/users/logout		172.16.238.1	
krqxetb6tfd7x8x3g1x11zmq9e	1680689086383		/api/v4/users/logout		172.16.238.1	
9ns7mzidy38b88kb5giujzurwo	1680689086424		/api/v4/users/logout		172.16.238.1	
b3be9cgtcjripjamkp6b4jn1wr	1680689086487		/api/v4/users/logout		172.16.238.1	
379guohotpga5ju1gs7qe7nyta	1680689086456		/api/v4/users/logout		172.16.238.1	
i3yqkucx9bf6mc154dmfoiafxr	1680689086785		/api/v4/users/logout		172.16.238.1	
3p46ne3z5jf9zfmqtykizxgr6o	1680689086910		/api/v4/users/logout		172.16.238.1	
gxewf3ic8py1mxj8uhkoftxs9e	1680689086901		/api/v4/users/logout		172.16.238.1	
wocdobo8w3fzfpobzixjzbhn7e	1680689086923		/api/v4/users/logout		172.16.238.1	
zsgi6sdtrt8u8rjzcrgq1ixs9o	1680689087028		/api/v4/users/logout		172.16.238.1	
aij5n5ti9jf9mp4ezqq43axzde	1681109841819	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
gjr36f1idprydn3uj9kyq7r88h	1681109841848	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1ufxpzb8dtdgic3rkrsicjes1c	1681109841883	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wmkyebqk9f85tpgn4wy1rfue5r	1681109842049	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
y4nntqr5jidqf83daddf7xh8ky	1681109842147	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
zjf5wroxq7dcpkhb5ruqs47ech	1681109842176	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
usr6h1buj7yxfyh1osgkhirehw	1681109842432	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
n57g57i7hbrgfc8hk6s136dufa	1681109842448	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8g778equg3nffqdfat9ge4kw8w	1681109842466	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
7ybwgj6ckty7f8giwni5979bse	1681109842626	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
g6nh1jp9tfrctdj5cadcez8dfh	1681109842640	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oxrzwim63tby7q86rnuadgxkso	1681109842650	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bgg3n7amuinizgmbijjjqm9oda	1681109870523		/api/v4/users/login	attempt - login_id=user2.mm	172.16.238.1	
mtz46fhzjtbf8erex7eo1xw89y	1681109870631	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	authenticated	172.16.238.1	
e6cmtzzfgif4pcrez1t38q7oxc	1681109870639	e343y5ecu7dyujwqm7yfimh1je	/api/v4/users/login	success session_user=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	i1k6tpebb3bjmcaxfw3mezjqkr
sauzsyga47gb8yqn45ksectjyw	1681110087283	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
x7uwrtqbz7yuueuthmfa4z19fy	1681110087299	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
u5cgki8pwi8gtrqdghe5wargfh	1681110087316	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
cz7r9yrtdbbnzegwe5bd4wy1kc	1681110087368	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6oy8nrqxp3yw9kw6kq538gcycr	1681110087394	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bnabuffssbyrxqh4htkm4axdxo	1681110087425	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1p8zu7uhpjbgmjrm1cxg6jykoo	1681110087668	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8j6mh9cc47yd7bwasdo8yfsh7o	1681133218458		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
jcewghngffy48fpdcq31393spc	1681110087680	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
51qhq83rnbn6pb4a9frk6ii5ww	1681110087695	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
p6m86a1fdjgp7ff488663fa7ba	1681110087826	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
iaa9i6wi77drtdkhpf5ib3cdna	1681110087837	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
upw9x8o7htfrfkdgmp6ug1ef3a	1681110087849	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
343zp1q3opg5pf8kntqw5ndkgy	1681110658044	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8pmn6mbxmtg8mmz9wp8cjf5kaa	1681110658066	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4p9rjqy65pdpmebq4kjk6pem6w	1681110658116	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xn3q7gfgpjbdidw6b5mz5z7tgh	1681110658213	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8q8a9xkkqjy19m9yt84ypek54h	1681110658250	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
iuk451ggspdixb5zu6udd4yh3w	1681110658295	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wsaoqpqpcffcxe5je4ubthqd1y	1681110658490	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
g8ei1fe8wfbh9c4t9j8b1i6bma	1681110658505	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
u9xoa5jjqtyp3euw99bb587huh	1681110658516	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bjuda4f5epb9bqi5977pusohdc	1681110658662	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3woa9cz1gtn55g8xug5cjp84xa	1681110658674	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bo7h9ezjbi813ra9ocqsf1bbrh	1681110658691	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
jfz6hwracirz9krzkpydpedtje	1681111081457	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oyp4nkb1hir1up9q4nd1wzrh7h	1681111081480	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
z9w58d4cr7djtmde7qzbypamwr	1681111081503	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
zyad1mwby3frmjh9cke1x9atwr	1681111081556	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
iqmm8dpgt3ns8yhay9kkpu9zjo	1681111081587	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
7swxd6fxdpfm3nsqbw3jdcbobe	1681111081616	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
gwnw6oqaqbg6zf97coq5mi3d1r	1681111081819	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9ws1uqzhk78op8bqcqhnfn3j6o	1681111081833	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9zuikyjt77g1pexqtmbijjucfa	1681111081848	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xw3d8o4c13gqiy8ej4s45smhto	1681111082132	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ct317xjx3jnkpdbd47curhko6a	1681111082147	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6t4sozdi8pywi8ez6kuqtcto7h	1681111082164	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ukhowsq1gpbpxjjo4auxsh19xh	1681111136513	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8ot7s1wy8ffc3b8ik5qxhc1xcc	1681111136528	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
17con4ugq78o8n6wphzg7anjbo	1681111136545	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
mopn9ea8cfnhfyw93tbek8bw6r	1681111136603	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
pz1beytjeprr8pagpfj8wz34ua	1681111136633	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
cnu51tec1i8q5mkb7c1dcchhtc	1681111136657	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8xhndsexy7b5tgkwqn569nxxmh	1681111136877	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
dysuff7gzid1zxb8yhdee6p98o	1681111136891	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
r8ehuiuybjgmjqse7rya8husba	1681111136903	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
quwgop1jqtgexgkzokbx64sh8c	1681111137115	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1ehsqkmezirimb8idrpjxkc6sw	1681111137129	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
j4s9ym3mnpgp3rp6ikxm3bgfec	1681111137145	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
uxatgkndk7n5drxebjqpiumw1h	1681111402501	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
s7rd63bn53n77xbodeteuoc95r	1681111402519	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
74kfs5r4kpradepwy5z9ynxk5h	1681111402536	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hj5wg3k7gfdkichbh6y1cbrc6r	1681111402593	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6ey3ika55pnutki8ttsjzywn6a	1681111402624	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8ja5uj69wb86mr35dd5dj9ed4y	1681111402647	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3a8zh7gii3n8tk1moi3gw68b5w	1681111402856	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9dk1pwyykpdkmmuoqpk4nifu1y	1681111402870	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
mf41watng7rmpp57itz37krhmy	1681111402885	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oooba1c8ttbuip8n3c6yqoiqpe	1681111403016	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4gfqw86zk3g1fxc491ox9yyuxw	1681111403027	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4jpyooxaef8jjcmgb7bzpucbte	1681111403039	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
kehk96rk7tdz8d6k6898ry9y8h	1681111582502	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ishykahfdpr7tysbsgaz7k137a	1681111582522	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e1hn1yfrfird5bhfw5rjp5frje	1681111582545	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
emt1cj738jnc8pzmeszpgqc9uy	1681111582604	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
hchnkg4htbf53cooou5desbych	1681111582642	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5e6q4r6akfnftnt31pp7bgxqgy	1681111582674	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
5m9zpe5aebd7zc33fi74di1k6a	1681111582917	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
fwhy7iwet38bzcrib8zc1hgrho	1681111582935	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wog8gpzj7jn89x7hix1btux1ke	1681111582965	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
y6erk6kueift3x9zk4uiq8yj1o	1681111583103	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oew5mhf3y7rtf8op73d8akk1wo	1681111583118	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
swwmwe4f4pfhdkh35uoi8hh8ja	1681111583131	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
amir4hs8ufns9goi19dmdyf8iy	1681111750999	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
qmor6gjgpt8m9pgizrq9csbk8y	1681111751017	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
t1wehrxhebg9tyrpu1xw4q9p7y	1681111751037	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
cpnetysm17g9xbceqs74ct3ehc	1681111751095	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4mzaj6ijdj8xfeizg8qaazz7mo	1681111751130	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ndb1r9rixbbotr3mqntg51oh1c	1681111751173	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
sszirjzief8gjn47g6pe56ixdy	1681111751383	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
wzw8o5csopf7ppphxexabm5rzw	1681111751398	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
aga7p9tfcbytmmwqjwjx17zggh	1681111751411	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
nrtypgnootrt3ecnu6a5h541qc	1681111751540	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
7ww1z3kyiibdpkr8gfx3ox6hzc	1681111751551	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
j1p9os6ppfnhdg9kuitkedtj8c	1681111751563	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
stjxi8jrg3yfueykhr7wccjgfh	1681111852330	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
fs7ktrpxutrtbnzknmqat9bpcc	1681111852350	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
1pnt5fxzpffwpbdrdjpqqizzjo	1681111852369	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6fchkadcsfbj8yex6937w8rtwh	1681111852414	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
cq31d66j9jbddbo6qtbsftgkir	1681111852438	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
8xe5bk3zm3n68ckw8imprfrega	1681111852471	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
xmsbmx5dhjyj5xktitt6pk399o	1681111852689	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
cztkkwm5rjdcugfghsrfew7pse	1681111852702	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ebp9n67ki7rsu8t3oaky5w174w	1681111852721	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
z8bxodrpw3rmbgc381fbwz5xwo	1681111852835	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
owzwpmuudtgz9rmpo8u1hyrwby	1681111852846	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
c9hd1itohi8q7epp4n4g1xcdph	1681111852856	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
6xhqez71ffy55b6pd1jjn3mfxh	1681111980654		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
ozc8qe1yfbgzfdnqpjbx95m5ry	1681111980768	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
eme78nn4x7f3p8cwk3zr1gyxrc	1681111980775	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	85g6f6sddfrymxb9cdyorooy9w
wtcqsk4yn7d8urrk3n47ypzodc	1681112027836	whida44gqpyfierua1wfrnbxtr	/api/v4/channels	name=stockholm-office	172.16.238.1	85g6f6sddfrymxb9cdyorooy9w
sn91uod6eiy73xc6tn5bpq7ipr	1681112040851	whida44gqpyfierua1wfrnbxtr	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	85g6f6sddfrymxb9cdyorooy9w
mnf8nm4zutnhik3wbqdzjze59y	1681112067027	e343y5ecu7dyujwqm7yfimh1je	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=e343y5ecu7dyujwqm7yfimh1je	172.16.238.1	i1k6tpebb3bjmcaxfw3mezjqkr
zhftefgef78j8czyisnuqg8p3r	1681112138428	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
3oda3o86k7ytu8byuuqer4dndo	1681112408136	e343y5ecu7dyujwqm7yfimh1je	/api/v4/channels	name=a-private-channel-for-admins	172.16.238.1	i1k6tpebb3bjmcaxfw3mezjqkr
8ca1nxcapjfabgu44xxkp87zcc	1681112421027	e343y5ecu7dyujwqm7yfimh1je	/api/v4/channels/8tmxnejrb3fhxb6p91b7358y3c/members	name=a-private-channel-for-admins user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	i1k6tpebb3bjmcaxfw3mezjqkr
req9awt9atybfes8u57b8wo9ko	1681112441749	e343y5ecu7dyujwqm7yfimh1je	/api/v4/channels/8tmxnejrb3fhxb6p91b7358y3c/members	name=a-private-channel-for-admins user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	i1k6tpebb3bjmcaxfw3mezjqkr
5efb9trzhtgjdgdjm6z58gzqqa	1681112459875	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/8tmxnejrb3fhxb6p91b7358y3c/members	name=a-private-channel-for-admins user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
orda8r7sppg7zjssqy118ygj3w	1681114916577		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
s7mxiu8453f8trsqdsrzn5894e	1681114916839	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	c3fkucxodibntj9d1gq9n1imno
ufzaamrx77bht8fbtkjk84sgzc	1681114925212	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	c3fkucxodibntj9d1gq9n1imno
iyczxc1swiyy8bjn9hijtyw58y	1681115131311	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
cgecoe7fn7d49dtjwdi6jjmi7h	1681115131331	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rasgn4mi63r988ouzr5f3wt66r	1681115131351	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1wtt7aq8rpfo8d8qkhykffboho	1681115131366	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6ocpkdumw7gui8hmzgg7p19cwa	1681115131430	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
r8f9dzxykibrmrbqrp1aoodwar	1681115131463	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ed85obesrbyzjx6zdkgdn9gipc	1681115131496	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ofrtobg953dy3f6c4utnue7aea	1681115131741	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
7s4repb4dpdbug897694uzdgge	1681115131754	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
jexykcysg3rdtcskfnx8m9g5yy	1681115131768	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rbzqazqxnpda3eax11g7k1jjdr	1681115131903	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
i8jmrdiz8byfumc65k5kicj9ee	1681115132106	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
qiq8rxuxgf88xfyjj633f5igje	1681115132143	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6crsme49z7b3jgx3bfc8ouhmzw	1681115132212	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
cgmj3jjqwpdimnkk4ggc8df3eh	1681125240312		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
wkbuaefbfbgx8nys5g9hz8cnar	1681125240444	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
jk58robqwtg77mzftdfknw3naw	1681125240455	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	x9tpqtxukfbgfqhro7whsbfokh
6uys6sbpitdk5yqo7qenn6y8sh	1681125347357		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
e884nf5f57b4f8tbpjfhfz3yoy	1681125347482	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
d8sdr7w6upbh5c7x4tewwhdqmy	1681125347515	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	hpba3z6zsp889qfcfdejf38g1e
kmqg6gjkdpn13bmp7qq4fpycwc	1681125392320		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
omqqwowp73ghxcdag4tsnzd4pc	1681125392405	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
wmx87kixj3ba9mdij5ti68m1ja	1681125392434	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	j1htwq4pxjf9mjoa978mamq4ne
85nuf7kq4fb3pkwin4qwhaqz8h	1681125499644		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
6sxnuid15tgq5y68ny4h7ifpko	1681125499754	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
7h8d5gr66bnk9rj8upyu7uysfw	1681125499761	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	1xk8og3rst8o3efxr8ygfm1yfh
hxcbpkhzjidh8cbhk5tawsfznc	1681125860222		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
xt9d874wqinozqi64wd84aryrh	1681125860308	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
nkfinh6jbidy3puprrik5bt94o	1681125860316	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	ki6mx7yhg3nxjx4rp4s4rd3byw
i6ftwdibgtnnpgyfosxnw1j59e	1681126009191		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
6jisud7n9388mebkqfra9mjije	1681126009301	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
nq7yifq9ipgnibdi9mwt1dj3qa	1681126009321	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	184sd4isgjnmxk73sw8oak8rao
7n5xediygpy97cii6o4nm7neua	1681126158309		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
d7g4t1nrkb8upgg9w58tk8g4cw	1681126158406	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
wwwypq9paby3jmasn1qnuobfcy	1681126158414	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	9z3gyxgg7tb3pc3zab8wxf4ruh
7n5pn5pp4trutdkfee9ntt46fr	1681126174072		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
o8e7mha3kfnabgmjjuhnbgq8ae	1681126174176	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
idtzi4959pgsxfri5kffhc94ne	1681126174187	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	d7iwe1d7e3fjbdpk4a1ae96bwo
ffq94igbipybtct1ite8fk1e7a	1681126291695		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
hwfdu36f7fby5gjrws7scfu45o	1681126291797	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
nu7zb3sarb8y5jxei3a4jsx7yy	1681126291806	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	prnhrdnr3tffpx9b3jgqxn3a3y
y4i9t4ihopfzf8o1d4itmet9oy	1681126420178	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
4nmd5qy5fjrx3mxu7mk7pyrr7c	1681126420184	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	fsuaqyismpga786gp4s4adnb8a
h8im8iqzh38mid4ibqo1xt1bxh	1681126586833		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
iukmtqerdibcieuzrbk8e1316h	1681126586920	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
zm7645td87gu3khtdekecjm9ew	1681126586927	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	yqiqgkh6zbd8pmswx57snuwoxr
hi8nqjta17g9i8hqjrkz9madjw	1681126645672		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
ctmb6ztb9td4dd173au5sra4ba	1681126645758	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
8imqoy9eojn57ba6htswrfti1y	1681126645764	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	qoxkhmofhffnxf58cot5wz5cje
jjtcozzej7dkjkt8kyxw559y9e	1681127325814		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
h5fdwno3ntn6jddqwbjzi5w9zh	1681127326023	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
bk5m58jrhbg9dmbbtcd5ayarsc	1681127326037	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	37s8r648q3yozcgwkzwwok9hxc
unwt11fdttywif8wx1kyauxs9w	1681127336402	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	37s8r648q3yozcgwkzwwok9hxc
nqhdixtdtig3pdkz61g9r8jfpw	1681127794844		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
nhphh5547pnq7yoxru8aza8rzo	1681127794925	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
atwhrxhg8jr3pxz7n646h3pm7o	1681127794930	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	1osnofctkffxxgejwtnkw4pshr
y7w3oa6nq38z5kxysqa1fzmr3e	1681127810176		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
7in8e7u3rjdi3dranqz6h6ek1w	1681127810259	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
3xam4smfdbr35q4jm57rm3gf4e	1681127810264	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	1bc8bjqqppfyzc99393yj8wsta
otcbpqk7xiba88kba7ibacrfxc	1681127895521		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
dredyajk9i867ryhb1b31z9uoh	1681127895631	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ib3i7kw96tnwb8paprgoad63hy	1681127895638	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	fhjjanxsujybifpmfjkjpfrk9r
dnjs7qqpjj8x9pyzm7wxthpunr	1681128165145		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
gp16wp8egiyt8n9csknmx35kwr	1681128165256	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
d1feitr5qtgk3qwum49prnxhyh	1681128165271	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	tue4h5sq1bgq9f7h563coz3eao
4c7qqgt4kpncxcb55wkkkaysmr	1681128235263		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
s8cdpj11ff843qezoxyyks6teh	1681128235474	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ky8f76rihpfy8eky7191ptdn4a	1681128235495	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	kxjar1rahinrue3idzdce95utw
dqzisytew78m58ug6efgk7abeh	1681128611468		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
sksctde89fgx5n5wbc7mcsfmpw	1681128611552	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
x68xpofwjtndxn5bztqmu3w61h	1681128611561	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	dhk79q8my7bxppwj9sxb8nqxhy
ebga196cj7dyumaj6osho9f8ah	1681128640772		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
qfspg4og7j8qzdf9xwwdyd5r8e	1681128640851	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
5m1hfbygf7n4m8b48u5e9xtu1h	1681128640857	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	drn51htewp8omn1e9tw7atezky
58dz1xbzejgn5dzycfyyfa1poa	1681128679417		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
r8wuwrhqybybzcrb6d5xsi471y	1681128679504	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
7zh9t8u5ojyaxy6kx5g9abkogr	1681128679510	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	yqfqgghqdj8ddejduxyax76x7a
ykmz8skgupb65xyzo41ncbdmxa	1681128701023	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4qupxgcpqjnj3mj6a9wqmk7wih	1681128701057	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
bf4uigskbidtdmoh5xcwa6ofse	1681128701076	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
ckp7fostqfbbjqggjse19kisph	1681128701090	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
sia3mo14dp8gmndq69z7fhdmch	1681128701145	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
e43ogjsqkirbzk5dx51b6a1esh	1681128701178	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
sdmyargrz7b4irkf6kyhpoj4ua	1681128701225	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
38u3yjq7z78wpbnewxdan3fkmc	1681128701501	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
gi5fooii9tnpiks9me8y54x31o	1681128701530	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
4npeh4719fgmij8xwxs9ssag4e	1681309188610		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
fb9ymwdfhpnu5kz5mfx348a3jc	1681128701542	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
qdstyhe1k7napk5on6pxjbgzdr	1681128701677	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
oa9mm1eenbf7bqcg3q1uo5meth	1681128701787	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
9cxckweswpyjuc186eh5m64w5y	1681128701800	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
npanxnzxxpr8tbs3dzb7hqxeqw	1681128701815	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	fo4846aaei8i38kq9kmhb86xnr
rzsqi5xqhidruf6oajh9j87fky	1681128726186		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
f6ih9fx88jyw7e3znpsseazcfc	1681128726265	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
zoykzbak5irtij4ahaquxqm7ec	1681128726271	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	ofn6pxhi9jbuueamjqifcps6ty
8415kxyzaidj3nc7u1ffsc4cye	1681128848372		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
fq4aiayiutf9bjpuhps6rwqxew	1681128848462	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
m7u53h8pu3gg5kein6ejio7hfe	1681128848469	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	abt45onof3r45xdnthj5kozbiw
9pq4j78ttpf98ba3auyu4swt8r	1681128892515		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
n5chpht9t3ntuxz9nao318u3wh	1681128892666	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
n8e9wtbu1pg6j89zkyhfxrikjo	1681128892690	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	hitnzj8h3irp9k3h4gif7c8udy
yg6jrp48ttrrjp3ea7y9f4731e	1681129572989		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
j5i4hats63bozrgkizqoygs7jr	1681129573108	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
m5uwpc6sgf8bxkyzrj43fwbmar	1681129573117	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	8gowo5sx7tfyzcipqq8h88w6qr
nmnem15qhfyc38cq4mumswd9dr	1681129576806		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
imy71m4hq7bhfyaaxrp5wz4ewe	1681129576906	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
d7mrwpq4zjnkx8sz9u3p6xmhaw	1681129576915	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	h6e5m4iebpbhfb88i867srk73w
6xqip6z717rhtc7ib1ziof4eor	1681129741391		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
9desf9h1apb1xpjrm7co58ptjc	1681129741513	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ybddtooejidu7rc6bhg17j4gbr	1681129741531	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	dq388qibsfrrxcm4877ybb9pdc
8o757apq7jgk9bg3qk8bdxbt6a	1681129976419		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
gheks1ue5bfd7kg68sekst7gwo	1681129976544	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
1ot7s6zsn3rxijiz94rb5yopwe	1681129976554	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	1zajwirgkfdiuc6ccukpxn8w4a
hzd6pmmhsjgeufz43yge9wo8ho	1681130100492		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ipu6phrn13gmzgkrugqam1f4ka	1681130100677	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
nyxphkrqqf8ntbmpjpj75o5obe	1681130100685	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	cr51okhxwb8rpkgcdns83oo6qr
qmuhgqghftd85qasczhxbxedwa	1681130260509		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
u7bbcjzn4jyhdb3hme9xqx7kbc	1681130260608	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
qt8ekapwbtyhijqs5g4s5u613a	1681130260616	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	sk5fcndp978tzf1yzcmyh8fibo
tsgjm4f8tj88bdi7nioc7fagwo	1681130324411		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
5owpwotrcbbcdnxi1yoecrh1bc	1681130324543	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
7nxixh855pggpbpaphw8qnpawa	1681130324551	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	3ng7wrtur7n9tp4hxrcdm3k5by
z9sj6x3n37du5c4bshk1kbuasa	1681130325110		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
ggq1kt35pbnm3njwqgdhubi8bc	1681130325249	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
p8ube6adsigf5yn59o6ufufccy	1681130325313	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	k49pyo85cfbqzq9bdnikzm5d3c
y5nedbo31jbczbjewzi6mx9cba	1681130331755		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
skzk7wfmxpfouxk8zfrqnpyjmo	1681130332146	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
9s9wjt4zpjns7r4qdpyjsipsma	1681130332163	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	qbksy37r1tgb5xbkym6dygbhay
5ekd8m5xrf8jxcs5tbw3dq3kno	1681130383308		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
es3oddzhgiyuxb7czcyqb5za1y	1681130383577	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
erprk4mo1jysi8nczzufax44oh	1681130383627	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	e1f3a9rp4bneurcfkfmwhwq9ca
xwsp3tm1aprx5dp1dw133zda8r	1681130472998		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
9qdkjn5n9ty43bmuc85sd1fech	1681130473184	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
xzjjqfe6rir3pbwjsxd4kw6aeo	1681130473205	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	eyfnqj13bjr9jf8zxndicdtgoe
i6ooft4xutbqfrkw3w18ja35qh	1681130484337	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	eyfnqj13bjr9jf8zxndicdtgoe
i9h54gi9fffhmckobxfjaearrr	1681133218683	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
qwc1jsjr13nmxjqodntrwxo7se	1681133218699	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	i6474fe9cfrd3gax3qjzxmt7dy
ofe9wa6t5p88iedjr5rz98qxao	1681133323084		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
5bzgt1xfqt8n8rgxfknk7xj9hr	1681133323328	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ies1ky3bz7y5dne7twiueaxxso	1681133323351	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	n4ccpbomjig5bntsn44bn8ddke
xjzzry8ppbry8e6f5btkqokxke	1681133334177	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	n4ccpbomjig5bntsn44bn8ddke
bexu33zigfdi5mkaqrsg63n79o	1681133940277		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
omdkcwtaginnmq4gbo7ni4asze	1681133940476	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
hoqb7r6beirmb8fnmmndqk6hae	1681133940507	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	d9t5rj3kkinsjcthrrd4a5ishe
jfqirw6dd3bitghukhkupw7mco	1681133955012	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	d9t5rj3kkinsjcthrrd4a5ishe
8dupqoi3tirybd9kh1tcw49o8r	1681134068343		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
mqppynatdtfo3p61a3i16cutna	1681134068677	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
paid7eon97fgbcq5c9fcnnz17o	1681134068700	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	t6frxijhpidrxx1bk9h78t7j4r
jyojmd95gtfs9c1pn7xryedzpc	1681134080401	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	t6frxijhpidrxx1bk9h78t7j4r
91bai4iry3nzbnbhu14oitbt4e	1681134171903		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
b1fjeto9pjfoigqudz9bd9bgwh	1681134172149	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
3zbp65zmrfgzd8mr19r418wk6c	1681134172169	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	6i3f14843fbk7c3fuponzkpezc
p33j1y3cgfy59y4dxo7aet5m5w	1681134182113	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	6i3f14843fbk7c3fuponzkpezc
sqs4jzr4hbb47kpwfs4hcy55ya	1681134652600		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
oo3upjhuj3gftmqwbrwas8k9rr	1681134652909	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
m1unbhs31j83ur9cfy343kajeo	1681134652923	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	xu35r1b6ipnfuq44qfsmt47k7e
hz8js1tnu3yp3kmxj5qp9imwsc	1681134663653	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	xu35r1b6ipnfuq44qfsmt47k7e
aq6huhurk38z9pdsuzpqj9fooc	1681135437336		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
bbq17y6zhpdhtkytodh4pjcu9e	1681135437555	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
u6zd7m1b3tnkdpko6a3ucs5jee	1681135437585	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	1ampayagetbc8kbx6tby9psj6c
pedisdhtt7ned838fbxhgs5ofa	1681135452604	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	1ampayagetbc8kbx6tby9psj6c
k1zpma99qbb7mnau7c8qft3gsc	1681135889680		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
t76j4up9dtbxmfmw19xdcefz4c	1681135889889	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
9sdbduqpcpruuepdzadpwschhy	1681135889903	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	c4ybos1rupbk7jgmehfq1tnnsc
dh83qgfxmtni8gb4pngpupny6w	1681135904419	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	c4ybos1rupbk7jgmehfq1tnnsc
9p758t6hnbg7uecpua3xka887o	1681136218978		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
anfngi67xf85bpyig1zwnz988r	1681136219172	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
xkhyfrynfidy8m8w4ng3h1j9sy	1681136219180	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	gi4giaxc5fbfbg47fg73jnjusy
6nsnsbjf3tfmdko5un4rj1j8yh	1681136230302	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	gi4giaxc5fbfbg47fg73jnjusy
guxh9m3ydfy5xyoq8mekq6si4y	1681136665821		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
yjn9cbqtqjy4mq1q1tenxhtdaa	1681136666032	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
9opguwutcjds5ps9asggxt73ph	1681136666046	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	j5mku4x5x38odekt4s48jwpx6c
fskdup8nt38upqp8bzarnfwtro	1681136676686	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	j5mku4x5x38odekt4s48jwpx6c
7gpeiwxa3pf95dyt84f1pxqnjo	1681136884669		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
smoce3bqq3fw7mx676bn91tqoo	1681136884887	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
5x7baptrmfbpipubbpasyi9hmy	1681136884902	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	cfjb83ziifydzyz6rhg6xmwxtc
nzc4d8kfti8xbjy3iri6d1pmic	1681136901568	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	cfjb83ziifydzyz6rhg6xmwxtc
r96nsn8srby8tk3kerjtfbpycy	1681136967541		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
3yuni6dpyirninfi6zc9o1kspy	1681136967761	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
xk7fwjw8fi815xumw64uj6smtw	1681136967773	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	535h6y7wjtftix7y1ywzo4hw6e
s3kfhgdq3i8cf8nemsczjdewae	1681136985492	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	535h6y7wjtftix7y1ywzo4hw6e
a6sibhb5njnh3kypzxtxmb7fsh	1681137117153		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
m157wjp49bgyjrdrowe5b5p1hw	1681137117365	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
3id9c9gxdpdxfg58f7gcyybbdo	1681137117386	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	t1zqp51a3fykukqdumwja5tfde
3drxon7j3tgrt8odddowmid65e	1681137128977	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	t1zqp51a3fykukqdumwja5tfde
oryhmu11k3fwmkndbw4sbdz4xh	1681214236029	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
3wqoxkyzxtgmigcw8obszh6uoe	1681214236045	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
snmkqrsaqfdstgde94rhnc1y8r	1681214236063	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
4npaja47ei8wd8jseuot53reho	1681214236083	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
odf9q7jqoiy4ikfk81byb9jc1c	1681214236161	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
js9ctokjo78wdyfchwr1yofpmo	1681214236196	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
p6mn4mb8jifa9xw5kskwgzo9xw	1681214236224	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
6xp74zt1b78bdefa7jkkbfwghw	1681214236570	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
aj8f5aqf6prbdj6gpeh71kxdic	1681214236582	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
kugtsrkhubbi5fm85hsenq4heh	1681214236591	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
skmbhfdcqb8bbf1rok6faknzar	1681214236797	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
afhih68shj88pbftkfx8icji8r	1681214236905	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
axn4p8fypfg8j84bwdgfwemsuh	1681214236915	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
36pzy4d4aibhzbspqsqamfwzhy	1681214236926	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
jdh4ggy5qfb87daj9mpaqg4quo	1681214504847		/api/v4/users/login	attempt - login_id=admin	172.16.238.1	
weg963c8k3gfbn5zuad81ic1ne	1681214504948	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	authenticated	172.16.238.1	
xua9ziu4m386mr3fpk71nfywoo	1681214504968	whida44gqpyfierua1wfrnbxtr	/api/v4/users/login	success session_user=whida44gqpyfierua1wfrnbxtr	172.16.238.1	eq4ku4o937neuntmi83kz4kikc
tjb56ouq6jyq9rbr7xhnxzw1qo	1681214778052		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
qizgg87trifc9b7r1w88racnba	1681214778274	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
o3bqymsncbbibyj11xbs9z6dqy	1681214778297	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	h8j4wpret7ybxrgdngo9i9a7yw
kmqaybwjr781bgb8jofqj6qgta	1681214793413	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	h8j4wpret7ybxrgdngo9i9a7yw
xe7pgw6tgiyiij5zottu7u66ww	1681214887692		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
m5rb9opnnifjzr793eas6tfy6c	1681214887847	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
sdbp7stx7ir63xxqposz6a51ur	1681214887895	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	cnqpcwgpmiguzmk9bycj8xcgce
efr5yx9c63dqxyn7a61daypxow	1681214903351	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	cnqpcwgpmiguzmk9bycj8xcgce
zdxh8dgz6fnh3jyuk11hizoynw	1681298192944	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
5rujdwkdfbni8ywwx3nj555hfw	1681298192979	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
7s3rbaojcbyw8chzhwabjtpqzc	1681298192998	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
sakykhqwhirxbpnmajs3ixpckr	1681298193017	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
f17ngnc653g5u8jefiro4ao9tw	1681298193113	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
jqpe1f5uaby37fbqrm5f3hxi8h	1681298193173	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
34sukc9p5byh3jpuen5uya49cc	1681298193217	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
g4gi1recz3f1tjj4g9kqt3k59r	1681298193638	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ehr17i1g17n5fj4awba467ss8y	1681298193652	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
14stqicbcbyyjpjbix78uur4kr	1681298193684	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1r7jwq9fxbdcikpt63qn1ifw3w	1681298193999	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ok8dkfqifjft3p9ffy9p58kzmw	1681298194208	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
hx5tuxdsqtgfddj1e5gz36swto	1681298194222	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
g8z3dqyt37fdmnf9ipz3nymi7y	1681298194240	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
yf1qsgapeifrpy8pft6pk8f6iy	1681298574120		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
aco8pnnzjiya3y8nsspzpm1iqa	1681298574351	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
wcif648qciyf7bz49qt9octc1w	1681298574370	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	wyg51swgf3bbbb7jtan9nccjna
shhhqx4eebdax8fuk1hygsa3be	1681298591450	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	wyg51swgf3bbbb7jtan9nccjna
ko397raf9785feu196io1gyhih	1681300695846		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
mycm985mp3rczqoo178gupc6rh	1681300696024	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
y1fddhy1wtnh8kjrgqgyqegs3h	1681300696045	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	up8cpfx4apna5ys41di7wij7qo
d65rs51ccbno7ccthug1igca7c	1681300773069	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	up8cpfx4apna5ys41di7wij7qo
nch7ani9xtbyibwr1zhjc6e4ro	1681300993194		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
b7chbnyw3tn35dyxztye7fbc5y	1681300993423	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
3qkq19bortr4fxbxm1pjxpx8dh	1681300993432	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	yk4s7p7x5bfy8e5471mrdp57gr
prnaaomj3pyc5c1zunfzxyrukh	1681301006343	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	yk4s7p7x5bfy8e5471mrdp57gr
1c5639is7ty6bj9r39ao6im57e	1681301062228		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
7sf1tpe7z3fzietmpi5fzyitja	1681301062452	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
hwrsxqfyqbd9iquf56mrjbpqdc	1681301062485	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	wit9o1omg7b3dezekyo9p9be5o
ts1946pcrb873gj55499qqu54c	1681301113351	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	wit9o1omg7b3dezekyo9p9be5o
khxgyiqzmp8b5cnir47tyhhfxy	1681302152159		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
736hi3fg9ifu9j9ao4knbkpnwy	1681302152378	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
48db1rhk5ffetc13apapa77pdh	1681302152405	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	j6g8b63nr7yxjjk93usp7xf1za
z7zz8f4i378ixefxmzdn66cr1y	1681302296557		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
xsx93o3of3ntirkudbqdhn7kya	1681302296826	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
g7jon54hxj8x8k6cfbxhmprr5r	1681302296838	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	ptg9hp4sciywtg6fpy8ijdstwc
eyuxy6jp9fgw3gaf7er5j834fa	1681302555006		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
eaxqcc314f8o7re4an8n9gdb7e	1681302555248	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ouxcwpuagf8w3yktsfjp8up36a	1681302555256	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	m91o3jrbmbdabduta8i97unxjc
fx54rzp8xfrujd5it6d9gc71qc	1681302775582		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
xeu1kougnpyudrtbo1roooqg7e	1681302775774	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ae1z7am84trsfgq94tycf9y3tc	1681302775813	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	my3rx6qssb8rtei434uuosg53h
to86o83y4pgp7nfspir4fg6kih	1681303324990		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
y6af81xbnb8g3ngk11u487gx3e	1681303325203	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
oym5hkyjnb8uiqdr1qrrporb1h	1681303325220	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	7rzmwgiz4tf33pz311rchesyjw
5mnasc9sfffobfapeshtgs7m9a	1681303424178		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
pudfrp7n33yq8keprpe7jey7jr	1681303424393	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
qarssdpw4idr7cfz15k9cu4one	1681303424425	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	h8na6s16jff6xqh8opz37q6p3c
zxqrmumra7gr7grwqfuyon8f4o	1681303494958		/api/v4/users/login	attempt - login_id=user1.mm@localhost.com	172.16.238.1	
p1rq5x97zpgddn867x51hsu1jh	1681303495174	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
nf1unpedtin1dqmg6am1b5yxuw	1681303495181	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	jsigmempfjrhux3gwabynczq5o
fst3egj18tg3dcgkoop6zcbkxo	1681303510673	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/logout		172.16.238.1	jsigmempfjrhux3gwabynczq5o
4d67cbuebpnb5eu4uq9i791pka	1681306483557		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
xc4a3s6jgj8upxiby3sk5wf7oa	1681306483664	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
uj9haduud3bs3ewbftkzxdif6r	1681306483671	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	xmuxszyjbbympqhfyr6itrop5o
upkgmjnqjib3jmint5kcupnj3e	1681306675020		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
35wji7b6a3fd7qapjor9kstz6y	1681306675122	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ghg1h9xfbbfmzdxt5ki56wzbay	1681306675131	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	g1pmtocr43ftxmz4x4gqr391zy
ykq8s8yrctnrxnxio1kyey6e9h	1681306720928		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
p1w1rm86i3fft8ixdizwtdzy1w	1681306721035	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
btdnbq1fmbbj9pqm3o4fzh5rgo	1681306721041	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	j8b4ych7tbgt5pa19bsukojyqh
mgwxu3wx5tghiddm1eu8pws6yo	1681306745271		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
6hisc9oauifsin77pq79xr8nee	1681306745381	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
e5en8em8mpdr7mbjixzyybx5yh	1681306745387	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	5tub8jnzxjgozes1ubefxh4gwh
3hhjoydctfr9tf17ytkhdoik6y	1681306952793		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
so6wjddhkig5m8boojjywd9coc	1681306953147	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
to9mj3f1d3fqtxcrb36ojn5ckr	1681306953178	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	khbrwxg957fqtedfn5xsc5roxe
ojn34kddtffmpdy175mzmjahto	1681306981204		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
pwwd9hhtxjb75gizn7pnefhw6y	1681306981306	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ri3a3xssrbrrxdyy96ebqxzwgh	1681306981314	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	r19cpn9nbbfcmezd7y4g5ixhso
rtgfkdttbjdijm31usaeqn33cw	1681307215553		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
q435heupobr53jpcqmgqbuqyaw	1681307215667	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ddgyksgpiirpjpoe6fufabztso	1681307215673	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	3phret7i7pbtjcbzmnxsukm6nr
o1q4ye3fubb8xpmib5cihhia6e	1681307350205	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dhfajri7c78ztdn5iot5bwed9h	1681307350224	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
rii647zrbjf99daqhbte59oy4c	1681307350242	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
8w516w3g6pbqfpnbmt9nxmhfja	1681307350262	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
asifztwiubfb3bmq7o1r8n5yuh	1681307350323	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
emzs1q8sqbnixjtbapydpyjsiw	1681307350366	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
dopa9sgpsjnzinb4ci4cpsziww	1681307350395	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
3c6uosdu1pdmzjxi94os83cy3h	1681307350658	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
r6wt1g9ynby7fp5endpz14g9de	1681307350676	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ih76ngf7uf8a8ku545ei51a4kc	1681307350691	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
bbskfnq1hibkfdxtjw5qynpt3e	1681307350877	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
wiidasxdzf8bjypripjorba45c	1681307351006	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
m185zn7whjrwzfsgfzt6wq1pwr	1681307351019	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
5asqijhzrfgepnmx4wxm8swshh	1681307351031	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
iwrgyckeefbjmb7n4xk6bcitbr	1681307387420		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
pseffhimpjygbd6o1zxrihwqhw	1681307387517	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
nt3eb1owhffn5ffgoxu3ubdath	1681307387524	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	s74dnu5u9fnd7m6goma7hu18uw
j9cthuuewfdrfbxztxhedxyhxo	1681307793964		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
15ehfco4gfbkinyxx9npzqnu4o	1681307794054	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
w8dtqrxxufyy8r7ewfx9g71uih	1681307794061	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	s7bd6fgs7pr5zkncfjdczznhrw
ygcqwea1bjrrzxy9q54swupzio	1681307924523		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
etp5u6sdb7d39e3o7co5wyj7jy	1681307924640	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
sy5uxgfjy3d6dyhx4qhpp4to3h	1681307924650	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	q4bqw8ujztykdcpa4ynihy4g4a
tuj8b73keir7beb5fyzz7uzm3r	1681308003238		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
1r4ouns1dfd3ubwfqpw3o6d5ka	1681308003340	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
64znsmwe3tbgpnjxdgsggioixw	1681308003346	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	563yhbctn7gw9x4gpd47aupeke
wqmtu8mjsink3re7p8xrpobmuw	1681308914295		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
4sq6bfc45fn5uer5dru8y4ob6e	1681308914425	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
45h9suqo3jn89gimpxgwh76hta	1681308914436	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	x5nbwwjywbyabecwi55tcbjc1c
huyq8wfx1pfcpff4kp17s3mtmh	1681309188703	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
icw7odq91bn7zjjofbadtu51ac	1681309188720	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	uqn7dfy4xtf3ixmnfwi5s8yobh
5ss1gs5wmtgduxrxm6dayqcere	1681309425254		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
nr9ew4oqmbgsmc574z873eroie	1681309425367	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
sjjhh69jhjnm9mbznr51d6krto	1681309425377	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	8kp6erua9tf1ir7ohk58pgb94r
8h348mrjapyr7ke6of43gsii1w	1681312247276		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
wthw5hy9s3ruuqh3n61caisxgo	1681312247367	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
jxfw6uz4y7rsfgpdrpu3bzio4w	1681312247373	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	mrkmmjk1t7bsbg5tig4wmdnxoa
4z7ysqxnufgizbj35kbm9bdjne	1681310364144		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
huoag4zzxbbwpq6dt5yeznbyco	1681310364243	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
69i44b87f3ro3yqbmdoqy15jte	1681310364253	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	gmpdyjsdkjbob8ofxueqswac3h
jg7e534euifjxg5hcdeka6dzsh	1681310411780		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ydi5sna3obg8ze76irit9fcaeo	1681310411877	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
u7fgzw9no78j7c7s7i3kinuufy	1681310411883	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	sxe54rhx9ib7bryouw3hi8cn4y
gn7mh3t4ktni3xd8ibx6heyxxw	1681310919086		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
owc8r9har3yxzmtufajmrj8dze	1681310919194	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
s7yefq4t4fgtmymzjgiecoadfo	1681310919204	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	67cg6xkgp3yuicaoq14mneaw6y
959394dw7jykxm5cs9bbzaxh7o	1681311951540		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
hm6hqupwijdwfyafdzk8kjoqww	1681311951653	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
ukt6unag5fnh9xse14kbo593ww	1681311951669	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	rn4juqasatr89gdqj3mgikgfbw
bdajqxkt338rmrpyipecadj7fy	1681312037080		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
fszhgr4nntfoxks7fhhwi98bre	1681312037191	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
btgp36f3rjye5rie4fy89yniqe	1681312037200	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	i1po5nrdgtdfxpuqd91ubgg6ea
qyurp6mqepdi3c8nr57c17543w	1681314452075		/api/v4/users/login	attempt - login_id=user1.mm	172.16.238.1	
ry4kkz6defbzzr7awo8hx7xr8h	1681314452329	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	authenticated	172.16.238.1	
7wkzc8e5jtrw8yu3da1bwy9fxr	1681314452338	ygmycw6rnff7igko8gwbqchujr	/api/v4/users/login	success session_user=ygmycw6rnff7igko8gwbqchujr	172.16.238.1	643z3ocdqff8xeg8iq6ocrcoew
eyj6meikdjdddnpreufsiti79o	1681385135109	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
c7a1fkrtrbyh3yj7bfocqbctor	1681385135153	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
pr4guf6zf7bd7mqt8jaq6n8dfw	1681385135185	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ayb95b1mffrq3rz5i6wkyu4yoh	1681385135221	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=geds3gxhdf81dccdrm8bfx37ry	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
goqzmr55mjre7yc3oo6kjmezgw	1681385135468	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
57k11mc6oidhijnkf43ytunijc	1681385135602	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
9d34q6744tf5xmur53aipn3ngw	1681385135692	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/9wp7xhh6f7namrfm1asziaf9nh/members	name=after-work user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
n6d468p8etb87kmzs5tgdzggne	1681385136321	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
pn4bcbdwqiy63n8sydnxshsc6c	1681385136343	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
mjc8tp6wziy3zbad5btf9cw4pe	1681385136362	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/giyj94p1fp86p8zs9z6u5b3ujh/members	name=off-topic user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1exzgzh6g7rgt8k7cprc3tyc3r	1681385136932	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/hb8cxm688f86zgrejdmgdr7qsc/members	name=stockholm-office user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
1kda4hb5p3nap8s9q6anwxjcxc	1681385137245	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=bgct5icpib883fx619bh3cfu6h	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
9wxkoprn3jb75xkktsin6snakh	1681385137273	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=wq6i7sbf4tnqzbssbn7gy7cjcc	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
ireeyb5b1fyzmnecfk7eqir1dh	1681385137287	geds3gxhdf81dccdrm8bfx37ry	/api/v4/channels/p7retz8iwtgzdrdceqw13fwmbr/members	name=town-square user_id=596q88qz87nbzbddntjm5xi6fh	172.16.238.1	y978n4jxf7b79ph3ccwfoproeh
takdwneonjb7ppwjdakziaf1se	1681393949826		/api/v4/users/logout		172.16.238.1	
c5a7b5ntnb8w7j4xgjdn6omeca	1681393949905		/api/v4/users/logout		172.16.238.1	
bahof8drt3r8j8nefrznhyjjch	1681393950009		/api/v4/users/logout		172.16.238.1	
knfx7g5z1id6uxyod6uha1wn7y	1681393950119		/api/v4/users/logout		172.16.238.1	
ohwedaxg93r9zx3wahmfc19jie	1681393950295		/api/v4/users/logout		172.16.238.1	
upiidzjetbbtibm8u31kzrwgcw	1681393950328		/api/v4/users/logout		172.16.238.1	
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.bots (userid, description, ownerid, createat, updateat, deleteat, lasticonupdate) FROM stdin;
uzpc4t1qkjbt3gspmrtmuzrimw	Mattermost Apps Registry and API proxy.	com.mattermost.apps	1675955407740	1675955407740	0	0
nm4raj8trpgetcnutzc8icka7r	Playbooks bot.	playbooks	1675955408410	1675955408410	0	0
g6hetueczp8wif38h7o3o1pcyc	Created by Boards plugin.	focalboard	1675955410092	1675955410092	0	0
59858ksa4ircjd9a5811negojr		whida44gqpyfierua1wfrnbxtr	1675955999763	1675955999763	0	0
nphyqs6wq3f4xb317o5eifbzeh	Calls Bot	com.mattermost.calls	1680689074315	1680689074315	0	0
\.


--
-- Data for Name: channelmemberhistory; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmemberhistory (channelid, userid, jointime, leavetime) FROM stdin;
p7retz8iwtgzdrdceqw13fwmbr	whida44gqpyfierua1wfrnbxtr	1675955722125	\N
giyj94p1fp86p8zs9z6u5b3ujh	whida44gqpyfierua1wfrnbxtr	1675955722214	\N
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry	1675956111707	\N
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry	1675956111736	\N
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr	1675956421325	\N
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr	1675956421364	\N
p7retz8iwtgzdrdceqw13fwmbr	bgct5icpib883fx619bh3cfu6h	1676646214689	\N
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h	1676646214697	\N
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h	1676646214765	\N
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry	1678033545977	1678033569794
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry	1678033678971	\N
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr	1678033762129	\N
9wp7xhh6f7namrfm1asziaf9nh	bgct5icpib883fx619bh3cfu6h	1678033782813	\N
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr	1678033905146	\N
rk4gdc4whjnupqoad46hwa9cme	geds3gxhdf81dccdrm8bfx37ry	1678033923766	1678033937009
p7retz8iwtgzdrdceqw13fwmbr	wq6i7sbf4tnqzbssbn7gy7cjcc	1678611368277	\N
giyj94p1fp86p8zs9z6u5b3ujh	wq6i7sbf4tnqzbssbn7gy7cjcc	1678611368371	1678611368803
p7retz8iwtgzdrdceqw13fwmbr	e343y5ecu7dyujwqm7yfimh1je	1678611396672	\N
giyj94p1fp86p8zs9z6u5b3ujh	e343y5ecu7dyujwqm7yfimh1je	1678611396725	\N
9wp7xhh6f7namrfm1asziaf9nh	wq6i7sbf4tnqzbssbn7gy7cjcc	1679410201689	\N
9wp7xhh6f7namrfm1asziaf9nh	e343y5ecu7dyujwqm7yfimh1je	1679410301787	\N
p7retz8iwtgzdrdceqw13fwmbr	596q88qz87nbzbddntjm5xi6fh	1679412884781	\N
giyj94p1fp86p8zs9z6u5b3ujh	596q88qz87nbzbddntjm5xi6fh	1679412884976	\N
9wp7xhh6f7namrfm1asziaf9nh	596q88qz87nbzbddntjm5xi6fh	1679412902623	\N
giyj94p1fp86p8zs9z6u5b3ujh	wq6i7sbf4tnqzbssbn7gy7cjcc	1679413187501	\N
xnbbfxbs1i87z8xp5mc5pxo3yw	wq6i7sbf4tnqzbssbn7gy7cjcc	1679414701505	\N
xnbbfxbs1i87z8xp5mc5pxo3yw	e343y5ecu7dyujwqm7yfimh1je	1679414701569	\N
xnbbfxbs1i87z8xp5mc5pxo3yw	geds3gxhdf81dccdrm8bfx37ry	1679414701602	\N
k17btosn9bbniczjj96ttnzido	wq6i7sbf4tnqzbssbn7gy7cjcc	1679415348790	\N
k17btosn9bbniczjj96ttnzido	geds3gxhdf81dccdrm8bfx37ry	1679415348837	\N
k17btosn9bbniczjj96ttnzido	ygmycw6rnff7igko8gwbqchujr	1679415348857	\N
k17btosn9bbniczjj96ttnzido	e343y5ecu7dyujwqm7yfimh1je	1679415348875	\N
k17btosn9bbniczjj96ttnzido	bgct5icpib883fx619bh3cfu6h	1679415348909	\N
hb8cxm688f86zgrejdmgdr7qsc	whida44gqpyfierua1wfrnbxtr	1681112027818	\N
hb8cxm688f86zgrejdmgdr7qsc	geds3gxhdf81dccdrm8bfx37ry	1681112040847	\N
hb8cxm688f86zgrejdmgdr7qsc	e343y5ecu7dyujwqm7yfimh1je	1681112066919	\N
hb8cxm688f86zgrejdmgdr7qsc	bgct5icpib883fx619bh3cfu6h	1681112138424	\N
8tmxnejrb3fhxb6p91b7358y3c	e343y5ecu7dyujwqm7yfimh1je	1681112408116	\N
8tmxnejrb3fhxb6p91b7358y3c	geds3gxhdf81dccdrm8bfx37ry	1681112421024	\N
8tmxnejrb3fhxb6p91b7358y3c	bgct5icpib883fx619bh3cfu6h	1681112441748	\N
bk454rpi9byk9nqgbebmsyxd6o	e343y5ecu7dyujwqm7yfimh1je	1681299111342	\N
44bx8k5kpjdnigcyurthgn733y	e343y5ecu7dyujwqm7yfimh1je	1681299111449	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot, urgentmentioncount) FROM stdin;
giyj94p1fp86p8zs9z6u5b3ujh	whida44gqpyfierua1wfrnbxtr		1675955722219	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1675955722219	t	t	f	0	0	\N
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry		1676646214793	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1676646214793	t	f	f	0	1	\N
9wp7xhh6f7namrfm1asziaf9nh	geds3gxhdf81dccdrm8bfx37ry		1678033721258	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033721258	t	f	f	0	1	\N
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry		1678033315382	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033315382	t	t	f	0	5	\N
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr		1678033959731	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1678033959731	t	t	f	0	2	\N
9wp7xhh6f7namrfm1asziaf9nh	bgct5icpib883fx619bh3cfu6h		1679410055294	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679410055294	t	f	f	0	5	\N
p7retz8iwtgzdrdceqw13fwmbr	596q88qz87nbzbddntjm5xi6fh		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679412884754	t	f	f	0	0	\N
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr		1679410380227	7	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679410380227	t	f	f	0	7	\N
9wp7xhh6f7namrfm1asziaf9nh	wq6i7sbf4tnqzbssbn7gy7cjcc		1679410217097	6	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679410217097	t	f	f	0	6	\N
giyj94p1fp86p8zs9z6u5b3ujh	596q88qz87nbzbddntjm5xi6fh		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679412884900	t	f	f	0	0	\N
p7retz8iwtgzdrdceqw13fwmbr	wq6i7sbf4tnqzbssbn7gy7cjcc		1679410503342	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679410503342	t	f	f	0	8	\N
9wp7xhh6f7namrfm1asziaf9nh	596q88qz87nbzbddntjm5xi6fh		1679412935049	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679412935049	t	f	f	0	8	\N
giyj94p1fp86p8zs9z6u5b3ujh	bgct5icpib883fx619bh3cfu6h		1679413133914	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679413133914	t	f	f	0	5	\N
9wp7xhh6f7namrfm1asziaf9nh	e343y5ecu7dyujwqm7yfimh1je		1679412935049	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679412935049	t	f	f	0	8	0
giyj94p1fp86p8zs9z6u5b3ujh	wq6i7sbf4tnqzbssbn7gy7cjcc		1679414296857	6	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679414296857	t	f	f	0	6	\N
giyj94p1fp86p8zs9z6u5b3ujh	e343y5ecu7dyujwqm7yfimh1je		1681303898664	43	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681303898664	t	f	f	0	43	0
xnbbfxbs1i87z8xp5mc5pxo3yw	geds3gxhdf81dccdrm8bfx37ry		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679414701583	t	f	f	0	0	\N
44bx8k5kpjdnigcyurthgn733y	e343y5ecu7dyujwqm7yfimh1je		1681299111461	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681299111461	t	t	f	0	0	0
k17btosn9bbniczjj96ttnzido	wq6i7sbf4tnqzbssbn7gy7cjcc		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679415348754	t	f	f	0	0	\N
k17btosn9bbniczjj96ttnzido	geds3gxhdf81dccdrm8bfx37ry		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679415348793	t	f	f	0	0	\N
k17btosn9bbniczjj96ttnzido	e343y5ecu7dyujwqm7yfimh1je		1679415493032	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679415493032	t	f	f	0	2	\N
k17btosn9bbniczjj96ttnzido	ygmycw6rnff7igko8gwbqchujr		1679415493032	2	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679415493032	t	f	f	0	2	\N
xnbbfxbs1i87z8xp5mc5pxo3yw	wq6i7sbf4tnqzbssbn7gy7cjcc		1679416148565	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679416148565	t	f	f	0	8	\N
xnbbfxbs1i87z8xp5mc5pxo3yw	e343y5ecu7dyujwqm7yfimh1je		1679416148565	8	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679416148565	t	f	f	0	8	\N
k17btosn9bbniczjj96ttnzido	bgct5icpib883fx619bh3cfu6h		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1679415348881	t	f	f	0	0	\N
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr		1681214863422	48	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681214863422	t	f	f	0	48	0
p7retz8iwtgzdrdceqw13fwmbr	e343y5ecu7dyujwqm7yfimh1je		1681313817936	62	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681313817936	t	f	f	0	61	0
p7retz8iwtgzdrdceqw13fwmbr	whida44gqpyfierua1wfrnbxtr		1681111875167	29	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681111875167	t	t	f	0	29	0
8tmxnejrb3fhxb6p91b7358y3c	e343y5ecu7dyujwqm7yfimh1je		1681112527887	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112527887	t	t	f	0	5	0
bk454rpi9byk9nqgbebmsyxd6o	e343y5ecu7dyujwqm7yfimh1je		1681299111350	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681299111350	t	t	f	0	0	0
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr		1681301111397	42	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681301111397	t	f	f	0	42	0
p7retz8iwtgzdrdceqw13fwmbr	bgct5icpib883fx619bh3cfu6h		1681312264373	61	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681312264373	t	f	f	0	61	0
hb8cxm688f86zgrejdmgdr7qsc	geds3gxhdf81dccdrm8bfx37ry		1681112041994	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112041994	t	f	f	0	1	0
hb8cxm688f86zgrejdmgdr7qsc	whida44gqpyfierua1wfrnbxtr		1681112066949	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112066949	t	t	f	0	1	0
hb8cxm688f86zgrejdmgdr7qsc	bgct5icpib883fx619bh3cfu6h		1681112190186	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112190186	t	f	f	0	5	0
hb8cxm688f86zgrejdmgdr7qsc	e343y5ecu7dyujwqm7yfimh1je		1681112190186	5	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112190186	t	f	f	0	5	0
8tmxnejrb3fhxb6p91b7358y3c	geds3gxhdf81dccdrm8bfx37ry		1681112421170	1	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112421170	t	f	f	0	1	0
8tmxnejrb3fhxb6p91b7358y3c	bgct5icpib883fx619bh3cfu6h		1681112485148	4	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default"}	1681112485148	t	f	f	0	4	0
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
rk4gdc4whjnupqoad46hwa9cme	1678033905128	1678033905128	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	My Public Room	my-public-room			1678033959731	2	0	ygmycw6rnff7igko8gwbqchujr		f	\N	2	1678033959731
9wp7xhh6f7namrfm1asziaf9nh	1678033545956	1678033545956	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	After Work	after-work		An channel for afterwork 	1679412935049	8	0	geds3gxhdf81dccdrm8bfx37ry		f	\N	8	1679412935049
k17btosn9bbniczjj96ttnzido	1679415348737	1679415348737	0		G	matrix.bridge, matrix_user1.matrix, matrix_user2.matrix, user1.m	e57ddb185c1761630241fd8c40dead00010b1001			1679415493032	2	0		\N	\N	\N	2	1679415493032
xnbbfxbs1i87z8xp5mc5pxo3yw	1679414701428	1679414701428	0		G	matrix.bridge, matrix_user2.matrix, user2.mm	31c45577841f1121099e96a8691b5dcb7af94b7b			1679416148565	8	0		\N	\N	\N	8	1679416148565
hb8cxm688f86zgrejdmgdr7qsc	1681112027795	1681112027795	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	Stockholm Office	stockholm-office			1681112190186	5	0	whida44gqpyfierua1wfrnbxtr		f	\N	5	1681112190186
p7retz8iwtgzdrdceqw13fwmbr	1675955722038	1675955722038	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	Town Square	town-square			1681313848427	63	0		\N	\N	\N	61	1681312264373
8tmxnejrb3fhxb6p91b7358y3c	1681112408031	1681112408031	0	ebxg8q3pzbdrdjo7xx1qqw3guy	P	A Private Channel for admins	a-private-channel-for-admins			1681112527887	5	0	e343y5ecu7dyujwqm7yfimh1je		f	\N	5	1681112527887
bk454rpi9byk9nqgbebmsyxd6o	1681299111082	1681299111082	0	rjartdbsbtrfjfk9k9argymhqw	O	Town Square	town-square			1681299111350	0	0		\N	\N	\N	0	1681299111350
44bx8k5kpjdnigcyurthgn733y	1681299111111	1681299111111	0	rjartdbsbtrfjfk9k9argymhqw	O	Off-Topic	off-topic			1681299111461	0	0		\N	\N	\N	0	1681299111461
giyj94p1fp86p8zs9z6u5b3ujh	1675955722056	1675955722056	0	ebxg8q3pzbdrdjo7xx1qqw3guy	O	Off-Topic	off-topic			1681303898664	43	0		\N	\N	\N	43	1681303898664
\.


--
-- Data for Name: clusterdiscovery; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.clusterdiscovery (id, type, clustername, hostname, gossipport, port, createat, lastpingat) FROM stdin;
\.


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commands (id, token, createat, updateat, deleteat, creatorid, teamid, trigger, method, username, iconurl, autocomplete, autocompletedesc, autocompletehint, displayname, description, url, pluginid) FROM stdin;
\.


--
-- Data for Name: commandwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.commandwebhooks (id, createat, commandid, userid, channelid, rootid, usecount) FROM stdin;
\.


--
-- Data for Name: compliances; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.compliances (id, createat, userid, status, count, "desc", type, startat, endat, keywords, emails) FROM stdin;
\.


--
-- Data for Name: db_lock; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.db_lock (id, expireat) FROM stdin;
\.


--
-- Data for Name: db_migrations; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.db_migrations (version, name) FROM stdin;
1	create_teams
2	create_team_members
3	create_cluster_discovery
4	create_command_webhooks
5	create_compliances
6	create_emojis
7	create_user_groups
8	create_group_members
9	create_group_teams
10	create_group_channels
11	create_link_metadata
12	create_commands
13	create_incoming_webhooks
14	create_outgoing_webhooks
15	create_systems
16	create_reactions
17	create_roles
18	create_schemes
19	create_licenses
20	create_posts
21	create_product_notice_view_state
22	create_sessions
23	create_terms_of_service
24	create_audits
25	create_oauth_access_data
26	create_preferences
27	create_status
28	create_tokens
29	create_bots
30	create_user_access_tokens
31	create_remote_clusters
32	create_sharedchannels
33	create_sidebar_channels
34	create_oauthauthdata
35	create_sharedchannelattachments
36	create_sharedchannelusers
37	create_sharedchannelremotes
38	create_jobs
39	create_channel_member_history
40	create_sidebar_categories
41	create_upload_sessions
42	create_threads
43	thread_memberships
44	create_user_terms_of_service
45	create_plugin_key_value_store
46	create_users
47	create_file_info
48	create_oauth_apps
49	create_channels
50	create_channelmembers
51	create_msg_root_count
52	create_public_channels
53	create_retention_policies
54	create_crt_channelmembership_count
55	create_crt_thread_count_and_unreads
56	upgrade_channels_v6.0
57	upgrade_command_webhooks_v6.0
58	upgrade_channelmembers_v6.0
59	upgrade_users_v6.0
60	upgrade_jobs_v6.0
61	upgrade_link_metadata_v6.0
62	upgrade_sessions_v6.0
63	upgrade_threads_v6.0
64	upgrade_status_v6.0
65	upgrade_groupchannels_v6.0
66	upgrade_posts_v6.0
67	upgrade_channelmembers_v6.1
68	upgrade_teammembers_v6.1
69	upgrade_jobs_v6.1
70	upgrade_cte_v6.1
71	upgrade_sessions_v6.1
72	upgrade_schemes_v6.3
73	upgrade_plugin_key_value_store_v6.3
74	upgrade_users_v6.3
75	alter_upload_sessions_index
76	upgrade_lastrootpostat
77	upgrade_users_v6.5
78	create_oauth_mattermost_app_id
79	usergroups_displayname_index
80	posts_createat_id
81	threads_deleteat
82	upgrade_oauth_mattermost_app_id
83	threads_threaddeleteat
84	recent_searches
85	fileinfo_add_archived_column
86	add_cloud_limits_archived
87	sidebar_categories_index
88	remaining_migrations
89	add-channelid-to-reaction
90	create_enums
91	create_post_reminder
92	add_createat_to_teamembers
93	notify_admin
95	remove_posts_parentid
94	threads_teamid
96	threads_threadteamid
97	create_posts_priority
98	create_post_acknowledgements
99	create_drafts
100	add_draft_priority_column
101	create_true_up_review_history
102	posts_originalid_index
103	add_sentat_to_notifyadmin
104	upgrade_notifyadmin
\.


--
-- Data for Name: drafts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.drafts (createat, updateat, deleteat, userid, channelid, rootid, message, props, fileids, priority) FROM stdin;
1681112505418	1681112527959	1681112527959	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c		# H1\n## H2	{}	[]	null
1681136400750	1681137031186	1681137031186	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh		[](url)	{}	[]	null
1681303119730	1681303119730	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh		Beatae corrupti officia dolorum. Consequuntur sint odit adipisci libero. Tempore itaque dolorem quam saepe architecto sed enim. Deleniti quis quia minima nesciunt odio at doloremque error quidem. Dolores expedita odit eius fugiat corrupti facere velit. Tempore dolore iusto sapiente nemo veritatis incidunt delectus quo molestias.	{}	[]	null
1681303510031	1681303510031	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr		Earum molestias in aliquid corrupti sunt rem. Nostrum magni debitis voluptatibus est corporis quo perspiciatis perferendis. Veritatis nulla ipsa laboriosam recusandae et amet velit quasi. Sequi fuga quae eius soluta voluptas. Laboriosam iste architecto incidunt doloremque eum ab neque numquam a.	{}	[]	null
1681313829527	1681313854373	0	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr	iwf9qjrqm7g1pxjtfrotp1izuo		{}	[]	null
\.


--
-- Data for Name: emoji; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.emoji (id, createat, updateat, deleteat, creatorid, name) FROM stdin;
\.


--
-- Data for Name: fileinfo; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.fileinfo (id, creatorid, postid, createat, updateat, deleteat, path, thumbnailpath, previewpath, name, extension, size, mimetype, width, height, haspreviewimage, minipreview, content, remoteid, archived) FROM stdin;
huxsrcaqh3fybr5acjoi79ajhc	e343y5ecu7dyujwqm7yfimh1je	rk4fdirw8tbf5esp5u4ujrxw3y	1679410362249	1679410362249	0	20230321/teams/noteam/channels/9wp7xhh6f7namrfm1asziaf9nh/users/e343y5ecu7dyujwqm7yfimh1je/huxsrcaqh3fybr5acjoi79ajhc/024906F6-E58D-4AD5-923E-D12140EC537A.jpeg	20230321/teams/noteam/channels/9wp7xhh6f7namrfm1asziaf9nh/users/e343y5ecu7dyujwqm7yfimh1je/huxsrcaqh3fybr5acjoi79ajhc/024906F6-E58D-4AD5-923E-D12140EC537A_thumb.jpg	20230321/teams/noteam/channels/9wp7xhh6f7namrfm1asziaf9nh/users/e343y5ecu7dyujwqm7yfimh1je/huxsrcaqh3fybr5acjoi79ajhc/024906F6-E58D-4AD5-923E-D12140EC537A_preview.jpg	024906F6-E58D-4AD5-923E-D12140EC537A.jpeg	jpeg	608445	image/jpeg	1080	1920	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f321a39f16783ed2ee696099e4916e5c5ac66ee313053248edb5f2c42ecdc1580e7e600f077ec21d2759d1a2b2b7d36df5116c8b646e6c09b3640e0b07085b38c96cf3ed9af94bc2bf11fc43e05d65750b0b2b6b6b88d1d195879d6f202304f967a1c7460411eb4ed7fe386b7e2f4b7d32ee3b7b3b4b2324b1476f17ccaf211bcee62ced9c0e19881ce0726be6fea75633b27a1f690c6e0aac3f791e5fcfd2cb7f5baf33ffd9			f
1nhhutjbhpb3pprgjun73p4k6e	wq6i7sbf4tnqzbssbn7gy7cjcc	4cgemgmbpf8g5yy571phx7pa4e	1679410491898	1679410491898	0	20230321/teams/noteam/channels/p7retz8iwtgzdrdceqw13fwmbr/users/wq6i7sbf4tnqzbssbn7gy7cjcc/1nhhutjbhpb3pprgjun73p4k6e/HotElement.jpeg	20230321/teams/noteam/channels/p7retz8iwtgzdrdceqw13fwmbr/users/wq6i7sbf4tnqzbssbn7gy7cjcc/1nhhutjbhpb3pprgjun73p4k6e/HotElement_thumb.jpg	20230321/teams/noteam/channels/p7retz8iwtgzdrdceqw13fwmbr/users/wq6i7sbf4tnqzbssbn7gy7cjcc/1nhhutjbhpb3pprgjun73p4k6e/HotElement_preview.jpg	HotElement.jpeg	jpeg	35374	image/jpeg	450	600	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00daf8bdfb42587c3af0326b4fa7cb7f3f9d144f6bbcc653783963c1e84018ef9ce6b63e1b78f23f19784349d6618cdbadec66e0c272e10f4da4e3eb5e69e38f13181acb519acdee61b1b98ae2536ea5d9955c6e3b4024e016380335bbf0e6fb4ff105bde5fda5cea7a74124f2b43244f25b0914bb36f11b74073919504d78746a7eface3a5b7fd3f53d6ab417b1e752d6f6b7cb73ffd9			f
mwucdemjwt8kiyfdibi557foeh	bgct5icpib883fx619bh3cfu6h	mmgsgno1ztb9xy9nxkz31dsa9h	1679413133572	1679413133572	0	20230321/teams/noteam/channels/giyj94p1fp86p8zs9z6u5b3ujh/users/bgct5icpib883fx619bh3cfu6h/mwucdemjwt8kiyfdibi557foeh/TBana-Nacka.png	20230321/teams/noteam/channels/giyj94p1fp86p8zs9z6u5b3ujh/users/bgct5icpib883fx619bh3cfu6h/mwucdemjwt8kiyfdibi557foeh/TBana-Nacka_thumb.png	20230321/teams/noteam/channels/giyj94p1fp86p8zs9z6u5b3ujh/users/bgct5icpib883fx619bh3cfu6h/mwucdemjwt8kiyfdibi557foeh/TBana-Nacka_preview.png	TBana-Nacka.png	png	230773	image/png	2276	1088	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fd35f0d4dab2dbc30df7d9ee6044282fd662249d81c6e31edc2e793f78d6bcd7b6f6f710412cc8934e488918e0b903271eb81cd72e926a36b2a99ad2e27923779a30137c619cf1d31f750918eec4f3d0d68db5b1d6f56b7d42eace4b73626416de665589700138cff74639f5f6ad9c356dec611a9a24b57a7fc13fffd9			f
3wfpqmqueb8w3qxynyykr8sfch	wq6i7sbf4tnqzbssbn7gy7cjcc	ikdic8s8ajbw8x3khspqntf4yo	1679414775004	1679414775004	0	20230321/teams/noteam/channels/xnbbfxbs1i87z8xp5mc5pxo3yw/users/wq6i7sbf4tnqzbssbn7gy7cjcc/3wfpqmqueb8w3qxynyykr8sfch/HotElement.jpeg	20230321/teams/noteam/channels/xnbbfxbs1i87z8xp5mc5pxo3yw/users/wq6i7sbf4tnqzbssbn7gy7cjcc/3wfpqmqueb8w3qxynyykr8sfch/HotElement_thumb.jpg	20230321/teams/noteam/channels/xnbbfxbs1i87z8xp5mc5pxo3yw/users/wq6i7sbf4tnqzbssbn7gy7cjcc/3wfpqmqueb8w3qxynyykr8sfch/HotElement_preview.jpg	HotElement.jpeg	jpeg	35374	image/jpeg	450	600	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00daf8bdfb42587c3af0326b4fa7cb7f3f9d144f6bbcc653783963c1e84018ef9ce6b63e1b78f23f19784349d6618cdbadec66e0c272e10f4da4e3eb5e69e38f13181acb519acdee61b1b98ae2536ea5d9955c6e3b4024e016380335bbf0e6fb4ff105bde5fda5cea7a74124f2b43244f25b0914bb36f11b74073919504d78746a7eface3a5b7fd3f53d6ab417b1e752d6f6b7cb73ffd9			f
md3m4x9gg7dy9cyj1gpft9u4ky	ygmycw6rnff7igko8gwbqchujr	hsrgcic9ptnkfkp8p86ocaxp1y	1679415479712	1679415479712	0	20230321/teams/noteam/channels/k17btosn9bbniczjj96ttnzido/users/ygmycw6rnff7igko8gwbqchujr/md3m4x9gg7dy9cyj1gpft9u4ky/TBana-Nacka.png	20230321/teams/noteam/channels/k17btosn9bbniczjj96ttnzido/users/ygmycw6rnff7igko8gwbqchujr/md3m4x9gg7dy9cyj1gpft9u4ky/TBana-Nacka_thumb.png	20230321/teams/noteam/channels/k17btosn9bbniczjj96ttnzido/users/ygmycw6rnff7igko8gwbqchujr/md3m4x9gg7dy9cyj1gpft9u4ky/TBana-Nacka_preview.png	TBana-Nacka.png	png	230773	image/png	2276	1088	t	\\xffd8ffdb0084000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f1718161418121415140103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc00011080010001003012200021101031101ffc401a20000010501010101010100000000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa0100030101010101010101010000000000000102030405060708090a0b1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fd35f0d4dab2dbc30df7d9ee6044282fd662249d81c6e31edc2e793f78d6bcd7b6f6f710412cc8934e488918e0b903271eb81cd72e926a36b2a99ad2e27923779a30137c619cf1d31f750918eec4f3d0d68db5b1d6f56b7d42eace4b73626416de665589700138cff74639f5f6ad9c356dec611a9a24b57a7fc13fffd9			f
\.


--
-- Data for Name: focalboard_blocks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
czebhwzawapy55jy4qxmozzo4cr	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["axpbptk9grbrhzdq9rodcqgomra","7dzinn6e9fpri3chki7e71xs8yh","ayarazd7asb8ozkksuxy5351aqh","7196jqjcy8jn7bmsod7ythqpamw","7omaahugkcfdhp8xohiy1d7iniy","7pwy6b4y9qtde9mayz9t576wzbo"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410132	1675955410132	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
caaryyfj35iyo9q7ukein9jiu4e	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["aiwph7zdhpjbombd49uom6p5qxy","7yd3axyrhzbyh3x9qozk5qtbsrh","ai93zq6uonfrf7gjibrwatofmiy","79u5d4yzqdjg65qgcpwbmob9fzo","7eqriuxcf87dh9frg5aiuc1bp9r","7hhgoyez5etb7mpptkrdq75dghe"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410138	1675955410138	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ctor6xdeexffg8xzqd76prxk1ge	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["awjd7cdpaobfi7yofwb76szzdjw","7wgktjf58itbeddwexf15wbg59a","adc9tusigjj8rzqxbfo7s7uko6a","7hncbmdr4jpng3xb44yth4mmwma","7zcg6yc1dyjbwi8nys6916knsse","797gc7kuqubggbbth9tjb394r5c"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675955410145	1675955410145	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
cbpyozo5n738dmq36auszr7twty	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a7nrc4e58m3ru5puz4wswn1trdc","7dqzit6ec5t8ubbnf5pzarpuuja","aoudetcozh3yfmkqkq3cyhp9d8w","7xz74uk3bt3fu9y6spr7s69f8cc","7pbnkbqkjipb47cjxptp91ppz4c","7bqzsshop3pg9mka4h1tspz8ity"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675955410150	1675955410150	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vkngsehpzdbf47g6pgp9fxz4o7a	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675955410157	1675955410157	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7omaahugkcfdhp8xohiy1d7iniy	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410167	1675955410167	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7196jqjcy8jn7bmsod7ythqpamw	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410172	1675955410172	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dzinn6e9fpri3chki7e71xs8yh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	divider		{}	1675955410176	1675955410175	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pwy6b4y9qtde9mayz9t576wzbo	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410178	1675955410178	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
axpbptk9grbrhzdq9rodcqgomra	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410181	1675955410181	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ayarazd7asb8ozkksuxy5351aqh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Action Items	{}	1675955410183	1675955410183	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7o4rz1o44gbf4zepkb4sqrmhwce	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675955410188	1675955410187	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pyuztkwto3b6irhdu7jcusoeqh	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410196	1675955410196	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7f1qymriaetf8fyqb6b88hn6syy	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410211	1675955410211	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
74g7zukwfhjgcfpugf4hxqcostc	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410221	1675955410221	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a5gpne7xtsjr37d8xxgu93bpyay	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675955410243	1675955410243	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
afoajfa1w4brjbq3wpmguh61w7w	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675955410251	1675955410251	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7yd3axyrhzbyh3x9qozk5qtbsrh	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	divider		{}	1675955410258	1675955410258	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hhgoyez5etb7mpptkrdq75dghe	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410264	1675955410264	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7eqriuxcf87dh9frg5aiuc1bp9r	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410268	1675955410268	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
79u5d4yzqdjg65qgcpwbmob9fzo	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410273	1675955410273	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ai93zq6uonfrf7gjibrwatofmiy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Action Items	{}	1675955410277	1675955410277	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aiwph7zdhpjbombd49uom6p5qxy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410283	1675955410283	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hncbmdr4jpng3xb44yth4mmwma	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410289	1675955410289	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7zcg6yc1dyjbwi8nys6916knsse	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410297	1675955410296	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7wgktjf58itbeddwexf15wbg59a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	divider		{}	1675955410303	1675955410302	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
797gc7kuqubggbbth9tjb394r5c	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410309	1675955410309	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
adc9tusigjj8rzqxbfo7s7uko6a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Action Items	{}	1675955410314	1675955410314	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
awjd7cdpaobfi7yofwb76szzdjw	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410320	1675955410320	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dqzit6ec5t8ubbnf5pzarpuuja	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	divider		{}	1675955410326	1675955410326	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pbnkbqkjipb47cjxptp91ppz4c	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410331	1675955410331	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7bqzsshop3pg9mka4h1tspz8ity	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410339	1675955410339	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7xz74uk3bt3fu9y6spr7s69f8cc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410359	1675955410359	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aoudetcozh3yfmkqkq3cyhp9d8w	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Action Items	{}	1675955410371	1675955410371	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a7nrc4e58m3ru5puz4wswn1trdc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410400	1675955410400	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vk8bc997m1bysubqa9zzpuikwmo	2023-02-09 15:10:10.921795+00		1	view	All Contacts	{"cardOrder":["c7n4qjbom77g5mxhapf6tmtcidw","cirqnetz9uf8ebpfrq68dx7sj1o","czb14t4y4gbf15ehgi9kpj6hyey","c71eyc8srz7gazgtp3hafyys1ba","c45s8knkw1jf79mfpkh4k1w39ko"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxarr4qdxsi8u9jak7cc3yeikuh","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675955410931	1675955410931	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vcaht3fzu1p8czftchjwej9zdbh	2023-02-09 15:10:10.921795+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675955410934	1675955410934	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c71eyc8srz7gazgtp3hafyys1ba	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["akf5xjt9byinzfkeos6r6px8jbw","askua4mi95jy8bchwhybg8gfcse","7zu87byt3etrfjj4if6i7o9f5zw","7kwnrbo5c43gfjnpdoygghmfz5y","7n61tdes8updx7dgk4g1qmkqbnh","7iy8rn8s9ubdhxb9w43e5fmhuwh","7gx593y1kpif75xkrho74839yne","7kx16rigxffr9bezsar6dxammny","7uwrwbb9sa38j8d95d4ww8mypdw","7afgp343sijrc7gonf9qoy7556y","71gqjf96497fi9ryke93twwe7xh","77iiwbg3iufbkjp39xbytusm7fy"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675955410936	1675955410936	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
czb14t4y4gbf15ehgi9kpj6hyey	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["afdi9nuij83bz9ywhkjsyorsika","ap8htxxgcnpgaxka4s11df59y5c","7cwxpmkp8d3y78e5t4t8aizh9ac","7f6prgh7etidefktxjadakro7de","79by87rm9i3ngfk95wxr4hcu8mw","7p31k115qpbyo5fefdqbwceunfo","7dizabc4pu78y8kknah8pckrpgw","7e8a3i33n8jnujrhb9im4u3f3bc","7pobi5s6iq3dhbktgrootac1h4h","73wnuh3ums7grtb58as6qdu1s7r","7czs3x5g5o7godjj9nwpmnc6dye","76fuqbbtu8pywjqqj1hgg4q9e8e"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675955410940	1675955410940	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c45s8knkw1jf79mfpkh4k1w39ko	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["atyt9edm39tbtbnjddx5rt8mmda","a98wh64rrxtyumdfmo5dim8wikr","7pa48ejem6p8stdqhbbicqjj7cy","714ghubqyrpgd7nw34mh31ug79c","7i9im8g6b17nizpis19mmnn9ckh","78wczgiecq7dkjbau9r54izny9w","7n4b867c94tyymfg16gwoqj94fe","7fymoo4ywy3yg5gyh91ijm1tmuw","77p9joh3ajpg1tr6b385zidjbge","7164ftmhpnfdwu8gy3icogzpa8o","7w4tgym95obnjp8smfskq9iypcc","7bwix7j583irsdmre8a3ttqy31e"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675955410943	1675955410943	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7czs3x5g5o7godjj9nwpmnc6dye	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Hand-off to customer success	{}	1675955411012	1675955411012	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73wnuh3ums7grtb58as6qdu1s7r	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Finalize contract	{}	1675955411015	1675955411015	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76fuqbbtu8pywjqqj1hgg4q9e8e	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Post-sales follow up	{}	1675955411019	1675955411019	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cirqnetz9uf8ebpfrq68dx7sj1o	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["auxx7ta8sktnsjmafar4n4ox7uh","auyp7cdhmbpyymefooaxte184nh","7ia67tegp7f8obj4yxtaa8d9whc","768tmcyaxypyrimxhbpqw5i1fpr","765g3gs41epfp9jrm6pm3o9ym3a","7qdcudfpn53b5i8mpe73odd8nwr","71sd6tycbyj8gjrxp1iin7pa7zr","7xgfqfh9fdffcpmg91rdj6d1tea","7kzfgicen5j8d7rwhzbq6o4cedr","7pur5woxchiymbppotiqc3epu8e","7pft7f9sj4jd3upimxkh7x8w87h","7qbk31ej6jjyrjjsqyeu9fmturc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675955410949	1675955410948	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cxarr4qdxsi8u9jak7cc3yeikuh	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["ahae77tk763dpmmeijk8nwjociw","awdkgnnej7tnb5yweq4psgm8smc","7axxtz7491tbzddsddkhr1okagw","79gysbkm967djicna43f88r9wpe","71prjd7h1ofy1tbfmwbcyjxkunw","7p4tj6cwryjnbjqu6dp5zbia8rr","7wu3q67edhi8ebgmjzjfiwsahyo","71q3bar1wm7y9tc51rd8j7fymor","779frbxrdd7gb7e1g1u1wcweqnc","7s7keem8eetrm5yguee6e48agee","7yipg3d9mtigbdq8z5h7r3f3wgy","7jyt49rqrwbf5udj38tqu4ea37a"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675955410953	1675955410953	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c7n4qjbom77g5mxhapf6tmtcidw	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["anbyeqt5wz3dkxq6kckxwn79xxr","aw1x1hw8aefd37joninhxtwxxka","7ojg7aiidaprm5q7y54ng8xa97r","7issp85h1mpn7pjo969iynpzike","73x54ue6mzbrj38t5mbkyfds7xc","7ddxcwbw3bpyk3nbyupp9s767pa","7w5z546c5u3d15n1fferi4y3sne","7bdmxk7xcrpryibc4g5srw41qqr","738c4jz9iytfmmjc43f8ma8bn1y","73x4mgnyqrff6jjmdmpwrc3r69a","76zfm97dmgjywuj7ukop3y918no","7xcdyhrcxqfn1byi14nkcfzoyor"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675955410961	1675955410961	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vpzrdpq8ugp88ipudigtx7kksch	2023-02-09 15:10:10.921795+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["cirqnetz9uf8ebpfrq68dx7sj1o"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675955410964	1675955410964	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7zu87byt3etrfjj4if6i7o9f5zw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send initial email	{"value":true}	1675955410969	1675955410969	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kwnrbo5c43gfjnpdoygghmfz5y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send follow-up email	{"value":true}	1675955410972	1675955410972	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7uwrwbb9sa38j8d95d4ww8mypdw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send proposal	{"value":true}	1675955410975	1675955410975	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7afgp343sijrc7gonf9qoy7556y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Finalize contract	{}	1675955410978	1675955410978	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n61tdes8updx7dgk4g1qmkqbnh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule initial sales call	{"value":true}	1675955410980	1675955410980	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7gx593y1kpif75xkrho74839yne	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule demo	{"value":true}	1675955410982	1675955410982	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71gqjf96497fi9ryke93twwe7xh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Hand-off to customer success	{}	1675955410985	1675955410985	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kx16rigxffr9bezsar6dxammny	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Follow up after demo	{"value":true}	1675955410987	1675955410987	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7iy8rn8s9ubdhxb9w43e5fmhuwh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955410990	1675955410990	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77iiwbg3iufbkjp39xbytusm7fy	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Post-sales follow up	{}	1675955410993	1675955410993	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
askua4mi95jy8bchwhybg8gfcse	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Checklist	{}	1675955410996	1675955410996	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
akf5xjt9byinzfkeos6r6px8jbw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955410999	1675955410999	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7cwxpmkp8d3y78e5t4t8aizh9ac	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send initial email	{"value":true}	1675955411002	1675955411002	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p31k115qpbyo5fefdqbwceunfo	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411004	1675955411004	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7e8a3i33n8jnujrhb9im4u3f3bc	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Follow up after demo	{"value":true}	1675955411007	1675955411007	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pobi5s6iq3dhbktgrootac1h4h	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send proposal	{"value":true}	1675955411009	1675955411009	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7dizabc4pu78y8kknah8pckrpgw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule demo	{"value":true}	1675955411023	1675955411023	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79by87rm9i3ngfk95wxr4hcu8mw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule initial sales call	{"value":true}	1675955411027	1675955411027	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7f6prgh7etidefktxjadakro7de	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send follow-up email	{"value":true}	1675955411030	1675955411030	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
afdi9nuij83bz9ywhkjsyorsika	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411032	1675955411032	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ap8htxxgcnpgaxka4s11df59y5c	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Checklist	{}	1675955411035	1675955411035	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7fymoo4ywy3yg5gyh91ijm1tmuw	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Follow up after demo	{"value":true}	1675955411038	1675955411038	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pa48ejem6p8stdqhbbicqjj7cy	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send initial email	{"value":true}	1675955411041	1675955411041	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
714ghubqyrpgd7nw34mh31ug79c	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send follow-up email	{"value":true}	1675955411043	1675955411043	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77p9joh3ajpg1tr6b385zidjbge	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send proposal	{"value":true}	1675955411046	1675955411046	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7164ftmhpnfdwu8gy3icogzpa8o	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Finalize contract	{"value":true}	1675955411049	1675955411049	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78wczgiecq7dkjbau9r54izny9w	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411054	1675955411054	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7i9im8g6b17nizpis19mmnn9ckh	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule initial sales call	{"value":true}	1675955411062	1675955411062	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n4b867c94tyymfg16gwoqj94fe	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule demo	{"value":true}	1675955411077	1675955411077	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w4tgym95obnjp8smfskq9iypcc	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Hand-off to customer success	{"value":true}	1675955411088	1675955411088	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bwix7j583irsdmre8a3ttqy31e	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Post-sales follow up	{"value":true}	1675955411093	1675955411093	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a98wh64rrxtyumdfmo5dim8wikr	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Checklist	{}	1675955411098	1675955411098	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
atyt9edm39tbtbnjddx5rt8mmda	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411104	1675955411104	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qbk31ej6jjyrjjsqyeu9fmturc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Post-sales follow up	{}	1675955411116	1675955411116	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kzfgicen5j8d7rwhzbq6o4cedr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send proposal	{}	1675955411121	1675955411121	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pft7f9sj4jd3upimxkh7x8w87h	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Hand-off to customer success	{}	1675955411130	1675955411130	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xgfqfh9fdffcpmg91rdj6d1tea	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Follow up after demo	{}	1675955411136	1675955411136	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71sd6tycbyj8gjrxp1iin7pa7zr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule demo	{"value":true}	1675955411141	1675955411141	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ia67tegp7f8obj4yxtaa8d9whc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send initial email	{"value":true}	1675955411144	1675955411144	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qdcudfpn53b5i8mpe73odd8nwr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411148	1675955411148	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
768tmcyaxypyrimxhbpqw5i1fpr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send follow-up email	{"value":true}	1675955411154	1675955411153	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
765g3gs41epfp9jrm6pm3o9ym3a	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule initial sales call	{"value":true}	1675955411160	1675955411160	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pur5woxchiymbppotiqc3epu8e	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Finalize contract	{}	1675955411166	1675955411166	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auyp7cdhmbpyymefooaxte184nh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Checklist	{}	1675955411172	1675955411172	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auxx7ta8sktnsjmafar4n4ox7uh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411178	1675955411178	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7axxtz7491tbzddsddkhr1okagw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send initial email	{"value":false}	1675955411184	1675955411184	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71prjd7h1ofy1tbfmwbcyjxkunw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule initial sales call	{"value":false}	1675955411190	1675955411190	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p4tj6cwryjnbjqu6dp5zbia8rr	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411196	1675955411196	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
779frbxrdd7gb7e1g1u1wcweqnc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send proposal	{}	1675955411202	1675955411202	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7s7keem8eetrm5yguee6e48agee	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Finalize contract	{}	1675955411208	1675955411208	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7jyt49rqrwbf5udj38tqu4ea37a	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Post-sales follow up	{}	1675955411213	1675955411213	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79gysbkm967djicna43f88r9wpe	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send follow-up email	{"value":false}	1675955411219	1675955411219	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7wu3q67edhi8ebgmjzjfiwsahyo	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule demo	{"value":false}	1675955411224	1675955411224	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7yipg3d9mtigbdq8z5h7r3f3wgy	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Hand-off to customer success	{}	1675955411230	1675955411230	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71q3bar1wm7y9tc51rd8j7fymor	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Follow up after demo	{}	1675955411241	1675955411241	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ahae77tk763dpmmeijk8nwjociw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Notes\n[Enter notes here...]	{}	1675955411252	1675955411251	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
awdkgnnej7tnb5yweq4psgm8smc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Checklist	{}	1675955411261	1675955411261	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kfpfh7omc7f4bpgcpq5u3axgue	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675955411268	1675955411268	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
756nnjpzjwpntbe66myqiuw3qda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675955411275	1675955411275	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76rekmo79d78qtxh39scmb1kx5y	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675955411281	1675955411281	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7imo387hkz3yrzrs9it7krmgjda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675955411288	1675955411288	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7k5f3rk8c6iyxzrcktu4wr3fwda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675955411293	1675955411293	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71bhibupqmbntbxg6dt8snc6asc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411297	1675955411297	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7mb4ytzwbwidq7czurerc6o1swc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675955411302	1675955411302	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7h5pc91n56p8yfmgp74rsqy78ro	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675955411310	1675955411310	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78kwigroocfyn5pf41nhoupwoda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675955411319	1675955411319	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77predkxwjjgf7d6dtcjaooxr3e	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675955411332	1675955411332	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a65asssmsbjdh3giat9xzqoqdco	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675955411338	1675955411338	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a4zbibzhm1irk8pkx4xqmp4dpqc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675955411344	1675955411344	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
738c4jz9iytfmmjc43f8ma8bn1y	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send proposal	{}	1675955411349	1675955411349	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ojg7aiidaprm5q7y54ng8xa97r	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send initial email	{"value":true}	1675955411355	1675955411355	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bdmxk7xcrpryibc4g5srw41qqr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Follow up after demo	{}	1675955411360	1675955411360	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x4mgnyqrff6jjmdmpwrc3r69a	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Finalize contract	{}	1675955411367	1675955411367	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ddxcwbw3bpyk3nbyupp9s767pa	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411374	1675955411374	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w5z546c5u3d15n1fferi4y3sne	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule demo	{"value":false}	1675955411380	1675955411380	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x54ue6mzbrj38t5mbkyfds7xc	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule initial sales call	{"value":false}	1675955411387	1675955411387	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xcdyhrcxqfn1byi14nkcfzoyor	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Post-sales follow up	{}	1675955411394	1675955411394	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76zfm97dmgjywuj7ukop3y918no	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Hand-off to customer success	{}	1675955411401	1675955411401	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7issp85h1mpn7pjo969iynpzike	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send follow-up email	{"value":false}	1675955411408	1675955411408	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
aw1x1hw8aefd37joninhxtwxxka	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Checklist	{}	1675955411416	1675955411415	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p3whtqf9cpnbuygpkfsutwheoo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 3]	{"value":false}	1675955413115	1675955413115	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
anbyeqt5wz3dkxq6kckxwn79xxr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411433	1675955411433	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ccq3ukx8c8bgo9x49g8q851froe	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7kx1socx6mjgwxksy1nmnu8hbky","7mazt3mp5yfbdfkgh7iy4upqccy","7bh94nigoqtgyjgdtk7xan14t4h"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675955412199	1675955412199	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cchc3zymfa3f5mktpoiqo4nbzsr	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a54rpf4qjypbpdkdnraatck173h","76x94fpy89brh8jsjip3eepyb6c","7oq6wa91e1jnqxfhnshadyqwana","7gui4597mfbyqmgbrenwcu4apja","7wi6nur6ysig43x8yntx1atf13y","7zmwfuc7jqiysupcxdmncgdxqne","75wszyfkeptb4zr63z84e9koy3e"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412211	1675955412211	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
c4dc75947tjn5mem7kzzpgqnswh	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["a8mj5x4thmtbi8jxh51jhq9u7iw","a8w7wz49bb78qxydiw5i398u7sy","7sbu99dbrabgj5bxyqe5c47ztqa"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412223	1675955412223	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
crq3aeiaa8frsmdbaox76xiapmc	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["agr7xb7krnfyifg6yua5z86k4th"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412232	1675955412231	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cbby4rxqas3fxxpeso3quj6s1wy	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412240	1675955412240	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
v9yh48g8pk3r6ico6sdomybkj5r	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675955412247	1675955412247	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
vjy9kijzb53rqmdmszg5nii5nue	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cchc3zymfa3f5mktpoiqo4nbzsr","ccq3ukx8c8bgo9x49g8q851froe","c4dc75947tjn5mem7kzzpgqnswh","crq3aeiaa8frsmdbaox76xiapmc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675955412252	1675955412252	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7bh94nigoqtgyjgdtk7xan14t4h	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Utilities	{"value":true}	1675955412257	1675955412257	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7kx1socx6mjgwxksy1nmnu8hbky	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Mobile phone	{"value":true}	1675955412261	1675955412261	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7mazt3mp5yfbdfkgh7iy4upqccy	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Internet	{"value":true}	1675955412266	1675955412266	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7zmwfuc7jqiysupcxdmncgdxqne	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Cereal	{"value":false}	1675955412271	1675955412271	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7wi6nur6ysig43x8yntx1atf13y	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Butter	{"value":false}	1675955412276	1675955412276	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7gui4597mfbyqmgbrenwcu4apja	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bread	{"value":false}	1675955412281	1675955412281	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
76x94fpy89brh8jsjip3eepyb6c	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Milk	{"value":false}	1675955412285	1675955412285	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
75wszyfkeptb4zr63z84e9koy3e	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bananas	{"value":false}	1675955412291	1675955412291	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7oq6wa91e1jnqxfhnshadyqwana	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Eggs	{"value":false}	1675955412296	1675955412296	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a54rpf4qjypbpdkdnraatck173h	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	text	## Grocery list	{}	1675955412300	1675955412300	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7sbu99dbrabgj5bxyqe5c47ztqa	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675955412306	1675955412306	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8mj5x4thmtbi8jxh51jhq9u7iw	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675955412310	1675955412310	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8w7wz49bb78qxydiw5i398u7sy	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Route	{}	1675955412315	1675955412315	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
agr7xb7krnfyifg6yua5z86k4th	2023-02-09 15:10:12.186101+00	crq3aeiaa8frsmdbaox76xiapmc	1	text		{}	1675955412322	1675955412322	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cz4wzottsq3dpubozjfty9o4ciw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["aoun6pu8ahbgbdryiwihaf5g7kw","7kzqxyu34tbn4igsiaabt7yusnh","ak6b15yexfbdjbkbgb1qsb37bwo","71oe5g19kwtr65d43ydcfyaquma","7nqstxcxk97gfdq4kug4us1b6my","7p3whtqf9cpnbuygpkfsutwheoo","76z5c5whtetgo3frgooosey8kgw"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675955413003	1675955413003	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c4mkyqpdicprz7mwj3hhnuw8ngc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a76yjexz653d9pn58r7wmfsf7pw","7b3bgpbw3pjgcibq8ghzdqhnqkc","ap7b19me84b8zzq6oknt89cwtxr","7uzdep7j5rbrnzrnugyojjqa43h","7ueynnzbbwp8xbk73848ipjaerr","7qwpifwt5hp87ukgmwusuqbtppa","7pe4oiok7zbdajbz9ryt57qksbo"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413009	1675955413009	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cper74m1sojfhpgur1xhwynxfiy	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["ae87wjndr9pnijcmi6hc5wb59re","7skzimbdzbpbq5kforgshzs61kw","ajut4tttrqbnmbp17wkag5omfxy","76sisungewinx7qgn6njki4ticy","7gfdcsb1poj8f5qp7r3h6pe4b1y","7pqf6oazaz3r3fcfdhe8f566prh","79qz9ycustfdhiqoejuc64jbjuy"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413015	1675955413015	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cd6qe9kcu8tny3qk1q166ieq7ca	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["abdket889k3gqjgyapdtwdyrrma","7i5s3bpukbbri5fgi6fqj8hm8ya","aq35hqbaejb8iie6wit8itohs5c","7e1o55mq96py68xhxrpppfpdc5w","73zjyyew9dfbatkcgyp4zg77gmw","7d1eaa4nzcjd9jbo69mcoru8ape","7z54jn3njybgsbf8qtppxtz1zmo"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413019	1675955413019	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c1zftz5wzmiditnznpqken4saxc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["ae1mquzi61p8qufeuyb9tducnuy","74t5gy1zgujrtjrhiohjrobchqw","afisf71n8n3r49jcapjxbbj3qoh","7m3f5jyj7sjfbjmwxdp5oein9qr","7jy5wgugfjfy53ccqd67c35tchr","73f1jioomr3ryzrrp5h79ce3xde","7jy5gzxjmoiyb3kjxi6xfr4enyh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413027	1675955413027	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vqikjy5xq5bynxrsw7z8jnwzr7c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413052	1675955413052	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v1ihhkqej8brfbbthmm8j1b111c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz4wzottsq3dpubozjfty9o4ciw","c1zftz5wzmiditnznpqken4saxc","c4mkyqpdicprz7mwj3hhnuw8ngc","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413058	1675955413058	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vsqznqhthm7dstpj4jxpeifppyw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["c4mkyqpdicprz7mwj3hhnuw8ngc","c1zftz5wzmiditnznpqken4saxc","cz4wzottsq3dpubozjfty9o4ciw","cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413067	1675955413067	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v8iq8y5gb6pd65n5iudaoegkc8a	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955413081	1675955413081	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
71oe5g19kwtr65d43ydcfyaquma	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 1]	{"value":false}	1675955413085	1675955413085	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7nqstxcxk97gfdq4kug4us1b6my	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 2]	{"value":false}	1675955413107	1675955413107	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7kzqxyu34tbn4igsiaabt7yusnh	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	divider		{}	1675955413110	1675955413110	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76z5c5whtetgo3frgooosey8kgw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	...	{"value":false}	1675955413112	1675955413112	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ak6b15yexfbdjbkbgb1qsb37bwo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Checklist	{}	1675955413117	1675955413117	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aoun6pu8ahbgbdryiwihaf5g7kw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Description\n*[Brief description of this task]*	{}	1675955413120	1675955413120	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7ueynnzbbwp8xbk73848ipjaerr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 2]	{"value":false}	1675955413122	1675955413122	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pe4oiok7zbdajbz9ryt57qksbo	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	...	{"value":false}	1675955413134	1675955413134	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7uzdep7j5rbrnzrnugyojjqa43h	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 1]	{"value":false}	1675955413141	1675955413141	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7qwpifwt5hp87ukgmwusuqbtppa	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 3]	{"value":false}	1675955413162	1675955413162	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7b3bgpbw3pjgcibq8ghzdqhnqkc	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	divider		{}	1675955413188	1675955413188	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ap7b19me84b8zzq6oknt89cwtxr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Checklist	{}	1675955413203	1675955413203	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
a76yjexz653d9pn58r7wmfsf7pw	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413234	1675955413234	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
79qz9ycustfdhiqoejuc64jbjuy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	...	{"value":false}	1675955413238	1675955413238	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7gfdcsb1poj8f5qp7r3h6pe4b1y	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 2]	{"value":false}	1675955413243	1675955413243	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7skzimbdzbpbq5kforgshzs61kw	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	divider		{}	1675955413247	1675955413247	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pqf6oazaz3r3fcfdhe8f566prh	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 3]	{"value":false}	1675955413258	1675955413258	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76sisungewinx7qgn6njki4ticy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 1]	{"value":false}	1675955413263	1675955413263	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae87wjndr9pnijcmi6hc5wb59re	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Description\n*[Brief description of this task]*	{}	1675955413268	1675955413268	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ajut4tttrqbnmbp17wkag5omfxy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Checklist	{}	1675955413273	1675955413273	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7i5s3bpukbbri5fgi6fqj8hm8ya	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	divider		{}	1675955413279	1675955413279	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e1o55mq96py68xhxrpppfpdc5w	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 1]	{"value":false}	1675955413285	1675955413285	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7d1eaa4nzcjd9jbo69mcoru8ape	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 3]	{"value":false}	1675955413291	1675955413291	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7z54jn3njybgsbf8qtppxtz1zmo	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	...	{"value":false}	1675955413295	1675955413295	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73zjyyew9dfbatkcgyp4zg77gmw	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 2]	{"value":false}	1675955413304	1675955413304	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aq35hqbaejb8iie6wit8itohs5c	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Checklist	{}	1675955413318	1675955413318	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abdket889k3gqjgyapdtwdyrrma	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Description\n*[Brief description of this task]*	{}	1675955413333	1675955413333	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5gzxjmoiyb3kjxi6xfr4enyh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	...	{"value":false}	1675955413338	1675955413338	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73f1jioomr3ryzrrp5h79ce3xde	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 3]	{"value":false}	1675955413343	1675955413343	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
74t5gy1zgujrtjrhiohjrobchqw	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	divider		{}	1675955413359	1675955413359	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5wgugfjfy53ccqd67c35tchr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 2]	{"value":false}	1675955413363	1675955413363	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7m3f5jyj7sjfbjmwxdp5oein9qr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 1]	{"value":false}	1675955413369	1675955413369	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae1mquzi61p8qufeuyb9tducnuy	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413377	1675955413377	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
afisf71n8n3r49jcapjxbbj3qoh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Checklist	{}	1675955413405	1675955413405	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76azhipbobfygfynia6zacn9w3o	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675955413408	1675955413408	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7mb6ctqe7pfrtbedqcco1cubphw	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675955413413	1675955413413	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jditmempbfbwjf5qcqsen8jrjr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675955413418	1675955413418	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
785gjigqkdif5jf3eu11aubu45h	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675955413423	1675955413423	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e5qw6opfzpnxxdzuow1futiuch	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675955413441	1675955413441	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
acqyxd35m8jgmice6s8zu7r5p3w	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675955413455	1675955413455	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abcywf8z4midn9mt3qcmufk8tmr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675955413461	1675955413461	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vz8mbztwmdtyddeqoecmudbhf4y	2023-02-09 15:10:14.174793+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414182	1675955414182	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
vzs4utd66mig95xj9aon575y7mo	2023-02-09 15:10:14.174793+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414186	1675955414185	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ch8r4zp93di899kf58zrexgx8do	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675955414192	1675955414192	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ckiw38hhaz7dz9j817znsydproy	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675955414198	1675955414198	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cfn4r8fnn37ysfe69imeisb9n7r	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414209	1675955414209	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c7wiascn8wpn3xkhkq8xmkqe8tc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414222	1675955414222	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cm8zp8a7jp3gezbg3x375hbahye	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414237	1675955414237	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1yangmadqbyqddpcnz51mzb1dc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414244	1675955414244	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cbrnxdi4457dduryz6qpynu5ynr	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414250	1675955414249	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1kzebdkek3ntixdj5of7q57pya	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414260	1675955414260	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
7o9ksmt3jktribytdp9putspe4e	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675955414703	1675955414703	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v5kjrsy165t85um9997ir99bjxh	2023-02-09 15:10:14.174793+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675955414270	1675955414270	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c3kb3yi7xob87xrscc561s3tkmh	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414451	1675955414451	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cogh3eo3tg7d9umaa5b7rjteejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675955414456	1675955414456	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cif69jfjjyfdq9y6kmz6g36mc5a	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414461	1675955414461	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cpqd9prb7ij8x98bfoaubgbkbfy	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675955414467	1675955414467	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
v6ghe65mhd3fatfmn8r4mkmpejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675955414476	1675955414476	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vt6x1h6sacibh3cchs3tea6du9w	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955414486	1675955414486	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
ve6nrxk4a6trupk94tfw8oxgutw	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675955414493	1675955414493	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vu77og8uegir6fqcd97psqyuabo	2023-02-09 15:10:14.585839+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cc9a5jhgow7njpft3ywtffsz78c","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675955414600	1675955414600	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cc9a5jhgow7njpft3ywtffsz78c	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["awzojrhtdh3nr5psizhywihzzgh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414605	1675955414605	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfcj6p6y8rpn9tnezxe9bmsnmrh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["a6znekksdmpgmjedazsggqn1egh","apejdcik6kfn4fpdzixe485b7ae","76mot8uwo8jyatk53897g4oatca"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414611	1675955414611	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cxy8tneoo8b885jtn4zfqp5xona	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aposk4q1ze3yozq4i1h9b6gjcbe","ahohrhxsoxjdmmp8igah5otrsho","7o9ksmt3jktribytdp9putspe4e"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955414618	1675955414618	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cjwq1mmub3fbx9xidzmj1jth7dh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["acx4qi4iqi3dgbgxe13rndfcxew"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414623	1675955414623	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cawustaeu8pftmf4m4pfqya7k5h	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["aghhoq7neoirsbqq1b5r3m8knih"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414629	1675955414629	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfxdu38pf57f98nmq8jj1fbtqja	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["adxhwp1jo67yxzczyc4p5ywxkmr","aq6rch5gsb3ne8cmqcp56ery9so","7q7j6yp8etpbktptcwtxefck6iw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414634	1675955414634	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cn3ox8hrrutgtbnhoebu7fqgzdy	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ar9whaq5zjifr8rq61a3e5pkyfa"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414639	1675955414639	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
c49q5wfok97ghujoyxiaqitzdry	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["akgpkj8rmabby58uyeyag9stijw"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414645	1675955414645	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
casdocyctotyajr5mb6kehetz1a	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["au7ctdfpqgtrf3xksx398ux3e5h"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414649	1675955414649	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
chcs5bmiyftf1fjfpiaoeewpgba	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["aip8b45tfj3bp3dduxap3wn7g1a"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414655	1675955414655	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
voi8jzi41yiyrucj1sh61s8tm6w	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["casdocyctotyajr5mb6kehetz1a","cfcj6p6y8rpn9tnezxe9bmsnmrh","cjwq1mmub3fbx9xidzmj1jth7dh","cxy8tneoo8b885jtn4zfqp5xona","cn3ox8hrrutgtbnhoebu7fqgzdy","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414660	1675955414660	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v7j16qap9ctfzibq6zgg66b5hay	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["cxy8tneoo8b885jtn4zfqp5xona","cjwq1mmub3fbx9xidzmj1jth7dh","cn3ox8hrrutgtbnhoebu7fqgzdy","cfcj6p6y8rpn9tnezxe9bmsnmrh","casdocyctotyajr5mb6kehetz1a","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414677	1675955414677	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
awzojrhtdh3nr5psizhywihzzgh	2023-02-09 15:10:14.585839+00	cc9a5jhgow7njpft3ywtffsz78c	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414683	1675955414683	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
76mot8uwo8jyatk53897g4oatca	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414688	1675955414688	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
a6znekksdmpgmjedazsggqn1egh	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414694	1675955414694	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
apejdcik6kfn4fpdzixe485b7ae	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414699	1675955414699	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aposk4q1ze3yozq4i1h9b6gjcbe	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414707	1675955414707	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ahohrhxsoxjdmmp8igah5otrsho	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414712	1675955414712	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
acx4qi4iqi3dgbgxe13rndfcxew	2023-02-09 15:10:14.585839+00	cjwq1mmub3fbx9xidzmj1jth7dh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414717	1675955414717	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
abs7abu751bbbjczo3e9j9kyssw	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414722	1675955414722	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adaiaeiqjrfbf3xekijke57ggco	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414728	1675955414728	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aghhoq7neoirsbqq1b5r3m8knih	2023-02-09 15:10:14.585839+00	cawustaeu8pftmf4m4pfqya7k5h	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414733	1675955414733	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
7q7j6yp8etpbktptcwtxefck6iw	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414738	1675955414738	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adxhwp1jo67yxzczyc4p5ywxkmr	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414744	1675955414744	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aq6rch5gsb3ne8cmqcp56ery9so	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414750	1675955414750	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ar9whaq5zjifr8rq61a3e5pkyfa	2023-02-09 15:10:14.585839+00	cn3ox8hrrutgtbnhoebu7fqgzdy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414756	1675955414756	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
akgpkj8rmabby58uyeyag9stijw	2023-02-09 15:10:14.585839+00	c49q5wfok97ghujoyxiaqitzdry	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414761	1675955414761	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
au7ctdfpqgtrf3xksx398ux3e5h	2023-02-09 15:10:14.585839+00	casdocyctotyajr5mb6kehetz1a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414766	1675955414766	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aip8b45tfj3bp3dduxap3wn7g1a	2023-02-09 15:10:14.585839+00	chcs5bmiyftf1fjfpiaoeewpgba	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414771	1675955414771	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
vq5gp9utjdfgaxfzyoh1xbiyieh	2023-02-09 15:10:15.027456+00		1	view	All Users	{"cardOrder":["cmunfwxy6kif48jhg8g8do7wnpy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675955415037	1675955415037	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cmunfwxy6kif48jhg8g8do7wnpy	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["apd8tm8d9838fbczp1a5exi6nde"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675955415043	1675955415043	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
ceo3xece5mid4jjwaoqfs51xqch	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["a66wqjsz1yp87pb3k5sc355cpuy"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415048	1675955415048	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aogf1khixcifedyhnnxb8y5cs9a	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675955416752	1675955416752	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cwb6qiq5p4pgmfjnk95xz13rx4h	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a9xsae5aqafrbixp9gwjwpbqb3r"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675955415054	1675955415054	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
co7xboyn5mfgatfdpye6nhj8ntw	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aitj1uj1gytfytcxxkarzf7z1sh"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415059	1675955415059	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
c7jc13yp69bfh5q3inet8r7jqso	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["azqotjxjdhj8r7r89r9wu3jyxby"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675955415065	1675955415065	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vcnu6wcrtrpr1umz6oeyq5kpfzr	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415072	1675955415072	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vi47u17fbjjbzjmdcu8z9fke64o	2023-02-09 15:10:15.027456+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675955415107	1675955415107	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
apd8tm8d9838fbczp1a5exi6nde	2023-02-09 15:10:15.027456+00	cmunfwxy6kif48jhg8g8do7wnpy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415117	1675955415117	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a66wqjsz1yp87pb3k5sc355cpuy	2023-02-09 15:10:15.027456+00	ceo3xece5mid4jjwaoqfs51xqch	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415123	1675955415123	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a9xsae5aqafrbixp9gwjwpbqb3r	2023-02-09 15:10:15.027456+00	cwb6qiq5p4pgmfjnk95xz13rx4h	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415129	1675955415129	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aitj1uj1gytfytcxxkarzf7z1sh	2023-02-09 15:10:15.027456+00	co7xboyn5mfgatfdpye6nhj8ntw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415134	1675955415134	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
azqotjxjdhj8r7r89r9wu3jyxby	2023-02-09 15:10:15.027456+00	c7jc13yp69bfh5q3inet8r7jqso	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415137	1675955415137	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cc6jo65tkri8kxfy85rpyg9r8de	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","ah8cy7eza9tba5pmk3qfdn4ngfo"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675955415566	1675955415566	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
c95jy6ztp3t8pinfsftu93bs6uh	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ard5i9e86qjnppf8zzttwiqdsme","aogzjxtgjt38upneka4fjk7f6hh","abdasiyq4k7ndtfrdadrias8sjy","7h6rn8yhjp7bm9q4sac8hinx8ge"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675955415576	1675955415576	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cf735gnmxwbdrd885z11f19rbyw	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","apsnwcshioid6uca7ugj36paj7y"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415586	1675955415586	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cjfsfemn88jfx7xutwd7jwfrubo	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","aqwxfnfpu9p81zxum4kyy36faso"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415591	1675955415591	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7egzqwfr9n3gqjq6yrs9powrjby	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675955416755	1675955416755	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vywt3ibumzp8tdg4wm67j5km7ma	2023-02-09 15:10:15.260316+00		1	view	Competitor List	{"cardOrder":["cinzhmm4ixiry8p5uchukeyjxuy","c43hjyntaxi8hup6dykbx4iik4h","ci6ss4aksnir9ukm1ycpbcnxihr","cptd3wkf6tt8oiq891pwj6frbbh","cf1fyfb97p7rumpmtedzawkzp4r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675955415270	1675955415270	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
vr7jn5u1b7tnjmjw6tnrkxnx7uc	2023-02-09 15:10:15.260316+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675955415276	1675955415276	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cinzhmm4ixiry8p5uchukeyjxuy	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["apypqwuyws7dxzj3g3fwk8atdse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675955415280	1675955415280	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
c43hjyntaxi8hup6dykbx4iik4h	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["az9nkkcazeiruicczj15tot913a"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675955415284	1675955415284	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
ci6ss4aksnir9ukm1ycpbcnxihr	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["asge3fu3t6inhjbz3muc4expd9c"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675955415290	1675955415290	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cf1fyfb97p7rumpmtedzawkzp4r	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a48dxo8rjrpna7ke391tmepk37c"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675955415295	1675955415295	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cptd3wkf6tt8oiq891pwj6frbbh	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["acuyiteaixfncprpfxb6p9q65xc"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675955415301	1675955415301	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
apypqwuyws7dxzj3g3fwk8atdse	2023-02-09 15:10:15.260316+00	cinzhmm4ixiry8p5uchukeyjxuy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415306	1675955415306	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
az9nkkcazeiruicczj15tot913a	2023-02-09 15:10:15.260316+00	c43hjyntaxi8hup6dykbx4iik4h	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415316	1675955415316	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
asge3fu3t6inhjbz3muc4expd9c	2023-02-09 15:10:15.260316+00	ci6ss4aksnir9ukm1ycpbcnxihr	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415329	1675955415329	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
a48dxo8rjrpna7ke391tmepk37c	2023-02-09 15:10:15.260316+00	cf1fyfb97p7rumpmtedzawkzp4r	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675955415342	1675955415342	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
arqrzjjesiirobdw5t97yrnax1a	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675955416173	1675955416173	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
acuyiteaixfncprpfxb6p9q65xc	2023-02-09 15:10:15.260316+00	cptd3wkf6tt8oiq891pwj6frbbh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415347	1675955415347	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cyhsodm36cbdh8q7kxm1j1gr8yw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","aowo8igj7rtnp7mwapij7s3o3xa","aej4ic8nk8td7zebzhmhfh9wu6y","7xt8yx9f49jbxbpkhjce5pi5g7o"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955416001	1675955416001	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cxjt8ekj8yfratx83ukjr1nt5dw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a8xtbuofra3yyf8dms1mknwen3r"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416006	1675955416006	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cut844cdxxj86xqyrs9ctgecfme	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","ab6dzethdibbmfpwqwe5hx98pga"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416011	1675955416011	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ccoro58a94idw8mdo9k5rx3dx4h	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a66nc7e11k78e9gm4hfude4z6dr"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416016	1675955416016	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c13uy7qkt57gapqc3qp61bhyjqr	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["afw5i81na7id4jfw1wzb1qc7o6e"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955416022	1675955416022	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
czwsifj8cm7fabf6asnhc8fugho	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["azexrsotg53bp7xrf7zjogmk1fo","am796mc4hafgy7dc95e41hwfrmw","7csaz76fn9fgabquxp54stmjbne"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416028	1675955416028	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
v9d4nczqqmtri8mb6m83qj7j9oo	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416036	1675955416035	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vrtqx3uxamfynjd7ojjm8mcu3ty	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cxjt8ekj8yfratx83ukjr1nt5dw","cut844cdxxj86xqyrs9ctgecfme","czwsifj8cm7fabf6asnhc8fugho","ccoro58a94idw8mdo9k5rx3dx4h","c13uy7qkt57gapqc3qp61bhyjqr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416048	1675955416047	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vgf1tx6hdcfg4bnj1fpgkyfdnno	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416057	1675955416057	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
azexrsotg53bp7xrf7zjogmk1fo	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416158	1675955416158	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vy4rzknwe5bdrbd8kg5sfaq7rcy	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675955415596	1675955415596	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vf1ywowszz3bktg6rzbj8x5w9qc	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415602	1675955415602	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vca7xj7s8d3fpu856mw15dw1o8o	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415607	1675955415607	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
v6jmwqbs8hjrkipcqhjgcxyn9ge	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675955415613	1675955415613	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ah8cy7eza9tba5pmk3qfdn4ngfo	2023-02-09 15:10:15.523642+00	cc6jo65tkri8kxfy85rpyg9r8de	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415619	1675955415619	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7h6rn8yhjp7bm9q4sac8hinx8ge	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675955415624	1675955415624	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ard5i9e86qjnppf8zzttwiqdsme	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415630	1675955415630	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aogzjxtgjt38upneka4fjk7f6hh	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Media	{}	1675955415634	1675955415634	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
akta9uxe6pp8gtbmbunotw87m3r	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415639	1675955415639	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsogn1m3ifrc9qsxzesijqcjdc	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675955415644	1675955415644	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ap7a7kupzfffomn6sxkw73yqjmy	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415649	1675955415649	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsnwcshioid6uca7ugj36paj7y	2023-02-09 15:10:15.523642+00	cf735gnmxwbdrd885z11f19rbyw	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415655	1675955415655	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aqwxfnfpu9p81zxum4kyy36faso	2023-02-09 15:10:15.523642+00	cjfsfemn88jfx7xutwd7jwfrubo	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415660	1675955415660	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vcqxizj9q6ibjxf4f7wkyrjqzoa	2023-02-09 15:10:15.867257+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675955415876	1675955415876	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
ceesyxk3sy38tidayxrqw8etwth	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675955415882	1675955415882	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmptymjj19b8xjdzzksdhuytehy	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415888	1675955415888	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmi544mdhx7yufmibt1cmatep6a	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675955415893	1675955415893	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
c4p4skb74yjgwjc3ke1jd5tekrr	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675955415899	1675955415899	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cqngo6k4i4b8pfb9enafb3hwhyw	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415904	1675955415904	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
vew7eb6b56fn8mk91duwjxdohar	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416064	1675955416064	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vdkcaex5b6tfy9gwkffyhczg8dy	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416071	1675955416071	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7xt8yx9f49jbxbpkhjce5pi5g7o	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675955416077	1675955416077	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aowo8igj7rtnp7mwapij7s3o3xa	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416085	1675955416085	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aej4ic8nk8td7zebzhmhfh9wu6y	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416091	1675955416091	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a8xtbuofra3yyf8dms1mknwen3r	2023-02-09 15:10:15.990252+00	cxjt8ekj8yfratx83ukjr1nt5dw	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416097	1675955416097	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ab6dzethdibbmfpwqwe5hx98pga	2023-02-09 15:10:15.990252+00	cut844cdxxj86xqyrs9ctgecfme	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416102	1675955416102	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsq6tift1pg43cqxh6ptkf8s4a	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416107	1675955416107	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a7qy7p9y4qbgwim4qheaoyh56se	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675955416113	1675955416113	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
asqe7das383fd8bsg6ki5k3j5de	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675955416119	1675955416119	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
agsg7r9qcppnjmbm4io1zxkqpfe	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675955416123	1675955416123	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a66nc7e11k78e9gm4hfude4z6dr	2023-02-09 15:10:15.990252+00	ccoro58a94idw8mdo9k5rx3dx4h	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416128	1675955416128	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a1dihou959jr7trof8zpknymz3h	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416134	1675955416134	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ahbfddu6t6i8mzmtsdmedda4tgh	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675955416138	1675955416138	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
afw5i81na7id4jfw1wzb1qc7o6e	2023-02-09 15:10:15.990252+00	c13uy7qkt57gapqc3qp61bhyjqr	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955416144	1675955416144	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7csaz76fn9fgabquxp54stmjbne	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416149	1675955416149	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
am796mc4hafgy7dc95e41hwfrmw	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416154	1675955416154	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsow3b1arbrnzmjybgu9axwtte	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675955416743	1675955416743	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aszhiqtytuty4888t8dii87td1w	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675955416179	1675955416179	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c5wz7jz8at3gx8brn8jcz7u3ujh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aanpn1chdbirddfu4obqi3rieew"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416560	1675955416560	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
c561c93bfjjyp7gsda4qk6d9dca	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["azz8hdz4357fq8fwghbqz7e88ww","71wbc54cp57yw5x84ih1u7b3bxw","7zudf4ytye3y69dtwtfkagbi7zh","784uu3ufcgb878ky7hyugmf6xcw","7kc44wypp1jnzmm3qh7ocx3t69e","7w4sjknti5pyd5kbkpoba1tkf8h","7gr65cgf58bgzmfun9odcmk14hr","7nb8y7jyoetro8cd36qcju53z8c","7413u4xnrebnf5gypfbzc3yokce","7htefhgxktin4fnfcac7ncuty3a","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7ny8o9rq7e3rsbyoogjmgetgspa"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416566	1675955416566	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ct5kpq5rgqidtik98waz1m5fdqo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["at1gc3nj44pfmtchdhm463rsugr","atkhpnbj8qjgyzyac48o36u4xpw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7qp41kosg67bkbppoqt1c64yu6h"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416570	1675955416570	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
chwbzoteop38obrffjnbye8kkph	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aj9qonaknubbcjc3txbjxqo5y7a","aqop7km57rpnpmfg6mro767ukaa","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7j9bhj4sh8iytxpnu1o1gpfyh6o"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416574	1675955416574	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
crkth4zwoppf6me17xb1sf7m7wr	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["aogf1khixcifedyhnnxb8y5cs9a","adhsx4h5ss7rqdcjt8xyam6xtqc","a1enn3jnusffjuc4ciqrfc197fr","7me9p46gbqiyfmfnapi7dyxb5br","7nsow3b1arbrnzmjybgu9axwtte"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416580	1675955416579	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cafahsprdajymd83b1dzr4sj91w	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["akr4w845sp3dgty4cayg6wrz96a","ai4qtbj8quiywfxdrorts7dsf3h","aoe9xan7bat8imn45t4x4knq11e","7egzqwfr9n3gqjq6yrs9powrjby"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416595	1675955416595	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
copdhfsz6e3gg3yqcofmw7uc8ah	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","ac97q9macgtgg8nawsmwyhsbwca","78i8aqjmqtibr7x4okhz6uqquqr","714ymz3mujfdi9c1u56g5hsw8bh"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416605	1675955416605	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cdy86cwon13n85k1498uqgckjmo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","agzxxkj19tfd5zxwje151ma8d4w","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7xbpdkw5rdtgfjrajorxz9z1m5a"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416610	1675955416610	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ccosx7u14o3b9bngcrskhb59umo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["aaj9oncuimtfeigzof3jn3j1kka","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7u7omjjrqmpfwzghn1jsa4ha47w"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416615	1675955416615	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cd1hudbdx63dt7mym7hxee6kzrc	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["ay7zz768zs7gb5e1h8qximpwq9a","an3ts498ri7bwffx31agx89zzuw","7mbw9t71hjbrydgzgkqqaoh8usr","7ttgph9jfotfxzphrb1wmyjzw1c"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416619	1675955416619	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
a1enn3jnusffjuc4ciqrfc197fr	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675955416748	1675955416748	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vknytio9am3r1ip5xkn179ymuac	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675955416625	1675955416625	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vprztdsecdb888pw11kzogsysde	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416633	1675955416633	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vyc7c3kwj6ibn7y8cr6rqwdtjwo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416640	1675955416640	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vuiygiikw4bywbyxto8n4ekg8gh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["crkth4zwoppf6me17xb1sf7m7wr","c561c93bfjjyp7gsda4qk6d9dca","ct5kpq5rgqidtik98waz1m5fdqo","cafahsprdajymd83b1dzr4sj91w","ccosx7u14o3b9bngcrskhb59umo","cdy86cwon13n85k1498uqgckjmo","cd1hudbdx63dt7mym7hxee6kzrc","c5wz7jz8at3gx8brn8jcz7u3ujh","chwbzoteop38obrffjnbye8kkph","copdhfsz6e3gg3yqcofmw7uc8ah"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675955416646	1675955416646	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aanpn1chdbirddfu4obqi3rieew	2023-02-09 15:10:16.551755+00	c5wz7jz8at3gx8brn8jcz7u3ujh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675955416652	1675955416652	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7kc44wypp1jnzmm3qh7ocx3t69e	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Assign tasks to teammates	{"value":false}	1675955416657	1675955416657	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ny8o9rq7e3rsbyoogjmgetgspa	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675955416664	1675955416664	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7w4sjknti5pyd5kbkpoba1tkf8h	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675955416670	1675955416670	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7413u4xnrebnf5gypfbzc3yokce	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675955416675	1675955416675	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
71wbc54cp57yw5x84ih1u7b3bxw	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Set priorities and update statuses	{"value":false}	1675955416681	1675955416681	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7gr65cgf58bgzmfun9odcmk14hr	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675955416687	1675955416687	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7htefhgxktin4fnfcac7ncuty3a	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675955416693	1675955416693	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7zudf4ytye3y69dtwtfkagbi7zh	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Manage deadlines and milestones	{"value":false}	1675955416701	1675955416700	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
azz8hdz4357fq8fwghbqz7e88ww	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675955416707	1675955416707	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7qp41kosg67bkbppoqt1c64yu6h	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675955416713	1675955416713	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
at1gc3nj44pfmtchdhm463rsugr	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675955416717	1675955416717	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
atkhpnbj8qjgyzyac48o36u4xpw	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675955416722	1675955416722	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7j9bhj4sh8iytxpnu1o1gpfyh6o	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675955416728	1675955416728	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aj9qonaknubbcjc3txbjxqo5y7a	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675955416733	1675955416733	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aqop7km57rpnpmfg6mro767ukaa	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675955416738	1675955416738	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aoe9xan7bat8imn45t4x4knq11e	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675955416760	1675955416760	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ai4qtbj8quiywfxdrorts7dsf3h	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675955416765	1675955416765	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
akr4w845sp3dgty4cayg6wrz96a	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675955416769	1675955416769	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
714ymz3mujfdi9c1u56g5hsw8bh	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675955416774	1675955416774	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ac97q9macgtgg8nawsmwyhsbwca	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675955416779	1675955416779	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7xbpdkw5rdtgfjrajorxz9z1m5a	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675955416783	1675955416783	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
agzxxkj19tfd5zxwje151ma8d4w	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675955416786	1675955416786	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7u7omjjrqmpfwzghn1jsa4ha47w	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675955416790	1675955416790	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aaj9oncuimtfeigzof3jn3j1kka	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675955416794	1675955416794	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ttgph9jfotfxzphrb1wmyjzw1c	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675955416799	1675955416799	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
an3ts498ri7bwffx31agx89zzuw	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675955416803	1675955416803	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ay7zz768zs7gb5e1h8qximpwq9a	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675955416807	1675955416807	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
\.


--
-- Data for Name: focalboard_blocks_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_blocks_history (id, insert_at, parent_id, schema, type, title, fields, create_at, update_at, delete_at, root_id, modified_by, channel_id, created_by, board_id) FROM stdin;
czebhwzawapy55jy4qxmozzo4cr	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Team Schedule	{"contentOrder":["axpbptk9grbrhzdq9rodcqgomra","7dzinn6e9fpri3chki7e71xs8yh","ayarazd7asb8ozkksuxy5351aqh","7196jqjcy8jn7bmsod7ythqpamw","7omaahugkcfdhp8xohiy1d7iniy","7pwy6b4y9qtde9mayz9t576wzbo"],"icon":"⏰","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410132	1675955410132	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
caaryyfj35iyo9q7ukein9jiu4e	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Video production	{"contentOrder":["aiwph7zdhpjbombd49uom6p5qxy","7yd3axyrhzbyh3x9qozk5qtbsrh","ai93zq6uonfrf7gjibrwatofmiy","79u5d4yzqdjg65qgcpwbmob9fzo","7eqriuxcf87dh9frg5aiuc1bp9r","7hhgoyez5etb7mpptkrdq75dghe"],"icon":"📹","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"34eb9c25-d5bf-49d9-859e-f74f4e0030e7"}}	1675955410138	1675955410138	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ctor6xdeexffg8xzqd76prxk1ge	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Offsite plans	{"contentOrder":["awjd7cdpaobfi7yofwb76szzdjw","7wgktjf58itbeddwexf15wbg59a","adc9tusigjj8rzqxbfo7s7uko6a","7hncbmdr4jpng3xb44yth4mmwma","7zcg6yc1dyjbwi8nys6916knsse","797gc7kuqubggbbth9tjb394r5c"],"icon":"🚙","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"8b05c83e-a44a-4d04-831e-97f01d8e2003","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"dabadd9b-adf1-4d9f-8702-805ac6cef602"}}	1675955410145	1675955410145	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
cbpyozo5n738dmq36auszr7twty	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	card	Social Media Strategy	{"contentOrder":["a7nrc4e58m3ru5puz4wswn1trdc","7dqzit6ec5t8ubbnf5pzarpuuja","aoudetcozh3yfmkqkq3cyhp9d8w","7xz74uk3bt3fu9y6spr7s69f8cc","7pbnkbqkjipb47cjxptp91ppz4c","7bqzsshop3pg9mka4h1tspz8ity"],"icon":"🎉","isTemplate":false,"properties":{"4cf1568d-530f-4028-8ffd-bdc65249187e":"b1abafbf-a038-4a19-8b68-56e0fd2319f7","d777ba3b-8728-40d1-87a6-59406bbbbfb0":"d37a61f4-f332-4db9-8b2d-5e0a91aa20ed"}}	1675955410150	1675955410150	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vkngsehpzdbf47g6pgp9fxz4o7a	2023-02-09 15:10:10.121663+00	b7wnw9awd4pnefryhq51apbzb4c	1	view	Discussion Items	{"cardOrder":["cjpkiya33qsagr4f9hrdwhgiajc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d777ba3b-8728-40d1-87a6-59406bbbbfb0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"4cf1568d-530f-4028-8ffd-bdc65249187e","reversed":false}],"viewType":"board","visibleOptionIds":[],"visiblePropertyIds":["4cf1568d-530f-4028-8ffd-bdc65249187e"]}	1675955410157	1675955410157	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7omaahugkcfdhp8xohiy1d7iniy	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410167	1675955410167	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7196jqjcy8jn7bmsod7ythqpamw	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410172	1675955410172	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dzinn6e9fpri3chki7e71xs8yh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	divider		{}	1675955410176	1675955410175	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pwy6b4y9qtde9mayz9t576wzbo	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	checkbox		{"value":false}	1675955410178	1675955410178	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
axpbptk9grbrhzdq9rodcqgomra	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410181	1675955410181	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ayarazd7asb8ozkksuxy5351aqh	2023-02-09 15:10:10.121663+00	czebhwzawapy55jy4qxmozzo4cr	1	text	## Action Items	{}	1675955410183	1675955410183	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7o4rz1o44gbf4zepkb4sqrmhwce	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	divider		{}	1675955410188	1675955410187	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pyuztkwto3b6irhdu7jcusoeqh	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410196	1675955410196	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7f1qymriaetf8fyqb6b88hn6syy	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410211	1675955410211	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
74g7zukwfhjgcfpugf4hxqcostc	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	checkbox		{"value":false}	1675955410221	1675955410221	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a5gpne7xtsjr37d8xxgu93bpyay	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Action Items	{}	1675955410243	1675955410243	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
afoajfa1w4brjbq3wpmguh61w7w	2023-02-09 15:10:10.121663+00	ch798q5ucefyobf5bymgqjt4f3h	1	text	# Notes\n*[Add meeting notes here]*	{}	1675955410251	1675955410251	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7yd3axyrhzbyh3x9qozk5qtbsrh	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	divider		{}	1675955410258	1675955410258	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hhgoyez5etb7mpptkrdq75dghe	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410264	1675955410264	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7eqriuxcf87dh9frg5aiuc1bp9r	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410268	1675955410268	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
79u5d4yzqdjg65qgcpwbmob9fzo	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	checkbox		{"value":false}	1675955410273	1675955410273	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
ai93zq6uonfrf7gjibrwatofmiy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Action Items	{}	1675955410277	1675955410277	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aiwph7zdhpjbombd49uom6p5qxy	2023-02-09 15:10:10.121663+00	caaryyfj35iyo9q7ukein9jiu4e	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410283	1675955410283	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7hncbmdr4jpng3xb44yth4mmwma	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410289	1675955410289	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7zcg6yc1dyjbwi8nys6916knsse	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410297	1675955410296	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7wgktjf58itbeddwexf15wbg59a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	divider		{}	1675955410303	1675955410302	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
797gc7kuqubggbbth9tjb394r5c	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	checkbox		{"value":false}	1675955410309	1675955410309	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
adc9tusigjj8rzqxbfo7s7uko6a	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Action Items	{}	1675955410314	1675955410314	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
awjd7cdpaobfi7yofwb76szzdjw	2023-02-09 15:10:10.121663+00	ctor6xdeexffg8xzqd76prxk1ge	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410320	1675955410320	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7dqzit6ec5t8ubbnf5pzarpuuja	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	divider		{}	1675955410326	1675955410326	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7pbnkbqkjipb47cjxptp91ppz4c	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410331	1675955410331	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7bqzsshop3pg9mka4h1tspz8ity	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410339	1675955410339	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
7xz74uk3bt3fu9y6spr7s69f8cc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	checkbox		{"value":false}	1675955410359	1675955410359	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
aoudetcozh3yfmkqkq3cyhp9d8w	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Action Items	{}	1675955410371	1675955410371	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
a7nrc4e58m3ru5puz4wswn1trdc	2023-02-09 15:10:10.121663+00	cbpyozo5n738dmq36auszr7twty	1	text	## Notes\n*[Add meeting notes here]*	{}	1675955410400	1675955410400	0	\N	system		system	bgrnqmugsw3gijk4i4iynp6b15o
vk8bc997m1bysubqa9zzpuikwmo	2023-02-09 15:10:10.921795+00		1	view	All Contacts	{"cardOrder":["c7n4qjbom77g5mxhapf6tmtcidw","cirqnetz9uf8ebpfrq68dx7sj1o","czb14t4y4gbf15ehgi9kpj6hyey","c71eyc8srz7gazgtp3hafyys1ba","c45s8knkw1jf79mfpkh4k1w39ko"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":240,"a1438fbbhjeffkexmcfhnx99o1h":151,"a5hwxjsmkn6bak6r7uea5bx1kwc":132,"abru6tz8uebdxy4skheqidh7zxy":247,"adtf1151chornmihz4xbgbk9exa":125,"aejo5tcmq54bauuueem9wc4fw4y":127,"ahf43e44h3y8ftanqgzno9z7q7w":129,"ainpw47babwkpyj77ic4b9zq9xr":157,"amahgyn9n4twaapg3jyxb6y4jic":224,"amba7ot98fh7hwsx8jdcfst5g7h":171,"aoheuj1f3mu6eehygr45fxa144y":130,"auhf91pm85f73swwidi4wid8jqe":157},"defaultTemplateId":"cxarr4qdxsi8u9jak7cc3yeikuh","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a5hwxjsmkn6bak6r7uea5bx1kwc","aoheuj1f3mu6eehygr45fxa144y","aro91wme9kfaie5ceu9qasmtcnw","ainpw47babwkpyj77ic4b9zq9xr","ahf43e44h3y8ftanqgzno9z7q7w","amahgyn9n4twaapg3jyxb6y4jic","abru6tz8uebdxy4skheqidh7zxy","a1438fbbhjeffkexmcfhnx99o1h","auhf91pm85f73swwidi4wid8jqe","adtf1151chornmihz4xbgbk9exa","aejo5tcmq54bauuueem9wc4fw4y","amba7ot98fh7hwsx8jdcfst5g7h"]}	1675955410931	1675955410931	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vcaht3fzu1p8czftchjwej9zdbh	2023-02-09 15:10:10.921795+00		1	view	Pipeline Tracker	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a","a5txuiubumsmrs8gsd5jz5gc1oa","acm9q494bcthyoqzmfogxxy5czy"],"visiblePropertyIds":["aro91wme9kfaie5ceu9qasmtcnw","amahgyn9n4twaapg3jyxb6y4jic"]}	1675955410934	1675955410934	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c71eyc8srz7gazgtp3hafyys1ba	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Jonathan Frazier	{"contentOrder":["akf5xjt9byinzfkeos6r6px8jbw","askua4mi95jy8bchwhybg8gfcse","7zu87byt3etrfjj4if6i7o9f5zw","7kwnrbo5c43gfjnpdoygghmfz5y","7n61tdes8updx7dgk4g1qmkqbnh","7iy8rn8s9ubdhxb9w43e5fmhuwh","7gx593y1kpif75xkrho74839yne","7kx16rigxffr9bezsar6dxammny","7uwrwbb9sa38j8d95d4ww8mypdw","7afgp343sijrc7gonf9qoy7556y","71gqjf96497fi9ryke93twwe7xh","77iiwbg3iufbkjp39xbytusm7fy"],"icon":"🙎‍♂️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(999) 123-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"a5txuiubumsmrs8gsd5jz5gc1oa","abru6tz8uebdxy4skheqidh7zxy":"jonathan.frazier@email.com","aejo5tcmq54bauuueem9wc4fw4y":"0%","ahf43e44h3y8ftanqgzno9z7q7w":"$800,000","ainpw47babwkpyj77ic4b9zq9xr":"Ositions Inc.","amahgyn9n4twaapg3jyxb6y4jic":"as5bk6afoaaa7caewe1zc391sce","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669118400000}"}}	1675955410936	1675955410936	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
czb14t4y4gbf15ehgi9kpj6hyey	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Richard Guzman	{"contentOrder":["afdi9nuij83bz9ywhkjsyorsika","ap8htxxgcnpgaxka4s11df59y5c","7cwxpmkp8d3y78e5t4t8aizh9ac","7f6prgh7etidefktxjadakro7de","79by87rm9i3ngfk95wxr4hcu8mw","7p31k115qpbyo5fefdqbwceunfo","7dizabc4pu78y8kknah8pckrpgw","7e8a3i33n8jnujrhb9im4u3f3bc","7pobi5s6iq3dhbktgrootac1h4h","73wnuh3ums7grtb58as6qdu1s7r","7czs3x5g5o7godjj9nwpmnc6dye","76fuqbbtu8pywjqqj1hgg4q9e8e"],"icon":"👨‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(222) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"axesd74yuxtbmw1sbk8ufax7z3a","abru6tz8uebdxy4skheqidh7zxy":"richard.guzman@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1681992000000}","aejo5tcmq54bauuueem9wc4fw4y":"80%","ahf43e44h3y8ftanqgzno9z7q7w":"$3,200,000","ainpw47babwkpyj77ic4b9zq9xr":"Afformance Ltd.","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667476800000}"}}	1675955410940	1675955410940	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c45s8knkw1jf79mfpkh4k1w39ko	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Byron Cole	{"contentOrder":["atyt9edm39tbtbnjddx5rt8mmda","a98wh64rrxtyumdfmo5dim8wikr","7pa48ejem6p8stdqhbbicqjj7cy","714ghubqyrpgd7nw34mh31ug79c","7i9im8g6b17nizpis19mmnn9ckh","78wczgiecq7dkjbau9r54izny9w","7n4b867c94tyymfg16gwoqj94fe","7fymoo4ywy3yg5gyh91ijm1tmuw","77p9joh3ajpg1tr6b385zidjbge","7164ftmhpnfdwu8gy3icogzpa8o","7w4tgym95obnjp8smfskq9iypcc","7bwix7j583irsdmre8a3ttqy31e"],"icon":"🤵","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(333) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"acm9q494bcthyoqzmfogxxy5czy","abru6tz8uebdxy4skheqidh7zxy":"byron.cole@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1667563200000}","aejo5tcmq54bauuueem9wc4fw4y":"100%","ahf43e44h3y8ftanqgzno9z7q7w":"$500,000","ainpw47babwkpyj77ic4b9zq9xr":"Helx Industries","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apjnaggwixchfxwiatfh7ey7uno","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1667822400000}"}}	1675955410943	1675955410943	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7czs3x5g5o7godjj9nwpmnc6dye	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Hand-off to customer success	{}	1675955411012	1675955411012	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73wnuh3ums7grtb58as6qdu1s7r	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Finalize contract	{}	1675955411015	1675955411015	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76fuqbbtu8pywjqqj1hgg4q9e8e	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Post-sales follow up	{}	1675955411019	1675955411019	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cirqnetz9uf8ebpfrq68dx7sj1o	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Caitlyn Russel	{"contentOrder":["auxx7ta8sktnsjmafar4n4ox7uh","auyp7cdhmbpyymefooaxte184nh","7ia67tegp7f8obj4yxtaa8d9whc","768tmcyaxypyrimxhbpqw5i1fpr","765g3gs41epfp9jrm6pm3o9ym3a","7qdcudfpn53b5i8mpe73odd8nwr","71sd6tycbyj8gjrxp1iin7pa7zr","7xgfqfh9fdffcpmg91rdj6d1tea","7kzfgicen5j8d7rwhzbq6o4cedr","7pur5woxchiymbppotiqc3epu8e","7pft7f9sj4jd3upimxkh7x8w87h","7qbk31ej6jjyrjjsqyeu9fmturc"],"icon":"🧑‍💼","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 123-1234","a5hwxjsmkn6bak6r7uea5bx1kwc":"ah6ehh43rwj88jy4awensin8pcw","abru6tz8uebdxy4skheqidh7zxy":"caitlyn.russel@email.com","adtf1151chornmihz4xbgbk9exa":"{\\"from\\":1689336000000}","aejo5tcmq54bauuueem9wc4fw4y":"20%","ahf43e44h3y8ftanqgzno9z7q7w":"$250,000","ainpw47babwkpyj77ic4b9zq9xr":"Liminary Corp.","amahgyn9n4twaapg3jyxb6y4jic":"aafwyza5iwdcwcyfyj6bp7emufw","aro91wme9kfaie5ceu9qasmtcnw":"apiswzj7uiwbh87z8dw8c6mturw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1668168000000}"}}	1675955410949	1675955410948	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
cxarr4qdxsi8u9jak7cc3yeikuh	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	New Prospect	{"contentOrder":["ahae77tk763dpmmeijk8nwjociw","awdkgnnej7tnb5yweq4psgm8smc","7axxtz7491tbzddsddkhr1okagw","79gysbkm967djicna43f88r9wpe","71prjd7h1ofy1tbfmwbcyjxkunw","7p4tj6cwryjnbjqu6dp5zbia8rr","7wu3q67edhi8ebgmjzjfiwsahyo","71q3bar1wm7y9tc51rd8j7fymor","779frbxrdd7gb7e1g1u1wcweqnc","7s7keem8eetrm5yguee6e48agee","7yipg3d9mtigbdq8z5h7r3f3wgy","7jyt49rqrwbf5udj38tqu4ea37a"],"icon":"👤","isTemplate":true,"properties":{"a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o"}}	1675955410953	1675955410953	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
c7n4qjbom77g5mxhapf6tmtcidw	2023-02-09 15:10:10.921795+00	bbkpwdj8x17bdpdqd176n8ctoua	1	card	Shelby Olson	{"contentOrder":["anbyeqt5wz3dkxq6kckxwn79xxr","aw1x1hw8aefd37joninhxtwxxka","7ojg7aiidaprm5q7y54ng8xa97r","7issp85h1mpn7pjo969iynpzike","73x54ue6mzbrj38t5mbkyfds7xc","7ddxcwbw3bpyk3nbyupp9s767pa","7w5z546c5u3d15n1fferi4y3sne","7bdmxk7xcrpryibc4g5srw41qqr","738c4jz9iytfmmjc43f8ma8bn1y","73x4mgnyqrff6jjmdmpwrc3r69a","76zfm97dmgjywuj7ukop3y918no","7xcdyhrcxqfn1byi14nkcfzoyor"],"icon":"🙎‍♀️","isTemplate":false,"properties":{"a1438fbbhjeffkexmcfhnx99o1h":"(111) 321-5678","a5hwxjsmkn6bak6r7uea5bx1kwc":"akj61wc9yxdwyw3t6m8igyf9d5o","abru6tz8uebdxy4skheqidh7zxy":"shelby.olson@email.com","ahf43e44h3y8ftanqgzno9z7q7w":"$30,000","ainpw47babwkpyj77ic4b9zq9xr":"Kadera Global","amahgyn9n4twaapg3jyxb6y4jic":"ar6t1ttcumgfuqugg5o4g4mzrza","aro91wme9kfaie5ceu9qasmtcnw":"auu9bfzqeuruyjwzzqgz7q8apuw","auhf91pm85f73swwidi4wid8jqe":"{\\"from\\":1669291200000}"}}	1675955410961	1675955410961	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
vpzrdpq8ugp88ipudigtx7kksch	2023-02-09 15:10:10.921795+00	bzwb99zf498tsm7mjqbiy7g81ze	1	view	Open Deals	{"cardOrder":["cirqnetz9uf8ebpfrq68dx7sj1o"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"a5hwxjsmkn6bak6r7uea5bx1kwc","values":["akj61wc9yxdwyw3t6m8igyf9d5o","aic89a5xox4wbppi6mbyx6ujsda","ah6ehh43rwj88jy4awensin8pcw","aprhd96zwi34o9cs4xyr3o9sf3c","axesd74yuxtbmw1sbk8ufax7z3a"]}],"operation":"and"},"groupById":"aro91wme9kfaie5ceu9qasmtcnw","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["apjnaggwixchfxwiatfh7ey7uno","apiswzj7uiwbh87z8dw8c6mturw","auu9bfzqeuruyjwzzqgz7q8apuw",""],"visiblePropertyIds":[]}	1675955410964	1675955410964	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7zu87byt3etrfjj4if6i7o9f5zw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send initial email	{"value":true}	1675955410969	1675955410969	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kwnrbo5c43gfjnpdoygghmfz5y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send follow-up email	{"value":true}	1675955410972	1675955410972	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7uwrwbb9sa38j8d95d4ww8mypdw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Send proposal	{"value":true}	1675955410975	1675955410975	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7afgp343sijrc7gonf9qoy7556y	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Finalize contract	{}	1675955410978	1675955410978	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n61tdes8updx7dgk4g1qmkqbnh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule initial sales call	{"value":true}	1675955410980	1675955410980	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7gx593y1kpif75xkrho74839yne	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule demo	{"value":true}	1675955410982	1675955410982	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71gqjf96497fi9ryke93twwe7xh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Hand-off to customer success	{}	1675955410985	1675955410985	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kx16rigxffr9bezsar6dxammny	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Follow up after demo	{"value":true}	1675955410987	1675955410987	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7iy8rn8s9ubdhxb9w43e5fmhuwh	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955410990	1675955410990	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77iiwbg3iufbkjp39xbytusm7fy	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	checkbox	Post-sales follow up	{}	1675955410993	1675955410993	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
askua4mi95jy8bchwhybg8gfcse	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Checklist	{}	1675955410996	1675955410996	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
akf5xjt9byinzfkeos6r6px8jbw	2023-02-09 15:10:10.921795+00	c71eyc8srz7gazgtp3hafyys1ba	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955410999	1675955410999	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7cwxpmkp8d3y78e5t4t8aizh9ac	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send initial email	{"value":true}	1675955411002	1675955411002	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p31k115qpbyo5fefdqbwceunfo	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411004	1675955411004	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7e8a3i33n8jnujrhb9im4u3f3bc	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Follow up after demo	{"value":true}	1675955411007	1675955411007	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pobi5s6iq3dhbktgrootac1h4h	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send proposal	{"value":true}	1675955411009	1675955411009	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7dizabc4pu78y8kknah8pckrpgw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule demo	{"value":true}	1675955411023	1675955411023	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79by87rm9i3ngfk95wxr4hcu8mw	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Schedule initial sales call	{"value":true}	1675955411027	1675955411027	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7f6prgh7etidefktxjadakro7de	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	checkbox	Send follow-up email	{"value":true}	1675955411030	1675955411030	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
afdi9nuij83bz9ywhkjsyorsika	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411032	1675955411032	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ap8htxxgcnpgaxka4s11df59y5c	2023-02-09 15:10:10.921795+00	czb14t4y4gbf15ehgi9kpj6hyey	1	text	## Checklist	{}	1675955411035	1675955411035	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7fymoo4ywy3yg5gyh91ijm1tmuw	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Follow up after demo	{"value":true}	1675955411038	1675955411038	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pa48ejem6p8stdqhbbicqjj7cy	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send initial email	{"value":true}	1675955411041	1675955411041	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
714ghubqyrpgd7nw34mh31ug79c	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send follow-up email	{"value":true}	1675955411043	1675955411043	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77p9joh3ajpg1tr6b385zidjbge	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Send proposal	{"value":true}	1675955411046	1675955411046	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7164ftmhpnfdwu8gy3icogzpa8o	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Finalize contract	{"value":true}	1675955411049	1675955411049	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78wczgiecq7dkjbau9r54izny9w	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411054	1675955411054	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7i9im8g6b17nizpis19mmnn9ckh	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule initial sales call	{"value":true}	1675955411062	1675955411062	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7n4b867c94tyymfg16gwoqj94fe	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Schedule demo	{"value":true}	1675955411077	1675955411077	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w4tgym95obnjp8smfskq9iypcc	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Hand-off to customer success	{"value":true}	1675955411088	1675955411088	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bwix7j583irsdmre8a3ttqy31e	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	checkbox	Post-sales follow up	{"value":true}	1675955411093	1675955411093	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a98wh64rrxtyumdfmo5dim8wikr	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Checklist	{}	1675955411098	1675955411098	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
atyt9edm39tbtbnjddx5rt8mmda	2023-02-09 15:10:10.921795+00	c45s8knkw1jf79mfpkh4k1w39ko	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411104	1675955411104	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qbk31ej6jjyrjjsqyeu9fmturc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Post-sales follow up	{}	1675955411116	1675955411116	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kzfgicen5j8d7rwhzbq6o4cedr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send proposal	{}	1675955411121	1675955411121	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pft7f9sj4jd3upimxkh7x8w87h	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Hand-off to customer success	{}	1675955411130	1675955411130	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xgfqfh9fdffcpmg91rdj6d1tea	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Follow up after demo	{}	1675955411136	1675955411136	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71sd6tycbyj8gjrxp1iin7pa7zr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule demo	{"value":true}	1675955411141	1675955411141	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ia67tegp7f8obj4yxtaa8d9whc	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send initial email	{"value":true}	1675955411144	1675955411144	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7qdcudfpn53b5i8mpe73odd8nwr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule follow-up sales call	{"value":true}	1675955411148	1675955411148	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
768tmcyaxypyrimxhbpqw5i1fpr	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Send follow-up email	{"value":true}	1675955411154	1675955411153	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
765g3gs41epfp9jrm6pm3o9ym3a	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Schedule initial sales call	{"value":true}	1675955411160	1675955411160	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7pur5woxchiymbppotiqc3epu8e	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	checkbox	Finalize contract	{}	1675955411166	1675955411166	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auyp7cdhmbpyymefooaxte184nh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Checklist	{}	1675955411172	1675955411172	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
auxx7ta8sktnsjmafar4n4ox7uh	2023-02-09 15:10:10.921795+00	cirqnetz9uf8ebpfrq68dx7sj1o	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411178	1675955411178	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7axxtz7491tbzddsddkhr1okagw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send initial email	{"value":false}	1675955411184	1675955411184	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71prjd7h1ofy1tbfmwbcyjxkunw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule initial sales call	{"value":false}	1675955411190	1675955411190	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p4tj6cwryjnbjqu6dp5zbia8rr	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411196	1675955411196	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
779frbxrdd7gb7e1g1u1wcweqnc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send proposal	{}	1675955411202	1675955411202	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7s7keem8eetrm5yguee6e48agee	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Finalize contract	{}	1675955411208	1675955411208	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7jyt49rqrwbf5udj38tqu4ea37a	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Post-sales follow up	{}	1675955411213	1675955411213	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
79gysbkm967djicna43f88r9wpe	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Send follow-up email	{"value":false}	1675955411219	1675955411219	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7wu3q67edhi8ebgmjzjfiwsahyo	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Schedule demo	{"value":false}	1675955411224	1675955411224	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7yipg3d9mtigbdq8z5h7r3f3wgy	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Hand-off to customer success	{}	1675955411230	1675955411230	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71q3bar1wm7y9tc51rd8j7fymor	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	checkbox	Follow up after demo	{}	1675955411241	1675955411241	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ahae77tk763dpmmeijk8nwjociw	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Notes\n[Enter notes here...]	{}	1675955411252	1675955411251	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
awdkgnnej7tnb5yweq4psgm8smc	2023-02-09 15:10:10.921795+00	cxarr4qdxsi8u9jak7cc3yeikuh	1	text	## Checklist	{}	1675955411261	1675955411261	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7kfpfh7omc7f4bpgcpq5u3axgue	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Hand-off to customer success	{}	1675955411268	1675955411268	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
756nnjpzjwpntbe66myqiuw3qda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send initial email	{"value":false}	1675955411275	1675955411275	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76rekmo79d78qtxh39scmb1kx5y	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Post-sales follow up	{}	1675955411281	1675955411281	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7imo387hkz3yrzrs9it7krmgjda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Finalize contract	{}	1675955411288	1675955411288	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7k5f3rk8c6iyxzrcktu4wr3fwda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send follow-up email	{"value":false}	1675955411293	1675955411293	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
71bhibupqmbntbxg6dt8snc6asc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411297	1675955411297	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7mb4ytzwbwidq7czurerc6o1swc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Send proposal	{}	1675955411302	1675955411302	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7h5pc91n56p8yfmgp74rsqy78ro	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Follow up after demo	{}	1675955411310	1675955411310	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
78kwigroocfyn5pf41nhoupwoda	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule initial sales call	{"value":false}	1675955411319	1675955411319	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
77predkxwjjgf7d6dtcjaooxr3e	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	checkbox	Schedule demo	{"value":false}	1675955411332	1675955411332	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a65asssmsbjdh3giat9xzqoqdco	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Checklist	{}	1675955411338	1675955411338	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
a4zbibzhm1irk8pkx4xqmp4dpqc	2023-02-09 15:10:10.921795+00	ct59gu9j4cpnrtjcpyn3a5okdqa	1	text	## Notes\n[Enter notes here...]	{}	1675955411344	1675955411344	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
738c4jz9iytfmmjc43f8ma8bn1y	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send proposal	{}	1675955411349	1675955411349	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ojg7aiidaprm5q7y54ng8xa97r	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send initial email	{"value":true}	1675955411355	1675955411355	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7bdmxk7xcrpryibc4g5srw41qqr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Follow up after demo	{}	1675955411360	1675955411360	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x4mgnyqrff6jjmdmpwrc3r69a	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Finalize contract	{}	1675955411367	1675955411367	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7ddxcwbw3bpyk3nbyupp9s767pa	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule follow-up sales call	{"value":false}	1675955411374	1675955411374	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7w5z546c5u3d15n1fferi4y3sne	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule demo	{"value":false}	1675955411380	1675955411380	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
73x54ue6mzbrj38t5mbkyfds7xc	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Schedule initial sales call	{"value":false}	1675955411387	1675955411387	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7xcdyhrcxqfn1byi14nkcfzoyor	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Post-sales follow up	{}	1675955411394	1675955411394	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
76zfm97dmgjywuj7ukop3y918no	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Hand-off to customer success	{}	1675955411401	1675955411401	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7issp85h1mpn7pjo969iynpzike	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	checkbox	Send follow-up email	{"value":false}	1675955411408	1675955411408	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
aw1x1hw8aefd37joninhxtwxxka	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Checklist	{}	1675955411416	1675955411415	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
7p3whtqf9cpnbuygpkfsutwheoo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 3]	{"value":false}	1675955413115	1675955413115	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
anbyeqt5wz3dkxq6kckxwn79xxr	2023-02-09 15:10:10.921795+00	c7n4qjbom77g5mxhapf6tmtcidw	1	text	## Notes\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.	{}	1675955411433	1675955411433	0	\N	system		system	ba4tbc4q9kb8ytjfs9kgx7jzjqy
ccq3ukx8c8bgo9x49g8q851froe	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Pay bills	{"contentOrder":["7kx1socx6mjgwxksy1nmnu8hbky","7mazt3mp5yfbdfkgh7iy4upqccy","7bh94nigoqtgyjgdtk7xan14t4h"],"icon":"🔌","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"aj4jyekqqssatjcq7r7chmy19ey","abthng7baedhhtrwsdodeuincqy":"true"}}	1675955412199	1675955412199	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cchc3zymfa3f5mktpoiqo4nbzsr	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Buy groceries	{"contentOrder":["a54rpf4qjypbpdkdnraatck173h","76x94fpy89brh8jsjip3eepyb6c","7oq6wa91e1jnqxfhnshadyqwana","7gui4597mfbyqmgbrenwcu4apja","7wi6nur6ysig43x8yntx1atf13y","7zmwfuc7jqiysupcxdmncgdxqne","75wszyfkeptb4zr63z84e9koy3e"],"icon":"🛒","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412211	1675955412211	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
c4dc75947tjn5mem7kzzpgqnswh	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Go for a walk	{"contentOrder":["a8mj5x4thmtbi8jxh51jhq9u7iw","a8w7wz49bb78qxydiw5i398u7sy","7sbu99dbrabgj5bxyqe5c47ztqa"],"icon":"👣","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412223	1675955412223	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
crq3aeiaa8frsmdbaox76xiapmc	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Feed Fluffy	{"contentOrder":["agr7xb7krnfyifg6yua5z86k4th"],"icon":"🐱","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"an51dnkenmoog9cetapbc4uyt3y"}}	1675955412232	1675955412231	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cbby4rxqas3fxxpeso3quj6s1wy	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	card	Gardening	{"contentOrder":[],"icon":"🌳","isTemplate":false,"properties":{"a9zf59u8x1rf4ywctpcqama7tio":"afpy8s7i45frggprmfsqngsocqh"}}	1675955412240	1675955412240	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
v9yh48g8pk3r6ico6sdomybkj5r	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	List View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio","abthng7baedhhtrwsdodeuincqy"]}	1675955412247	1675955412247	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
vjy9kijzb53rqmdmszg5nii5nue	2023-02-09 15:10:12.186101+00	bbn1888mprfrm5fjw9f1je9x3xo	1	view	Board View	{"cardOrder":["cchc3zymfa3f5mktpoiqo4nbzsr","ccq3ukx8c8bgo9x49g8q851froe","c4dc75947tjn5mem7kzzpgqnswh","crq3aeiaa8frsmdbaox76xiapmc","czowhma7rnpgb3eczbqo3t7fijo"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a9zf59u8x1rf4ywctpcqama7tio","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["an51dnkenmoog9cetapbc4uyt3y","afpy8s7i45frggprmfsqngsocqh","aj4jyekqqssatjcq7r7chmy19ey",""],"visiblePropertyIds":["a9zf59u8x1rf4ywctpcqama7tio"]}	1675955412252	1675955412252	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7bh94nigoqtgyjgdtk7xan14t4h	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Utilities	{"value":true}	1675955412257	1675955412257	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7kx1socx6mjgwxksy1nmnu8hbky	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Mobile phone	{"value":true}	1675955412261	1675955412261	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7mazt3mp5yfbdfkgh7iy4upqccy	2023-02-09 15:10:12.186101+00	ccq3ukx8c8bgo9x49g8q851froe	1	checkbox	Internet	{"value":true}	1675955412266	1675955412266	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7zmwfuc7jqiysupcxdmncgdxqne	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Cereal	{"value":false}	1675955412271	1675955412271	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7wi6nur6ysig43x8yntx1atf13y	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Butter	{"value":false}	1675955412276	1675955412276	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7gui4597mfbyqmgbrenwcu4apja	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bread	{"value":false}	1675955412281	1675955412281	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
76x94fpy89brh8jsjip3eepyb6c	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Milk	{"value":false}	1675955412285	1675955412285	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
75wszyfkeptb4zr63z84e9koy3e	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Bananas	{"value":false}	1675955412291	1675955412291	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7oq6wa91e1jnqxfhnshadyqwana	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	checkbox	Eggs	{"value":false}	1675955412296	1675955412296	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a54rpf4qjypbpdkdnraatck173h	2023-02-09 15:10:12.186101+00	cchc3zymfa3f5mktpoiqo4nbzsr	1	text	## Grocery list	{}	1675955412300	1675955412300	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
7sbu99dbrabgj5bxyqe5c47ztqa	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	image		{"fileId":"76fwrj36hptg6dywka4k5mt3sph.png"}	1675955412306	1675955412306	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8mj5x4thmtbi8jxh51jhq9u7iw	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Goal\nWalk at least 10,000 steps every day.	{}	1675955412310	1675955412310	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
a8w7wz49bb78qxydiw5i398u7sy	2023-02-09 15:10:12.186101+00	c4dc75947tjn5mem7kzzpgqnswh	1	text	## Route	{}	1675955412315	1675955412315	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
agr7xb7krnfyifg6yua5z86k4th	2023-02-09 15:10:12.186101+00	crq3aeiaa8frsmdbaox76xiapmc	1	text		{}	1675955412322	1675955412322	0	\N	system		system	b7ziufq456id898g6qn6hocdahe
cz4wzottsq3dpubozjfty9o4ciw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Identify dependencies	{"contentOrder":["aoun6pu8ahbgbdryiwihaf5g7kw","7kzqxyu34tbn4igsiaabt7yusnh","ak6b15yexfbdjbkbgb1qsb37bwo","71oe5g19kwtr65d43ydcfyaquma","7nqstxcxk97gfdq4kug4us1b6my","7p3whtqf9cpnbuygpkfsutwheoo","76z5c5whtetgo3frgooosey8kgw"],"icon":"🔗","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"98a57627-0f76-471d-850d-91f3ed9fd213"}}	1675955413003	1675955413003	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c4mkyqpdicprz7mwj3hhnuw8ngc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Define project scope	{"contentOrder":["a76yjexz653d9pn58r7wmfsf7pw","7b3bgpbw3pjgcibq8ghzdqhnqkc","ap7b19me84b8zzq6oknt89cwtxr","7uzdep7j5rbrnzrnugyojjqa43h","7ueynnzbbwp8xbk73848ipjaerr","7qwpifwt5hp87ukgmwusuqbtppa","7pe4oiok7zbdajbz9ryt57qksbo"],"icon":"🔬","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"32","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413009	1675955413009	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cper74m1sojfhpgur1xhwynxfiy	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Requirements sign-off	{"contentOrder":["ae87wjndr9pnijcmi6hc5wb59re","7skzimbdzbpbq5kforgshzs61kw","ajut4tttrqbnmbp17wkag5omfxy","76sisungewinx7qgn6njki4ticy","7gfdcsb1poj8f5qp7r3h6pe4b1y","7pqf6oazaz3r3fcfdhe8f566prh","79qz9ycustfdhiqoejuc64jbjuy"],"icon":"🖋️","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"8","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413015	1675955413015	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
cd6qe9kcu8tny3qk1q166ieq7ca	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Project budget approval	{"contentOrder":["abdket889k3gqjgyapdtwdyrrma","7i5s3bpukbbri5fgi6fqj8hm8ya","aq35hqbaejb8iie6wit8itohs5c","7e1o55mq96py68xhxrpppfpdc5w","73zjyyew9dfbatkcgyp4zg77gmw","7d1eaa4nzcjd9jbo69mcoru8ape","7z54jn3njybgsbf8qtppxtz1zmo"],"icon":"💵","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"16","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ayz81h9f3dwp7rzzbdebesc7ute","d3d682bf-e074-49d9-8df5-7320921c2d23":"d3bfb50f-f569-4bad-8a3a-dd15c3f60101"}}	1675955413019	1675955413019	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
c1zftz5wzmiditnznpqken4saxc	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	card	Conduct market analysis	{"contentOrder":["ae1mquzi61p8qufeuyb9tducnuy","74t5gy1zgujrtjrhiohjrobchqw","afisf71n8n3r49jcapjxbbj3qoh","7m3f5jyj7sjfbjmwxdp5oein9qr","7jy5wgugfjfy53ccqd67c35tchr","73f1jioomr3ryzrrp5h79ce3xde","7jy5gzxjmoiyb3kjxi6xfr4enyh"],"icon":"📈","isTemplate":false,"properties":{"a8daz81s4xjgke1ww6cwik5w7ye":"40","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ar6b8m3jxr3asyxhr8iucdbo6yc","d3d682bf-e074-49d9-8df5-7320921c2d23":"87f59784-b859-4c24-8ebe-17c766e081dd"}}	1675955413027	1675955413027	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vqikjy5xq5bynxrsw7z8jnwzr7c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Project Priorities	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d3d682bf-e074-49d9-8df5-7320921c2d23","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"87f59784-b859-4c24-8ebe-17c766e081dd":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"98a57627-0f76-471d-850d-91f3ed9fd213":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"d3bfb50f-f569-4bad-8a3a-dd15c3f60101":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["d3bfb50f-f569-4bad-8a3a-dd15c3f60101","87f59784-b859-4c24-8ebe-17c766e081dd","98a57627-0f76-471d-850d-91f3ed9fd213",""],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413052	1675955413052	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v1ihhkqej8brfbbthmm8j1b111c	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Progress Tracker	{"cardOrder":["cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz4wzottsq3dpubozjfty9o4ciw","c1zftz5wzmiditnznpqken4saxc","c4mkyqpdicprz7mwj3hhnuw8ngc","coxnjt3ro1in19dd1e3awdt338r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[],"kanbanCalculations":{"":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"adeo5xuwne3qjue83fcozekz8ko":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"afi4o5nhnqc3smtzs1hs3ij34dh":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ahpyxfnnrzynsw3im1psxpkgtpe":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ar6b8m3jxr3asyxhr8iucdbo6yc":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"},"ayz81h9f3dwp7rzzbdebesc7ute":{"calculation":"sum","propertyId":"a8daz81s4xjgke1ww6cwik5w7ye"}},"sortOptions":[],"viewType":"board","visibleOptionIds":["ayz81h9f3dwp7rzzbdebesc7ute","ar6b8m3jxr3asyxhr8iucdbo6yc","afi4o5nhnqc3smtzs1hs3ij34dh","adeo5xuwne3qjue83fcozekz8ko","ahpyxfnnrzynsw3im1psxpkgtpe",""],"visiblePropertyIds":["d3d682bf-e074-49d9-8df5-7320921c2d23","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413058	1675955413058	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vsqznqhthm7dstpj4jxpeifppyw	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Overview	{"cardOrder":["c4mkyqpdicprz7mwj3hhnuw8ngc","c1zftz5wzmiditnznpqken4saxc","cz4wzottsq3dpubozjfty9o4ciw","cd6qe9kcu8tny3qk1q166ieq7ca","cper74m1sojfhpgur1xhwynxfiy","cz8p8gofakfby8kzz83j97db8ph","ce1jm5q5i54enhuu4h3kkay1hcc"],"collapsedOptionIds":[],"columnCalculations":{"a8daz81s4xjgke1ww6cwik5w7ye":"sum"},"columnWidths":{"2a5da320-735c-4093-8787-f56e15cdfeed":196,"__title":280,"a8daz81s4xjgke1ww6cwik5w7ye":139,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":141,"d3d682bf-e074-49d9-8df5-7320921c2d23":110},"defaultTemplateId":"czw9es1e89fdpjr7cqptr1xq7qh","filter":{"filters":[],"operation":"and"},"groupById":"","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","d3d682bf-e074-49d9-8df5-7320921c2d23","2a5da320-735c-4093-8787-f56e15cdfeed","a3zsw7xs8sxy7atj8b6totp3mby","axkhqa4jxr3jcqe4k87g8bhmary","a7gdnz8ff8iyuqmzddjgmgo9ery","a8daz81s4xjgke1ww6cwik5w7ye"]}	1675955413067	1675955413067	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
v8iq8y5gb6pd65n5iudaoegkc8a	2023-02-09 15:10:12.994972+00	bc41mwxg9ybb69pn9j5zna6d36c	1	view	Task Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a3zsw7xs8sxy7atj8b6totp3mby","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955413081	1675955413081	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
71oe5g19kwtr65d43ydcfyaquma	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 1]	{"value":false}	1675955413085	1675955413085	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7nqstxcxk97gfdq4kug4us1b6my	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	[Subtask 2]	{"value":false}	1675955413107	1675955413107	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7kzqxyu34tbn4igsiaabt7yusnh	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	divider		{}	1675955413110	1675955413110	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76z5c5whtetgo3frgooosey8kgw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	checkbox	...	{"value":false}	1675955413112	1675955413112	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ak6b15yexfbdjbkbgb1qsb37bwo	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Checklist	{}	1675955413117	1675955413117	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aoun6pu8ahbgbdryiwihaf5g7kw	2023-02-09 15:10:12.994972+00	cz4wzottsq3dpubozjfty9o4ciw	1	text	## Description\n*[Brief description of this task]*	{}	1675955413120	1675955413120	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7ueynnzbbwp8xbk73848ipjaerr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 2]	{"value":false}	1675955413122	1675955413122	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pe4oiok7zbdajbz9ryt57qksbo	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	...	{"value":false}	1675955413134	1675955413134	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7uzdep7j5rbrnzrnugyojjqa43h	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 1]	{"value":false}	1675955413141	1675955413141	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7qwpifwt5hp87ukgmwusuqbtppa	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	checkbox	[Subtask 3]	{"value":false}	1675955413162	1675955413162	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7b3bgpbw3pjgcibq8ghzdqhnqkc	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	divider		{}	1675955413188	1675955413188	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ap7b19me84b8zzq6oknt89cwtxr	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Checklist	{}	1675955413203	1675955413203	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
a76yjexz653d9pn58r7wmfsf7pw	2023-02-09 15:10:12.994972+00	c4mkyqpdicprz7mwj3hhnuw8ngc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413234	1675955413234	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
79qz9ycustfdhiqoejuc64jbjuy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	...	{"value":false}	1675955413238	1675955413238	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7gfdcsb1poj8f5qp7r3h6pe4b1y	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 2]	{"value":false}	1675955413243	1675955413243	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7skzimbdzbpbq5kforgshzs61kw	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	divider		{}	1675955413247	1675955413247	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7pqf6oazaz3r3fcfdhe8f566prh	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 3]	{"value":false}	1675955413258	1675955413258	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76sisungewinx7qgn6njki4ticy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	checkbox	[Subtask 1]	{"value":false}	1675955413263	1675955413263	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae87wjndr9pnijcmi6hc5wb59re	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Description\n*[Brief description of this task]*	{}	1675955413268	1675955413268	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ajut4tttrqbnmbp17wkag5omfxy	2023-02-09 15:10:12.994972+00	cper74m1sojfhpgur1xhwynxfiy	1	text	## Checklist	{}	1675955413273	1675955413273	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7i5s3bpukbbri5fgi6fqj8hm8ya	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	divider		{}	1675955413279	1675955413279	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e1o55mq96py68xhxrpppfpdc5w	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 1]	{"value":false}	1675955413285	1675955413285	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7d1eaa4nzcjd9jbo69mcoru8ape	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 3]	{"value":false}	1675955413291	1675955413291	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7z54jn3njybgsbf8qtppxtz1zmo	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	...	{"value":false}	1675955413295	1675955413295	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73zjyyew9dfbatkcgyp4zg77gmw	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	checkbox	[Subtask 2]	{"value":false}	1675955413304	1675955413304	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
aq35hqbaejb8iie6wit8itohs5c	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Checklist	{}	1675955413318	1675955413318	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abdket889k3gqjgyapdtwdyrrma	2023-02-09 15:10:12.994972+00	cd6qe9kcu8tny3qk1q166ieq7ca	1	text	## Description\n*[Brief description of this task]*	{}	1675955413333	1675955413333	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5gzxjmoiyb3kjxi6xfr4enyh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	...	{"value":false}	1675955413338	1675955413338	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
73f1jioomr3ryzrrp5h79ce3xde	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 3]	{"value":false}	1675955413343	1675955413343	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
74t5gy1zgujrtjrhiohjrobchqw	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	divider		{}	1675955413359	1675955413359	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jy5wgugfjfy53ccqd67c35tchr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 2]	{"value":false}	1675955413363	1675955413363	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7m3f5jyj7sjfbjmwxdp5oein9qr	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	checkbox	[Subtask 1]	{"value":false}	1675955413369	1675955413369	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
ae1mquzi61p8qufeuyb9tducnuy	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Description\n*[Brief description of this task]*	{}	1675955413377	1675955413377	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
afisf71n8n3r49jcapjxbbj3qoh	2023-02-09 15:10:12.994972+00	c1zftz5wzmiditnznpqken4saxc	1	text	## Checklist	{}	1675955413405	1675955413405	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
76azhipbobfygfynia6zacn9w3o	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 3]	{"value":false}	1675955413408	1675955413408	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7mb6ctqe7pfrtbedqcco1cubphw	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 2]	{"value":false}	1675955413413	1675955413413	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7jditmempbfbwjf5qcqsen8jrjr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	divider		{}	1675955413418	1675955413418	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
785gjigqkdif5jf3eu11aubu45h	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	[Subtask 1]	{"value":false}	1675955413423	1675955413423	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
7e5qw6opfzpnxxdzuow1futiuch	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	checkbox	...	{"value":false}	1675955413441	1675955413441	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
acqyxd35m8jgmice6s8zu7r5p3w	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Description\n*[Brief description of this task]*	{}	1675955413455	1675955413455	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
abcywf8z4midn9mt3qcmufk8tmr	2023-02-09 15:10:12.994972+00	czw9es1e89fdpjr7cqptr1xq7qh	1	text	## Checklist	{}	1675955413461	1675955413461	0	\N	system		system	bzuetargh8tfgtdj4tt8t9w6ora
vz8mbztwmdtyddeqoecmudbhf4y	2023-02-09 15:10:14.174793+00		1	view	By Quarter	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":452,"a17ryhi1jfsboxkwkztwawhmsxe":148,"a6amddgmrzakw66cidqzgk6p4ge":230,"azzbawji5bksj69sekcs4srm1ky":142},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"aqxyzkdrs4egqf7yk866ixkaojc","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414182	1675955414182	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
vzs4utd66mig95xj9aon575y7mo	2023-02-09 15:10:14.174793+00		1	view	By Objectives	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":387,"a17ryhi1jfsboxkwkztwawhmsxe":134,"a6amddgmrzakw66cidqzgk6p4ge":183,"aqxyzkdrs4egqf7yk866ixkaojc":100},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a6amddgmrzakw66cidqzgk6p4ge","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a6amddgmrzakw66cidqzgk6p4ge","a17ryhi1jfsboxkwkztwawhmsxe","azzbawji5bksj69sekcs4srm1ky","adp5ft3kgz7r5iqq3tnwg551der","aqxyzkdrs4egqf7yk866ixkaojc","adu6mebzpibq6mgcswk69xxmnqe","asope3bddhm4gpsng5cfu4hf6rh","ajwxp866f9obs1kutfwaa5ru7fe","azqnyswk6s1boiwuthscm78qwuo","ahz3fmjnaguec8hce7xq3h5cjdr","a17bfcgnzmkwhziwa4tr38kiw5r"]}	1675955414186	1675955414185	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ch8r4zp93di899kf58zrexgx8do	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Improve customer NPS score	{"contentOrder":[],"icon":"💯","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"82%","ajwxp866f9obs1kutfwaa5ru7fe":"8.5","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"7","azzbawji5bksj69sekcs4srm1ky":"agm9p6gcq15ueuzqq3wd4be39wy"}}	1675955414192	1675955414192	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
ckiw38hhaz7dz9j817znsydproy	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Generate more Marketing Qualified Leads (MQLs)	{"contentOrder":[],"icon":"🛣️","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"65%","ajwxp866f9obs1kutfwaa5ru7fe":"100","aqxyzkdrs4egqf7yk866ixkaojc":"ahfbn1jsmhydym33ygxwg5jt3kh","azqnyswk6s1boiwuthscm78qwuo":"65","azzbawji5bksj69sekcs4srm1ky":"aehoa17cz18rqnrf75g7dwhphpr"}}	1675955414198	1675955414198	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cfn4r8fnn37ysfe69imeisb9n7r	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase customer retention	{"contentOrder":[],"icon":"😀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a8nukezwwmknqwjsygg7eaxs9te","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"66%","ajwxp866f9obs1kutfwaa5ru7fe":"90% customer retention rate","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"60%","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414209	1675955414209	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c7wiascn8wpn3xkhkq8xmkqe8tc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Hit company global sales target	{"contentOrder":[],"icon":"💰","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"15%","ajwxp866f9obs1kutfwaa5ru7fe":"50MM","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"7.5MM","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414222	1675955414222	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cm8zp8a7jp3gezbg3x375hbahye	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Increase user signups by 30%	{"contentOrder":[],"icon":"💳","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"a6robxx81diugpjq5jkezz3j1fo","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"as555ipyzopjjpfb5rjtssecw5e","ahz3fmjnaguec8hce7xq3h5cjdr":"0%","ajwxp866f9obs1kutfwaa5ru7fe":"1,000","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"0","azzbawji5bksj69sekcs4srm1ky":"afkxpcjqjypu7hhar7banxau91h"}}	1675955414237	1675955414237	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1yangmadqbyqddpcnz51mzb1dc	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Add 10 new customers in the EU	{"contentOrder":[],"icon":"🌍","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"auw3afh3kfhrfgmjr8muiz137jy","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"30%","ajwxp866f9obs1kutfwaa5ru7fe":"10","aqxyzkdrs4egqf7yk866ixkaojc":"acb6dqqs6yson7bbzx6jk9bghjh","azqnyswk6s1boiwuthscm78qwuo":"3","azzbawji5bksj69sekcs4srm1ky":"agrfeaoj7d8p5ianw5iaf3191ae"}}	1675955414244	1675955414244	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
cbrnxdi4457dduryz6qpynu5ynr	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Launch 3 key features	{"contentOrder":[],"icon":"🚀","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"apnt1f7na9rzgk1rt49keg7xbiy","a6amddgmrzakw66cidqzgk6p4ge":"ao9b5pxyt7tkgdohzh9oaustdhr","adp5ft3kgz7r5iqq3tnwg551der":"a8zg3rjtf4swh7smsjxpsn743rh","ahz3fmjnaguec8hce7xq3h5cjdr":"33%","ajwxp866f9obs1kutfwaa5ru7fe":"3","aqxyzkdrs4egqf7yk866ixkaojc":"anruuoyez51r3yjxuoc8zoqnwaw","azqnyswk6s1boiwuthscm78qwuo":"1","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414250	1675955414249	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c1kzebdkek3ntixdj5of7q57pya	2023-02-09 15:10:14.174793+00	bcm39o11e4ib8tye8mt6iyuec9o	1	card	Reduce bug backlog by 50%	{"contentOrder":[],"icon":"🐞","isTemplate":false,"properties":{"a17ryhi1jfsboxkwkztwawhmsxe":"abzfwnn6rmtfzyq5hg8uqmpsncy","a6amddgmrzakw66cidqzgk6p4ge":"apqfjst8massbjjhpcsjs3y1yqa","adp5ft3kgz7r5iqq3tnwg551der":"a1ts3ftyr8nocsicui98c89uxjy","ahz3fmjnaguec8hce7xq3h5cjdr":"100%","ajwxp866f9obs1kutfwaa5ru7fe":"75","aqxyzkdrs4egqf7yk866ixkaojc":"awfu37js3fomfkkczm1zppac57a","azqnyswk6s1boiwuthscm78qwuo":"75","azzbawji5bksj69sekcs4srm1ky":"aw5i7hmpadn6mbwbz955ubarhme"}}	1675955414260	1675955414260	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
7o9ksmt3jktribytdp9putspe4e	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	image		{"fileId":"7b9xk9boj3fbqfm3umeaaizp8qr.png"}	1675955414703	1675955414703	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v5kjrsy165t85um9997ir99bjxh	2023-02-09 15:10:14.174793+00	bm4ubx56krp4zwyfcqh7nxiigbr	1	view	Departments	{"cardOrder":["cpa534b5natgmunis8u1ixb55pw"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"azzbawji5bksj69sekcs4srm1ky","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aw5i7hmpadn6mbwbz955ubarhme","afkxpcjqjypu7hhar7banxau91h","aehoa17cz18rqnrf75g7dwhphpr","agrfeaoj7d8p5ianw5iaf3191ae","agm9p6gcq15ueuzqq3wd4be39wy","aucop7kw6xwodcix6zzojhxih6r","afust91f3g8ht368mkn5x9tgf1o","acocxxwjurud1jixhp7nowdig7y"],"visiblePropertyIds":[]}	1675955414270	1675955414270	0	\N	system		system	bhiem3kc7pj85585qw3abgs7psa
c3kb3yi7xob87xrscc561s3tkmh	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Start a daily journal	{"contentOrder":[],"icon":"✍️","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414451	1675955414451	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cogh3eo3tg7d9umaa5b7rjteejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Run 3 times a week	{"contentOrder":[],"icon":"🏃","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"6e7139e4-5358-46bb-8c01-7b029a57b80a","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"ffb3f951-b47f-413b-8f1d-238666728008"}}	1675955414456	1675955414456	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cif69jfjjyfdq9y6kmz6g36mc5a	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Learn to paint	{"contentOrder":[],"icon":"🎨","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"77c539af-309c-4db1-8329-d20ef7e9eacd","d6b1249b-bc18-45fc-889e-bec48fce80ef":"9a090e33-b110-4268-8909-132c5002c90e","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"3245a32d-f688-463b-87f4-8e7142c1b397"}}	1675955414461	1675955414461	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
cpqd9prb7ij8x98bfoaubgbkbfy	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	card	Open retirement account	{"contentOrder":[],"icon":"🏦","isTemplate":false,"properties":{"af6fcbb8-ca56-4b73-83eb-37437b9a667d":"bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","d6b1249b-bc18-45fc-889e-bec48fce80ef":"0a82977f-52bf-457b-841b-e2b7f76fb525","d9725d14-d5a8-48e5-8de1-6f8c004a9680":"80be816c-fc7a-4928-8489-8b02180f4954"}}	1675955414467	1675955414467	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
v6ghe65mhd3fatfmn8r4mkmpejo	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"af6fcbb8-ca56-4b73-83eb-37437b9a667d","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["bf52bfe6-ac4c-4948-821f-83eaa1c7b04a","77c539af-309c-4db1-8329-d20ef7e9eacd","98bdea27-0cce-4cde-8dc6-212add36e63a",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680","d6b1249b-bc18-45fc-889e-bec48fce80ef"]}	1675955414476	1675955414476	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vt6x1h6sacibh3cchs3tea6du9w	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"ajy6xbebzopojaenbnmfpgtdwso","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955414486	1675955414486	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
ve6nrxk4a6trupk94tfw8oxgutw	2023-02-09 15:10:14.424408+00	bd65qbzuqupfztpg31dgwgwm5ga	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"d6b1249b-bc18-45fc-889e-bec48fce80ef","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["9a090e33-b110-4268-8909-132c5002c90e","0a82977f-52bf-457b-841b-e2b7f76fb525","6e7139e4-5358-46bb-8c01-7b029a57b80a","d5371c63-66bf-4468-8738-c4dc4bea4843",""],"visiblePropertyIds":["d9725d14-d5a8-48e5-8de1-6f8c004a9680"]}	1675955414493	1675955414493	0	\N	system		system	bdjegdwuc3fr3jxmg7sgcn6mtww
vu77og8uegir6fqcd97psqyuabo	2023-02-09 15:10:14.585839+00		1	view	By Sprint	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{"ai7ajsdk14w7x5s8up3dwir77te":"count"},"columnWidths":{"20717ad3-5741-4416-83f1-6f133fff3d11":128,"50117d52-bcc7-4750-82aa-831a351c44a0":126,"__title":280,"a1g6i613dpe9oryeo71ex3c86hy":159,"aeomttrbhhsi8bph31jn84sto6h":141,"ax9f8so418s6s65hi5ympd93i6a":183,"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":100},"defaultTemplateId":"cc9a5jhgow7njpft3ywtffsz78c","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","aphg37f7zbpuc3bhwhp19s1ribh","a4378omyhmgj3bex13sj4wbpfiy","ai7ajsdk14w7x5s8up3dwir77te","a1g6i613dpe9oryeo71ex3c86hy","aeomttrbhhsi8bph31jn84sto6h","ax9f8so418s6s65hi5ympd93i6a"]}	1675955414600	1675955414600	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cc9a5jhgow7njpft3ywtffsz78c	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	User Story	{"contentOrder":["awzojrhtdh3nr5psizhywihzzgh"],"icon":"📖","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"apht1nt5ryukdmxkh6fkfn6rgoy","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414605	1675955414605	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfcj6p6y8rpn9tnezxe9bmsnmrh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Horizontal scroll issue	{"contentOrder":["a6znekksdmpgmjedazsggqn1egh","apejdcik6kfn4fpdzixe485b7ae","76mot8uwo8jyatk53897g4oatca"],"icon":"〰️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414611	1675955414611	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cxy8tneoo8b885jtn4zfqp5xona	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Login screen not loading	{"contentOrder":["aposk4q1ze3yozq4i1h9b6gjcbe","ahohrhxsoxjdmmp8igah5otrsho","7o9ksmt3jktribytdp9putspe4e"],"icon":"🖥️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"1","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955414618	1675955414618	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cjwq1mmub3fbx9xidzmj1jth7dh	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Move cards across boards	{"contentOrder":["acx4qi4iqi3dgbgxe13rndfcxew"],"icon":"🚚","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"abrfos7e7eczk9rqw6y5abadm1y","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414623	1675955414623	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cawustaeu8pftmf4m4pfqya7k5h	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Cross-team collaboration	{"contentOrder":["aghhoq7neoirsbqq1b5r3m8knih"],"icon":"🤝","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414629	1675955414629	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cfxdu38pf57f98nmq8jj1fbtqja	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Bug	{"contentOrder":["adxhwp1jo67yxzczyc4p5ywxkmr","aq6rch5gsb3ne8cmqcp56ery9so","7q7j6yp8etpbktptcwtxefck6iw"],"icon":"🐞","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"aomnawq4551cbbzha9gxnmb3z5w","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414634	1675955414634	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
cn3ox8hrrutgtbnhoebu7fqgzdy	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Standard properties	{"contentOrder":["ar9whaq5zjifr8rq61a3e5pkyfa"],"icon":"🏷️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414639	1675955414639	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
c49q5wfok97ghujoyxiaqitzdry	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Epic	{"contentOrder":["akgpkj8rmabby58uyeyag9stijw"],"icon":"🤝","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"3","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955414645	1675955414645	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
casdocyctotyajr5mb6kehetz1a	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Global templates	{"contentOrder":["au7ctdfpqgtrf3xksx398ux3e5h"],"icon":"🖼️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"a6ghze4iy441qhsh3eijnc8hwze","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","a1g6i613dpe9oryeo71ex3c86hy":"https://mattermost.com/boards/","ai7ajsdk14w7x5s8up3dwir77te":"2","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955414649	1675955414649	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
chcs5bmiyftf1fjfpiaoeewpgba	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	card	Feature	{"contentOrder":["aip8b45tfj3bp3dduxap3wn7g1a"],"icon":"🏗️","isTemplate":true,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"a5yxq8rbubrpnoommfwqmty138h","50117d52-bcc7-4750-82aa-831a351c44a0":"aft5bzo7h9aspqgrx3jpy5tzrer"}}	1675955414655	1675955414655	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
voi8jzi41yiyrucj1sh61s8tm6w	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Status	{"cardOrder":["casdocyctotyajr5mb6kehetz1a","cfcj6p6y8rpn9tnezxe9bmsnmrh","cjwq1mmub3fbx9xidzmj1jth7dh","cxy8tneoo8b885jtn4zfqp5xona","cn3ox8hrrutgtbnhoebu7fqgzdy","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["aft5bzo7h9aspqgrx3jpy5tzrer","abrfos7e7eczk9rqw6y5abadm1y","ax8wzbka5ahs3zziji3pp4qp9mc","atabdfbdmjh83136d5e5oysxybw","ace1bzypd586kkyhcht5qqd9eca","aay656c9m1hzwxc9ch5ftymh3nw","a6ghze4iy441qhsh3eijnc8hwze"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414660	1675955414660	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
v7j16qap9ctfzibq6zgg66b5hay	2023-02-09 15:10:14.585839+00	bgi1yqiis8t8xdqxgnet8ebutky	1	view	By Type	{"cardOrder":["cxy8tneoo8b885jtn4zfqp5xona","cjwq1mmub3fbx9xidzmj1jth7dh","cn3ox8hrrutgtbnhoebu7fqgzdy","cfcj6p6y8rpn9tnezxe9bmsnmrh","casdocyctotyajr5mb6kehetz1a","cawustaeu8pftmf4m4pfqya7k5h"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"20717ad3-5741-4416-83f1-6f133fff3d11","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["424ea5e3-9aa1-4075-8c5c-01b44b66e634","a5yxq8rbubrpnoommfwqmty138h","apht1nt5ryukdmxkh6fkfn6rgoy","aiycbuo3dr5k4xxbfr7coem8ono","aomnawq4551cbbzha9gxnmb3z5w"],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955414677	1675955414677	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
awzojrhtdh3nr5psizhywihzzgh	2023-02-09 15:10:14.585839+00	cc9a5jhgow7njpft3ywtffsz78c	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414683	1675955414683	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
76mot8uwo8jyatk53897g4oatca	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414688	1675955414688	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
a6znekksdmpgmjedazsggqn1egh	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414694	1675955414694	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
apejdcik6kfn4fpdzixe485b7ae	2023-02-09 15:10:14.585839+00	cfcj6p6y8rpn9tnezxe9bmsnmrh	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414699	1675955414699	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aposk4q1ze3yozq4i1h9b6gjcbe	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414707	1675955414707	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ahohrhxsoxjdmmp8igah5otrsho	2023-02-09 15:10:14.585839+00	cxy8tneoo8b885jtn4zfqp5xona	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414712	1675955414712	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
acx4qi4iqi3dgbgxe13rndfcxew	2023-02-09 15:10:14.585839+00	cjwq1mmub3fbx9xidzmj1jth7dh	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414717	1675955414717	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
abs7abu751bbbjczo3e9j9kyssw	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414722	1675955414722	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adaiaeiqjrfbf3xekijke57ggco	2023-02-09 15:10:14.585839+00	cfmk7771httynm8r7rm8cbrmrya	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414728	1675955414728	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aghhoq7neoirsbqq1b5r3m8knih	2023-02-09 15:10:14.585839+00	cawustaeu8pftmf4m4pfqya7k5h	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414733	1675955414733	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
7q7j6yp8etpbktptcwtxefck6iw	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	image		{"fileId":"7tmfu5iqju3n1mdfwi5gru89qmw.png"}	1675955414738	1675955414738	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
adxhwp1jo67yxzczyc4p5ywxkmr	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955414744	1675955414744	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aq6rch5gsb3ne8cmqcp56ery9so	2023-02-09 15:10:14.585839+00	cfxdu38pf57f98nmq8jj1fbtqja	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955414750	1675955414750	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
ar9whaq5zjifr8rq61a3e5pkyfa	2023-02-09 15:10:14.585839+00	cn3ox8hrrutgtbnhoebu7fqgzdy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414756	1675955414756	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
akgpkj8rmabby58uyeyag9stijw	2023-02-09 15:10:14.585839+00	c49q5wfok97ghujoyxiaqitzdry	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955414761	1675955414761	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
au7ctdfpqgtrf3xksx398ux3e5h	2023-02-09 15:10:14.585839+00	casdocyctotyajr5mb6kehetz1a	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414766	1675955414766	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
aip8b45tfj3bp3dduxap3wn7g1a	2023-02-09 15:10:14.585839+00	chcs5bmiyftf1fjfpiaoeewpgba	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955414771	1675955414771	0	\N	system		system	bazsdbbtz87gjp8ud7jkskiqzuc
vq5gp9utjdfgaxfzyoh1xbiyieh	2023-02-09 15:10:15.027456+00		1	view	All Users	{"cardOrder":["cmunfwxy6kif48jhg8g8do7wnpy"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"aaebj5fyx493eezx6ukxiwydgty":146,"acjq4t5ymytu8x1f68wkggm7ypc":222,"akrxgi7p7w14fym3gbynb98t9fh":131,"atg9qu6oe4bjm8jczzsn71ff5me":131},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"akrxgi7p7w14fym3gbynb98t9fh","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["aaebj5fyx493eezx6ukxiwydgty","akrxgi7p7w14fym3gbynb98t9fh","atg9qu6oe4bjm8jczzsn71ff5me","acjq4t5ymytu8x1f68wkggm7ypc","aphio1s5gkmpdbwoxynim7acw3e","aqafzdeekpyncwz7m7i54q3iqqy","aify3r761b9w43bqjtskrzi68tr"]}	1675955415037	1675955415037	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cmunfwxy6kif48jhg8g8do7wnpy	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Frank Nash	{"contentOrder":["apd8tm8d9838fbczp1a5exi6nde"],"icon":"👨‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"ap93ysuzy1xa7z818r6myrn4h4y","acjq4t5ymytu8x1f68wkggm7ypc":"frank.nash@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1669896000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"aehc83ffays3gh8myz16a8j7k4e"}}	1675955415043	1675955415043	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
ceo3xece5mid4jjwaoqfs51xqch	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Richard Parsons	{"contentOrder":["a66wqjsz1yp87pb3k5sc355cpuy"],"icon":"👨‍🦱","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"richard.parsons@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671019200000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415048	1675955415048	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aogf1khixcifedyhnnxb8y5cs9a	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	Mattermost Boards helps you manage and track all your project tasks with **Cards**.	{}	1675955416752	1675955416752	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cwb6qiq5p4pgmfjnk95xz13rx4h	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Claire Hart	{"contentOrder":["a9xsae5aqafrbixp9gwjwpbqb3r"],"icon":"👩‍🦰","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"aseqq9hrsua56r3s6nbuirj9eec","acjq4t5ymytu8x1f68wkggm7ypc":"claire.hart@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1670500800000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"ahn89mqg9u4igk6pdm7333t8i5h"}}	1675955415054	1675955415054	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
co7xboyn5mfgatfdpye6nhj8ntw	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Olivia Alsop	{"contentOrder":["aitj1uj1gytfytcxxkarzf7z1sh"],"icon":"👩‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"a7yq89whddzob1futao4rxk3yzc","acjq4t5ymytu8x1f68wkggm7ypc":"olivia.alsop@email.com","aify3r761b9w43bqjtskrzi68tr":"Password123","akrxgi7p7w14fym3gbynb98t9fh":"{\\"from\\":1671192000000}","aqafzdeekpyncwz7m7i54q3iqqy":"https://user-images.githubusercontent.com/46905241/121941290-ee355280-cd03-11eb-9b9f-f6f524e4103e.gif","atg9qu6oe4bjm8jczzsn71ff5me":"a1sxagjgaadym5yrjak6tcup1oa"}}	1675955415059	1675955415059	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
c7jc13yp69bfh5q3inet8r7jqso	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	card	Bernadette Powell	{"contentOrder":["azqotjxjdhj8r7r89r9wu3jyxby"],"icon":"🧑‍💼","isTemplate":false,"properties":{"aaebj5fyx493eezx6ukxiwydgty":"af6hjb3ysuaxbwnfqpby4wwnkdr","acjq4t5ymytu8x1f68wkggm7ypc":"bernadette.powell@email.com"}}	1675955415065	1675955415065	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vcnu6wcrtrpr1umz6oeyq5kpfzr	2023-02-09 15:10:15.027456+00	bh4pkixqsjift58e1qy6htrgeay	1	view	By Date	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"akrxgi7p7w14fym3gbynb98t9fh","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415072	1675955415072	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
vi47u17fbjjbzjmdcu8z9fke64o	2023-02-09 15:10:15.027456+00	bixohg18tt11in4qbtinimk974y	1	view	By Status	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["af6hjb3ysuaxbwnfqpby4wwnkdr","aotxum1p5bw3xuzqz3ctjw66yww","a7yq89whddzob1futao4rxk3yzc","aseqq9hrsua56r3s6nbuirj9eec","ap93ysuzy1xa7z818r6myrn4h4y"],"visiblePropertyIds":[]}	1675955415107	1675955415107	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
apd8tm8d9838fbczp1a5exi6nde	2023-02-09 15:10:15.027456+00	cmunfwxy6kif48jhg8g8do7wnpy	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415117	1675955415117	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a66wqjsz1yp87pb3k5sc355cpuy	2023-02-09 15:10:15.027456+00	ceo3xece5mid4jjwaoqfs51xqch	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415123	1675955415123	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
a9xsae5aqafrbixp9gwjwpbqb3r	2023-02-09 15:10:15.027456+00	cwb6qiq5p4pgmfjnk95xz13rx4h	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415129	1675955415129	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
aitj1uj1gytfytcxxkarzf7z1sh	2023-02-09 15:10:15.027456+00	co7xboyn5mfgatfdpye6nhj8ntw	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415134	1675955415134	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
azqotjxjdhj8r7r89r9wu3jyxby	2023-02-09 15:10:15.027456+00	c7jc13yp69bfh5q3inet8r7jqso	1	text	## Interview Notes\n- ...\n- ...\n- ... 	{}	1675955415137	1675955415137	0	\N	system		system	bujaeu6ekrtdtjyx1xnaptf3szc
cc6jo65tkri8kxfy85rpyg9r8de	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	New Project and Workflow Management Solutions for Developers	{"contentOrder":["71qhnzuec6esdi6fnynwpze4xya","ah8cy7eza9tba5pmk3qfdn4ngfo"],"icon":"🎯","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1645790400000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr","a3pdzi53kpbd4okzdkz6khi87zo","a3d9ux4fmi3anyd11kyipfbhwde"],"ae9ar615xoknd8hw8py7mbyr7zo":"awna1nuarjca99m9s4uiy9kwj5h","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-launches-new-project-and-workflow-management-solutions-for-developers/","aysx3atqexotgwp5kx6h5i5ancw":"aywiofmmtd3ofgzj95ysky4pjga"}}	1675955415566	1675955415566	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
c95jy6ztp3t8pinfsftu93bs6uh	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	[Tweet] Mattermost v6.1 includes card @-mention notifications in Boards	{"contentOrder":["7i96m7nbsdsex8n6hzuzrmdfjuy","7ed5bwp3gr8yax3mhtuwiaa9gjy","ard5i9e86qjnppf8zzttwiqdsme","aogzjxtgjt38upneka4fjk7f6hh","abdasiyq4k7ndtfrdadrias8sjy","7h6rn8yhjp7bm9q4sac8hinx8ge"],"icon":"🐤","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1639051200000}","ab6mbock6styfe6htf815ph1mhw":["az8o8pfe9hq6s7xaehoqyc3wpyc"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637668800000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://twitter.com/Mattermost/status/1463145633162969097?s=20","aysx3atqexotgwp5kx6h5i5ancw":"aj8y675weso8kpb6eceqbpj4ruw"}}	1675955415576	1675955415576	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cf735gnmxwbdrd885z11f19rbyw	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Top 10 Must-Have DevOps Tools in 2021	{"contentOrder":["7fo1utqc8x1z1z6hzg33hes1ktc","apsnwcshioid6uca7ugj36paj7y"],"icon":"🛠️","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1636113600000}","ab6mbock6styfe6htf815ph1mhw":["a8xceonxiu4n3c43szhskqizicr"],"ae9ar615xoknd8hw8py7mbyr7zo":"a9ana1e9w673o5cp8md4xjjwfto","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1637323200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://www.toolbox.com/tech/devops/articles/best-devops-tools/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415586	1675955415586	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
cjfsfemn88jfx7xutwd7jwfrubo	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	card	Unblocking Workflows: The Guide to Developer Productivity	{"contentOrder":["77tz16jtz5x73ncs3dxc3fp1d7h","aqwxfnfpu9p81zxum4kyy36faso"],"icon":"💻","isTemplate":false,"properties":{"a39x5cybshwrbjpc3juaakcyj6e":"{\\"from\\":1638532800000}","ab6mbock6styfe6htf815ph1mhw":["a3pdzi53kpbd4okzdkz6khi87zo"],"ae9ar615xoknd8hw8py7mbyr7zo":"apy9dcd7zmand615p3h53zjqxjh","agqsoiipowmnu9rdwxm57zrehtr":"{\\"from\\":1639483200000}","ap4e7kdg7eip7j3c3oyiz39eaoc":"https://mattermost.com/newsroom/press-releases/mattermost-unveils-definitive-report-on-the-state-of-developer-productivity-unblocking-workflows-the-guide-to-developer-productivity-2022-edition/","aysx3atqexotgwp5kx6h5i5ancw":"a3xky7ygn14osr1mokerbfah5cy"}}	1675955415591	1675955415591	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7egzqwfr9n3gqjq6yrs9powrjby	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	image		{"fileId":"7ek6wbpp19jfoujs1goh6kttbby.gif"}	1675955416755	1675955416755	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vywt3ibumzp8tdg4wm67j5km7ma	2023-02-09 15:10:15.260316+00		1	view	Competitor List	{"cardOrder":["cinzhmm4ixiry8p5uchukeyjxuy","c43hjyntaxi8hup6dykbx4iik4h","ci6ss4aksnir9ukm1ycpbcnxihr","cptd3wkf6tt8oiq891pwj6frbbh","cf1fyfb97p7rumpmtedzawkzp4r"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":210,"a1semdhszu1rq17d7et5ydrqqio":121,"aapogff3xoa8ym7xf56s87kysda":194,"ahzspe59iux8wigra8bg6cg18nc":156,"aiefo7nh9jwisn8b4cgakowithy":155,"aozntq4go4nkab688j1s7stqtfc":151,"az3jkw3ynd3mqmart7edypey15e":145},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ahzspe59iux8wigra8bg6cg18nc","aozntq4go4nkab688j1s7stqtfc","aiefo7nh9jwisn8b4cgakowithy","a6cwaq79b1pdpb97wkanmeyy4er","an1eerzscfxn6awdfajbg41uz3h","a1semdhszu1rq17d7et5ydrqqio","aapogff3xoa8ym7xf56s87kysda","az3jkw3ynd3mqmart7edypey15e"]}	1675955415270	1675955415270	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
vr7jn5u1b7tnjmjw6tnrkxnx7uc	2023-02-09 15:10:15.260316+00		1	view	Market Position	{"cardOrder":["cip8b4jcomfr7by9gtizebikfke","cacs91js1hb887ds41r6dwnd88c","ca3u8edwrof89i8obxffnz4xw3a"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["arfjpz9by5car71tz3behba8yih","abajmr34b8g1916w495xjb35iko","abt79uxg5edqojsrrefcnr4eruo","aipf3qfgjtkheiayjuxrxbpk9wa"],"visiblePropertyIds":[]}	1675955415276	1675955415276	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cinzhmm4ixiry8p5uchukeyjxuy	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Liminary Corp.	{"contentOrder":["apypqwuyws7dxzj3g3fwk8atdse"],"icon":"🌧","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"300","ahzspe59iux8wigra8bg6cg18nc":"liminarycorp.com","aiefo7nh9jwisn8b4cgakowithy":"$25,000,000","an1eerzscfxn6awdfajbg41uz3h":"2017","aozntq4go4nkab688j1s7stqtfc":"Toronto, Canada"}}	1675955415280	1675955415280	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
c43hjyntaxi8hup6dykbx4iik4h	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Helx Industries	{"contentOrder":["az9nkkcazeiruicczj15tot913a"],"icon":"📦","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abt79uxg5edqojsrrefcnr4eruo","a6cwaq79b1pdpb97wkanmeyy4er":"650","ahzspe59iux8wigra8bg6cg18nc":"helxindustries.com","aiefo7nh9jwisn8b4cgakowithy":"$50,000,000","an1eerzscfxn6awdfajbg41uz3h":"2009","aozntq4go4nkab688j1s7stqtfc":"New York, NY"}}	1675955415284	1675955415284	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
ci6ss4aksnir9ukm1ycpbcnxihr	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Kadera Global	{"contentOrder":["asge3fu3t6inhjbz3muc4expd9c"],"icon":"🛡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"aipf3qfgjtkheiayjuxrxbpk9wa","a6cwaq79b1pdpb97wkanmeyy4er":"150","ahzspe59iux8wigra8bg6cg18nc":"kaderaglobal.com","aiefo7nh9jwisn8b4cgakowithy":"$12,000,000","an1eerzscfxn6awdfajbg41uz3h":"2015","aozntq4go4nkab688j1s7stqtfc":"Seattle, OR"}}	1675955415290	1675955415290	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cf1fyfb97p7rumpmtedzawkzp4r	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Ositions Inc.	{"contentOrder":["a48dxo8rjrpna7ke391tmepk37c"],"icon":"🌃","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"abajmr34b8g1916w495xjb35iko","a6cwaq79b1pdpb97wkanmeyy4er":"2,700","ahzspe59iux8wigra8bg6cg18nc":"ositionsinc.com","aiefo7nh9jwisn8b4cgakowithy":"$125,000,000","an1eerzscfxn6awdfajbg41uz3h":"2004","aozntq4go4nkab688j1s7stqtfc":"Berlin, Germany"}}	1675955415295	1675955415295	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cptd3wkf6tt8oiq891pwj6frbbh	2023-02-09 15:10:15.260316+00	bkqk6hpfx7pbsucue7jan5n1o1o	1	card	Afformance Ltd.	{"contentOrder":["acuyiteaixfncprpfxb6p9q65xc"],"icon":"⚡","isTemplate":false,"properties":{"a1semdhszu1rq17d7et5ydrqqio":"arfjpz9by5car71tz3behba8yih","a6cwaq79b1pdpb97wkanmeyy4er":"1,800","ahzspe59iux8wigra8bg6cg18nc":"afformanceltd.com","aiefo7nh9jwisn8b4cgakowithy":"$200,000,000","an1eerzscfxn6awdfajbg41uz3h":"2002","aozntq4go4nkab688j1s7stqtfc":"Palo Alto, CA"}}	1675955415301	1675955415301	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
apypqwuyws7dxzj3g3fwk8atdse	2023-02-09 15:10:15.260316+00	cinzhmm4ixiry8p5uchukeyjxuy	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415306	1675955415306	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
az9nkkcazeiruicczj15tot913a	2023-02-09 15:10:15.260316+00	c43hjyntaxi8hup6dykbx4iik4h	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415316	1675955415316	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
asge3fu3t6inhjbz3muc4expd9c	2023-02-09 15:10:15.260316+00	ci6ss4aksnir9ukm1ycpbcnxihr	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415329	1675955415329	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
a48dxo8rjrpna7ke391tmepk37c	2023-02-09 15:10:15.260316+00	cf1fyfb97p7rumpmtedzawkzp4r	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n\n## Weaknesses\n- ...\n- ...\n\n## Opportunities\n- ...\n- ...\n\n## Threats\n- ...\n- ...	{}	1675955415342	1675955415342	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
arqrzjjesiirobdw5t97yrnax1a	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n*[Brief description of what this epic is about]*\n## Motivation\n*[Brief description on why this is needed]*\n## Acceptance Criteria\n- *[Criteron 1]*\n- *[Criteron 2]*\n- ...\n## Personas\n- *[Persona A]*\n- *[Persona B]*\n- ...\n## Reference Materials\n- *[Links to other relevant documents as needed]*\n- ...	{}	1675955416173	1675955416173	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
acuyiteaixfncprpfxb6p9q65xc	2023-02-09 15:10:15.260316+00	cptd3wkf6tt8oiq891pwj6frbbh	1	text	## Summary\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Duis fermentum aliquet massa in ornare. Pellentesque mollis nisl efficitur, eleifend nisi congue, scelerisque nunc. Aliquam lorem quam, commodo id nunc nec, congue bibendum velit. Vivamus sed mattis libero, et iaculis diam. Suspendisse euismod hendrerit nisl, quis ornare ipsum gravida in.\n## Strengths\n- ...\n- ...\n## Weaknesses\n- ...\n- ...\n## Opportunities\n- ...\n- ...\n## Threats\n- ...\n- ...	{}	1675955415347	1675955415347	0	\N	system		system	bhaxk1xppmtgnjrxua4dsakij5e
cyhsodm36cbdh8q7kxm1j1gr8yw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	App crashing	{"contentOrder":["79t7rkiuspeneqi9xurou9tqzwh","aowo8igj7rtnp7mwapij7s3o3xa","aej4ic8nk8td7zebzhmhfh9wu6y","7xt8yx9f49jbxbpkhjce5pi5g7o"],"icon":"📉","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"cb8ecdac-38be-4d36-8712-c4d58cc8a8e9"}}	1675955416001	1675955416001	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cxjt8ekj8yfratx83ukjr1nt5dw	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Calendar view	{"contentOrder":["7df11783ny67mdnognqae31ax6y","a8xtbuofra3yyf8dms1mknwen3r"],"icon":"📆","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"849766ba-56a5-48d1-886f-21672f415395","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416006	1675955416006	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
cut844cdxxj86xqyrs9ctgecfme	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Standard templates	{"contentOrder":["7uonmjk41nipnrsi6tz8wau5ssh","ab6dzethdibbmfpwqwe5hx98pga"],"icon":"🗺️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416011	1675955416011	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ccoro58a94idw8mdo9k5rx3dx4h	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Import / Export	{"contentOrder":["a66nc7e11k78e9gm4hfude4z6dr"],"icon":"🚢","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"6eea96c9-4c61-4968-8554-4b7537e8f748","50117d52-bcc7-4750-82aa-831a351c44a0":"ec6d2bc5-df2b-4f77-8479-e59ceb039946","60985f46-3e41-486e-8213-2b987440ea1c":"c01676ca-babf-4534-8be5-cce2287daa6c","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416016	1675955416016	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c13uy7qkt57gapqc3qp61bhyjqr	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Review API design	{"contentOrder":["afw5i81na7id4jfw1wzb1qc7o6e"],"icon":"🛣️","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"424ea5e3-9aa1-4075-8c5c-01b44b66e634","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"14892380-1a32-42dd-8034-a0cea32bc7e6","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"c62172ea-5da7-4dec-8186-37267d8ee9a7"}}	1675955416022	1675955416022	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
czwsifj8cm7fabf6asnhc8fugho	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	card	Icons don't display	{"contentOrder":["azexrsotg53bp7xrf7zjogmk1fo","am796mc4hafgy7dc95e41hwfrmw","7csaz76fn9fgabquxp54stmjbne"],"icon":"💻","isTemplate":false,"properties":{"20717ad3-5741-4416-83f1-6f133fff3d11":"1fdbb515-edd2-4af5-80fc-437ed2211a49","50117d52-bcc7-4750-82aa-831a351c44a0":"8c557f69-b0ed-46ec-83a3-8efab9d47ef5","60985f46-3e41-486e-8213-2b987440ea1c":"ed4a5340-460d-461b-8838-2c56e8ee59fe","ai7ajsdk14w7x5s8up3dwir77te":"https://mattermost.com/boards/","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e":"e6a7f297-4440-4783-8ab3-3af5ba62ca11"}}	1675955416028	1675955416028	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
v9d4nczqqmtri8mb6m83qj7j9oo	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a4378omyhmgj3bex13sj4wbpfiy","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416036	1675955416035	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vrtqx3uxamfynjd7ojjm8mcu3ty	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Sprints	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cxjt8ekj8yfratx83ukjr1nt5dw","cut844cdxxj86xqyrs9ctgecfme","czwsifj8cm7fabf6asnhc8fugho","ccoro58a94idw8mdo9k5rx3dx4h","c13uy7qkt57gapqc3qp61bhyjqr"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"60985f46-3e41-486e-8213-2b987440ea1c","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["c01676ca-babf-4534-8be5-cce2287daa6c","ed4a5340-460d-461b-8838-2c56e8ee59fe","14892380-1a32-42dd-8034-a0cea32bc7e6",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416048	1675955416047	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vgf1tx6hdcfg4bnj1fpgkyfdnno	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Tasks 🔨	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":139,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["6eea96c9-4c61-4968-8554-4b7537e8f748"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"50117d52-bcc7-4750-82aa-831a351c44a0","reversed":true}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416057	1675955416057	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
azexrsotg53bp7xrf7zjogmk1fo	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416158	1675955416158	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vy4rzknwe5bdrbd8kg5sfaq7rcy	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	By Status	{"cardOrder":[null,"cdbfkd15d6iy18rgx1tskmfsr6c","cn8yofg9rtkgmzgmb5xdi56p3ic","csgsnnywpuqzs5jgq87snk9x17e","cqwaytore5y487wdu8zffppqnea",null],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["awna1nuarjca99m9s4uiy9kwj5h","a9ana1e9w673o5cp8md4xjjwfto","apy9dcd7zmand615p3h53zjqxjh","acri4cm3bmay55f7ksztphmtnga","amsowcd9a8e1kid317r7ttw6uzh",""],"visiblePropertyIds":["ab6mbock6styfe6htf815ph1mhw"]}	1675955415596	1675955415596	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vf1ywowszz3bktg6rzbj8x5w9qc	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Due Date Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"a39x5cybshwrbjpc3juaakcyj6e","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415602	1675955415602	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vca7xj7s8d3fpu856mw15dw1o8o	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Publication Calendar	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"agqsoiipowmnu9rdwxm57zrehtr","defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955415607	1675955415607	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
v6jmwqbs8hjrkipcqhjgcxyn9ge	2023-02-09 15:10:15.523642+00	brs9cdimfw7fodyi7erqt747rhc	1	view	Content List	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":322,"ab6mbock6styfe6htf815ph1mhw":229,"aysx3atqexotgwp5kx6h5i5ancw":208},"defaultTemplateId":"cff1jmrxfrirgbeebhr9qd7nida","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"a39x5cybshwrbjpc3juaakcyj6e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["ae9ar615xoknd8hw8py7mbyr7zo","aysx3atqexotgwp5kx6h5i5ancw","ab6mbock6styfe6htf815ph1mhw","ao44fz8nf6z6tuj1x31t9yyehcc","a39x5cybshwrbjpc3juaakcyj6e","agqsoiipowmnu9rdwxm57zrehtr","ap4e7kdg7eip7j3c3oyiz39eaoc"]}	1675955415613	1675955415613	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ah8cy7eza9tba5pmk3qfdn4ngfo	2023-02-09 15:10:15.523642+00	cc6jo65tkri8kxfy85rpyg9r8de	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415619	1675955415619	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
7h6rn8yhjp7bm9q4sac8hinx8ge	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	image		{"fileId":"7y5kr8x8ybpnwdykjfuz57rggrh.png"}	1675955415624	1675955415624	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ard5i9e86qjnppf8zzttwiqdsme	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415630	1675955415630	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aogzjxtgjt38upneka4fjk7f6hh	2023-02-09 15:10:15.523642+00	c95jy6ztp3t8pinfsftu93bs6uh	1	text	## Media	{}	1675955415634	1675955415634	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
akta9uxe6pp8gtbmbunotw87m3r	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415639	1675955415639	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsogn1m3ifrc9qsxzesijqcjdc	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n- ...\n\n## Notes\n- ...\n- ...\n- ...	{}	1675955415644	1675955415644	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
ap7a7kupzfffomn6sxkw73yqjmy	2023-02-09 15:10:15.523642+00	cff1jmrxfrirgbeebhr9qd7nida	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415649	1675955415649	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
apsnwcshioid6uca7ugj36paj7y	2023-02-09 15:10:15.523642+00	cf735gnmxwbdrd885z11f19rbyw	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415655	1675955415655	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
aqwxfnfpu9p81zxum4kyy36faso	2023-02-09 15:10:15.523642+00	cjfsfemn88jfx7xutwd7jwfrubo	1	text	## Research\n- ...\n- ...\n\n## Plan\n- ...\n- ...\n\n## Notes\n- ...\n- ...	{}	1675955415660	1675955415660	0	\N	system		system	bg5b5bwqbotr19ke4zt7j9q8xqr
vcqxizj9q6ibjxf4f7wkyrjqzoa	2023-02-09 15:10:15.867257+00	bjbhs6bos3m8zjouf78xceg9nqw	1	view	Board view	{"cardOrder":["cniwb8xwcqtbstbcm3sdfrr854h","cs4qwpzr65fgttd7364dicskanh","c9s78pzbdg3g4jkcdjqahtnfejc","c8utmazns878jtfgtf7exyi9pee","cnobejmb6bf8e3c1w7em5z4pwyh"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aok6pgecm85qe9k5kcphzoe63ma","aq1dwbf661yx337hjcd5q3sbxwa","ar87yh5xmsswqkxmjq1ipfftfpc","akj3fkmxq7idma55mdt8sqpumyw"],"visiblePropertyIds":["aspaay76a5wrnuhtqgm97tt3rer"]}	1675955415876	1675955415876	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
ceesyxk3sy38tidayxrqw8etwth	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Tight deadline	{"contentOrder":[],"icon":"📅","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"ar87yh5xmsswqkxmjq1ipfftfpc"}}	1675955415882	1675955415882	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmptymjj19b8xjdzzksdhuytehy	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Team communication	{"contentOrder":[],"icon":"💬","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415888	1675955415888	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cmi544mdhx7yufmibt1cmatep6a	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Reschedule planning meeting	{"contentOrder":[],"icon":"🗓️","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aok6pgecm85qe9k5kcphzoe63ma"}}	1675955415893	1675955415893	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
c4p4skb74yjgwjc3ke1jd5tekrr	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Schedule more time for testing	{"contentOrder":[],"icon":"🧪","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"akj3fkmxq7idma55mdt8sqpumyw"}}	1675955415899	1675955415899	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
cqngo6k4i4b8pfb9enafb3hwhyw	2023-02-09 15:10:15.867257+00	bsjd59qtpbf888mqez3ge77domw	1	card	Positive user feedback	{"contentOrder":[],"icon":"🥰","isTemplate":false,"properties":{"adjckpdotpgkz7c6wixzw9ipb1e":"aq1dwbf661yx337hjcd5q3sbxwa"}}	1675955415904	1675955415904	0	\N	system		system	b6p46z69w8pdyzd8xyn6mg9xxmr
vew7eb6b56fn8mk91duwjxdohar	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	Board: Status	{"cardOrder":["cyhsodm36cbdh8q7kxm1j1gr8yw","cm4w7cc3aac6s9jdcujbs4j8f4r","c6egh6cpnj137ixdoitsoxq17oo","cct9u78utsdyotmejbmwwg66ihr","cmft87it1q7yebbd51ij9k65xbw","c9fe77j9qcruxf4itzib7ag6f1c","coup7afjknqnzbdwghiwbsq541w","c5ex1hndz8qyc8gx6ofbfeksftc"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"cidz4imnqhir48brz6e8hxhfrhy","filter":{"filters":[],"operation":"and"},"groupById":"50117d52-bcc7-4750-82aa-831a351c44a0","hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"board","visibleOptionIds":["8c557f69-b0ed-46ec-83a3-8efab9d47ef5","ec6d2bc5-df2b-4f77-8479-e59ceb039946","849766ba-56a5-48d1-886f-21672f415395",""],"visiblePropertyIds":["20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416064	1675955416064	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
vdkcaex5b6tfy9gwkffyhczg8dy	2023-02-09 15:10:15.990252+00	bui5izho7dtn77xg3thkiqprc9r	1	view	List: Bugs 🐞	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"50117d52-bcc7-4750-82aa-831a351c44a0":145,"__title":280},"defaultTemplateId":"","filter":{"filters":[{"condition":"includes","propertyId":"20717ad3-5741-4416-83f1-6f133fff3d11","values":["1fdbb515-edd2-4af5-80fc-437ed2211a49"]}],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[{"propertyId":"f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e","reversed":false}],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["50117d52-bcc7-4750-82aa-831a351c44a0","20717ad3-5741-4416-83f1-6f133fff3d11","60985f46-3e41-486e-8213-2b987440ea1c","f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e"]}	1675955416071	1675955416071	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7xt8yx9f49jbxbpkhjce5pi5g7o	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	image		{"fileId":"77pe9r4ckbin438ph3f18bpatua.png"}	1675955416077	1675955416077	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aowo8igj7rtnp7mwapij7s3o3xa	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Steps to reproduce the behavior\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n*[A clear and concise description of what you expected to happen.]*\n\n## Edition and Platform\n- Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n- Version: *[e.g. v0.9.0]*\n- Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n*[Add any other context about the problem here.]*	{}	1675955416085	1675955416085	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
aej4ic8nk8td7zebzhmhfh9wu6y	2023-02-09 15:10:15.990252+00	cyhsodm36cbdh8q7kxm1j1gr8yw	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416091	1675955416091	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a8xtbuofra3yyf8dms1mknwen3r	2023-02-09 15:10:15.990252+00	cxjt8ekj8yfratx83ukjr1nt5dw	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416097	1675955416097	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ab6dzethdibbmfpwqwe5hx98pga	2023-02-09 15:10:15.990252+00	cut844cdxxj86xqyrs9ctgecfme	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416102	1675955416102	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsq6tift1pg43cqxh6ptkf8s4a	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416107	1675955416107	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a7qy7p9y4qbgwim4qheaoyh56se	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Screenshots\nIf applicable, add screenshots to elaborate on the problem.	{}	1675955416113	1675955416113	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
asqe7das383fd8bsg6ki5k3j5de	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\nA clear and concise description of what you expected to happen.\n\n## Edition and Platform\n\n - Edition: Personal Desktop / Personal Server / Mattermost plugin\n - Version: [e.g. v0.9.0]\n - Browser and OS: [e.g. Chrome 91 on macOS, Edge 93 on Windows]\n\n## Additional context\n\nAdd any other context about the problem here.	{}	1675955416119	1675955416119	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
agsg7r9qcppnjmbm4io1zxkqpfe	2023-02-09 15:10:15.990252+00	cfefgwjke6bbxpjpig618g9bpte	1	text	## Steps to reproduce the behavior\n\n1. Go to ...\n2. Select  ...\n3. Scroll down to ...\n4. See error\n\n## Expected behavior\n\n*[A clear and concise description of what you expected to happen.]*\n\n## Screenshots\n\n*[If applicable, add screenshots to elaborate on the problem.]*\n\n## Edition and Platform\n\n - Edition: *[e.g. Personal Desktop / Personal Server / Mattermost plugin]*\n - Version: *[e.g. v0.9.0]*\n - Browser and OS: *[e.g. Chrome 91 on macOS, Edge 93 on Windows]*\n\n## Additional context\n\n*[Add any other context about the problem here.]*	{}	1675955416123	1675955416123	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a66nc7e11k78e9gm4hfude4z6dr	2023-02-09 15:10:15.990252+00	ccoro58a94idw8mdo9k5rx3dx4h	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416128	1675955416128	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
a1dihou959jr7trof8zpknymz3h	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Description\n*[Brief description of this task]*\n\n## Requirements\n- *[Requirement 1]*\n- *[Requirement 2]*\n- ...	{}	1675955416134	1675955416134	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
ahbfddu6t6i8mzmtsdmedda4tgh	2023-02-09 15:10:15.990252+00	cidz4imnqhir48brz6e8hxhfrhy	1	text	## Requirements\n- [Requirement 1]\n- [Requirement 2]\n- ...	{}	1675955416138	1675955416138	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
afw5i81na7id4jfw1wzb1qc7o6e	2023-02-09 15:10:15.990252+00	c13uy7qkt57gapqc3qp61bhyjqr	1	text	## Summary\n*[Brief description of what this epic is about]*\n\n## Motivation\n*[Brief description on why this is needed]*\n\n## Acceptance Criteria\n - *[Criteron 1]*\n - *[Criteron 2]*\n - ...\n\n## Personas\n - *[Persona A]*\n - *[Persona B]*\n - ...\n\n## Reference Materials\n - *[Links to other relevant documents as needed]*\n - ...	{}	1675955416144	1675955416144	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7csaz76fn9fgabquxp54stmjbne	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	image		{"fileId":"7pbp4qg415pbstc6enzeicnu3qh.png"}	1675955416149	1675955416149	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
am796mc4hafgy7dc95e41hwfrmw	2023-02-09 15:10:15.990252+00	czwsifj8cm7fabf6asnhc8fugho	1	text	## Screenshots\n*[If applicable, add screenshots to elaborate on the problem.]*	{}	1675955416154	1675955416154	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
7nsow3b1arbrnzmjybgu9axwtte	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	image		{"fileId":"7iw4rxx7jj7bypmdotd9z469cyh.png"}	1675955416743	1675955416743	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aszhiqtytuty4888t8dii87td1w	2023-02-09 15:10:15.990252+00	cwrq9ag3p5pgzzy98nfd3wwra1w	1	text	## Summary\n[Brief description of what this epic is about]\n\n## Motivation\n[Brief description on why this is needed]\n\n## Acceptance Criteria\n - [Criteron 1]\n - [Criteron 2]\n - ...\n\n## Personas\n - [Persona A]\n - [Persona B]\n - ...\n\n## Reference Materials\n - [Links to other relevant documents as needed]\n - ...	{}	1675955416179	1675955416179	0	\N	system		system	bhqt3na6kk78afbkt11p7rw1eha
c5wz7jz8at3gx8brn8jcz7u3ujh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Drag cards	{"contentOrder":["apktbgtee5jb8xrnqy3ibiujxew","aanpn1chdbirddfu4obqi3rieew"],"icon":"🤏","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#dragging-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416560	1675955416560	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
c561c93bfjjyp7gsda4qk6d9dca	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Manage tasks with cards	{"contentOrder":["azz8hdz4357fq8fwghbqz7e88ww","71wbc54cp57yw5x84ih1u7b3bxw","7zudf4ytye3y69dtwtfkagbi7zh","784uu3ufcgb878ky7hyugmf6xcw","7kc44wypp1jnzmm3qh7ocx3t69e","7w4sjknti5pyd5kbkpoba1tkf8h","7gr65cgf58bgzmfun9odcmk14hr","7nb8y7jyoetro8cd36qcju53z8c","7413u4xnrebnf5gypfbzc3yokce","7htefhgxktin4fnfcac7ncuty3a","76nwb9tqfsid5jx46yw34itqima","7dy3mcgzgybf1ifa3emgewkzj7e","a5ca6tii33bfw8ba36y1rswq3he","7876od6xhffr6fy69zeogag7eyw","7x7bq9awkatbm5x4docbh5gaw4y","7ghpx9qff43dgtke1rwidmge1ho","7nb8y7jyoetro8cd36qcju53z8c","7hdyxemhbytfm3m83g88djq9nhr","7pgnejxokubbe9kdrxj6g9qa41e","7hw9z6qtx8jyizkmm9g5yq3gxcy","7gk6ooz6npbb8by5rgp9aig7tua","7ny8o9rq7e3rsbyoogjmgetgspa"],"icon":"☑️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416566	1675955416566	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ct5kpq5rgqidtik98waz1m5fdqo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create your own board	{"contentOrder":["at1gc3nj44pfmtchdhm463rsugr","atkhpnbj8qjgyzyac48o36u4xpw","7r9my1yuddbn45dojrfht3neg8c","7eir5gdjxgjbsxpbyp3df4npcze","7qp41kosg67bkbppoqt1c64yu6h"],"icon":"📋","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-boards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416570	1675955416570	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
chwbzoteop38obrffjnbye8kkph	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share a board	{"contentOrder":["aj9qonaknubbcjc3txbjxqo5y7a","aqop7km57rpnpmfg6mro767ukaa","7r7asyew8d7fyunf4sow8e5iyoc","ad8j3n8tp77bppee3ipjt6odgpe","7w935usqt6pby8qz9x5pxaj7iow","7ogbs8h6q4j8z7ngy1m7eag63nw","7z1jau5qy3jfcxdp5cgq3duk6ne","7j9bhj4sh8iytxpnu1o1gpfyh6o"],"icon":"📤","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/sharing-boards.html","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416574	1675955416574	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
crkth4zwoppf6me17xb1sf7m7wr	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new card	{"contentOrder":["aogf1khixcifedyhnnxb8y5cs9a","adhsx4h5ss7rqdcjt8xyam6xtqc","a1enn3jnusffjuc4ciqrfc197fr","7me9p46gbqiyfmfnapi7dyxb5br","7nsow3b1arbrnzmjybgu9axwtte"],"icon":"📝","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-cards","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"amm6wfhnbuxojwssyftgs9dipqe","acypkejeb5yfujhj9te57p9kaxw":"aanaehcw3m13jytujsjk5hpf6ry"}}	1675955416580	1675955416579	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cafahsprdajymd83b1dzr4sj91w	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Share cards on Channels	{"contentOrder":["akr4w845sp3dgty4cayg6wrz96a","ai4qtbj8quiywfxdrorts7dsf3h","aoe9xan7bat8imn45t4x4knq11e","7egzqwfr9n3gqjq6yrs9powrjby"],"icon":"📮","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#share-card-previews","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416595	1675955416595	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
copdhfsz6e3gg3yqcofmw7uc8ah	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Filter and sort cards	{"contentOrder":["a4fz9kcfs9ibj8puk9mux7ac94c","ac97q9macgtgg8nawsmwyhsbwca","78i8aqjmqtibr7x4okhz6uqquqr","714ymz3mujfdi9c1u56g5hsw8bh"],"icon":"🎛️","isTemplate":false,"properties":{"a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416605	1675955416605	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cdy86cwon13n85k1498uqgckjmo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Create a new view	{"contentOrder":["aozbezukpgif3jpbsq7tahmmp5e","agzxxkj19tfd5zxwje151ma8d4w","7owai1ux3h3gtf8byynfk6hyx1c","7n8jq1dizyfgotby3o91arf1hxh","77y4wffj1ctg7xmm9bx45qn6q6o","7xbpdkw5rdtgfjrajorxz9z1m5a"],"icon":"👓","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/working-with-boards.html#adding-new-views","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416610	1675955416610	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ccosx7u14o3b9bngcrskhb59umo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	Add new properties	{"contentOrder":["aaj9oncuimtfeigzof3jn3j1kka","ayhk11qsuz789fk8bqae4oz8mro","7gc3z8cf8rirgfyutwoke9nn6jy","76cinqnb6k3dzmfbm9fnc8eofny","7u7omjjrqmpfwzghn1jsa4ha47w"],"icon":"🏷️","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#add-and-manage-properties","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"af3p8ztcyxgn8wd9z4az7o9tjeh","acypkejeb5yfujhj9te57p9kaxw":"ascd7nm9r491ayot8i86g1gmgqw"}}	1675955416615	1675955416615	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
cd1hudbdx63dt7mym7hxee6kzrc	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	card	@mention teammates	{"contentOrder":["ay7zz768zs7gb5e1h8qximpwq9a","an3ts498ri7bwffx31agx89zzuw","7mbw9t71hjbrydgzgkqqaoh8usr","7ttgph9jfotfxzphrb1wmyjzw1c"],"icon":"🔔","isTemplate":false,"properties":{"a4nfnb5xr3txr5xq7y9ho7kyz6c":"https://docs.mattermost.com/boards/work-with-cards.html#mention-people","a972dc7a-5f4c-45d2-8044-8c28c69717f1":"ajurey3xkocs1nwx8di5zx6oe7o","acypkejeb5yfujhj9te57p9kaxw":"aq6ukoiciyfctgwyhwzpfss8ghe"}}	1675955416619	1675955416619	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
a1enn3jnusffjuc4ciqrfc197fr	2023-02-09 15:10:16.551755+00	crkth4zwoppf6me17xb1sf7m7wr	1	text	To create a new card, simply do any of the following:\n- Select "**New**" on the top right header\n- Select "**+ New**" below any column\n- Select "**+**" to the right of any columnn header	{}	1675955416748	1675955416748	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vknytio9am3r1ip5xkn179ymuac	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Table View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{"__title":280,"a972dc7a-5f4c-45d2-8044-8c28c69717f1":100,"acypkejeb5yfujhj9te57p9kaxw":169},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"table","visibleOptionIds":[],"visiblePropertyIds":["a972dc7a-5f4c-45d2-8044-8c28c69717f1","aqh13jabwexjkzr3jqsz1i1syew","acmg7mz1rr1eykfug4hcdpb1y1o","acypkejeb5yfujhj9te57p9kaxw"]}	1675955416625	1675955416625	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vprztdsecdb888pw11kzogsysde	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Calendar View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"dateDisplayPropertyId":"acmg7mz1rr1eykfug4hcdpb1y1o","defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"calendar","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416633	1675955416633	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vyc7c3kwj6ibn7y8cr6rqwdtjwo	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Preview: Gallery View	{"cardOrder":[],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"hiddenOptionIds":[],"kanbanCalculations":{},"sortOptions":[],"viewType":"gallery","visibleOptionIds":[],"visiblePropertyIds":["__title"]}	1675955416640	1675955416640	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
vuiygiikw4bywbyxto8n4ekg8gh	2023-02-09 15:10:16.551755+00	buixxjic3xjfkieees4iafdrznc	1	view	Onboarding	{"cardOrder":["crkth4zwoppf6me17xb1sf7m7wr","c561c93bfjjyp7gsda4qk6d9dca","ct5kpq5rgqidtik98waz1m5fdqo","cafahsprdajymd83b1dzr4sj91w","ccosx7u14o3b9bngcrskhb59umo","cdy86cwon13n85k1498uqgckjmo","cd1hudbdx63dt7mym7hxee6kzrc","c5wz7jz8at3gx8brn8jcz7u3ujh","chwbzoteop38obrffjnbye8kkph","copdhfsz6e3gg3yqcofmw7uc8ah"],"collapsedOptionIds":[],"columnCalculations":{},"columnWidths":{},"defaultTemplateId":"","filter":{"filters":[],"operation":"and"},"groupById":"a972dc7a-5f4c-45d2-8044-8c28c69717f1","hiddenOptionIds":[""],"kanbanCalculations":{},"sortOptions":[],"viewType":"board","visibleOptionIds":["aqb5x3pt87dcc9stbk4ofodrpoy","a1mtm777bkagq3iuu7xo9b13qfr","auxbwzptiqzkii5r61uz3ndsy1r","aj9386k1bx8qwmepeuxg3b7z4pw"],"visiblePropertyIds":[]}	1675955416646	1675955416646	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aanpn1chdbirddfu4obqi3rieew	2023-02-09 15:10:16.551755+00	c5wz7jz8at3gx8brn8jcz7u3ujh	1	text	Mattermost Boards makes it easy for you to update certain properties on cards through our drag and drop functionality. Simply drag this card from the **Later** column to the **Completed** column to automatically update the status and mark this task as complete.	{}	1675955416652	1675955416652	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7kc44wypp1jnzmm3qh7ocx3t69e	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Assign tasks to teammates	{"value":false}	1675955416657	1675955416657	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ny8o9rq7e3rsbyoogjmgetgspa	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Create and manage checklists, like this one... :)	{"value":false}	1675955416664	1675955416664	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7w4sjknti5pyd5kbkpoba1tkf8h	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Add and update descriptions with Markdown	{"value":false}	1675955416670	1675955416670	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7413u4xnrebnf5gypfbzc3yokce	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Follow cards to get notified on the latest updates	{"value":false}	1675955416675	1675955416675	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
71wbc54cp57yw5x84ih1u7b3bxw	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Set priorities and update statuses	{"value":false}	1675955416681	1675955416681	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7gr65cgf58bgzmfun9odcmk14hr	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Provide feedback and ask questions via comments	{"value":false}	1675955416687	1675955416687	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7htefhgxktin4fnfcac7ncuty3a	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	@mention teammates so they can follow, and collaborate on, comments and descriptions	{"value":false}	1675955416693	1675955416693	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7zudf4ytye3y69dtwtfkagbi7zh	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	checkbox	Manage deadlines and milestones	{"value":false}	1675955416701	1675955416700	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
azz8hdz4357fq8fwghbqz7e88ww	2023-02-09 15:10:16.551755+00	c561c93bfjjyp7gsda4qk6d9dca	1	text	Cards allow your entire team to manage and collaborate on a task in one place. Within a card, your team can:	{}	1675955416707	1675955416707	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7qp41kosg67bkbppoqt1c64yu6h	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	image		{"fileId":"74uia99m9btr8peydw7oexn37tw.gif"}	1675955416713	1675955416713	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
at1gc3nj44pfmtchdhm463rsugr	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	A board helps you manage your project, organize tasks, and collaborate with your team all in one place.	{}	1675955416717	1675955416717	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
atkhpnbj8qjgyzyac48o36u4xpw	2023-02-09 15:10:16.551755+00	ct5kpq5rgqidtik98waz1m5fdqo	1	text	To create your own board, select the "+" on the top of the left hand sidebar. Choose from one of our standard templates and see how they can help you get started with your next project:\n\n- **Project Tasks**: Stay on top of your project tasks, track progress, and set priorities. \n- **Meeting Agenda**: Set your meeting agendas for recurring team meetings and 1:1s.\n- **Roadmap**: Plan your roadmap and manage your releases more efficiently.\n- **Personal Tasks**: Organize your life and track your personal tasks.\n- **Content Calendar**: Plan your editorial content, assign work, and track deadlines.\n- **Personal Goals**: Set and accomplish new personal goals and milestones.	{}	1675955416722	1675955416722	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7j9bhj4sh8iytxpnu1o1gpfyh6o	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	image		{"fileId":"7knxbyuiedtdafcgmropgkrtybr.gif"}	1675955416728	1675955416728	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aj9qonaknubbcjc3txbjxqo5y7a	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	Keep stakeholders and customers up-to-date on project progress by sharing your board.	{}	1675955416733	1675955416733	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aqop7km57rpnpmfg6mro767ukaa	2023-02-09 15:10:16.551755+00	chwbzoteop38obrffjnbye8kkph	1	text	To share a board, select **Share** at the top right of the Board view. Copy the link to share the board internally with your team or generate public link that can be accessed by anyone externally.	{}	1675955416738	1675955416738	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aoe9xan7bat8imn45t4x4knq11e	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	After you've copied the link, paste it into any channel or Direct Message to share the card. A preview of the card will display within the channel with a link back to the card on Boards.	{}	1675955416760	1675955416760	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ai4qtbj8quiywfxdrorts7dsf3h	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	To share a card, you'll need to copy the card link first. You can:\n\n- Open a card and select the options menu button at the top right of the card.\n- Open the board view and hover your mouse over any card to access the options menu button.	{}	1675955416765	1675955416765	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
akr4w845sp3dgty4cayg6wrz96a	2023-02-09 15:10:16.551755+00	cafahsprdajymd83b1dzr4sj91w	1	text	Cards can be linked and shared with teammates directly on Channels. Card previews are displayed when shared on Channels, so your team can discuss work items and get the relevant context without having to switch over to Boards.	{}	1675955416769	1675955416769	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
714ymz3mujfdi9c1u56g5hsw8bh	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	image		{"fileId":"7dybb6t8fj3nrdft7nerhuf784y.png"}	1675955416774	1675955416774	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ac97q9macgtgg8nawsmwyhsbwca	2023-02-09 15:10:16.551755+00	copdhfsz6e3gg3yqcofmw7uc8ah	1	text	Organize and find the cards you're looking for with our filter, sort, and grouping options. From the Board header, you can quickly toggle on different properties, change the group display, set filters, and change how the cards are sorted.	{}	1675955416779	1675955416779	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7xbpdkw5rdtgfjrajorxz9z1m5a	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	image		{"fileId":"78jws5m1myf8pufewzkaa6i11sc.gif"}	1675955416783	1675955416783	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
agzxxkj19tfd5zxwje151ma8d4w	2023-02-09 15:10:16.551755+00	cdy86cwon13n85k1498uqgckjmo	1	text	Views allow your team to visualize the same cards and data from different perspectives, so they can stay up-to-date in the way that works best for them. To add a new view, go to **Add a new view** from the view drop-down, then select from any of the following views:\n\n- **Board**: Adds a Kanban board, similar to this one, that allows your team to organize cards in swimlanes grouped by any property of your choosing. This view helps you visualize your project progress.\n- **Table**: Displays cards in a table format with rows and columns. Use this view to get an overview of all your project tasks. Easily view and compare the state of all properties across all cards without needing to open individual cards.\n- **Gallery**: Displays cards in a gallery format, so you can manage and organize cards with image attachments.\n- **Calendar**: Adds a calendar view to easily visualize your cards by dates and keep track of deadlines.	{}	1675955416786	1675955416786	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7u7omjjrqmpfwzghn1jsa4ha47w	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	image		{"fileId":"7d6hrtig3zt8f9cnbo1um5oxx3y.gif"}	1675955416790	1675955416790	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
aaj9oncuimtfeigzof3jn3j1kka	2023-02-09 15:10:16.551755+00	ccosx7u14o3b9bngcrskhb59umo	1	text	Customize cards to fit your needs and track the information most important to you. Boards supports a wide range of fully customizable property types. For example, you can:\n- Use the **Date** property for things like deadlines or milestones.\n- Assign owners to tasks with the **Person** property.\n- Define statuses and priorities with the **Select** property.\n- Create tags with the **Multi Select** property.\n- Link cards to webpages with the **URL** property.	{}	1675955416794	1675955416794	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
7ttgph9jfotfxzphrb1wmyjzw1c	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	image		{"fileId":"74nt9eqzea3ydjjpgjtsxcjgrxc.gif"}	1675955416799	1675955416799	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
an3ts498ri7bwffx31agx89zzuw	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	To mention a teammate use the **@ symbol with their username** in the comments or description section. They'll get a Direct Message notification via Channels and also be added as a [follower](https://docs.mattermost.com/boards/work-with-cards.html#receive-updates) to the card. \n\nWhenever any changes are made to the card, they'll automatically get notified on Channels.	{}	1675955416803	1675955416803	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
ay7zz768zs7gb5e1h8qximpwq9a	2023-02-09 15:10:16.551755+00	cd1hudbdx63dt7mym7hxee6kzrc	1	text	Collaborate with teammates directly on each card using @mentions and have all the relevant context in one place.	{}	1675955416807	1675955416807	0	\N	system		system	bgddz141a8j8kdp69mnntpbgoor
\.


--
-- Data for Name: focalboard_board_members; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members (board_id, user_id, roles, scheme_admin, scheme_editor, scheme_commenter, scheme_viewer) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	system		t	f	f	f
ba4tbc4q9kb8ytjfs9kgx7jzjqy	system		t	f	f	f
b7ziufq456id898g6qn6hocdahe	system		t	f	f	f
bzuetargh8tfgtdj4tt8t9w6ora	system		t	f	f	f
bhiem3kc7pj85585qw3abgs7psa	system		t	f	f	f
bdjegdwuc3fr3jxmg7sgcn6mtww	system		t	f	f	f
bazsdbbtz87gjp8ud7jkskiqzuc	system		t	f	f	f
bujaeu6ekrtdtjyx1xnaptf3szc	system		t	f	f	f
bhaxk1xppmtgnjrxua4dsakij5e	system		t	f	f	f
bg5b5bwqbotr19ke4zt7j9q8xqr	system		t	f	f	f
b6p46z69w8pdyzd8xyn6mg9xxmr	system		t	f	f	f
bhqt3na6kk78afbkt11p7rw1eha	system		t	f	f	f
bgddz141a8j8kdp69mnntpbgoor	system		t	f	f	f
\.


--
-- Data for Name: focalboard_board_members_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_board_members_history (board_id, user_id, action, insert_at) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	system	created	2023-02-09 15:10:10.890716+00
ba4tbc4q9kb8ytjfs9kgx7jzjqy	system	created	2023-02-09 15:10:12.184233+00
b7ziufq456id898g6qn6hocdahe	system	created	2023-02-09 15:10:12.811408+00
bzuetargh8tfgtdj4tt8t9w6ora	system	created	2023-02-09 15:10:14.168649+00
bhiem3kc7pj85585qw3abgs7psa	system	created	2023-02-09 15:10:14.420936+00
bdjegdwuc3fr3jxmg7sgcn6mtww	system	created	2023-02-09 15:10:14.582178+00
bazsdbbtz87gjp8ud7jkskiqzuc	system	created	2023-02-09 15:10:15.023543+00
bujaeu6ekrtdtjyx1xnaptf3szc	system	created	2023-02-09 15:10:15.256418+00
bhaxk1xppmtgnjrxua4dsakij5e	system	created	2023-02-09 15:10:15.51612+00
bg5b5bwqbotr19ke4zt7j9q8xqr	system	created	2023-02-09 15:10:15.85282+00
b6p46z69w8pdyzd8xyn6mg9xxmr	system	created	2023-02-09 15:10:15.987721+00
bhqt3na6kk78afbkt11p7rw1eha	system	created	2023-02-09 15:10:16.508824+00
bgddz141a8j8kdp69mnntpbgoor	system	created	2023-02-09 15:10:17.158334+00
\.


--
-- Data for Name: focalboard_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	2023-02-09 15:10:10.121663+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675955410124	1675955410124	0	
ba4tbc4q9kb8ytjfs9kgx7jzjqy	2023-02-09 15:10:10.921795+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675955410925	1675955410925	0	
b7ziufq456id898g6qn6hocdahe	2023-02-09 15:10:12.186101+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675955412192	1675955412192	0	
bzuetargh8tfgtdj4tt8t9w6ora	2023-02-09 15:10:12.994972+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675955412997	1675955412997	0	
bhiem3kc7pj85585qw3abgs7psa	2023-02-09 15:10:14.174793+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675955414178	1675955414178	0	
bdjegdwuc3fr3jxmg7sgcn6mtww	2023-02-09 15:10:14.424408+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675955414427	1675955414427	0	
bazsdbbtz87gjp8ud7jkskiqzuc	2023-02-09 15:10:14.585839+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675955414592	1675955414592	0	
bujaeu6ekrtdtjyx1xnaptf3szc	2023-02-09 15:10:15.027456+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675955415030	1675955415030	0	
bg5b5bwqbotr19ke4zt7j9q8xqr	2023-02-09 15:10:15.523642+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675955415541	1675955415541	0	
b6p46z69w8pdyzd8xyn6mg9xxmr	2023-02-09 15:10:15.867257+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675955415870	1675955415870	0	
bhaxk1xppmtgnjrxua4dsakij5e	2023-02-09 15:10:15.260316+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675955415264	1675955415264	0	
bhqt3na6kk78afbkt11p7rw1eha	2023-02-09 15:10:15.990252+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675955415996	1675955415996	0	
bgddz141a8j8kdp69mnntpbgoor	2023-02-09 15:10:16.551755+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675955416554	1675955416554	0	
\.


--
-- Data for Name: focalboard_boards_history; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_boards_history (id, insert_at, team_id, channel_id, created_by, modified_by, type, title, description, icon, show_description, is_template, template_version, properties, card_properties, create_at, update_at, delete_at, minimum_role) FROM stdin;
bgrnqmugsw3gijk4i4iynp6b15o	2023-02-09 15:10:10.121663+00	0		system	system	O	Meeting Agenda 	Use this template for recurring meeting agendas, like team meetings and 1:1's. To use this board:\n* Participants queue new items to discuss under "To Discuss"\n* Go through items during the meeting\n* Move items to Done or Revisit Later as needed	🍩	t	t	6	{"trackingTemplateId": "54fcf9c610f0ac5e4c522c0657c90602"}	[{"id": "d777ba3b-8728-40d1-87a6-59406bbbbfb0", "name": "Status", "type": "select", "options": [{"id": "34eb9c25-d5bf-49d9-859e-f74f4e0030e7", "color": "propColorPink", "value": "To Discuss 💬"}, {"id": "d37a61f4-f332-4db9-8b2d-5e0a91aa20ed", "color": "propColorYellow", "value": "Revisit Later ⏳"}, {"id": "dabadd9b-adf1-4d9f-8702-805ac6cef602", "color": "propColorGreen", "value": "Done / Archived 📦"}]}, {"id": "4cf1568d-530f-4028-8ffd-bdc65249187e", "name": "Priority", "type": "select", "options": [{"id": "8b05c83e-a44a-4d04-831e-97f01d8e2003", "color": "propColorRed", "value": "1. High"}, {"id": "b1abafbf-a038-4a19-8b68-56e0fd2319f7", "color": "propColorYellow", "value": "2. Medium"}, {"id": "2491ffaa-eb55-417b-8aff-4bd7d4136613", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aw4w63xhet79y9gueqzzeiifdoe", "name": "Created by", "type": "createdBy", "options": []}, {"id": "a6ux19353xcwfqg9k1inqg5sg4w", "name": "Created time", "type": "createdTime", "options": []}]	1675955410124	1675955410124	0	
ba4tbc4q9kb8ytjfs9kgx7jzjqy	2023-02-09 15:10:10.921795+00	0		system	system	O	Sales Pipeline CRM	Use this template to grow and keep track of your sales opportunities.	📈	t	t	6	{"trackingTemplateId": "ecc250bb7dff0fe02247f1110f097544"}	[{"id": "a5hwxjsmkn6bak6r7uea5bx1kwc", "name": "Status", "type": "select", "options": [{"id": "akj61wc9yxdwyw3t6m8igyf9d5o", "color": "propColorGray", "value": "Lead"}, {"id": "aic89a5xox4wbppi6mbyx6ujsda", "color": "propColorYellow", "value": "Qualified"}, {"id": "ah6ehh43rwj88jy4awensin8pcw", "color": "propColorBrown", "value": "Meeting"}, {"id": "aprhd96zwi34o9cs4xyr3o9sf3c", "color": "propColorPurple", "value": "Proposal"}, {"id": "axesd74yuxtbmw1sbk8ufax7z3a", "color": "propColorOrange", "value": "Negotiation"}, {"id": "a5txuiubumsmrs8gsd5jz5gc1oa", "color": "propColorRed", "value": "Lost"}, {"id": "acm9q494bcthyoqzmfogxxy5czy", "color": "propColorGreen", "value": "Closed 🏆"}]}, {"id": "aoheuj1f3mu6eehygr45fxa144y", "name": "Account Owner", "type": "multiPerson", "options": []}, {"id": "aro91wme9kfaie5ceu9qasmtcnw", "name": "Priority", "type": "select", "options": [{"id": "apjnaggwixchfxwiatfh7ey7uno", "color": "propColorRed", "value": "High 🔥"}, {"id": "apiswzj7uiwbh87z8dw8c6mturw", "color": "propColorYellow", "value": "Medium"}, {"id": "auu9bfzqeuruyjwzzqgz7q8apuw", "color": "propColorBrown", "value": "Low"}]}, {"id": "ainpw47babwkpyj77ic4b9zq9xr", "name": "Company", "type": "text", "options": []}, {"id": "ahf43e44h3y8ftanqgzno9z7q7w", "name": "Estimated Value", "type": "number", "options": []}, {"id": "amahgyn9n4twaapg3jyxb6y4jic", "name": "Territory", "type": "select", "options": [{"id": "ar6t1ttcumgfuqugg5o4g4mzrza", "color": "propColorBrown", "value": "Western US"}, {"id": "asbwojkm7zb4ohrtij97jkdfgwe", "color": "propColorGreen", "value": "Mountain West / Central US"}, {"id": "aw8ppwtcrm8iwopdadje3ni196w", "color": "propColorGray", "value": "Mid-Atlantic / Southeast"}, {"id": "aafwyza5iwdcwcyfyj6bp7emufw", "color": "propColorBlue", "value": "Northeast US / Canada"}, {"id": "agw8rcb9uxyt3c7g6tq3r65fgqe", "color": "propColorPink", "value": "Eastern Europe"}, {"id": "as5bk6afoaaa7caewe1zc391sce", "color": "propColorPurple", "value": "Central Europe / Africa"}, {"id": "a8fj94bka8z9t6p95qd3hn6t5re", "color": "propColorYellow", "value": "Middle East"}, {"id": "arpxa3faaou9trt4zx5sh435gne", "color": "propColorOrange", "value": "UK"}, {"id": "azdidd5wze4kcxf8neefj3ctkyr", "color": "propColorRed", "value": "Asia"}, {"id": "a4jn5mhqs3thknqf5opykntgsnc", "color": "propColorGray", "value": "Australia"}, {"id": "afjbgrecb7hp5owj7xh8u4w33tr", "color": "propColorBrown", "value": "Latin America"}]}, {"id": "abru6tz8uebdxy4skheqidh7zxy", "name": "Email", "type": "email", "options": []}, {"id": "a1438fbbhjeffkexmcfhnx99o1h", "name": "Phone", "type": "phone", "options": []}, {"id": "auhf91pm85f73swwidi4wid8jqe", "name": "Last Contact Date", "type": "date", "options": []}, {"id": "adtf1151chornmihz4xbgbk9exa", "name": "Expected Close", "type": "date", "options": []}, {"id": "aejo5tcmq54bauuueem9wc4fw4y", "name": "Close Probability", "type": "text", "options": []}, {"id": "amba7ot98fh7hwsx8jdcfst5g7h", "name": "Created Date", "type": "createdTime", "options": []}]	1675955410925	1675955410925	0	
b7ziufq456id898g6qn6hocdahe	2023-02-09 15:10:12.186101+00	0		system	system	O	Personal Tasks 	Use this template to organize your life and track your personal tasks.	✔️	t	t	6	{"trackingTemplateId": "dfb70c146a4584b8a21837477c7b5431"}	[{"id": "a9zf59u8x1rf4ywctpcqama7tio", "name": "Occurrence", "type": "select", "options": [{"id": "an51dnkenmoog9cetapbc4uyt3y", "color": "propColorBlue", "value": "Daily"}, {"id": "afpy8s7i45frggprmfsqngsocqh", "color": "propColorOrange", "value": "Weekly"}, {"id": "aj4jyekqqssatjcq7r7chmy19ey", "color": "propColorPurple", "value": "Monthly"}]}, {"id": "abthng7baedhhtrwsdodeuincqy", "name": "Completed", "type": "checkbox", "options": []}]	1675955412192	1675955412192	0	
bzuetargh8tfgtdj4tt8t9w6ora	2023-02-09 15:10:12.994972+00	0		system	system	O	Project Tasks 	Use this template to stay on top of your project tasks and progress.	🎯	t	t	6	{"trackingTemplateId": "a4ec399ab4f2088b1051c3cdf1dde4c3"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "ayz81h9f3dwp7rzzbdebesc7ute", "color": "propColorBlue", "value": "Not Started"}, {"id": "ar6b8m3jxr3asyxhr8iucdbo6yc", "color": "propColorYellow", "value": "In Progress"}, {"id": "afi4o5nhnqc3smtzs1hs3ij34dh", "color": "propColorRed", "value": "Blocked"}, {"id": "adeo5xuwne3qjue83fcozekz8ko", "color": "propColorGreen", "value": "Completed 🙌"}, {"id": "ahpyxfnnrzynsw3im1psxpkgtpe", "color": "propColorBrown", "value": "Archived"}]}, {"id": "d3d682bf-e074-49d9-8df5-7320921c2d23", "name": "Priority", "type": "select", "options": [{"id": "d3bfb50f-f569-4bad-8a3a-dd15c3f60101", "color": "propColorRed", "value": "1. High 🔥"}, {"id": "87f59784-b859-4c24-8ebe-17c766e081dd", "color": "propColorYellow", "value": "2. Medium"}, {"id": "98a57627-0f76-471d-850d-91f3ed9fd213", "color": "propColorGray", "value": "3. Low"}]}, {"id": "axkhqa4jxr3jcqe4k87g8bhmary", "name": "Assignee", "type": "person", "options": []}, {"id": "a8daz81s4xjgke1ww6cwik5w7ye", "name": "Estimated Hours", "type": "number", "options": []}, {"id": "a3zsw7xs8sxy7atj8b6totp3mby", "name": "Due Date", "type": "date", "options": []}, {"id": "a7gdnz8ff8iyuqmzddjgmgo9ery", "name": "Created By", "type": "createdBy", "options": []}, {"id": "2a5da320-735c-4093-8787-f56e15cdfeed", "name": "Date Created", "type": "createdTime", "options": []}]	1675955412997	1675955412997	0	
bhiem3kc7pj85585qw3abgs7psa	2023-02-09 15:10:14.174793+00	0		system	system	O	Company Goals & OKRs	Use this template to plan your company goals and OKRs more efficiently.	⛳	t	t	6	{"trackingTemplateId": "7ba22ccfdfac391d63dea5c4b8cde0de"}	[{"id": "a6amddgmrzakw66cidqzgk6p4ge", "name": "Objective", "type": "select", "options": [{"id": "auw3afh3kfhrfgmjr8muiz137jy", "color": "propColorGreen", "value": "Grow Revenue"}, {"id": "apqfjst8massbjjhpcsjs3y1yqa", "color": "propColorOrange", "value": "Delight Customers"}, {"id": "ao9b5pxyt7tkgdohzh9oaustdhr", "color": "propColorPurple", "value": "Drive Product Adoption"}]}, {"id": "a17ryhi1jfsboxkwkztwawhmsxe", "name": "Status", "type": "select", "options": [{"id": "a6robxx81diugpjq5jkezz3j1fo", "color": "propColorGray", "value": "Not Started"}, {"id": "a8nukezwwmknqwjsygg7eaxs9te", "color": "propColorBlue", "value": "In Progress"}, {"id": "apnt1f7na9rzgk1rt49keg7xbiy", "color": "propColorYellow", "value": "At Risk"}, {"id": "axbz3m1amss335wzwf9s7pqjzxr", "color": "propColorRed", "value": "Missed"}, {"id": "abzfwnn6rmtfzyq5hg8uqmpsncy", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "azzbawji5bksj69sekcs4srm1ky", "name": "Department", "type": "select", "options": [{"id": "aw5i7hmpadn6mbwbz955ubarhme", "color": "propColorBrown", "value": "Engineering"}, {"id": "afkxpcjqjypu7hhar7banxau91h", "color": "propColorBlue", "value": "Product"}, {"id": "aehoa17cz18rqnrf75g7dwhphpr", "color": "propColorOrange", "value": "Marketing"}, {"id": "agrfeaoj7d8p5ianw5iaf3191ae", "color": "propColorGreen", "value": "Sales"}, {"id": "agm9p6gcq15ueuzqq3wd4be39wy", "color": "propColorYellow", "value": "Support"}, {"id": "aucop7kw6xwodcix6zzojhxih6r", "color": "propColorPink", "value": "Design"}, {"id": "afust91f3g8ht368mkn5x9tgf1o", "color": "propColorPurple", "value": "Finance"}, {"id": "acocxxwjurud1jixhp7nowdig7y", "color": "propColorGray", "value": "Human Resources"}]}, {"id": "adp5ft3kgz7r5iqq3tnwg551der", "name": "Priority", "type": "select", "options": [{"id": "a8zg3rjtf4swh7smsjxpsn743rh", "color": "propColorRed", "value": "P1 🔥"}, {"id": "as555ipyzopjjpfb5rjtssecw5e", "color": "propColorYellow", "value": "P2"}, {"id": "a1ts3ftyr8nocsicui98c89uxjy", "color": "propColorGray", "value": "P3"}]}, {"id": "aqxyzkdrs4egqf7yk866ixkaojc", "name": "Quarter", "type": "select", "options": [{"id": "ahfbn1jsmhydym33ygxwg5jt3kh", "color": "propColorBlue", "value": "Q1"}, {"id": "awfu37js3fomfkkczm1zppac57a", "color": "propColorBrown", "value": "Q2"}, {"id": "anruuoyez51r3yjxuoc8zoqnwaw", "color": "propColorGreen", "value": "Q3"}, {"id": "acb6dqqs6yson7bbzx6jk9bghjh", "color": "propColorPurple", "value": "Q4"}]}, {"id": "adu6mebzpibq6mgcswk69xxmnqe", "name": "Due Date", "type": "date", "options": []}, {"id": "asope3bddhm4gpsng5cfu4hf6rh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "ajwxp866f9obs1kutfwaa5ru7fe", "name": "Target", "type": "number", "options": []}, {"id": "azqnyswk6s1boiwuthscm78qwuo", "name": "Actual", "type": "number", "options": []}, {"id": "ahz3fmjnaguec8hce7xq3h5cjdr", "name": "Completion (%)", "type": "text", "options": []}, {"id": "a17bfcgnzmkwhziwa4tr38kiw5r", "name": "Note", "type": "text", "options": []}]	1675955414178	1675955414178	0	
bdjegdwuc3fr3jxmg7sgcn6mtww	2023-02-09 15:10:14.424408+00	0		system	system	O	Personal Goals 	Use this template to set and accomplish new personal goals.	⛰️	t	t	6	{"trackingTemplateId": "7f32dc8d2ae008cfe56554e9363505cc"}	[{"id": "af6fcbb8-ca56-4b73-83eb-37437b9a667d", "name": "Status", "type": "select", "options": [{"id": "bf52bfe6-ac4c-4948-821f-83eaa1c7b04a", "color": "propColorRed", "value": "To Do"}, {"id": "77c539af-309c-4db1-8329-d20ef7e9eacd", "color": "propColorYellow", "value": "Doing"}, {"id": "98bdea27-0cce-4cde-8dc6-212add36e63a", "color": "propColorGreen", "value": "Done 🙌"}]}, {"id": "d9725d14-d5a8-48e5-8de1-6f8c004a9680", "name": "Category", "type": "select", "options": [{"id": "3245a32d-f688-463b-87f4-8e7142c1b397", "color": "propColorPurple", "value": "Life Skills"}, {"id": "80be816c-fc7a-4928-8489-8b02180f4954", "color": "propColorGreen", "value": "Finance"}, {"id": "ffb3f951-b47f-413b-8f1d-238666728008", "color": "propColorOrange", "value": "Health"}]}, {"id": "d6b1249b-bc18-45fc-889e-bec48fce80ef", "name": "Target", "type": "select", "options": [{"id": "9a090e33-b110-4268-8909-132c5002c90e", "color": "propColorBlue", "value": "Q1"}, {"id": "0a82977f-52bf-457b-841b-e2b7f76fb525", "color": "propColorBrown", "value": "Q2"}, {"id": "6e7139e4-5358-46bb-8c01-7b029a57b80a", "color": "propColorGreen", "value": "Q3"}, {"id": "d5371c63-66bf-4468-8738-c4dc4bea4843", "color": "propColorPurple", "value": "Q4"}]}, {"id": "ajy6xbebzopojaenbnmfpgtdwso", "name": "Due Date", "type": "date", "options": []}]	1675955414427	1675955414427	0	
bazsdbbtz87gjp8ud7jkskiqzuc	2023-02-09 15:10:14.585839+00	0		system	system	O	Sprint Planner 	Use this template to plan your sprints and manage your releases more efficiently.	🗓️	t	t	6	{"trackingTemplateId": "99b74e26d2f5d0a9b346d43c0a7bfb09"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "aft5bzo7h9aspqgrx3jpy5tzrer", "color": "propColorGray", "value": "Not Started"}, {"id": "abrfos7e7eczk9rqw6y5abadm1y", "color": "propColorOrange", "value": "Next Up"}, {"id": "ax8wzbka5ahs3zziji3pp4qp9mc", "color": "propColorBlue", "value": "In Progress"}, {"id": "atabdfbdmjh83136d5e5oysxybw", "color": "propColorYellow", "value": "In Review"}, {"id": "ace1bzypd586kkyhcht5qqd9eca", "color": "propColorPink", "value": "Approved"}, {"id": "aay656c9m1hzwxc9ch5ftymh3nw", "color": "propColorRed", "value": "Blocked"}, {"id": "a6ghze4iy441qhsh3eijnc8hwze", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "a5yxq8rbubrpnoommfwqmty138h", "color": "propColorGray", "value": "Feature 🏗"}, {"id": "apht1nt5ryukdmxkh6fkfn6rgoy", "color": "propColorOrange", "value": "User Story 📖"}, {"id": "aiycbuo3dr5k4xxbfr7coem8ono", "color": "propColorGreen", "value": "Task ⛏"}, {"id": "aomnawq4551cbbzha9gxnmb3z5w", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "multiPerson", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Story Points", "type": "number", "options": []}, {"id": "a1g6i613dpe9oryeo71ex3c86hy", "name": "Design Link", "type": "url", "options": []}, {"id": "aeomttrbhhsi8bph31jn84sto6h", "name": "Created Time", "type": "createdTime", "options": []}, {"id": "ax9f8so418s6s65hi5ympd93i6a", "name": "Created By", "type": "createdBy", "options": []}]	1675955414592	1675955414592	0	
bujaeu6ekrtdtjyx1xnaptf3szc	2023-02-09 15:10:15.027456+00	0		system	system	O	User Research Sessions	Use this template to manage and keep track of all your user research sessions.	🔬	t	t	6	{"trackingTemplateId": "6c345c7f50f6833f78b7d0f08ce450a3"}	[{"id": "aaebj5fyx493eezx6ukxiwydgty", "name": "Status", "type": "select", "options": [{"id": "af6hjb3ysuaxbwnfqpby4wwnkdr", "color": "propColorGray", "value": "Backlog 📒"}, {"id": "aotxum1p5bw3xuzqz3ctjw66yww", "color": "propColorYellow", "value": "Contacted 📞"}, {"id": "a7yq89whddzob1futao4rxk3yzc", "color": "propColorBlue", "value": "Scheduled 📅"}, {"id": "aseqq9hrsua56r3s6nbuirj9eec", "color": "propColorRed", "value": "Cancelled 🚫"}, {"id": "ap93ysuzy1xa7z818r6myrn4h4y", "color": "propColorGreen", "value": "Completed ✔️"}]}, {"id": "akrxgi7p7w14fym3gbynb98t9fh", "name": "Interview Date", "type": "date", "options": []}, {"id": "atg9qu6oe4bjm8jczzsn71ff5me", "name": "Product Area", "type": "select", "options": [{"id": "ahn89mqg9u4igk6pdm7333t8i5h", "color": "propColorGreen", "value": "Desktop App"}, {"id": "aehc83ffays3gh8myz16a8j7k4e", "color": "propColorPurple", "value": "Web App"}, {"id": "a1sxagjgaadym5yrjak6tcup1oa", "color": "propColorBlue", "value": "Mobile App"}]}, {"id": "acjq4t5ymytu8x1f68wkggm7ypc", "name": "Email", "type": "email", "options": []}, {"id": "aphio1s5gkmpdbwoxynim7acw3e", "name": "Interviewer", "type": "multiPerson", "options": []}, {"id": "aqafzdeekpyncwz7m7i54q3iqqy", "name": "Recording URL", "type": "url", "options": []}, {"id": "aify3r761b9w43bqjtskrzi68tr", "name": "Passcode", "type": "text", "options": []}]	1675955415030	1675955415030	0	
bg5b5bwqbotr19ke4zt7j9q8xqr	2023-02-09 15:10:15.523642+00	0		system	system	O	Content Calendar 	Use this template to plan and organize your editorial content.	📅	t	t	6	{"trackingTemplateId": "c75fbd659d2258b5183af2236d176ab4"}	[{"id": "ae9ar615xoknd8hw8py7mbyr7zo", "name": "Status", "type": "select", "options": [{"id": "awna1nuarjca99m9s4uiy9kwj5h", "color": "propColorGray", "value": "Idea 💡"}, {"id": "a9ana1e9w673o5cp8md4xjjwfto", "color": "propColorOrange", "value": "Draft"}, {"id": "apy9dcd7zmand615p3h53zjqxjh", "color": "propColorPurple", "value": "In Review"}, {"id": "acri4cm3bmay55f7ksztphmtnga", "color": "propColorBlue", "value": "Ready to Publish"}, {"id": "amsowcd9a8e1kid317r7ttw6uzh", "color": "propColorGreen", "value": "Published 🎉"}]}, {"id": "aysx3atqexotgwp5kx6h5i5ancw", "name": "Type", "type": "select", "options": [{"id": "aywiofmmtd3ofgzj95ysky4pjga", "color": "propColorOrange", "value": "Press Release"}, {"id": "apqdgjrmsmx8ngmp7zst51647de", "color": "propColorGreen", "value": "Sponsored Post"}, {"id": "a3woynbjnb7j16e74uw3pubrytw", "color": "propColorPurple", "value": "Customer Story"}, {"id": "aq36k5pkpfcypqb3idw36xdi1fh", "color": "propColorRed", "value": "Product Release"}, {"id": "azn66pmk34adygnizjqhgiac4ia", "color": "propColorGray", "value": "Partnership"}, {"id": "aj8y675weso8kpb6eceqbpj4ruw", "color": "propColorBlue", "value": "Feature Announcement"}, {"id": "a3xky7ygn14osr1mokerbfah5cy", "color": "propColorYellow", "value": "Article"}]}, {"id": "ab6mbock6styfe6htf815ph1mhw", "name": "Channel", "type": "multiSelect", "options": [{"id": "a8xceonxiu4n3c43szhskqizicr", "color": "propColorBrown", "value": "Website"}, {"id": "a3pdzi53kpbd4okzdkz6khi87zo", "color": "propColorGreen", "value": "Blog"}, {"id": "a3d9ux4fmi3anyd11kyipfbhwde", "color": "propColorOrange", "value": "Email"}, {"id": "a8cbbfdwocx73zn3787cx6gacsh", "color": "propColorRed", "value": "Podcast"}, {"id": "aigjtpcaxdp7d6kmctrwo1ztaia", "color": "propColorPink", "value": "Print"}, {"id": "af1wsn13muho59e7ghwaogxy5ey", "color": "propColorBlue", "value": "Facebook"}, {"id": "a47zajfxwhsg6q8m7ppbiqs7jge", "color": "propColorGray", "value": "LinkedIn"}, {"id": "az8o8pfe9hq6s7xaehoqyc3wpyc", "color": "propColorYellow", "value": "Twitter"}]}, {"id": "ao44fz8nf6z6tuj1x31t9yyehcc", "name": "Assignee", "type": "person", "options": []}, {"id": "a39x5cybshwrbjpc3juaakcyj6e", "name": "Due Date", "type": "date", "options": []}, {"id": "agqsoiipowmnu9rdwxm57zrehtr", "name": "Publication Date", "type": "date", "options": []}, {"id": "ap4e7kdg7eip7j3c3oyiz39eaoc", "name": "Link", "type": "url", "options": []}]	1675955415541	1675955415541	0	
b6p46z69w8pdyzd8xyn6mg9xxmr	2023-02-09 15:10:15.867257+00	0		system	system	O	Team Retrospective	Use this template at the end of your project or sprint to identify what worked well and what can be improved for the future.	🧭	t	t	6	{"trackingTemplateId": "e4f03181c4ced8edd4d53d33d569a086"}	[{"id": "adjckpdotpgkz7c6wixzw9ipb1e", "name": "Category", "type": "select", "options": [{"id": "aok6pgecm85qe9k5kcphzoe63ma", "color": "propColorGray", "value": "To Discuss 📣"}, {"id": "aq1dwbf661yx337hjcd5q3sbxwa", "color": "propColorGreen", "value": "Went Well 👍"}, {"id": "ar87yh5xmsswqkxmjq1ipfftfpc", "color": "propColorRed", "value": "Didn't Go Well 🚫"}, {"id": "akj3fkmxq7idma55mdt8sqpumyw", "color": "propColorBlue", "value": "Action Items ✅"}]}, {"id": "aspaay76a5wrnuhtqgm97tt3rer", "name": "Details", "type": "text", "options": []}, {"id": "arzsm76s376y7suuhao3tu6efoc", "name": "Created By", "type": "createdBy", "options": []}, {"id": "a8anbe5fpa668sryatcdsuuyh8a", "name": "Created Time", "type": "createdTime", "options": []}]	1675955415870	1675955415870	0	
bhaxk1xppmtgnjrxua4dsakij5e	2023-02-09 15:10:15.260316+00	0		system	system	O	Competitive Analysis	Use this template to track and stay ahead of the competition.	🗂️	t	t	6	{"trackingTemplateId": "06f4bff367a7c2126fab2380c9dec23c"}	[{"id": "ahzspe59iux8wigra8bg6cg18nc", "name": "Website", "type": "url", "options": []}, {"id": "aozntq4go4nkab688j1s7stqtfc", "name": "Location", "type": "text", "options": []}, {"id": "aiefo7nh9jwisn8b4cgakowithy", "name": "Revenue", "type": "text", "options": []}, {"id": "a6cwaq79b1pdpb97wkanmeyy4er", "name": "Employees", "type": "number", "options": []}, {"id": "an1eerzscfxn6awdfajbg41uz3h", "name": "Founded", "type": "text", "options": []}, {"id": "a1semdhszu1rq17d7et5ydrqqio", "name": "Market Position", "type": "select", "options": [{"id": "arfjpz9by5car71tz3behba8yih", "color": "propColorYellow", "value": "Leader"}, {"id": "abajmr34b8g1916w495xjb35iko", "color": "propColorRed", "value": "Challenger"}, {"id": "abt79uxg5edqojsrrefcnr4eruo", "color": "propColorBlue", "value": "Follower"}, {"id": "aipf3qfgjtkheiayjuxrxbpk9wa", "color": "propColorBrown", "value": "Nicher"}]}, {"id": "aapogff3xoa8ym7xf56s87kysda", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "az3jkw3ynd3mqmart7edypey15e", "name": "Last updated by", "type": "updatedBy", "options": []}]	1675955415264	1675955415264	0	
bhqt3na6kk78afbkt11p7rw1eha	2023-02-09 15:10:15.990252+00	0		system	system	O	Roadmap 	Use this template to plan your roadmap and manage your releases more efficiently.	🗺️	t	t	6	{"trackingTemplateId": "b728c6ca730e2cfc229741c5a4712b65"}	[{"id": "50117d52-bcc7-4750-82aa-831a351c44a0", "name": "Status", "type": "select", "options": [{"id": "8c557f69-b0ed-46ec-83a3-8efab9d47ef5", "color": "propColorGray", "value": "Not Started"}, {"id": "ec6d2bc5-df2b-4f77-8479-e59ceb039946", "color": "propColorYellow", "value": "In Progress"}, {"id": "849766ba-56a5-48d1-886f-21672f415395", "color": "propColorGreen", "value": "Complete 🙌"}]}, {"id": "20717ad3-5741-4416-83f1-6f133fff3d11", "name": "Type", "type": "select", "options": [{"id": "424ea5e3-9aa1-4075-8c5c-01b44b66e634", "color": "propColorYellow", "value": "Epic ⛰"}, {"id": "6eea96c9-4c61-4968-8554-4b7537e8f748", "color": "propColorGreen", "value": "Task 🔨"}, {"id": "1fdbb515-edd2-4af5-80fc-437ed2211a49", "color": "propColorRed", "value": "Bug 🐞"}]}, {"id": "60985f46-3e41-486e-8213-2b987440ea1c", "name": "Sprint", "type": "select", "options": [{"id": "c01676ca-babf-4534-8be5-cce2287daa6c", "color": "propColorBrown", "value": "Sprint 1"}, {"id": "ed4a5340-460d-461b-8838-2c56e8ee59fe", "color": "propColorPurple", "value": "Sprint 2"}, {"id": "14892380-1a32-42dd-8034-a0cea32bc7e6", "color": "propColorBlue", "value": "Sprint 3"}]}, {"id": "f7f3ad42-b31a-4ac2-81f0-28ea80c5b34e", "name": "Priority", "type": "select", "options": [{"id": "cb8ecdac-38be-4d36-8712-c4d58cc8a8e9", "color": "propColorRed", "value": "P1 🔥"}, {"id": "e6a7f297-4440-4783-8ab3-3af5ba62ca11", "color": "propColorYellow", "value": "P2"}, {"id": "c62172ea-5da7-4dec-8186-37267d8ee9a7", "color": "propColorGray", "value": "P3"}]}, {"id": "aphg37f7zbpuc3bhwhp19s1ribh", "name": "Assignee", "type": "person", "options": []}, {"id": "a4378omyhmgj3bex13sj4wbpfiy", "name": "Due Date", "type": "date", "options": []}, {"id": "a36o9q1yik6nmar6ri4q4uca7ey", "name": "Created Date", "type": "createdTime", "options": []}, {"id": "ai7ajsdk14w7x5s8up3dwir77te", "name": "Design Link", "type": "url", "options": []}]	1675955415996	1675955415996	0	
bgddz141a8j8kdp69mnntpbgoor	2023-02-09 15:10:16.551755+00	0		system	system	O	Welcome to Boards!	Mattermost Boards is an open source project management tool that helps you organize, track, and manage work across teams. Select a card to learn more.	👋	t	t	6	{"trackingTemplateId": "65aba997282f3ac457cd66736fb86915"}	[{"id": "a972dc7a-5f4c-45d2-8044-8c28c69717f1", "name": "Status", "type": "select", "options": [{"id": "amm6wfhnbuxojwssyftgs9dipqe", "color": "propColorRed", "value": "To do 🔥"}, {"id": "af3p8ztcyxgn8wd9z4az7o9tjeh", "color": "propColorYellow", "value": "Next up"}, {"id": "ajurey3xkocs1nwx8di5zx6oe7o", "color": "propColorPurple", "value": "Later"}, {"id": "agkinkjy5983wsk6kppsujajxqw", "color": "propColorGreen", "value": "Completed 🙌"}]}, {"id": "acypkejeb5yfujhj9te57p9kaxw", "name": "Priority", "type": "select", "options": [{"id": "aanaehcw3m13jytujsjk5hpf6ry", "color": "propColorOrange", "value": "1. High"}, {"id": "ascd7nm9r491ayot8i86g1gmgqw", "color": "propColorBrown", "value": "2. Medium"}, {"id": "aq6ukoiciyfctgwyhwzpfss8ghe", "color": "propColorGray", "value": "3. Low"}]}, {"id": "aqh13jabwexjkzr3jqsz1i1syew", "name": "Assignee", "type": "person", "options": []}, {"id": "acmg7mz1rr1eykfug4hcdpb1y1o", "name": "Due Date", "type": "date", "options": []}, {"id": "amewjwfjrtpu8ha73xsrdmxazxr", "name": "Reviewed", "type": "checkbox", "options": []}, {"id": "attzzboqaz6m1sdti5xa7gjnk1e", "name": "Last updated time", "type": "updatedTime", "options": []}, {"id": "a4nfnb5xr3txr5xq7y9ho7kyz6c", "name": "Reference", "type": "url", "options": []}, {"id": "a9gzwi3dt5n55nddej6zcbhxaeh", "name": "Created by", "type": "createdBy", "options": []}]	1675955416554	1675955416554	0	
\.


--
-- Data for Name: focalboard_categories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_categories (id, name, user_id, team_id, channel_id, create_at, update_at, delete_at, collapsed, type, sort_order) FROM stdin;
\.


--
-- Data for Name: focalboard_category_boards; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_category_boards (id, user_id, category_id, board_id, create_at, update_at, sort_order, hidden) FROM stdin;
\.


--
-- Data for Name: focalboard_file_info; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_file_info (id, create_at, delete_at, name, extension, size, archived) FROM stdin;
\.


--
-- Data for Name: focalboard_notification_hints; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_notification_hints (block_type, block_id, workspace_id, modified_by_id, create_at, notify_at) FROM stdin;
\.


--
-- Data for Name: focalboard_preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_preferences (userid, category, name, value) FROM stdin;
\.


--
-- Data for Name: focalboard_schema_migrations; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_schema_migrations (version, name) FROM stdin;
1	init
2	system_settings_table
3	blocks_rootid
4	auth_table
5	blocks_modifiedby
6	sharing_table
7	workspaces_table
8	teams
9	blocks_history
10	blocks_created_by
11	match_collation
12	match_column_collation
13	millisecond_timestamps
14	add_not_null_constraint
15	blocks_history_no_nulls
16	subscriptions_table
17	add_file_info
18	add_teams_and_boards
19	populate_categories
20	populate_category_blocks
21	create_boards_members_history
22	create_default_board_role
23	persist_category_collapsed_state
24	mark_existsing_categories_collapsed
25	indexes_update
26	create_preferences_table
27	migrate_user_props_to_preferences
28	remove_template_channel_link
29	add_category_type_field
30	add_category_sort_order
31	add_category_boards_sort_order
32	move_boards_category_to_end
33	remove_deleted_category_boards
34	category_boards_remove_unused_delete_at_column
35	add_hidden_board_column
36	category_board_add_unique_constraint
37	hidden_boards_from_preferences
38	delete_hiddenBoardIDs_from_preferences
\.


--
-- Data for Name: focalboard_sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_sessions (id, token, user_id, props, create_at, update_at, auth_service) FROM stdin;
\.


--
-- Data for Name: focalboard_sharing; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_sharing (id, enabled, token, modified_by, update_at, workspace_id) FROM stdin;
\.


--
-- Data for Name: focalboard_subscriptions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_subscriptions (block_type, block_id, workspace_id, subscriber_type, subscriber_id, notified_at, create_at, delete_at) FROM stdin;
\.


--
-- Data for Name: focalboard_system_settings; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_system_settings (id, value) FROM stdin;
UniqueIDsMigrationComplete	true
TeamLessBoardsMigrationComplete	true
DeletedMembershipBoardsMigrationComplete	true
CategoryUuidIdMigrationComplete	true
TelemetryID	7yjbdy1is1ibc8mf9u9g11s1ije
DeDuplicateCategoryBoardTableComplete	true
\.


--
-- Data for Name: focalboard_teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_teams (id, signup_token, settings, modified_by, update_at) FROM stdin;
\.


--
-- Data for Name: focalboard_users; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.focalboard_users (id, username, email, password, mfa_secret, auth_service, auth_data, props, create_at, update_at, delete_at) FROM stdin;
\.


--
-- Data for Name: groupchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupchannels (groupid, autoadd, schemeadmin, createat, deleteat, updateat, channelid) FROM stdin;
\.


--
-- Data for Name: groupmembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupmembers (groupid, userid, createat, deleteat) FROM stdin;
\.


--
-- Data for Name: groupteams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.groupteams (groupid, autoadd, schemeadmin, createat, deleteat, updateat, teamid) FROM stdin;
\.


--
-- Data for Name: incomingwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.incomingwebhooks (id, createat, updateat, deleteat, userid, channelid, teamid, displayname, description, username, iconurl, channellocked) FROM stdin;
\.


--
-- Data for Name: ir_category; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_category (id, name, teamid, userid, collapsed, createat, updateat, deleteat) FROM stdin;
\.


--
-- Data for Name: ir_category_item; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_category_item (type, categoryid, itemid) FROM stdin;
\.


--
-- Data for Name: ir_channelaction; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_channelaction (id, channelid, enabled, deleteat, actiontype, triggertype, payload) FROM stdin;
\.


--
-- Data for Name: ir_incident; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_incident (id, name, description, isactive, commanderuserid, teamid, channelid, createat, endat, deleteat, activestage, postid, playbookid, checklistsjson, activestagetitle, reminderpostid, broadcastchannelid, previousreminder, remindermessagetemplate, currentstatus, reporteruserid, concatenatedinviteduserids, defaultcommanderid, announcementchannelid, concatenatedwebhookoncreationurls, concatenatedinvitedgroupids, retrospective, messageonjoin, retrospectivepublishedat, retrospectivereminderintervalseconds, retrospectivewascanceled, concatenatedwebhookonstatusupdateurls, laststatusupdateat, exportchannelonfinishedenabled, categorizechannelenabled, categoryname, concatenatedbroadcastchannelids, channelidtorootid, remindertimerdefaultseconds, statusupdateenabled, retrospectiveenabled, statusupdatebroadcastchannelsenabled, statusupdatebroadcastwebhooksenabled, summarymodifiedat, createchannelmemberonnewparticipant, removechannelmemberonremovedparticipant, runtype) FROM stdin;
\.


--
-- Data for Name: ir_metric; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_metric (incidentid, metricconfigid, value, published) FROM stdin;
\.


--
-- Data for Name: ir_metricconfig; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_metricconfig (id, playbookid, title, description, type, target, ordering, deleteat) FROM stdin;
\.


--
-- Data for Name: ir_playbook; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbook (id, title, description, teamid, createpublicincident, createat, deleteat, checklistsjson, numstages, numsteps, broadcastchannelid, remindermessagetemplate, remindertimerdefaultseconds, concatenatedinviteduserids, inviteusersenabled, defaultcommanderid, defaultcommanderenabled, announcementchannelid, announcementchannelenabled, concatenatedwebhookoncreationurls, webhookoncreationenabled, concatenatedinvitedgroupids, messageonjoin, messageonjoinenabled, retrospectivereminderintervalseconds, retrospectivetemplate, concatenatedwebhookonstatusupdateurls, webhookonstatusupdateenabled, concatenatedsignalanykeywords, signalanykeywordsenabled, updateat, exportchannelonfinishedenabled, categorizechannelenabled, categoryname, concatenatedbroadcastchannelids, broadcastenabled, runsummarytemplate, channelnametemplate, statusupdateenabled, retrospectiveenabled, public, runsummarytemplateenabled, createchannelmemberonnewparticipant, removechannelmemberonremovedparticipant, channelid, channelmode) FROM stdin;
\.


--
-- Data for Name: ir_playbookautofollow; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbookautofollow (playbookid, userid) FROM stdin;
\.


--
-- Data for Name: ir_playbookmember; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_playbookmember (playbookid, memberid, roles) FROM stdin;
\.


--
-- Data for Name: ir_run_participants; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_run_participants (userid, incidentid, isfollower, isparticipant) FROM stdin;
\.


--
-- Data for Name: ir_statusposts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_statusposts (incidentid, postid) FROM stdin;
\.


--
-- Data for Name: ir_system; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_system (skey, svalue) FROM stdin;
DatabaseVersion	0.63.0
\.


--
-- Data for Name: ir_timelineevent; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_timelineevent (id, incidentid, createat, deleteat, eventat, eventtype, summary, details, postid, subjectuserid, creatoruserid) FROM stdin;
\.


--
-- Data for Name: ir_userinfo; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_userinfo (id, lastdailytododmat, digestnotificationsettingsjson) FROM stdin;
whida44gqpyfierua1wfrnbxtr	1681111982367	{"disable_daily_digest":false,"disable_weekly_digest":false}
e343y5ecu7dyujwqm7yfimh1je	1681298432320	{"disable_daily_digest":false,"disable_weekly_digest":false}
ygmycw6rnff7igko8gwbqchujr	1681298576250	{"disable_daily_digest":false,"disable_weekly_digest":false}
\.


--
-- Data for Name: ir_viewedchannel; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.ir_viewedchannel (channelid, userid) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.jobs (id, type, priority, createat, startat, lastactivityat, status, progress, data) FROM stdin;
ms7jm6ewktrqbnbctx6nqx3dce	migrations	0	1675955468473	1675955477173	1675955477390	success	0	{"last_done": "{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"00000000000000000000000000\\",\\"last_channel_id\\":\\"00000000000000000000000000\\",\\"last_user\\":\\"00000000000000000000000000\\"}", "migration_key": "migration_advanced_permissions_phase_2"}
mucbym53t3yx7rc34ykoe9nqxw	expiry_notify	0	1675956204266	1675956211726	1675956211732	success	0	null
icozsjcfejymbknkbxjnw6me9h	expiry_notify	0	1675956803891	1675956811555	1675956811558	success	0	null
cbzrej5q4p8z5rzrc5jh8ksuhy	expiry_notify	0	1675957765190	1675957774699	1675957774704	success	0	null
ear3tmtgr7nw5gyg6iorx9ugmc	expiry_notify	0	1675970888410	1675970894307	1675970894312	success	0	null
6stkbt4pd7nkpk5cf19wczwtxy	expiry_notify	0	1675971488019	1675971494062	1675971494081	success	0	null
zqmpega96id93pi7fediazhiqo	expiry_notify	0	1675972087639	1675972093815	1675972093820	success	0	null
amneorp9y78afnsb8mcys4maaa	expiry_notify	0	1678033369981	1678033383664	1678033383669	success	0	null
jjmzgyt5epnzf8f5zetp6qdwbh	expiry_notify	0	1678033970016	1678033983828	1678033983833	success	0	null
yszek49t57bztnkmoxb7hqjuir	expiry_notify	0	1679129301514	1679129305954	1679129305964	success	0	null
txwzicu7dbrd8f1pgszfae7w8w	expiry_notify	0	1679129901571	1679129906184	1679129906202	success	0	null
87rtgy9qnpnwpnmywef7d6sggr	expiry_notify	0	1679130501781	1679130506603	1679130506610	success	0	null
jkwtx3htx3yt7dpxg3xnbsohqo	expiry_notify	0	1679410558951	1679410559017	1679410559023	success	0	null
c8chdc71c7bcbrt3iy4j9dwb1a	expiry_notify	0	1679411203164	1679411216012	1679411216017	success	0	null
qpywtbc7ubfbzqcqswd3tdsdna	expiry_notify	0	1679412532423	1679412547165	1679412547169	success	0	null
k4o1rtqc5tgj5ym9kg94s5jtfa	expiry_notify	0	1679413133270	1679413147913	1679413147919	success	0	null
ot3wpsxayby4txjtdz3csdeeko	product_notices	0	1679413613301	1679413628046	1679413628259	success	0	null
bjo7bgmc43gqzeicj1ftx4w7zc	expiry_notify	0	1679413733313	1679413748075	1679413748079	success	0	null
h8qxoee6a7ru589xoxwaksoo4y	expiry_notify	0	1679414333335	1679414348204	1679414348214	success	0	null
khof8hj4ajdtpm6tyw49myt16r	expiry_notify	0	1679414933392	1679414948359	1679414948367	success	0	null
z1styr1w5j8ad819q1frfnempr	expiry_notify	0	1679415533487	1679415533545	1679415533557	success	0	null
d8atouc3zpyripy6p7tuecscde	expiry_notify	0	1679416133524	1679416133689	1679416133694	success	0	null
ueibtw84ntg79kyuebu56q4qfa	install_plugin_notify_admin	0	1681109914528	1681109920742	1681109920745	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pxfm8s7mt38riyuuci7ubjjk5o	install_plugin_notify_admin	0	1681112915017	1681112921539	1681112921544	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
r8rxcrbgmjfcjmqssnst4auqkw	install_plugin_notify_admin	0	1681110034545	1681110040774	1681110040781	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x1tres3ombgqfmad4dmnefemse	install_plugin_notify_admin	0	1681110154584	1681110160851	1681110160887	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
53c5udx6wjrij8h1r3cga8parr	install_plugin_notify_admin	0	1681110274579	1681110280857	1681110280862	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8yj8h5ytftyg9ycy9me6m81m3e	install_plugin_notify_admin	0	1681110394586	1681110400881	1681110400884	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fd6j7qbe6fg9fdwdrzkc7iprhc	expiry_notify	0	1681110454594	1681110460904	1681110460965	success	100	null
y6b41ci64i8xxp5kihgg3kgtme	install_plugin_notify_admin	0	1681110514602	1681110520915	1681110520919	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
f7okx578ufg97k744doiub6gga	install_plugin_notify_admin	0	1681110634609	1681110640934	1681110640938	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ymzjdhbkrbgoigj8x1iwgd11kc	install_plugin_notify_admin	0	1681110754686	1681110761067	1681110761070	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mo33c765gjyhirtg6c3r4pa9oc	install_plugin_notify_admin	0	1681110874703	1681110881103	1681110881107	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
p96ddqp7u7dapbggrt545etr8w	install_plugin_notify_admin	0	1681110994718	1681111001132	1681111001147	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xz96paekgfyz7jn93r8w44xizc	install_plugin_notify_admin	0	1681111114770	1681111121162	1681111121167	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1iu78hscstbgbrrotpa8x1qs4h	expiry_notify	0	1681111114758	1681111121162	1681111121173	success	100	null
ekepy4gez7fffyc5f7ueys3uto	install_plugin_notify_admin	0	1681111234807	1681111241185	1681111241189	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ghcr9hzm4f849c5aiakdt5joaw	install_plugin_notify_admin	0	1681111354828	1681111361224	1681111361241	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
a7qbgs87w7ybzmt137yao68imh	install_plugin_notify_admin	0	1681111474840	1681111481253	1681111481258	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8dz45zufqbbwtkezbdofbnab7o	install_plugin_notify_admin	0	1681111594852	1681111601295	1681111601308	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wtq3188mnj8qpc1tuqzohsthby	install_plugin_notify_admin	0	1681111714911	1681111721317	1681111721321	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1h4u3zz5dbge7kimt9u7xkkgyw	install_plugin_notify_admin	0	1681113035030	1681113041566	1681113041571	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3xh8rjstgbfgpm5dmex4u9jjow	expiry_notify	0	1681111774921	1681111781362	1681111781371	success	100	null
cz9jbfn5j3gtxjdjaffomn4swh	install_plugin_notify_admin	0	1681116035530	1681116042574	1681116042587	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
o76wrmmp37fzpypb7qc8bimjhh	install_plugin_notify_admin	0	1681114115258	1681114121933	1681114121938	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4exah8p7apgdtqrx1tnbzphctc	install_plugin_notify_admin	0	1681111834933	1681111841417	1681111841422	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4k6bpy81b3bmmj7ezsbzssf7xh	expiry_notify	0	1681113095039	1681113101576	1681113101583	success	100	null
cay9iucf3tdode3y1txy969xye	install_plugin_notify_admin	0	1681111954973	1681111961442	1681111961447	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yrzn5tpzcpfnjneyqyofg4j7kw	install_plugin_notify_admin	0	1681113155045	1681113161596	1681113161600	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4ujknicfo7gu58gaydu4q9swjo	install_plugin_notify_admin	0	1681112075017	1681112081465	1681112081470	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pxquoisgpbbgxby96sks9nywhe	install_plugin_notify_admin	0	1681112194941	1681112201401	1681112201405	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
85aa9dm7s3dwpyrm3y7qkzmtsr	install_plugin_notify_admin	0	1681116395615	1681116402793	1681116402800	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z5nq3ipoq7bjmy17c1cas3mobr	install_plugin_notify_admin	0	1681112314958	1681112321416	1681112321420	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
r8jxed4qp7dimrmqgny43rhh9y	install_plugin_notify_admin	0	1681113395184	1681113401761	1681113401765	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ibo1wqooi3nmfk4w3fk9annpgc	expiry_notify	0	1681116395608	1681116402794	1681116402805	success	100	null
8do3dkij4tn4zgmddt3p8t5p7o	product_notices	0	1681113395177	1681113401761	1681113402142	success	100	null
gjm9onokbfnc7fwptbeeoa4ijc	install_plugin_notify_admin	0	1681112434978	1681112441431	1681112441435	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dz7r5i54obgj7d3mde4if3fnnr	install_plugin_notify_admin	0	1681116755708	1681116762912	1681116762916	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3z19qibu4jgs3doc387zk17x7e	expiry_notify	0	1681112434967	1681112441431	1681112441440	success	100	null
qzjat6aki7r5jpup7yeno6rqjh	install_plugin_notify_admin	0	1681113635207	1681113641834	1681113641839	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pz4zapwoe3n6ikwjhe8e7jhjth	expiry_notify	0	1681117055737	1681117062990	1681117063002	success	100	null
s1oaxsor77fdxrz55aeoboks3o	install_plugin_notify_admin	0	1681113755219	1681113761855	1681113761860	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
th5qg3qyijnx9xmbpp4yuhrk3c	expiry_notify	0	1681113755225	1681113761855	1681113761868	success	100	null
ngrkaamxmpbziptzaytad3grwy	install_plugin_notify_admin	0	1681117235758	1681117243032	1681117243039	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z5y56cdnftfspbz9a6zezf7k8o	install_plugin_notify_admin	0	1681113875237	1681113881883	1681113881887	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
sw66jc8c8id8t8mmda7zt7p15h	install_plugin_notify_admin	0	1681114475328	1681114482078	1681114482083	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xb4sd3tnw7f4idpywqgi7e9wko	install_plugin_notify_admin	0	1681114595338	1681114602129	1681114602133	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bcb1zwy8bidgdc4hzjjeoqm6ic	install_plugin_notify_admin	0	1681114715352	1681114722182	1681114722188	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6r3q7uuzo3bodye5pdqe3wb9yy	install_plugin_notify_admin	0	1681114955380	1681114962271	1681114962275	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5szt9a8hibgt7ywp6gn69dnbqr	install_plugin_notify_admin	0	1681115075391	1681115082321	1681115082342	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ny8je6m3ai8qj8gwpqj1rd3wuo	expiry_notify	0	1681115075398	1681115082321	1681115082428	success	100	null
nfxaus1pkbd87rjes7mjmxhm8w	install_plugin_notify_admin	0	1681115675473	1681115682475	1681115682481	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hoetnq5bjtgn3e1jeogp3sqjyc	install_plugin_notify_admin	0	1681115915518	1681115922533	1681115922539	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3s4xnr1g8ifemfdxfsywr5198c	install_plugin_notify_admin	0	1681112554985	1681112561453	1681112561458	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dmi8zshr83gzuetqs3aopn5hxa	install_plugin_notify_admin	0	1681112675000	1681112681474	1681112681479	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hszik111jid3j8hjur7sdymtgh	install_plugin_notify_admin	0	1681113275166	1681113281728	1681113281732	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
uteubezjyjfn7nosdfz7f9tr9c	install_plugin_notify_admin	0	1681116155584	1681116162660	1681116162664	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x348twfotbyaujmsrt88btu3jh	install_plugin_notify_admin	0	1681112795006	1681112801504	1681112801509	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
aru6k9ja13nuixugcnypg74zhr	install_plugin_notify_admin	0	1681113515196	1681113521793	1681113521797	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
byz1es7t4td6mndezrzx7a95gh	install_plugin_notify_admin	0	1681116275596	1681116282762	1681116282766	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xmebiaekppdhjr1muwxsyyi4dh	install_plugin_notify_admin	0	1681113995249	1681114001908	1681114001913	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
y8bseksueirj5rkrgpqiig6bby	install_plugin_notify_admin	0	1681114235284	1681114241977	1681114241982	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8z8ob6bcgjnfzmqqq8sd7p3gmy	install_plugin_notify_admin	0	1681116515652	1681116522841	1681116522847	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mmw71pbb9tg4bf94t4yrku1qew	install_plugin_notify_admin	0	1681114355303	1681114362021	1681114362026	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
k8zmnjyn7fg3ufx5twrgbpycmc	install_plugin_notify_admin	0	1681116635696	1681116642884	1681116642889	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
81phbictn3gsj8e6gpuu1ssywc	expiry_notify	0	1681114415320	1681114422056	1681114422100	success	100	null
s4df1rt3r7gz3cyzs6ubhgq7fh	install_plugin_notify_admin	0	1681116875721	1681116882936	1681116882942	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
myqhf4a3dpn6ijbkctc35nytze	install_plugin_notify_admin	0	1681114835366	1681114842227	1681114842234	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jjyekm83u7ymdjwxfm37byh1oc	install_plugin_notify_admin	0	1681115195411	1681115202349	1681115202421	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4y4gfxzyc7bopfqrm3ybpsbidw	install_plugin_notify_admin	0	1681115315432	1681115322372	1681115322375	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8ui9z3iwg78t88n7hzpkftpi3c	install_plugin_notify_admin	0	1681116995721	1681117002972	1681117002977	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kxn959ut1b8q9n96opckt5g16r	install_plugin_notify_admin	0	1681117355772	1681117363062	1681117363067	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gn6hkhmh3iytirg4b5ec61qfjo	install_plugin_notify_admin	0	1681115435449	1681115442420	1681115442456	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dmk6wsw1j3ydtrkzse9j5sdmwa	product_notices	0	1681116995729	1681117002972	1681117003216	success	100	null
ftorcss5bpyfx8f4n3ajhgqm4e	install_plugin_notify_admin	0	1681115555461	1681115562448	1681115562452	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g8xhx8irmiyttb9mtrb6xo7g4w	install_plugin_notify_admin	0	1681117115747	1681117123005	1681117123009	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rokccjgpu3fg7k1fyk9zbxuwzh	expiry_notify	0	1681115735484	1681115742489	1681115742498	success	100	null
6bnke6pp9jdotxkqzfm34y4ncy	install_plugin_notify_admin	0	1681115795498	1681115802502	1681115802507	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wo6f6sr76tbpipai7x97xqd7zc	install_plugin_notify_admin	0	1681117475783	1681117483090	1681117483094	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
68rqg51zp78bfpmi44z6it577h	install_plugin_notify_admin	0	1681117595794	1681117603117	1681117603123	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ke9xctikcpbfupa6iscmppjguo	install_plugin_notify_admin	0	1681117715809	1681117723144	1681117723151	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wgyhdkijiing3gx76kcxfrur4e	expiry_notify	0	1681117715804	1681117723145	1681117723174	success	100	null
eubup4a4o7n4jkhxngebju8kie	install_plugin_notify_admin	0	1681117835818	1681117843192	1681117843197	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7sf4hp6ijiba5qyfuwgedf59oy	install_plugin_notify_admin	0	1681117955828	1681117963221	1681117963224	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1c9s8hm88t8btge1ex36eeycuo	install_plugin_notify_admin	0	1681119636117	1681119643787	1681119643793	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5ch1b7d7qi8wxxwuo8iqqpx6cr	install_plugin_notify_admin	0	1681118075844	1681118083246	1681118083251	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ye745wcfb7d8mpqyhfyztam3or	install_plugin_notify_admin	0	1681118195864	1681118203273	1681118203280	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
b96jwwspufgazqbny4nosyu7or	expiry_notify	0	1681119696131	1681119703805	1681119703838	success	100	null
a66mr5e987b4jdh9kr6g7ppawa	install_plugin_notify_admin	0	1681118315897	1681118323307	1681118323314	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ujxbfbii1t8pzp3jr1mrog9nhc	install_plugin_notify_admin	0	1681119756144	1681119763818	1681119763822	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bpr3derab78abxczsnuowg4b9e	expiry_notify	0	1681118375908	1681118383331	1681118383340	success	100	null
7npnp4dof7fn9ktcuq8jup5ewy	install_plugin_notify_admin	0	1681118435920	1681118443349	1681118443355	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zxjn8kc1d7gqpxfnnfmygekemo	install_plugin_notify_admin	0	1681119876184	1681119883848	1681119883852	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fnt8nb1ypjb88yfkwkosk8h7jr	install_plugin_notify_admin	0	1681118555931	1681118563384	1681118563389	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
855up9ytx7yj8bt89krgr6z4we	install_plugin_notify_admin	0	1681119996196	1681120003888	1681120003893	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
p37zjm9gep81tg33u4b881unjh	install_plugin_notify_admin	0	1681118675942	1681118683428	1681118683431	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
f9frijwkjjbd88qewqqya4chza	install_plugin_notify_admin	0	1681118795956	1681118803468	1681118803474	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x93jb6kdrprh5dsqe9bucsyoce	install_plugin_notify_admin	0	1681120116202	1681120123911	1681120123923	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xbyjb1fzg7d53cy7r43uqyfg6r	install_plugin_notify_admin	0	1681118915968	1681118923500	1681118923504	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nygqouxzdbb4pr34umpqd5bday	install_plugin_notify_admin	0	1681120236212	1681120243938	1681120243943	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ahozbt7azjrgmjrutoqaf46iye	install_plugin_notify_admin	0	1681119035979	1681119043533	1681119043537	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
spnf7xh3qf8upr8ahwnaf5yczr	install_plugin_notify_admin	0	1681119396088	1681119403701	1681119403704	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
76runyg1z7yxzx7uqb5ky5d6mh	expiry_notify	0	1681119035986	1681119043533	1681119043544	success	100	null
n6xzx4wg3idpxdnxmxe59sei9o	install_plugin_notify_admin	0	1681120356296	1681120363993	1681120363997	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7bfsd6m7uiyming3arq54qqnkc	install_plugin_notify_admin	0	1681119156013	1681119163575	1681119163580	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ti7wo4fc43gm8d6eiu8xtk5imh	expiry_notify	0	1681120356239	1681120363993	1681120364004	success	100	null
wz5e9yabr7bdbxadtqf9u76hwe	install_plugin_notify_admin	0	1681119276058	1681119283638	1681119283664	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ogaq3gcz6fg17mh7qdr88jr9qr	install_plugin_notify_admin	0	1681120476346	1681120484028	1681120484039	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xbgbq34zfiy1jkn1w7frd4eu8c	install_plugin_notify_admin	0	1681119516099	1681119523731	1681119523736	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ryfg1xoa87g9jfijwxeyexa8nc	install_plugin_notify_admin	0	1681120596370	1681120604069	1681120604074	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
urdib38rdfysbdgwnye8skemsr	product_notices	0	1681120596425	1681120604069	1681120604332	success	100	null
7nio4o7hq7yz9bnz7acnck3dbr	install_plugin_notify_admin	0	1681120716457	1681120724145	1681120724150	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
h3669pezw78i3eru6q71ja7aoa	install_plugin_notify_admin	0	1681120836468	1681120844197	1681120844214	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wuqu63cjeig9ifnmzseggy6e7w	install_plugin_notify_admin	0	1681120956485	1681120964251	1681120964259	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tseohcerbfdubknu76bwzzyaxc	expiry_notify	0	1681121016499	1681121024272	1681121024282	success	100	null
6aohp8n5cpy67mycq1cy86mj5h	install_plugin_notify_admin	0	1681121076455	1681121084252	1681121084256	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dwruprm6p78hxyz35ya3x9at8e	install_plugin_notify_admin	0	1681123597047	1681123605137	1681123605142	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
f3rkocj6rpb7dd47jgcxxenqgr	install_plugin_notify_admin	0	1681121196478	1681121204285	1681121204302	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
86gbozxd4iyg9f5439bdrzmgra	install_plugin_notify_admin	0	1681127737944	1681127746765	1681127746770	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hrkzx7bnbiryipiktcpdd7zsor	install_plugin_notify_admin	0	1681123957139	1681123965431	1681123965449	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hy3jfjxh67dftganx6bgt8xbmw	install_plugin_notify_admin	0	1681121436516	1681121444353	1681121444358	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rwxofjuajfd3783btjfq5bi79o	install_plugin_notify_admin	0	1681124917293	1681124925789	1681124925794	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8ujy8faznfgw5e81auchs1dpth	install_plugin_notify_admin	0	1681127857968	1681127866785	1681127866788	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wkzsc4uw33d6i8nrc9kughysye	install_plugin_notify_admin	0	1681128338035	1681128346925	1681128346929	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
apfdee6cw3bkpkds3nzexp71sc	install_plugin_notify_admin	0	1681125397381	1681125405939	1681125405944	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hh8kkyeoxi8kxrfunms5wrbeah	install_plugin_notify_admin	0	1681128578097	1681128587086	1681128587092	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
c4bthpxmpfredysuydmw7mxswc	install_plugin_notify_admin	0	1681128818141	1681128827189	1681128827212	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
h3cqnn7h67rf5r4d1hxkbfj4sh	install_plugin_notify_admin	0	1681125637413	1681125646000	1681125646004	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kw61dpzf87bsdkc4gie83tmpqe	install_plugin_notify_admin	0	1681128938191	1681128947221	1681128947226	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
np1j3w6q4py59ndh7oww41h6ha	expiry_notify	0	1681125637406	1681125646000	1681125646018	success	100	null
81k5z157tj8czqpdyrc33371gw	install_plugin_notify_admin	0	1681129178216	1681129187285	1681129187290	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z77ci737fpbstpkay5cfh39uer	install_plugin_notify_admin	0	1681125757426	1681125766023	1681125766027	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wuio9tu96iyx3d7ouj8ihfzufh	install_plugin_notify_admin	0	1681129778248	1681129787413	1681129787417	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
31161u57u3n3tjihzbt9ifkh7e	install_plugin_notify_admin	0	1681125877440	1681125886050	1681125886055	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1up9m9dw6inozcmg3c3cwm995h	install_plugin_notify_admin	0	1681129898282	1681129907456	1681129907461	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
q3crzo9owtdnfmbuarykfxtyah	install_plugin_notify_admin	0	1681127137855	1681127146455	1681127146459	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ojo67ou7afb3mecgz4cbezf5xc	expiry_notify	0	1681126297637	1681126306181	1681126306192	success	100	null
mgd34dp75pdpmy1q5iz81cabah	install_plugin_notify_admin	0	1681130018295	1681130027523	1681130027573	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wdfb8wfw3ircdpcxhwk19hqcho	install_plugin_notify_admin	0	1681126477676	1681126486231	1681126486237	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wz63ejcq7b83zduhqnpew8fifc	install_plugin_notify_admin	0	1681126597701	1681126606269	1681126606274	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1m8xworfmfdz5qzmxcxnx8wqeo	install_plugin_notify_admin	0	1681126957785	1681126966395	1681126966402	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kgtmwig14p8mumt1m64emkrbnw	install_plugin_notify_admin	0	1681130138307	1681130147644	1681130147647	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9ffgpj7a8jr7iegs735i9qkkqy	install_plugin_notify_admin	0	1681127017833	1681127026408	1681127026424	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kjb1czmnjpgimg5bt5axbpth6e	install_plugin_notify_admin	0	1681127377910	1681127386690	1681127386694	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6wx46febxjgspdxc31itwtgb5o	expiry_notify	0	1681130198317	1681130207687	1681130207705	success	100	null
54mad3fmctr4dnzfe6hed3az3o	install_plugin_notify_admin	0	1681130258328	1681130267701	1681130267704	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
o7mjfmusaid7p8qqzmbjfmxoxe	install_plugin_notify_admin	0	1681130498401	1681130507826	1681130507833	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9yg6of89fidizrtu9hwexpiu7c	install_plugin_notify_admin	0	1681121316508	1681121324325	1681121324355	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
stjsfs4z7prsintuz7yc1jy1ny	install_plugin_notify_admin	0	1681126837732	1681126846329	1681126846332	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qhr3ih67ptbnjbu1q5dwzuq8xo	expiry_notify	0	1681123657057	1681123665158	1681123665169	success	100	null
3iajoems8idnjr4pmme9jxdwga	product_notices	0	1681127797959	1681127806776	1681127807040	success	100	null
cftb7zmi77gd7b7ycmqnfpojtw	install_plugin_notify_admin	0	1681123717068	1681123725174	1681123725178	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ghztdojo1frbpktozeo5fbciwr	install_plugin_notify_admin	0	1681124077199	1681124085463	1681124085478	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
srr5hcok5bd1znabncuqqt7gsc	install_plugin_notify_admin	0	1681127977981	1681127986812	1681127986816	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ooo3nzxao7riirc1rb71gde1ho	install_plugin_notify_admin	0	1681128097992	1681128106851	1681128106855	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ked547zz1inkimn7p1q1gqitso	install_plugin_notify_admin	0	1681124197205	1681124205552	1681124205590	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
c3waqzqkfbfp5xg6ygb4kictpe	product_notices	0	1681124197212	1681124205552	1681124205988	success	100	null
pcq6qfdsnib59bhxjzhkhkcm8r	install_plugin_notify_admin	0	1681128458083	1681128467060	1681128467065	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
e7t3jpo5jt877xab3yi8xsk6ta	install_plugin_notify_admin	0	1681124317224	1681124325588	1681124325594	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
78zx8j3pn3drmn1zqbnhieo3fc	expiry_notify	0	1681128218015	1681128226893	1681128226904	success	100	null
mo1o67xzpjgxpmd61wzfhctxho	expiry_notify	0	1681124317231	1681124325588	1681124325600	success	100	null
9fow17qsgi8nbj1so6ma9s9w1y	install_plugin_notify_admin	0	1681128218026	1681128226893	1681128226906	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
85yy5cxxajrjdx9ko84z7pwo7w	install_plugin_notify_admin	0	1681124437244	1681124445626	1681124445637	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hek4n7tgaj81tn3oh6emb4pcwy	install_plugin_notify_admin	0	1681128698111	1681128707122	1681128707127	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xh3iikiqttggjjyrwxm3q3ee9c	expiry_notify	0	1681124977307	1681124985812	1681124985823	success	100	null
wh6rsh18qfnb9krj95ejsix9ne	install_plugin_notify_admin	0	1681125157330	1681125165852	1681125165855	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
itccxab3u3rhdcwaqbusuxu1fh	expiry_notify	0	1681128878182	1681128887211	1681128887220	success	100	null
ffmsybztnj83zf5b1stnj4e84r	install_plugin_notify_admin	0	1681126117547	1681126126124	1681126126129	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3nh89dq9sif5my3u1p1tsfxjfa	install_plugin_notify_admin	0	1681129058203	1681129067262	1681129067273	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
b1cstcg1b3ba9yjxrynox7iwoe	install_plugin_notify_admin	0	1681126237623	1681126246164	1681126246168	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zsjk4xajh383fpi41huaqj3uoa	expiry_notify	0	1681126897776	1681126906340	1681126906348	success	100	null
uw8ucriwi3nd8j68ygbqrz1kto	install_plugin_notify_admin	0	1681129298230	1681129307316	1681129307320	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ppog7e6kr7yxtb53ez1cptp43e	install_plugin_notify_admin	0	1681127257859	1681127266646	1681127266652	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1zkd4r6k4j8aie5tkppfswj67r	install_plugin_notify_admin	0	1681129418246	1681129427359	1681129427363	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gae3ezzkcfgw9m7retw8hwmrqc	install_plugin_notify_admin	0	1681127497893	1681127506683	1681127506688	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
14pdhtum83dm5f3os9asib5edc	expiry_notify	0	1681127557904	1681127566691	1681127566701	success	100	null
ei1j5r8e6tdyzc7ppohbwwfghe	install_plugin_notify_admin	0	1681127617917	1681127626721	1681127626726	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
znsj53t3btbpzp3tachq8dt4sh	install_plugin_notify_admin	0	1681129538260	1681129547382	1681129547389	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dju67gm39ir97j36px8tj9d53c	expiry_notify	0	1681129538266	1681129547382	1681129547390	success	100	null
wx4mmzehitdkzc1z97texjpixw	install_plugin_notify_admin	0	1681129658258	1681129667410	1681129667427	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qd19piw8xfnkdpmkfarkbprm8a	install_plugin_notify_admin	0	1681130378387	1681130387750	1681130387765	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
abfcmfugmfdqtxg4i8q79jxker	install_plugin_notify_admin	0	1681132298630	1681132308334	1681132308341	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g43igkywgfrdtchxth3cbw9mzw	install_plugin_notify_admin	0	1681121556554	1681121564398	1681121564422	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oes6nshnppga8qjxkuuro518qy	install_plugin_notify_admin	0	1681123837080	1681123845269	1681123845313	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jgz6awjncbg83mzodmnwmh64oh	install_plugin_notify_admin	0	1681121676571	1681121684429	1681121684433	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ykbzwt955pgpdphu37sdsfqzcy	install_plugin_notify_admin	0	1681124557257	1681124565683	1681124565687	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ho81ixmjc7gm9r4ffgtk9zia4w	expiry_notify	0	1681121676579	1681121684429	1681121684439	success	100	null
uiwczyb343yjzx7xajuntcscte	install_plugin_notify_admin	0	1681121796590	1681121804462	1681121804466	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4fn7q6y3tbrotqmebjfgfj6p1a	install_plugin_notify_admin	0	1681124677272	1681124685716	1681124685721	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
obiwas9kkbr9ujztq5wde4zdxc	install_plugin_notify_admin	0	1681121916600	1681121924486	1681121924491	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fj81ki1kupdemrbaasqaasc1we	install_plugin_notify_admin	0	1681124797284	1681124805751	1681124805753	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
btkrph1uibgxjnoa3s5d8rzsuh	install_plugin_notify_admin	0	1681122036638	1681122044547	1681122044552	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zksqe3w3dt8ydnx7zok1z3kmya	install_plugin_notify_admin	0	1681122156652	1681122164585	1681122164589	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
eizskxuemtr8tdxuspakj4brba	install_plugin_notify_admin	0	1681125037315	1681125045823	1681125045828	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5r5r9gcwhbremjf69g1ga7s83c	install_plugin_notify_admin	0	1681122276702	1681122284643	1681122284678	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hiy7cqd74fnrzjzz3mg5qk6yjw	install_plugin_notify_admin	0	1681125277362	1681125285893	1681125285901	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bc8e6t1j7idqxgtt9orudqayze	install_plugin_notify_admin	0	1681122876856	1681122884838	1681122884842	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xn13gqci1jr87jb711bh9tg5uw	expiry_notify	0	1681122336748	1681122344668	1681122344683	success	100	null
7n4uqq4k9fgmiccorhswrjn3ha	install_plugin_notify_admin	0	1681122396790	1681122404670	1681122404683	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zcnjtumtp7nwtfzo35zjprdy3o	install_plugin_notify_admin	0	1681125517395	1681125525974	1681125525978	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dqdak9c1btyybewchdx6rkuofc	install_plugin_notify_admin	0	1681122516802	1681122524713	1681122524718	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1gr14nbsktnd78bezuhkp8kach	install_plugin_notify_admin	0	1681125997450	1681126006082	1681126006086	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
umuddyktqpbs981x5r4zs5w9ac	install_plugin_notify_admin	0	1681122636811	1681122644747	1681122644758	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oorizmcufjyy7d3ky9eieqmhpy	install_plugin_notify_admin	0	1681122756840	1681122764801	1681122764808	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9oygtifbgbg7fxfd69sx8r3gua	install_plugin_notify_admin	0	1681126357655	1681126366198	1681126366203	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
sfofrxgy9pfy58di6hcc7mmwsw	install_plugin_notify_admin	0	1681126717716	1681126726298	1681126726302	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4axo7hdxw7nozjdpj5m7ypd64h	install_plugin_notify_admin	0	1681122996963	1681123004955	1681123004960	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
e6szupxchbbo7jtj7o7thrymkw	expiry_notify	0	1681122996952	1681123004955	1681123004966	success	100	null
3s1p8beknpfp78d9mkndct5n9c	install_plugin_notify_admin	0	1681123116994	1681123125002	1681123125036	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3kh1ra7pjpdyprdg1on1tq6bae	install_plugin_notify_admin	0	1681123237009	1681123245036	1681123245040	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
srqe9quft7fa5kujamwkocryao	install_plugin_notify_admin	0	1681123357022	1681123365078	1681123365082	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xfs7iwskt7nxfefdprqx7oumdh	install_plugin_notify_admin	0	1681123477034	1681123485108	1681123485112	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
k3te3gfs4fgczgapwryif356bw	install_plugin_notify_admin	0	1681130618412	1681130627849	1681130627853	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fh59cnhosiyspqpr8s7xb8n1da	install_plugin_notify_admin	0	1681137339834	1681137350360	1681137350365	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xp96e5quc3nepjqhzjgogcge1y	install_plugin_notify_admin	0	1681196569998	1681196583486	1681196583494	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6zojmzone7nczg1pyjrzigkaqh	install_plugin_notify_admin	0	1681132418628	1681132428332	1681132428336	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nb8nr4gb73rezb9xa3s84awyew	install_plugin_notify_admin	0	1681134099042	1681134109192	1681134109240	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
txxdeesssif7zjcy8hmxhbj3be	install_plugin_notify_admin	0	1681211173804	1681211174106	1681211174111	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8ghyitwgbbr7t81xy59a58ezac	install_plugin_notify_admin	0	1681137579860	1681137590407	1681137590418	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6m5i3yb393rd3x11s9ahwmhhwy	install_plugin_notify_admin	0	1681194649383	1681194662211	1681194662216	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
isq1u3wudtrfdye8jsyyej6j4h	expiry_notify	0	1681134159056	1681134169205	1681134169217	success	100	null
681u9jojgj818me8h5gwmi7jkc	install_plugin_notify_admin	0	1681298097371	1681298097398	1681298097403	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
uddraixf1tdkjn6czfejmbi3ze	install_plugin_notify_admin	0	1681196930088	1681196943681	1681196943686	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hsxh1o9pjifwme5wf5c4xzcpoc	install_plugin_notify_admin	0	1681134939253	1681134949537	1681134949550	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cq7ac86gyidimxqq4idb59xs3c	install_plugin_notify_admin	0	1681195129437	1681195142333	1681195142339	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ucozm11iq3nm3ru3aggyt5koxa	product_notices	0	1681134999267	1681135009548	1681135009848	success	100	null
5qghtjg43fbhzx4cusxk54cyre	install_plugin_notify_admin	0	1681196089767	1681196103090	1681196103127	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9ty5nwaenifgxbjcnf8atpy9fw	expiry_notify	0	1681195189445	1681195202351	1681195202361	success	100	null
xa5ducdm77r83c7jf9pi13hnwh	install_plugin_notify_admin	0	1681135179317	1681135189577	1681135189581	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hwpxwa5tntba7rpbxcwn3aq1ar	product_notices	0	1681211473845	1681211474172	1681211474466	success	100	null
6gkdeh9rfty58doo1s9wmcqfhr	install_plugin_notify_admin	0	1681135299383	1681135309664	1681135309668	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9tbnr9bycig3fro5rfi6yrcfay	install_plugin_notify_admin	0	1681195729678	1681195742816	1681195742823	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g4ew4arhtididjx4k4w6p9o9or	install_plugin_notify_admin	0	1681136739737	1681136750228	1681136750233	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rht9okcp4jn9bj6gdg4xcjqmzy	install_plugin_notify_admin	0	1681209853638	1681209853838	1681209853843	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3sksmwxjfbbup8s5cgy65nefdo	install_plugin_notify_admin	0	1681197170164	1681197183836	1681197183855	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zpy4ec951jbcjctynjchrowu1e	expiry_notify	0	1681197170142	1681197183837	1681197183874	success	100	null
6qexo3c4p7rrjb1gronyzsuhir	expiry_notify	0	1681136799748	1681136810250	1681136810268	success	100	null
dnzix53nxjn53nsdmy1cjuw4cc	install_plugin_notify_admin	0	1681203571429	1681203586269	1681203586275	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ka4a4jmnjbg758fedj7enjzchc	install_plugin_notify_admin	0	1681195849713	1681195862939	1681195862973	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ihirt8kzujrfbchx347s8e3fky	install_plugin_notify_admin	0	1681136859826	1681136870257	1681136870264	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qeaagcfwkfdc7pxydbtmt4p4wh	install_plugin_notify_admin	0	1681211773883	1681211774234	1681211774238	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ie8jogqny3f7meysw6ey5yh4qh	expiry_notify	0	1681195849728	1681195862917	1681195863000	success	100	null
ih61z4ithifc8nywda6m8i588c	install_plugin_notify_admin	0	1681214752058	1681214767084	1681214767279	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oyebgbws47d4triu7tdd7fqxgr	install_plugin_notify_admin	0	1681195969749	1681195983030	1681195983045	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
sibewpq1jtd95qusfj7bknqcty	install_plugin_notify_admin	0	1681209973658	1681209973862	1681209973867	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mftp4pr4ftrfzyain4imkxsb3y	expiry_notify	0	1681209973651	1681209973863	1681209973874	success	100	null
gkmsc35zupd4znii31uxtedufy	install_plugin_notify_admin	0	1681130738402	1681130747853	1681130747859	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6i1ciyt7tf8epmii615qwicdfw	install_plugin_notify_admin	0	1681132538702	1681132548441	1681132548446	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5599krairfbuib9m6q6b9ug4yh	install_plugin_notify_admin	0	1681196690009	1681196703522	1681196703527	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6bqi6qreqtbjpdmgyi4zw8rxrc	install_plugin_notify_admin	0	1681130858419	1681130867876	1681130867881	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
uebbgcf7tpyhmy853t33feq8mc	install_plugin_notify_admin	0	1681298217392	1681298217433	1681298217437	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
h6jfy1gdctrfdk1fxk658b8xuc	expiry_notify	0	1681130858412	1681130867876	1681130867886	success	100	null
r5pm1df9at8gpq9jc7wds98qya	install_plugin_notify_admin	0	1681134219071	1681134229220	1681134229226	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
p4cqk4brijr1dmyejraxuoopto	install_plugin_notify_admin	0	1681137459853	1681137470383	1681137470388	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ndzefiit57nofk8k4d6wyikfzw	install_plugin_notify_admin	0	1681300137740	1681300138251	1681300138260	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
44eaazq5j7dtx8qh3rciwxm5cw	install_plugin_notify_admin	0	1681134459131	1681134469317	1681134469322	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
b9fhz1iqq3b33p1hz4z1fafsbc	expiry_notify	0	1681137459845	1681137470383	1681137470397	success	100	null
6t4ty83bbtn9fmf4rpa4s7j7yc	install_plugin_notify_admin	0	1681196810078	1681196823600	1681196823606	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
t4wp14fxhpnttfdrbua3mpwfty	install_plugin_notify_admin	0	1681136979855	1681136990340	1681136990393	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6nfi33p4kfy8jkztt5gaqxke6h	install_plugin_notify_admin	0	1681211293823	1681211294134	1681211294139	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
64p5cse5kpfg9km14r54nd1qnc	install_plugin_notify_admin	0	1681194769395	1681194782243	1681194782248	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oknooqdngbd3mpkbmtxhitwn8c	install_plugin_notify_admin	0	1681197050110	1681197063751	1681197063766	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rxjzj1dgypry7ygixjepwnh3th	install_plugin_notify_admin	0	1681195249455	1681195262362	1681195262366	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
d5wgufk3jbgduxhx7he9sdd3jr	expiry_notify	0	1681211293816	1681211294134	1681211294155	success	100	null
opagrpwbupd45j4i9insdgfciw	install_plugin_notify_admin	0	1681195369470	1681195382391	1681195382395	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3ap9qejdqfg5ijbat663rff9sc	install_plugin_notify_admin	0	1681300257755	1681300258272	1681300258277	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5583jsxa4jy8tnrxogmfbpj1pc	install_plugin_notify_admin	0	1681211653869	1681211654209	1681211654214	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nu9ncqkot7yq8r7g43hj7qieea	install_plugin_notify_admin	0	1681204646520	1681204661342	1681204661346	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mz975xamib86je3h45arp9uaay	expiry_notify	0	1681204647048	1681204661342	1681204661348	success	100	null
pm4da87ipp8nty3b3a7tr5b87o	install_plugin_notify_admin	0	1681214872084	1681214872225	1681214872249	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kxacw7njrtrfffp1h5mmrs9wry	install_plugin_notify_admin	0	1681210213687	1681210213922	1681210213926	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cxir6skmdp8yz8zzm74oiq1szw	install_plugin_notify_admin	0	1681300377763	1681300378310	1681300378314	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3ot8qnubapdyzmknx5hmwh89po	install_plugin_notify_admin	0	1681220526674	1681220526722	1681220526796	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
uf7hegfw7j8tdjwdq4uwy4dbuy	install_plugin_notify_admin	0	1681258986334	1681266191659	1681266192110	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tnoxxnbs43g57dj9m6bhae4p3a	expiry_notify	0	1681300617860	1681300618426	1681300618441	success	100	null
njx5rm4inbdcjgrcp1wdu8qtqh	expiry_notify	0	1681258986297	1681266191661	1681266193147	success	100	null
moysi4pywfg98gnz3t6pn8izie	install_plugin_notify_admin	0	1681300617819	1681300618426	1681300618451	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oufjn7jz5intigmug6ckt7tmie	product_notices	0	1681258986238	1681266191660	1681266194020	success	100	null
ecixasff97foje5kyjma4z34dr	install_plugin_notify_admin	0	1681302538269	1681302539695	1681302539730	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hr53zmqagpnazdxd74ebuubhqw	install_plugin_notify_admin	0	1681130978430	1681130987902	1681130987906	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x8ryxnr6afnzmxh588bdrdppga	expiry_notify	0	1681306379468	1681306381526	1681306381556	success	100	null
5x8xxc1dn7nfbcio9styjjumwa	install_plugin_notify_admin	0	1681132658729	1681132668493	1681132668521	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
u37xoyomxtnyid3xiji19tooge	install_plugin_notify_admin	0	1681197250159	1681197265155	1681197265174	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oztk7f9nqtrt7cbzrejzrz5hdw	install_plugin_notify_admin	0	1681211413835	1681211414160	1681211414164	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
uff7enn3ubfq8d5skbrcdpgugh	install_plugin_notify_admin	0	1681132778776	1681132788579	1681132788584	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hszyjgtbspdije7npethpotwrc	install_plugin_notify_admin	0	1681298337413	1681298337490	1681298337494	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
aegju4fgptdzincwhxspup6x6o	install_plugin_notify_admin	0	1681134339116	1681134349279	1681134349322	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
f3c5c64s4br3jboabfd57urfxh	install_plugin_notify_admin	0	1681144895466	1681144910344	1681144910351	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rx1bngby6if6xpsbhqk1z7bqec	install_plugin_notify_admin	0	1681214992095	1681214992315	1681214992340	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xfi9tc93ttb3iphikmcgawj6sa	install_plugin_notify_admin	0	1681137099820	1681137110308	1681137110315	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cthp8haq4jggjbccgfw8tqdfph	expiry_notify	0	1681144895486	1681144910343	1681144910361	success	100	null
cxa8hxb46b895bpwrqormejy1r	install_plugin_notify_admin	0	1681205717939	1681205732888	1681205732900	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bxmj848y5trcp81dccmiqr75uc	product_notices	0	1681144895390	1681144910343	1681144910611	success	100	null
bgwuafn61pbz5gz71c8g8t5ere	expiry_notify	0	1681205717911	1681205732888	1681205732929	success	100	null
mt4a5eix6jbpzyu7onb6k8z83w	install_plugin_notify_admin	0	1681195009425	1681195022302	1681195022306	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wop4u44zzty1xxczy9docsrxuh	expiry_notify	0	1681220526565	1681220526722	1681220526807	success	100	null
wg6r6pn4bidd5qya4wwpc1uuge	install_plugin_notify_admin	0	1681298577455	1681298577677	1681298577711	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8prxjtyoointieq1q5iazpy6gw	install_plugin_notify_admin	0	1681210333700	1681210333942	1681210333946	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bfq35bmh6by8tjm74hr1qdbwhr	install_plugin_notify_admin	0	1681300737883	1681300738531	1681300738544	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zq971jnkqjdo3ykbe3gadpspky	install_plugin_notify_admin	0	1681300857892	1681300858570	1681300858574	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gdqgzo6w1jgudxw75o5ymoitmr	expiry_notify	0	1681266192120	1681273396518	1681273396910	success	100	null
e4xqohjcnfnctx7ny4uj9on17h	install_plugin_notify_admin	0	1681266192902	1681273396518	1681273397107	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
t3b385pq3fdbtcaacemg3dg8gc	product_notices	0	1681266193079	1681273396518	1681273397992	success	100	null
abxb8dkyapgspxbzscaozy17ro	install_plugin_notify_admin	0	1681300977894	1681300978621	1681300978715	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mmzrxjuntjr69yaupgsfxar7qr	install_plugin_notify_admin	0	1681302778322	1681302779842	1681302779903	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tdziq1ai7byj5d59bcii6ddwbc	install_plugin_notify_admin	0	1681302898341	1681302899905	1681302899913	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xcxetj3hj3d55bz5wockippgow	install_plugin_notify_admin	0	1681303618759	1681303620227	1681303620231	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
67rgn4e31jyrpdjbussaqszexw	install_plugin_notify_admin	0	1681303858807	1681303860396	1681303860400	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xodg5ky6xirr9yh67ux9wy3dxh	expiry_notify	0	1681303858783	1681303860396	1681303860410	success	100	null
d4y5s43bgidx8q365wcpk7d8fa	install_plugin_notify_admin	0	1681303978823	1681303980429	1681303980433	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rgik1cinnifafbj4szxxrmw7yo	install_plugin_notify_admin	0	1681304458983	1681304460687	1681304460692	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
amouhp1yt3b4fp1mfh161g6uyh	product_notices	0	1681305179100	1681305180907	1681305181213	success	100	null
rotmk3e9yig9zgf8gxj5i6r6fw	install_plugin_notify_admin	0	1681305779365	1681305781242	1681305781248	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ti1xi81xe7f1pga4ne9coayurr	install_plugin_notify_admin	0	1681131098439	1681131107924	1681131107928	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9qz841joafbabncdy3x889mrge	install_plugin_notify_admin	0	1681211533856	1681211534185	1681211534189	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ax7z94jg9fgztqskd6ixwj595h	expiry_notify	0	1681132838792	1681132848633	1681132848644	success	100	null
fgtpsbos7ffftqwi96shepw48c	install_plugin_notify_admin	0	1681298457428	1681298457514	1681298457520	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ps9yswodn7ykpneenjqo5zno1w	install_plugin_notify_admin	0	1681133018817	1681133028672	1681133028677	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
k8uaxdoz43nmtxzgt35ea1cmko	install_plugin_notify_admin	0	1681152123778	1681159328793	1681159328851	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
eus6p96xitf37bwkg49xz77kky	install_plugin_notify_admin	0	1681133138840	1681133148766	1681133148785	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6k5qcy5mwbnq8j6qey6ws4uoeo	install_plugin_notify_admin	0	1681198993359	1681199008327	1681199008401	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nzjcjw84qbbhjn3yjjdku4sg8e	expiry_notify	0	1681152123693	1681159328794	1681159328949	success	100	null
ei3415y497rpxc531zoie55yqo	install_plugin_notify_admin	0	1681134579143	1681134589345	1681134589349	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
81dbp8a86ifytqy74udt3o3uic	install_plugin_notify_admin	0	1681298937513	1681298937805	1681298937810	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
e8nrsp85xi8gu8s3oktn31ox6r	product_notices	0	1681152123628	1681159328794	1681159329521	success	100	null
pgtgnhra6b81pynajsunuhkrzy	expiry_notify	0	1681198993328	1681199008327	1681199008498	success	100	null
5q6h7fs6xt8s5r73cscr44h78w	install_plugin_notify_admin	0	1681215232135	1681215232415	1681215232445	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
j9cmes1cf7fi7gpzn94jg4i15h	install_plugin_notify_admin	0	1681195489538	1681195502602	1681195502614	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1h97g4ax17goxfdkignyowsqme	product_notices	0	1681198993368	1681199008326	1681199008834	success	100	null
ofjnjowehjfddqbebsxi9dhwnh	install_plugin_notify_admin	0	1681195609534	1681195622622	1681195622636	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ba36nefqhfgcdeffup19p8rqpr	expiry_notify	0	1681215232125	1681215232415	1681215232469	success	100	null
xhq4kf57ubn658eeq9uoisehzc	install_plugin_notify_admin	0	1681199112654	1681199127660	1681199127668	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w99mi9riyp88t8x9u5i5iqoqjo	install_plugin_notify_admin	0	1681205838129	1681206889418	1681206889541	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5ofzzyd5pfgefk8g6jnme8fbce	install_plugin_notify_admin	0	1681299297588	1681299298018	1681299298024	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w96jio7gj3bxty38tmjwu1hmir	install_plugin_notify_admin	0	1681221483765	1681221498723	1681221498731	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5zix73auqjyqixabbtrb7hyrfr	plugins	0	1681196209800	1681196223232	1681196223243	success	0	null
6xs5eza6oprndxms9m5teieiwc	install_plugin_notify_admin	0	1681210453713	1681210453970	1681210453974	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z37n7rycy3r1zjhrdxkawmed1e	import_delete	0	1681196209883	1681196223232	1681196223262	success	100	null
ykt38qm1838rdpj9i3x4kjr58y	install_plugin_notify_admin	0	1681196209868	1681196223232	1681196223271	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7ew9iixtq3gw3m95oq4nuh47re	expiry_notify	0	1681221483884	1681221498723	1681221498737	success	100	null
4witbbeh73n6xrwzah4roytwqh	export_delete	0	1681196209836	1681196223232	1681196223282	success	100	null
gaw8z1ofc7r4ikzffctwku1mbr	install_plugin_notify_admin	0	1681210573726	1681210573992	1681210573998	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
76cbuj9qutnzppksrz6wqxh8mr	install_plugin_notify_admin	0	1681210693746	1681210694019	1681210694023	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mpu7dxbn33ftfdtcwsamtj8r7o	install_plugin_notify_admin	0	1681210813759	1681210814042	1681210814046	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
c6ap5r5z3bg1mxoddhnnupzfor	install_plugin_notify_admin	0	1681210933776	1681210934063	1681210934067	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wkgzz9wag7g4fekh3y5ucjrn1h	install_plugin_notify_admin	0	1681273396561	1681280601955	1681280601988	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7i5hxr9m63yrfbfmz9ydz598kc	expiry_notify	0	1681273396515	1681280601955	1681280602317	success	100	null
73rcq8ahh7yh3nanbwu4cqt89a	product_notices	0	1681273396447	1681280601955	1681280602696	success	100	null
sios9wwyr7ba5c3riiyibh1mfc	install_plugin_notify_admin	0	1681131218452	1681131227966	1681131227972	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4hmr1imd57n6pyrim4tbny7qxr	install_plugin_notify_admin	0	1681132898803	1681132908652	1681132908665	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4bt6e7a1iiyk8ydah9t3uw7h6e	install_plugin_notify_admin	0	1681199232690	1681199232787	1681199232791	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ckpxsbop8jn7icmoa4ek95s65r	install_plugin_notify_admin	0	1681211893894	1681211894258	1681211894261	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7f3maogd3brs5kuch83igigwbh	install_plugin_notify_admin	0	1681134699206	1681134709471	1681134709500	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ytubwta33bfidkgunhpy61hq3y	expiry_notify	0	1681298637477	1681298637706	1681298637717	success	100	null
91ab8jqz8bnepgxuewhnha338a	install_plugin_notify_admin	0	1681159328942	1681166534856	1681166535181	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ktfabiq437g59dsa5kzodki18c	install_plugin_notify_admin	0	1681134819235	1681134829512	1681134829519	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
goyxqtysxpyj3bcd7477eh3qhh	expiry_notify	0	1681159328880	1681166534868	1681166535634	success	100	null
qpzubsjbeb8smqw8dbja1rbghr	expiry_notify	0	1681134819242	1681134829511	1681134829525	success	100	null
5pk9hn1k57gw5qsrg6txm5a7rr	install_plugin_notify_admin	0	1681206889488	1681206904424	1681206904429	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g49exfzaepnrbybxn84ecjpzqh	product_notices	0	1681159328863	1681166534856	1681166536610	success	100	null
jog5mpysotyt9ru49z68j4481e	expiry_notify	0	1681211953903	1681211954270	1681211954280	success	100	null
sbehcp471bn6xmxn9iuc5443qr	expiry_notify	0	1681206889912	1681206904424	1681206904435	success	100	null
wz98ei9nfjnizktwfbk81sxeuc	install_plugin_notify_admin	0	1681196329913	1681196343304	1681196343309	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jxck3uf45tr9prgxewqmyn7r9w	install_plugin_notify_admin	0	1681298697485	1681298697745	1681298697750	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wno13fqkq3repbewttmbmjx8mo	install_plugin_notify_admin	0	1681196449938	1681196463391	1681196463433	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
trxt1cmt6pdsxqnwgaod7aonka	install_plugin_notify_admin	0	1681212133926	1681212134306	1681212134311	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
n4aehqj3rpgu5rmexnyk1osria	expiry_notify	0	1681210633736	1681210634007	1681210634017	success	100	null
t1mka8g3sfbt3fkakenqec5wpy	install_plugin_notify_admin	0	1681211053790	1681211054085	1681211054090	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ni1qwndfm3rrjndci7zmjjz6iy	install_plugin_notify_admin	0	1681215352150	1681215352462	1681215352474	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8pjt3ta9938odkazxo7ojmfaty	install_plugin_notify_admin	0	1681301097907	1681301098651	1681301098656	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
c6yaf1axo78ubxbwnx8w5hbtqh	install_plugin_notify_admin	0	1681215535908	1681215550058	1681215550062	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ajmnnwmdz3ri8e95pakhdombba	install_plugin_notify_admin	0	1681301217923	1681301218683	1681301218688	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tgpt4gndijrp7du68a51qy3ncy	expiry_notify	0	1681301277936	1681301278694	1681301278711	success	100	null
q9z91x9z9inn7qgfgpx7q5zzja	install_plugin_notify_admin	0	1681223237861	1681223252862	1681223252868	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
383xbtyspbgrtg3pqpqax738ir	expiry_notify	0	1681223237909	1681223252862	1681223252885	success	100	null
9qzhnbwgdirq7moahfyhfcgdih	product_notices	0	1681280602370	1681280616957	1681280617061	success	100	null
b6agqasjejfg8psufqpqjy9qsh	product_notices	0	1681223237994	1681223252861	1681223253208	success	100	null
iqbtxbu39bg88rn6sn8x8nkakh	install_plugin_notify_admin	0	1681301337948	1681301338705	1681301338710	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
snfjewrt5tyqif9gxpapn4zwqy	install_plugin_notify_admin	0	1681303018415	1681303019954	1681303019957	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zztcwkgxtif1ur7scmu3zk7utr	install_plugin_notify_admin	0	1681280602150	1681280616957	1681280616963	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
n8cos84wnibhtkmecymbycmckr	install_plugin_notify_admin	0	1681303498738	1681303500193	1681303500218	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nfuun6rf5pbipcfgad57nzukch	expiry_notify	0	1681280602287	1681280616957	1681280616968	success	100	null
tsccex1qjp8xzxdoruybu7eq3a	install_plugin_notify_admin	0	1681303738768	1681303740338	1681303740343	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rqyof51bjjbg9n4sa3kwdkziew	install_plugin_notify_admin	0	1681131338462	1681131348018	1681131348024	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
p3efb8oawbdx8eset5ppwep4fr	install_plugin_notify_admin	0	1681133258866	1681133268808	1681133268819	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
u37bghdkmjgpfn5dwfdg3dbi4w	product_notices	0	1681131398470	1681131408038	1681131408307	success	100	null
dzac4184nprn9poc4rhopy86ho	install_plugin_notify_admin	0	1681199352706	1681199352831	1681199352834	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
eftu8ouqifntmcbpcab4fi334r	install_plugin_notify_admin	0	1681212013913	1681212014284	1681212014289	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dw9iyp1x4pbe3bh5mk9gnoreaw	install_plugin_notify_admin	0	1681131458479	1681131468052	1681131468056	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
unw886bchifhxrw83kcc4n15qe	install_plugin_notify_admin	0	1681135059299	1681135069558	1681135069562	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
czsahywr4jfb8g8emjky1dxano	install_plugin_notify_admin	0	1681298817495	1681298817770	1681298817774	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fu48j5ef37nptn3oixfqhsamfe	import_delete	0	1681297977190	1681297992138	1681297992162	success	100	null
cj6qhae57tfbigtxbkt61d6sar	expiry_notify	0	1681131518488	1681131528063	1681131528073	success	100	null
77ypbq1177d55pgkdad4i6k6yc	install_plugin_notify_admin	0	1681135419395	1681135429688	1681135429692	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jwcym5r6fbbr3bsfegbg57poww	install_plugin_notify_admin	0	1681212253938	1681212254328	1681212254336	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4qtyerxhxfrtie67tr4d8t6eih	expiry_notify	0	1681166534566	1681173738863	1681173739197	success	100	null
cgokqzxexbfmupnxif9mif83ea	install_plugin_notify_admin	0	1681166534881	1681173738863	1681173739264	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x9gii7fqkfdpb85wxbhrophr1c	expiry_notify	0	1681135479406	1681135489698	1681135489707	success	100	null
bnrkynou5tfddydmjtp9x3hkko	product_notices	0	1681297977135	1681297992138	1681297992849	success	100	null
xowcqmfh9bdotegrfmefd9u4aw	product_notices	0	1681166535330	1681173738863	1681173739889	success	100	null
uzucsnqnbjds78s8dafkwwswrc	install_plugin_notify_admin	0	1681135539416	1681135549711	1681135549715	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w5wogfj1z38xbfbpudi7uhcozc	install_plugin_notify_admin	0	1681207838806	1681207853692	1681207853699	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dspteau5fj83myowxebnt1crke	install_plugin_notify_admin	0	1681215472164	1681215472480	1681215472485	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w8ghrip65prr7ks7py4e6amasw	expiry_notify	0	1681196509970	1681196523444	1681196523469	success	100	null
q4d9gzpjotgo3y3hsri6ayhnmr	expiry_notify	0	1681207838811	1681207853692	1681207853706	success	100	null
3mtsbutzkidyzn1uac5rfebnic	product_notices	0	1681207838698	1681207853692	1681207858950	success	100	null
17e4tnnih3y9ig4i6xu1hnws6o	install_plugin_notify_admin	0	1681215709101	1681215724105	1681215724109	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9kqu6o7yqin998w1jw67ubysoc	expiry_notify	0	1681209313562	1681209313702	1681209313711	success	100	null
nd97coxnw7gaxqcyct54gewtrc	install_plugin_notify_admin	0	1681299057534	1681299057966	1681299058161	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yqw9d95y9tneup7dtbncw58q6r	install_plugin_notify_admin	0	1681209373577	1681209373722	1681209373727	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z7ddfyrcffrrjxnw94hc57prny	install_plugin_notify_admin	0	1681301457955	1681301458746	1681301458758	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4nhx8egf1idfijrytboe443hmr	install_plugin_notify_admin	0	1681209493587	1681209493759	1681209493764	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ohd9csaq83dqty6mab4r5bzy3r	install_plugin_notify_admin	0	1681227208293	1681227223111	1681227223193	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pxesmbo753d1jyi36zu5yfgcme	expiry_notify	0	1681227208257	1681227223111	1681227223206	success	100	null
sp9uga5wsbfzfgueazswowh6gr	product_notices	0	1681227208307	1681227223110	1681227223412	success	100	null
qmduori9styu9jtiqdyitq6grr	install_plugin_notify_admin	0	1681303138546	1681303140015	1681303140024	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1otni5qunpgxxdyrqwrfjrbsuy	plugins	0	1681297975799	1681297977134	1681297977161	success	0	null
rw1xih8aqf8u5yc5cxbr4cedgw	export_delete	0	1681297976957	1681297977134	1681297977202	success	100	null
zqnxeqggkpbejb6877ycb4phzr	install_plugin_notify_admin	0	1681297977054	1681297977133	1681297977200	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5wknuaynyp87dcccitojtphihr	expiry_notify	0	1681297976853	1681297977134	1681297977244	success	100	null
1gq1sn89mb8czkochk9na6cora	install_plugin_notify_admin	0	1681131578499	1681131588076	1681131588082	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dfo837dh6i8obfcawzprjpq3co	install_plugin_notify_admin	0	1681305899383	1681305901273	1681305901276	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yhns6mxjrtrupf1o1uayq595mh	install_plugin_notify_admin	0	1681306499482	1681306501568	1681306501574	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z83ofoejn7rzf8f1uuqez5jkoy	install_plugin_notify_admin	0	1681133378899	1681133388865	1681133388882	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nqyr7iy5xby37g6msxg4nmm6te	install_plugin_notify_admin	0	1681299177558	1681299177989	1681299177994	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3bioj5d713ggbgpoia55kbh3nw	install_plugin_notify_admin	0	1681306739539	1681306741700	1681306741711	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
t3honp1m6ffwtpj1k5xew9fkxe	install_plugin_notify_admin	0	1681173739246	1681180943968	1681180944207	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ccsjrqg5oirqmmge9kjychf9fo	install_plugin_notify_admin	0	1681200319714	1681200334474	1681200334481	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
us63wkz5y3fcxgkuqioakz3dkw	install_plugin_notify_admin	0	1681133498935	1681133508913	1681133508918	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fu9qn94c7788teeasxf4r997tr	install_plugin_notify_admin	0	1681213911081	1681213925945	1681213925948	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1eijfj3yatdb9k7q8awnn4z76o	expiry_notify	0	1681133498945	1681133508913	1681133508921	success	100	null
ukuqxzdg3incbnn8jen64tbmzr	expiry_notify	0	1681200319728	1681200334474	1681200334486	success	100	null
41juxehxspdhfem89ezc7x1iic	expiry_notify	0	1681173739198	1681180943978	1681180945621	success	100	null
8ai6zqps9fbab8tsj4ws9r8b1r	install_plugin_notify_admin	0	1681135659428	1681135669743	1681135669748	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
absyn1awoty5tma3ynw8x7ukny	product_notices	0	1681173738942	1681180943969	1681180946363	success	100	null
rx1snytwhbr58kruscr5sb8ouy	install_plugin_notify_admin	0	1681136619708	1681136630178	1681136630193	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
q647ocsqf3gw3f11hc5i6ociuw	expiry_notify	0	1681213910918	1681213925945	1681213925954	success	100	null
jdx1jcrhktgdufsdhcxi98o6wc	install_plugin_notify_admin	0	1681299777738	1681299778218	1681299778228	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3sy65dy59pdtmyjdx5c61jporo	install_plugin_notify_admin	0	1681214031983	1681214046890	1681214046894	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
z8pqunb16jgndpjphd7qjfpexc	expiry_notify	0	1681208653005	1681208653141	1681208653159	success	100	null
91f5z8siofyk5rhgfc7yo5yqjc	install_plugin_notify_admin	0	1681208653029	1681208653141	1681208653161	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ag4uu3aqo7rq3rc9t1kdm747ce	install_plugin_notify_admin	0	1681209133537	1681209133654	1681209133658	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ix87478m83g7uqza96ffpmw7ih	install_plugin_notify_admin	0	1681215818205	1681215832989	1681215832993	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ckfngaufj7by7j3x4h8mfcuwwr	expiry_notify	0	1681299957720	1681299958223	1681299958291	success	100	null
rk9giwhhgiytiytsnhxqquet3a	install_plugin_notify_admin	0	1681230110833	1681230111319	1681230111328	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xhxzcjpfaidq5pdgzt9jjrutbr	expiry_notify	0	1681230111176	1681230111319	1681230111429	success	100	null
z5kxaeigniyspc3no6tygm7rny	install_plugin_notify_admin	0	1681301577999	1681301578836	1681301578854	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
m1kz5sgib7gi7csxi3yibbzwyy	install_plugin_notify_admin	0	1681301698017	1681301698919	1681301698923	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9rct3skim7gw9xoe5fe7skg56c	product_notices	0	1681301577991	1681301578836	1681301579192	success	100	null
1f6ao1oqxibh8bzzkup3595snh	install_plugin_notify_admin	0	1681302658308	1681302659781	1681302659819	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
crtnhkyktjy69mo7xtgbf14uzo	expiry_notify	0	1681304518996	1681304520701	1681304520713	success	100	null
mw5hffahf38dbrhrqujusukykw	expiry_notify	0	1681303198567	1681303200058	1681303200071	success	100	null
4wy6bxzb67f78bh1inutnade1h	install_plugin_notify_admin	0	1681304699022	1681304700749	1681304700754	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rksqqhsorfdwmp89wh1h4x8bty	install_plugin_notify_admin	0	1681304579007	1681304580720	1681304580732	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ftxbgw1nifbopc1zzxrh85m6mw	install_plugin_notify_admin	0	1681304819039	1681304820780	1681304820784	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tnohpk8bkbnppdpsrzkrk65azr	install_plugin_notify_admin	0	1681131698509	1681131708106	1681131708111	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
h5p13168cf8bmrg6aj36s4n58y	install_plugin_notify_admin	0	1681131818520	1681131828127	1681131828131	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oqoxb71aw3ywmeorczozyhaffa	install_plugin_notify_admin	0	1681133618956	1681133628940	1681133628944	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7y37z95tz7gm7qm68x63frcjxw	install_plugin_notify_admin	0	1681214151991	1681214166938	1681214166945	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
crtjdqkeu7f8dd55e3tbrmxjco	expiry_notify	0	1681299297638	1681299298017	1681299298033	success	100	null
ckyai85au7gb5pgjzp135pi8mh	install_plugin_notify_admin	0	1681135779446	1681135789831	1681135789836	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xnsm9kuuqpb99dh3as56od9uic	install_plugin_notify_admin	0	1681201373672	1681201388387	1681201388398	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
u4wsq4jitjgjzgpgi353p8dgfe	install_plugin_notify_admin	0	1681306019399	1681306021312	1681306021317	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jabj4rp74bgg5x6giem91njmae	expiry_notify	0	1681201373662	1681201388387	1681201388401	success	100	null
b53pcjzwoigh9gafe6myhfaz5o	expiry_notify	0	1681180945100	1681188147523	1681188147799	success	100	null
6zpuhms137y3bb1shfawpmx9dy	install_plugin_notify_admin	0	1681180945106	1681188147521	1681188147803	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6m9dydgg4ibjfc8wec3p86gabw	install_plugin_notify_admin	0	1681136139534	1681136150015	1681136150030	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
65tcxnrkpirczpbhd9e74dn68o	expiry_notify	0	1681136139521	1681136150016	1681136150044	success	100	null
b9x7w5knqtgt3yitesph7qwz5a	install_plugin_notify_admin	0	1681214392007	1681214406977	1681214406981	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5w6ijcx1uibuuk4639jt7oxb6y	product_notices	0	1681180944598	1681188147522	1681188148481	success	100	null
acjkgmwdgibp3jka9dr5kshjta	install_plugin_notify_admin	0	1681136379671	1681136390106	1681136390117	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wisu8jdczjn19yzniuf7rqh69r	install_plugin_notify_admin	0	1681208773497	1681208773556	1681208773560	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9d97d7beeffbxrqcemeu4zubye	install_plugin_notify_admin	0	1681299537690	1681299538080	1681299538086	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
y9grnizqetygfpbf4esgdp7nca	install_plugin_notify_admin	0	1681209613599	1681209613789	1681209613793	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
iij6dytexf8mbkwycretbyyp6w	install_plugin_notify_admin	0	1681217552881	1681217567878	1681217567882	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7naqcofsu3n3zeipqoc4zps3me	install_plugin_notify_admin	0	1681209733618	1681209733812	1681209733815	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
18ooub1qoigjuqbffzmybok6oh	product_notices	0	1681237348916	1681237363424	1681237363760	success	100	null
xg89ndsj4tfx3g314pe3qhu1xy	expiry_notify	0	1681217552909	1681217567877	1681217567888	success	100	null
pq3k6wm67p833x6y869kcouc4c	install_plugin_notify_admin	0	1681300017728	1681300018234	1681300018237	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ma4dxoz737dp8fuup3owcbxhmr	install_plugin_notify_admin	0	1681301818046	1681301818955	1681301818972	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
necua1p3jpr3by8b4gkc9mrrjy	install_plugin_notify_admin	0	1681237348908	1681237363424	1681237363434	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kas3z5cysfr48dxmjhmq3k8ibe	expiry_notify	0	1681237348880	1681237363424	1681237363437	success	100	null
gmobwgbe7pf9fxjxq4hzn3y41a	install_plugin_notify_admin	0	1681301938128	1681301939053	1681301939118	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g5ttwtpszbgdmpffm7x8dyxo6a	expiry_notify	0	1681301938111	1681301939054	1681301939118	success	100	null
d1pibn98bifdpcbx7pq1z53tiy	expiry_notify	0	1681302598297	1681302599765	1681302599848	success	100	null
qkjgk963djf7pf5m3d3zqyu9qc	install_plugin_notify_admin	0	1681303258607	1681303260074	1681303260081	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3qp1axxanpgb5qbd3j7uu6jzkh	install_plugin_notify_admin	0	1681303378711	1681303380133	1681303380147	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jnonz6zfj7d7igiuc1zjirn9fy	install_plugin_notify_admin	0	1681304939055	1681304940815	1681304940819	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bxoiaqi8t3rc8etnfta9s7x8jr	install_plugin_notify_admin	0	1681305299221	1681305301047	1681305301051	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kayqoxyrxbraig5mc7w3i847iw	install_plugin_notify_admin	0	1681131938538	1681131948181	1681131948188	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1t9u1mg587gt7k86p5qmpfy98o	install_plugin_notify_admin	0	1681306139413	1681306141344	1681306141351	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9rpf79giej8pmrjesdscxsw83r	install_plugin_notify_admin	0	1681133738964	1681133748978	1681133748981	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ydaeekeje3g3pj7bdpow3m6rfw	install_plugin_notify_admin	0	1681214271999	1681214286959	1681214286962	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hp4thhtspb8jmrh1broxfa89me	install_plugin_notify_admin	0	1681299417669	1681299418036	1681299418040	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qys7nihdabrk3nipy3c51wk8fr	install_plugin_notify_admin	0	1681133979026	1681133989102	1681133989107	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
69hfo9zgiin3jphu8yupoaaxge	install_plugin_notify_admin	0	1681202344471	1681202344492	1681202344506	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jiohqs5ia3duupoy4pa1yzubme	install_plugin_notify_admin	0	1681135899468	1681135909895	1681135909901	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gn3jxgqn1i875mnyaggoatuych	install_plugin_notify_admin	0	1681188147647	1681188162525	1681188162530	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
afkajeqtc78i8f7ona1j3a1cpc	expiry_notify	0	1681202344427	1681202344492	1681202344520	success	100	null
844ju7zsf7ra8fngbwmjahigqw	install_plugin_notify_admin	0	1681136019494	1681136029939	1681136029974	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mzqbxqyxyinabfgzg5edf68csr	expiry_notify	0	1681188147712	1681188162525	1681188162539	success	100	null
rf85yb6re3fkzntje1yeubmezo	install_plugin_notify_admin	0	1681214512016	1681214526997	1681214527000	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
f1y778dqkjditc7f5mjnic4fby	install_plugin_notify_admin	0	1681137219819	1681137230338	1681137230341	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ciq87msqcbne3rh5tjxgc7jj8c	product_notices	0	1681188147717	1681188162524	1681188162677	success	100	null
93ana5nd6fffxy57noo6byf5oh	install_plugin_notify_admin	0	1681208893509	1681208893583	1681208893586	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jojwbo7uiibppmhcoh6y7pq9eh	install_plugin_notify_admin	0	1681299657706	1681299658131	1681299658136	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rpwsxnqj63r57jeeypdh96ewoa	install_plugin_notify_admin	0	1681306619510	1681306621651	1681306621685	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3aadtfgwmbbt5fp6qctudir3wr	expiry_notify	0	1681214572024	1681214587004	1681214587017	success	100	null
3tsygxcbsid7jqijrkcmiexxja	install_plugin_notify_admin	0	1681302058132	1681302059174	1681302059196	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
d3yxqo79d3yedps6mi89x37xby	install_plugin_notify_admin	0	1681218574887	1681218589812	1681218589818	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zk3wfqy4g3g3tko4e4gbdbdqwc	install_plugin_notify_admin	0	1681302178200	1681302179303	1681302179307	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dqamntxac3yamykjpc6shictpe	expiry_notify	0	1681218574862	1681218589812	1681218589826	success	100	null
z5ix45j867fr7yawj6yy7byqaa	install_plugin_notify_admin	0	1681302298213	1681302299560	1681302299604	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
poetwg64aiyetctjdtyofa9aic	install_plugin_notify_admin	0	1681304098837	1681304100482	1681304100485	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
69ktcssjg7ybuxzwq8mx3m7zua	install_plugin_notify_admin	0	1681244577300	1681251782369	1681251782441	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
iwgqg7miqpguimisst1p6x7hke	expiry_notify	0	1681244577365	1681251782369	1681251782581	success	100	null
saj59shz1ifuixdbhh38o8qc4w	product_notices	0	1681244577401	1681251782369	1681251783126	success	100	null
jyr8odzmi7gx5q1pngwcafi47o	install_plugin_notify_admin	0	1681304218955	1681304220616	1681304220621	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jhxerfpx778mue6bukhym33tzw	install_plugin_notify_admin	0	1681305059070	1681305060862	1681305060868	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xrouyqi5i7g97gtgj6ozo6wpmo	install_plugin_notify_admin	0	1681305179092	1681305180907	1681305180911	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cyzrmfwqkib7fxttb6fzumraho	install_plugin_notify_admin	0	1681305659343	1681305661188	1681305661194	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fx16t4ikotr48dou13ozuyqpih	expiry_notify	0	1681305719355	1681305721211	1681305721227	success	100	null
cp9cd7m717bq9y6toawk4pnmsw	install_plugin_notify_admin	0	1681132058548	1681132068225	1681132068229	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jrf7zrw77fg6zmi773ixq87t3y	install_plugin_notify_admin	0	1681133859004	1681133869008	1681133869037	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qomtrj8haif93ezdc7shmqsagh	install_plugin_notify_admin	0	1681214632051	1681214647015	1681214647019	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
36bkhbnzkiyr5kk6f7ciyotk6e	install_plugin_notify_admin	0	1681132178613	1681132188301	1681132188307	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cpjipofuxiyebxp4fm6sh57nwc	install_plugin_notify_admin	0	1681299897710	1681299898201	1681299898206	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hmeyfkdabibwpjk61p5yzcnzqa	expiry_notify	0	1681132178620	1681132188301	1681132188314	success	100	null
t9k6hdsnofn9mpt43br6juzo7o	install_plugin_notify_admin	0	1681136259625	1681136270051	1681136270056	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8koze8im93numr9wrw1khf7yno	install_plugin_notify_admin	0	1681306259437	1681306261469	1681306261476	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
adjz5787hpruic1kygxw7dymyh	install_plugin_notify_admin	0	1681136499681	1681136510130	1681136510138	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8pbewz9c8jbgufbnwrt83jsgmr	install_plugin_notify_admin	0	1681194528724	1681194541546	1681194541549	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
u1ir639zhjgspeytahmcay4cdr	install_plugin_notify_admin	0	1681203451066	1681203465903	1681203465911	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
mwi34rpintdt9kqknpqshcympw	expiry_notify	0	1681194528042	1681194541546	1681194541557	success	100	null
77h3f14yoi8htrep8ptpz7a7ha	install_plugin_notify_admin	0	1681300497789	1681300498376	1681300498385	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
68yctrbm5fde7pum3dyhynqpae	product_notices	0	1681194527680	1681194541546	1681194541813	success	100	null
soy1spg6xpf49pihs8tdm6n5bo	expiry_notify	0	1681203451080	1681203465903	1681203465922	success	100	null
6rfdeaaz6bf5ic7y7i3oix7hga	install_plugin_notify_admin	0	1681215112118	1681215112360	1681215112391	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g173d7g6qbbzpc3kymkjof5bxw	install_plugin_notify_admin	0	1681194889404	1681194902265	1681194902269	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hupwwnbo1if37jow84n57rmxya	product_notices	0	1681203451088	1681203465902	1681203466173	success	100	null
mhkh3ba5ebdabcwxtzmjcmu7za	install_plugin_notify_admin	0	1681306379459	1681306381526	1681306381549	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pmd4kmjtp7n6zms3i8565hdr3a	product_notices	0	1681215112109	1681215112360	1681215112906	success	100	null
a3rkgsoo3ifobbi1i9ozwwq7gc	install_plugin_notify_admin	0	1681209013524	1681209013619	1681209013627	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ogdgc6zbdprcu8u313zbmpb7co	install_plugin_notify_admin	0	1681302418222	1681302419627	1681302419650	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ad3xkriedi8pum6cbney5bidhy	install_plugin_notify_admin	0	1681209253549	1681209253686	1681209253690	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
k1rfwtnwapfhteqacr9ifrt6nc	install_plugin_notify_admin	0	1681210093670	1681210093889	1681210093893	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
fdu3k1mor7dcddngam7eiwas4y	install_plugin_notify_admin	0	1681304338970	1681304340652	1681304340656	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jxk1er4ynin6b8r31b4nogo7rr	expiry_notify	0	1681219536106	1681219550937	1681219550949	success	100	null
49hyzqesf3d4xjem8tq45oskde	install_plugin_notify_admin	0	1681219536097	1681219550937	1681219550952	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
y4ybd5u9zbd68pmck9smthh5tr	expiry_notify	0	1681307039607	1681307041916	1681307042013	success	100	null
zy3bif4s878kbcf655oxx36dmo	product_notices	0	1681219536087	1681219550937	1681219551197	success	100	null
jjk145eif3yqdkikb9zc7d97oa	expiry_notify	0	1681305119081	1681305120882	1681305120892	success	100	null
h5ijoqts8bd39ma531ozkjs4go	install_plugin_notify_admin	0	1681305419256	1681305421109	1681305421114	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g4k1kwcweibgmqiokh8ccqzdec	install_plugin_notify_admin	0	1681251782487	1681258986340	1681258986377	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
g6t9e8pd73dompuxaqzfgywb6c	expiry_notify	0	1681251782314	1681258986340	1681258986378	success	100	null
3mwaurtik7bu5dkou8n4qg8j8o	product_notices	0	1681251782561	1681258986340	1681258986936	success	100	null
oumfacf69j8migeho8fdei7nca	install_plugin_notify_admin	0	1681305539312	1681305541143	1681305541147	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dg6qcn8t67gjdy17fcikhb43fa	install_plugin_notify_admin	0	1681306859573	1681306861732	1681306861737	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gwn548jps78u5p8fwrjwusiwjc	install_plugin_notify_admin	0	1681314421123	1681314424437	1681314424442	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xicdngpxhiy7ichyzypmy358eo	install_plugin_notify_admin	0	1681307459685	1681307462018	1681307462024	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
64mbyjsnn3rsxcmgsd11pr1whr	install_plugin_notify_admin	0	1681314541157	1681314544476	1681314544482	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ic9h8s53g7n3fdk1aec1w46xyo	install_plugin_notify_admin	0	1681314661181	1681314664617	1681314664661	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
96aerw9euig9bx81uzrgdbpkuo	install_plugin_notify_admin	0	1681329433820	1681329448804	1681329448828	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
d915hd9dmid6uxgrxsmk7o3fwe	install_plugin_notify_admin	0	1681365587892	1681365602341	1681365602350	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
6h6g5baf4b8ipct3t1b8rxkf4o	plugins	0	1681384385810	1681384399525	1681384399552	success	0	null
ipy7hcctfbdridtt97mzwk3gto	install_plugin_notify_admin	0	1681384565880	1681384579746	1681384579761	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tzouxog8rf8498tfetua99c4dy	install_plugin_notify_admin	0	1681384685929	1681384699835	1681384699840	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5fc6arx74384dpbzr7ybudyhgh	install_plugin_notify_admin	0	1681306979592	1681306981867	1681306982027	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
sc97tk7iyigpfq49toh9eyipuo	install_plugin_notify_admin	0	1681307219630	1681307221956	1681307221960	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3ru5hpyimtn6tbhf463xo31s1h	install_plugin_notify_admin	0	1681314781193	1681314784676	1681314784679	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w8is3wjm7br1tkxsp9y6oty3tw	expiry_notify	0	1681314961196	1681314964609	1681314964653	success	100	null
kgaqxgdmffrcfptipuzwpbdyyh	install_plugin_notify_admin	0	1681336661030	1681336676011	1681336676040	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
s3t4poqpm3f7xmm1hxxaky5fyh	expiry_notify	0	1681336660983	1681336676011	1681336676047	success	100	null
xzm6t1a87bgepegfw13rbo69so	product_notices	0	1681336661060	1681336676011	1681336676274	success	100	null
n648tip3ob8opjisgzest1khyh	expiry_notify	0	1681365587920	1681365602337	1681365602363	success	100	null
4yt3m9dknfg9jbrxdiue3e3dir	product_notices	0	1681365587810	1681365602338	1681365602553	success	100	null
jk8h6ozgajn18xt5ipcoqmwu3w	import_delete	0	1681384385839	1681384399525	1681384399561	success	100	null
pq9j7roh9jdidrftf9mugknuew	install_plugin_notify_admin	0	1681384805941	1681384819968	1681384819983	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
iwh3nm7e7pbx9f8kn4445muyjo	install_plugin_notify_admin	0	1681307099617	1681307101930	1681307101934	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
oakt4citsfyztc576uwpr1y8aw	install_plugin_notify_admin	0	1681307339669	1681307341993	1681307342010	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jxi9841ot3n6bkmdfixice1bfe	install_plugin_notify_admin	0	1681307579711	1681307582050	1681307582053	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
1qh7m3xq43y1jcmot96z8yro5h	product_notices	0	1681343893824	1681343908473	1681343910105	success	100	null
9qxdteb89jn9zxm7k6bbex7guy	install_plugin_notify_admin	0	1681307699769	1681307702079	1681307702086	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
98by5aqkxfd5fnfyqsyofejaea	expiry_notify	0	1681307699754	1681307702079	1681307702093	success	100	null
xwwxfrujetdhxryc3m8rryrz4c	install_plugin_notify_admin	0	1681307819803	1681307822109	1681307822114	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4ett8zjab78n8m9to4o9wdebuw	install_plugin_notify_admin	0	1681307939839	1681307942139	1681307942143	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
48n3t43nuj8h5jmmpfwr6i9doh	install_plugin_notify_admin	0	1681308059920	1681308062168	1681308062171	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
is3eqy9kmp8oxqtqyowor91fda	install_plugin_notify_admin	0	1681308179948	1681308182193	1681308182201	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
exy6rtuu3trpjk7ihq6f4adkrw	install_plugin_notify_admin	0	1681308299982	1681308302246	1681308302252	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7kn54uqbajdyfj5qey4mkk4imy	expiry_notify	0	1681308359999	1681308362263	1681308362282	success	100	null
puc8d6bzwfrwbkm8zjpzuesdoc	install_plugin_notify_admin	0	1681308420012	1681308422286	1681308422329	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ygtk5rban7ntfp6mmwuisddkio	install_plugin_notify_admin	0	1681308540046	1681308542341	1681308542348	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tmnbhts5z3y6jnuu1x9yiyxrcc	install_plugin_notify_admin	0	1681308660060	1681308662372	1681308662376	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
resk49wyhinfmrx5pbwkws65gc	install_plugin_notify_admin	0	1681308780088	1681308782399	1681308782406	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
inowh7gqwi8hxrx6riqhdkhazo	product_notices	0	1681308780076	1681308782399	1681308782662	success	100	null
csouhqzyspfyxqmr73rp5w9yxy	install_plugin_notify_admin	0	1681308900100	1681308902428	1681308902433	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rbx3ma7bkt8e8d6z55a58z8rwy	install_plugin_notify_admin	0	1681309260170	1681309262529	1681309262534	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
9mj93c1ikjgjjq9napwyozspfh	install_plugin_notify_admin	0	1681309020140	1681309022473	1681309022511	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
cc7nj958rfbt3njneg35hpxooy	expiry_notify	0	1681309020132	1681309022474	1681309022516	success	100	null
cwor15zz17y93nceu4mf4tgpwe	install_plugin_notify_admin	0	1681309140155	1681309142501	1681309142505	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3jh9uxe7a7r1udqdemqpsr8sie	install_plugin_notify_admin	0	1681309380185	1681309382555	1681309382563	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
i3sfs5ekhpbcxrgj74w5gmr61r	install_plugin_notify_admin	0	1681309500203	1681309502582	1681309502587	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tk78nfs8g3dgtrwpjddru7ediw	install_plugin_notify_admin	0	1681309620218	1681309622621	1681309622626	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
hezoj5ujt3gwmk4kbwngqxdsiw	expiry_notify	0	1681309680227	1681309682642	1681309682652	success	100	null
guboop8bztfe7kawu9iiswf3ma	install_plugin_notify_admin	0	1681309740235	1681309742658	1681309742661	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
s5jd7jhak3dcfrz17iacbkhesh	install_plugin_notify_admin	0	1681309860261	1681309862702	1681309862729	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7tjshn8k9t8bmystdp4a8afofa	install_plugin_notify_admin	0	1681309980346	1681309982751	1681309982754	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gqsk1r1xpfbhmqem1iggm1wd4a	install_plugin_notify_admin	0	1681310100367	1681310102794	1681310102829	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
k339excfx38uj8k79ys97kj89r	install_plugin_notify_admin	0	1681310220395	1681310222820	1681310222825	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yiy5atx64bf88b67e55med41uy	expiry_notify	0	1681310340410	1681310342842	1681310342850	success	100	null
jxgcafc8zi8c3qmjnmi6j75ahe	install_plugin_notify_admin	0	1681314901217	1681314904714	1681314904718	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ynccxd5tkign3napdb8qceghiw	install_plugin_notify_admin	0	1681310340420	1681310342842	1681310342848	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nmarps5ki78sbc1h9yb8dnhwor	install_plugin_notify_admin	0	1681310700459	1681310702925	1681310702931	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
gidpixwmsfdkx894yg93xtfkca	install_plugin_notify_admin	0	1681343893876	1681343908473	1681343908511	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
j1unxajnqjy9imxpgsbym5d1pc	expiry_notify	0	1681372817529	1681372832448	1681372832460	success	100	null
y6uzi43tp3dhbkn1myod44hmay	install_plugin_notify_admin	0	1681372817472	1681372832448	1681372832531	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ad7obg7bf3n6jb679qj5ukcy7w	product_notices	0	1681372817421	1681372832448	1681372832956	success	100	null
4m1jjsz8xjftup3mchbe5c667w	export_delete	0	1681384385753	1681384399525	1681384399598	success	100	null
ehggmm964jrti8nst5oiu5txqh	install_plugin_notify_admin	0	1681384445862	1681384459559	1681384459564	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3byw4rm47i8c7esoe9dg84o5sc	install_plugin_notify_admin	0	1681384925972	1681384940047	1681384940065	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xo58x3in3tnx8x5awboyjn1nyo	install_plugin_notify_admin	0	1681310460435	1681310462864	1681310462868	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
dxnt1dck8jdczd7j4ja4s3o6yc	install_plugin_notify_admin	0	1681310580444	1681310582883	1681310582898	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nz48mxt88tdhtqm94ctyhb3qoh	product_notices	0	1681322200079	1681322200122	1681322200601	success	100	null
juqfeukb1pfimrdgswmqw7n5gw	install_plugin_notify_admin	0	1681322200127	1681322215142	1681322215160	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
zfmca3x6mbggfnhwf61ywy3o4o	expiry_notify	0	1681322200108	1681322215143	1681322215168	success	100	null
i1nm333zm38ammoymgsdpm5yrc	expiry_notify	0	1681343893843	1681343908473	1681343908527	success	100	null
dmhkgfobe78xpr6s4yiustz5ar	expiry_notify	0	1681380047364	1681380062392	1681380062995	success	100	null
c66exyyny3rstcy13j5hfk1n4y	expiry_notify	0	1681384985985	1681385000070	1681385000093	success	100	null
garzayq87tr17ns1t4d999813y	install_plugin_notify_admin	0	1681385045998	1681385060125	1681385060137	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
4skmbqud37deibe16hxd3394te	install_plugin_notify_admin	0	1681310820473	1681310822968	1681310822973	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ic5kdfotdjbz5kje1htdit6bre	install_plugin_notify_admin	0	1681310940454	1681310942983	1681310943046	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ca7xm8sa63na5f11y5ypyn513a	install_plugin_notify_admin	0	1681312140633	1681312143473	1681312143480	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
xnzq4zeji3na7n556arbfx3x1a	expiry_notify	0	1681311000464	1681311002998	1681311003009	success	100	null
98wortddpffy5e8pefutcf7x8o	install_plugin_notify_admin	0	1681311060473	1681311063012	1681311063017	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
3mzh1n4oepfapkhf9dqqqs5bxh	install_plugin_notify_admin	0	1681311180494	1681311183059	1681311183066	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
rnchjskijp83py93ra5pup7hoo	install_plugin_notify_admin	0	1681311300506	1681311303083	1681311303088	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
bhe74trh8prb8j5sqahqsmnudr	install_plugin_notify_admin	0	1681311420525	1681311423161	1681311423195	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
i1etnexyi3g3frb7rkba7jp9ko	install_plugin_notify_admin	0	1681311540548	1681311543229	1681311543266	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pnereyfmupy4pgsn67xyxr4hpc	install_plugin_notify_admin	0	1681311660568	1681311663297	1681311663304	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yqm1xruw6jgifg6j57w9zhyjcc	expiry_notify	0	1681311660560	1681311663297	1681311663307	success	100	null
nzpco59r47yn9q5qooi8ujwagy	install_plugin_notify_admin	0	1681311780573	1681311783412	1681311783417	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nq9fxoxcb78pucgsfrf9dkxdea	install_plugin_notify_admin	0	1681311900582	1681311903431	1681311903435	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
x9aoqgza3prh8ep6cno9f64wno	install_plugin_notify_admin	0	1681312020604	1681312023450	1681312023460	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8y8d1swwcb88xqx36bek9iyokc	install_plugin_notify_admin	0	1681312260647	1681312263508	1681312263512	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8frdb5u5q3gzbey8jurf8qkfwe	install_plugin_notify_admin	0	1681312740861	1681312743797	1681312743803	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
iho9yiu1ff84xjdthbkc8pawbo	expiry_notify	0	1681312320660	1681312323521	1681312323533	success	100	null
sgypsntoh3yfzqtofmhnpp938w	install_plugin_notify_admin	0	1681312380713	1681312383584	1681312383595	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
kz1hmm5pm3faiqjxrrg1jxuukr	product_notices	0	1681312380751	1681312383584	1681312384099	success	100	null
7m8i5f3ocpb4xg3ehwns6swypr	install_plugin_notify_admin	0	1681312500764	1681312503623	1681312503634	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
5qzxiao9qiy67fgacgo8zpabjo	install_plugin_notify_admin	0	1681312620772	1681312623685	1681312623689	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
nn9ospf19bgzxccj4fk64tqfyr	install_plugin_notify_admin	0	1681312860874	1681312863829	1681312863836	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pqe8xphnwpbfpn6836hwbhbncr	install_plugin_notify_admin	0	1681312980890	1681312983871	1681312983878	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
yhrwni18r7ycfn6yk6hdfuoaty	install_plugin_notify_admin	0	1681313100907	1681313103893	1681313103897	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
c4fabnw9ctgsdes1jupsgnqx7o	expiry_notify	0	1681312980897	1681312983871	1681312983893	success	100	null
sk91cz9jjpg5zrptpf3k9uqafw	install_plugin_notify_admin	0	1681313220920	1681313223923	1681313223926	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
pe8r6i4kifyourtffmfy9wjuco	install_plugin_notify_admin	0	1681313340933	1681313344003	1681313344010	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
tdypfok9i3yapbp481ae1ah1we	install_plugin_notify_admin	0	1681313460948	1681313464034	1681313464038	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
w5s1nocyu7nsb8zkf6ywipuy9c	install_plugin_notify_admin	0	1681313581015	1681313584174	1681313584180	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
ufc4b8omjin3mfoncnqbfx6qzr	expiry_notify	0	1681313641025	1681313644187	1681313644197	success	100	null
4bjca3mt4jnfxxmz47hq6kdjea	install_plugin_notify_admin	0	1681313701033	1681313704203	1681313704209	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
r86aunbhsb8zmnjsbyjdi79p8o	install_plugin_notify_admin	0	1681313821045	1681313824236	1681313824240	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
wfmqfpkzzpfc88j1ouoygfxcny	install_plugin_notify_admin	0	1681314061076	1681314064306	1681314064311	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qt9emz7fq786fjif534nymt1so	product_notices	0	1681329433844	1681329448797	1681329449136	success	100	null
pww36i6snjnrd8rec3zozhf1xa	install_plugin_notify_admin	0	1681351123996	1681351138867	1681351138889	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
38a8hddjeiriuxcato5jzysjbw	expiry_notify	0	1681351123981	1681351138867	1681351138970	success	100	null
ojpyuq1jsjb9pq6dwixqhu9tba	product_notices	0	1681351124034	1681351138867	1681351140119	success	100	null
x4pu943wd7y57jrf7cb83dchya	install_plugin_notify_admin	0	1681380047453	1681380062392	1681380062722	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8da3geuoqbyc3r19eoecsbfkaw	product_notices	0	1681380047470	1681380062391	1681380063407	success	100	null
3i8r68rzhtbotmy8uia15jxbro	install_plugin_notify_admin	0	1681313941062	1681313944273	1681313944278	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
8f57ke35pp8jbm4mgk5eojhjaw	install_plugin_notify_admin	0	1681314181087	1681314184358	1681314184363	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
idf7zdozf3n6bcgkiro9n9ftry	expiry_notify	0	1681329433360	1681329448797	1681329448828	success	100	null
tufofats8fno3kqpwr9rg44xzy	install_plugin_notify_admin	0	1681314301097	1681314304389	1681314304393	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
jjt4cgqryinjzx54arf7qznb8w	expiry_notify	0	1681314301105	1681314304388	1681314304399	success	100	null
hdo4uqqwjbrqxjrdu863yi8jpy	install_plugin_notify_admin	0	1681358353938	1681358368864	1681358368877	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
qdasccm5e384xdyy5dyws6rqjc	expiry_notify	0	1681358353906	1681358368864	1681358368890	success	100	null
9u3oc69ysidp3besc7xwoxuc8h	product_notices	0	1681358353961	1681358368864	1681358369598	success	100	null
a7gdpenz9jddmrqx1k3eemdmno	install_plugin_notify_admin	0	1681384325369	1681384339219	1681384339234	error	-1	{"error": "Error during job execution. — DoCheckForAdminNotifications: Unable to send notification post., No license found"}
7rea87k3e3byumuqfszx4chhch	expiry_notify	0	1681384325475	1681384339218	1681384339326	success	100	null
1af5gmikaf8t8rrdi6xubyg6wr	product_notices	0	1681384324842	1681384339219	1681384340184	success	100	null
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.licenses (id, createat, bytes) FROM stdin;
\.


--
-- Data for Name: linkmetadata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.linkmetadata (hash, url, "timestamp", type, data) FROM stdin;
2355789025	http://localhost:8080	1681124400000	none	null
3412747390	http://localhost:8080	1681128000000	none	null
2431647895	http://localhost:8080	1681135200000	none	null
1054898161	http://localhost:8080	1681214400000	none	null
\.


--
-- Data for Name: notifyadmin; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.notifyadmin (userid, createat, requiredplan, requiredfeature, trial, sentat) FROM stdin;
\.


--
-- Data for Name: oauthaccessdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthaccessdata (token, refreshtoken, redirecturi, clientid, userid, expiresat, scope) FROM stdin;
\.


--
-- Data for Name: oauthapps; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthapps (id, creatorid, createat, updateat, clientsecret, name, description, callbackurls, homepage, istrusted, iconurl, mattermostappid) FROM stdin;
\.


--
-- Data for Name: oauthauthdata; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.oauthauthdata (clientid, userid, code, expiresin, createat, redirecturi, state, scope) FROM stdin;
\.


--
-- Data for Name: outgoingwebhooks; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.outgoingwebhooks (id, token, createat, updateat, deleteat, creatorid, channelid, teamid, triggerwords, callbackurls, displayname, contenttype, triggerwhen, username, iconurl, description) FROM stdin;
\.


--
-- Data for Name: pluginkeyvaluestore; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.pluginkeyvaluestore (pluginid, pkey, pvalue, expireat) FROM stdin;
com.mattermost.apps	mmi_botid	\\x757a7063347431716b6a6274336773706d72746d757a72696d77	0
playbooks	mmi_botid	\\x6e6d3472616a38747270676574636e75747a633869636b613772	0
focalboard	mmi_botid	\\x67366865747565637a7038776966333868376f336f3170637963	0
com.mattermost.calls	mmi_botid	\\x6e706879717336777133663478623331376f35656966627a6568	0
\.


--
-- Data for Name: postacknowledgements; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.postacknowledgements (postid, userid, acknowledgedat) FROM stdin;
\.


--
-- Data for Name: postreminders; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.postreminders (postid, userid, targettime) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.posts (id, createat, updateat, deleteat, userid, channelid, rootid, originalid, message, type, props, hashtags, filenames, fileids, hasreactions, editat, ispinned, remoteid) FROM stdin;
f6j4cu9sqbytpy6wd4eq43bcte	1675955722129	1675955722129	0	whida44gqpyfierua1wfrnbxtr	p7retz8iwtgzdrdceqw13fwmbr			admin joined the team.	system_join_team	{"username": "admin"}		[]	[]	f	0	f	\N
7zddp9uw33yrxy5u6tjd8kpk5h	1675955722177	1675955722177	0	whida44gqpyfierua1wfrnbxtr	p7retz8iwtgzdrdceqw13fwmbr				system_welcome_post	{}		[]	[]	f	0	f	\N
4t5emn3sniy3mqhpmapfaedzje	1675955722219	1675955722219	0	whida44gqpyfierua1wfrnbxtr	giyj94p1fp86p8zs9z6u5b3ujh			admin joined the channel.	system_join_channel	{"username": "admin"}		[]	[]	f	0	f	\N
wceqk9cyopy3pb34i5zhjktsxe	1675956111709	1675956111709	0	geds3gxhdf81dccdrm8bfx37ry	p7retz8iwtgzdrdceqw13fwmbr			matrix.bridge joined the team.	system_join_team	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
atxnnabgd38oxya4ee5q7sqx3y	1675956111738	1675956111738	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
roetytajujyqbcc67c4aoi9oko	1675956421327	1675956421327	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			user1.mm joined the team.	system_join_team	{"username": "user1.mm"}		[]	[]	f	0	f	\N
i8dqkodnninc5qzxxdfyaykpie	1675956421370	1675956421370	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
e85mjzrcbjgkincfjq36k1jzch	1675957608047	1675957608047	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
3bcyhzzf8igs7jfqi4rumabd9w	1675957625593	1675957625593	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
6xytrtqtb7g49q3a9ubfg3m9rw	1676646214696	1676646214696	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			matrix_user1.matrix joined the team.	system_join_team	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
ioyak1g35fnymppx6gehzcb7ka	1676646214704	1676646214704	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
mj13enz8zpfufxoz4poh556omo	1676646214793	1676646214793	0	bgct5icpib883fx619bh3cfu6h	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user1.matrix joined the channel.	system_join_channel	{"username": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
qpybi5a1tff9u81mgtngeuhkro	1676646372520	1676646372520	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Hej		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
xcginserxtyab8q7dtajc43fwr	1678032937595	1678032937595	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			oko		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
i3rgzbuhdpn73conyzd7zw6sbc	1678032959928	1678032959928	0	bgct5icpib883fx619bh3cfu6h	giyj94p1fp86p8zs9z6u5b3ujh			kook		{}		[]	[]	f	0	f	\N
ma8t73u6cbnkdy4gsyue5rrd9h	1678033228840	1678033228840	0	ygmycw6rnff7igko8gwbqchujr	p7retz8iwtgzdrdceqw13fwmbr			okok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
jqbf9g91b3neteabf1378kf6ao	1678033315382	1678033315382	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			kalle		{}		[]	[]	f	0	f	\N
ah95xeojein9dgb3g5d3nf6m1e	1678033545983	1678033545983	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
gnytotamoid5urg5ythwdpg7xw	1678033569799	1678033569799	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			@matrix.bridge left the channel.	system_leave_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
e8q748ruubdpzr4mq19momkpky	1678033678977	1678033678977	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix.bridge joined the channel.	system_join_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
srm7mzjxe3fa8j8ueysash8qor	1678033721258	1678033721258	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
en6dc4fqdjdg7b8aufnuzp5aga	1678033762144	1678033762144	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
man1grukefr4jmityxs3z4z8te	1678033769132	1678033769132	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
wcnfnenx17d47mnrubj9mug3mh	1678033782830	1678033782830	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
hz71npt4spyr9gesejj34pynkc	1678033803352	1678033803352	0	ygmycw6rnff7igko8gwbqchujr	9wp7xhh6f7namrfm1asziaf9nh			KLKLK		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
iwxpx5nkofgqzk437ejaa9fhxo	1678033905152	1678033905152	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			user1.mm joined the channel.	system_join_channel	{"username": "user1.mm"}		[]	[]	f	0	f	\N
wfngnt9tdfga5yoob75d3euqmy	1678033923786	1678033923786	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			matrix.bridge added to the channel by user1.mm.	system_add_to_channel	{"userId": "ygmycw6rnff7igko8gwbqchujr", "username": "user1.mm", "addedUserId": "geds3gxhdf81dccdrm8bfx37ry", "addedUsername": "matrix.bridge"}		[]	[]	f	0	f	\N
i9nc6axzgjbsmf3h49jhcddsoc	1678033937017	1678033937017	0	geds3gxhdf81dccdrm8bfx37ry	rk4gdc4whjnupqoad46hwa9cme			@matrix.bridge left the channel.	system_leave_channel	{"username": "matrix.bridge"}		[]	[]	f	0	f	\N
pbezqx8zubr5dyxs63dckmr4ko	1678033955581	1678033955581	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
11tiqukwoi8fzqtm5mf6rzcqxc	1678033959731	1678033959731	0	ygmycw6rnff7igko8gwbqchujr	rk4gdc4whjnupqoad46hwa9cme			lölö		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
xaoe948b4idp3jutbshjkri7wo	1678034001601	1678034001601	0	bgct5icpib883fx619bh3cfu6h	9wp7xhh6f7namrfm1asziaf9nh			ddd		{}		[]	[]	f	0	f	\N
mohtrsnmajrgiyfrwhk1wks17y	1678611368286	1678611368286	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			matrix_user2.matrix joined the team.	system_join_team	{"username": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
dcea18ycwif6ux4fn58youfeca	1678611368417	1678611368417	0	wq6i7sbf4tnqzbssbn7gy7cjcc	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user2.matrix joined the channel.	system_join_channel	{"username": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
tr9w9j7rp3dzzyphb4jnibrtko	1678611368929	1678611368929	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			@matrix_user2.matrix removed from the channel.	system_remove_from_channel	{"removedUserId": "wq6i7sbf4tnqzbssbn7gy7cjcc", "removedUsername": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
b3ep6go787gpufiweug9qmwoyr	1678611372954	1678611372954	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			ok		{}		[]	[]	f	0	f	\N
syyjtnzntfffbpbmi99659jnxw	1678611396675	1678611396675	0	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			user2.mm joined the team.	system_join_team	{"username": "user2.mm"}		[]	[]	f	0	f	\N
ygncs7pg6iy47r6d99btbu6zgo	1678611396734	1678611396734	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
king6u1yi7ffxghigtd9jphdmr	1679129910821	1679129910821	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Ok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
n7snuo6bu3fx9dggi79hf5sw6y	1679410055294	1679410055294	0	bgct5icpib883fx619bh3cfu6h	9wp7xhh6f7namrfm1asziaf9nh			ok		{}		[]	[]	f	0	f	\N
uead5u8yffyrmypxu5dc89uc3a	1679410201749	1679410201749	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix_user2.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "wq6i7sbf4tnqzbssbn7gy7cjcc", "addedUsername": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
mqe4d7586j893g7h7m8d6q75jh	1679410217097	1679410217097	0	wq6i7sbf4tnqzbssbn7gy7cjcc	9wp7xhh6f7namrfm1asziaf9nh			ok		{}		[]	[]	f	0	f	\N
yqyg4hczbjyrtp3mhhasdea5uw	1679410301802	1679410301802	0	e343y5ecu7dyujwqm7yfimh1je	9wp7xhh6f7namrfm1asziaf9nh			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
rk4fdirw8tbf5esp5u4ujrxw3y	1679410380227	1679410380227	0	e343y5ecu7dyujwqm7yfimh1je	9wp7xhh6f7namrfm1asziaf9nh			Fine dinner AW		{"disable_group_highlight": true}		[]	["huxsrcaqh3fybr5acjoi79ajhc"]	f	0	f	\N
4cgemgmbpf8g5yy571phx7pa4e	1679410492039	1679410492039	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			HotElement.jpeg		{}		[]	["1nhhutjbhpb3pprgjun73p4k6e"]	f	0	f	\N
dtrsppfpmpfzzetkxdirz8f6io	1679410503342	1679410503342	0	wq6i7sbf4tnqzbssbn7gy7cjcc	p7retz8iwtgzdrdceqw13fwmbr			Element will work		{}		[]	[]	f	0	f	\N
trum6h9zzfd39g3gw3eaprwk8o	1679412884800	1679412884800	0	596q88qz87nbzbddntjm5xi6fh	p7retz8iwtgzdrdceqw13fwmbr			matrix_user3.matrix joined the team.	system_join_team	{"username": "matrix_user3.matrix"}		[]	[]	f	0	f	\N
ugrra88pypb99k41jyi9tzxnnw	1679412885016	1679412885016	0	596q88qz87nbzbddntjm5xi6fh	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user3.matrix joined the channel.	system_join_channel	{"username": "matrix_user3.matrix"}		[]	[]	f	0	f	\N
i758rckif7yfpb3eejcyhcpd3w	1679412902660	1679412902660	0	geds3gxhdf81dccdrm8bfx37ry	9wp7xhh6f7namrfm1asziaf9nh			matrix_user3.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "596q88qz87nbzbddntjm5xi6fh", "addedUsername": "matrix_user3.matrix"}		[]	[]	f	0	f	\N
n5b1g7hkb7fjicpakx9wa9ht6y	1679412935049	1679412935049	0	596q88qz87nbzbddntjm5xi6fh	9wp7xhh6f7namrfm1asziaf9nh			Like the dinner. I will join		{}		[]	[]	f	0	f	\N
mmgsgno1ztb9xy9nxkz31dsa9h	1679413133914	1679413133914	0	bgct5icpib883fx619bh3cfu6h	giyj94p1fp86p8zs9z6u5b3ujh			TBana-Nacka.png		{}		[]	["mwucdemjwt8kiyfdibi557foeh"]	f	0	f	\N
31f5d73k77gg3nhy7y3bw3wfuo	1679413187538	1679413187538	0	geds3gxhdf81dccdrm8bfx37ry	giyj94p1fp86p8zs9z6u5b3ujh			matrix_user2.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "wq6i7sbf4tnqzbssbn7gy7cjcc", "addedUsername": "matrix_user2.matrix"}		[]	[]	f	0	f	\N
p8xxnnebtbdmfmub5izhr6sk4e	1679414296857	1679414296857	0	wq6i7sbf4tnqzbssbn7gy7cjcc	giyj94p1fp86p8zs9z6u5b3ujh			    Java=cool		{}		[]	[]	f	0	f	\N
ase8kxerfbbrjy669mi479x96w	1679414708254	1679414708254	0	e343y5ecu7dyujwqm7yfimh1je	xnbbfxbs1i87z8xp5mc5pxo3yw			okok		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
ipt473jec3ryxbwh9cnmfi6xge	1679414757151	1679414757151	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			klkl		{}		[]	[]	f	0	f	\N
ikdic8s8ajbw8x3khspqntf4yo	1679414775084	1679414775084	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			HotElement.jpeg		{}		[]	["3wfpqmqueb8w3qxynyykr8sfch"]	f	0	f	\N
7dfsq3iaxbd3pbustja3xsenfc	1679414872851	1679414872851	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			oko		{}		[]	[]	f	0	f	\N
b5fnqbwt4f8q7rxkq7iikr7mte	1679414884317	1679414884317	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			okok		{}		[]	[]	f	0	f	\N
msro55a3qpdbtc4zi6nxn8y4oo	1679415355637	1679415355637	0	e343y5ecu7dyujwqm7yfimh1je	k17btosn9bbniczjj96ttnzido			**bold**		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
hsrgcic9ptnkfkp8p86ocaxp1y	1679415493032	1679415493032	0	ygmycw6rnff7igko8gwbqchujr	k17btosn9bbniczjj96ttnzido			Nacka		{"disable_group_highlight": true}		[]	["md3m4x9gg7dy9cyj1gpft9u4ky"]	f	0	f	\N
8m5ddq14n3bptkjtamybeu4kzo	1679416093713	1679416093713	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			ok		{}		[]	[]	f	0	f	\N
sfg34yaxn3yaxkhfmqj5c5nuxc	1679416132487	1679416132487	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			okok		{}		[]	[]	f	0	f	\N
3k7a1gszqtgejrxykkeuw3goir	1679416148565	1679416148565	0	wq6i7sbf4tnqzbssbn7gy7cjcc	xnbbfxbs1i87z8xp5mc5pxo3yw			**Bold**		{}		[]	[]	f	0	f	\N
5y6yiqc1ztdf9c1xjpb4rbk86h	1681109860538	1681109860538	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			ok		{}		[]	[]	f	0	f	\N
o9r858nntiy4pr8ktp4xkixrcc	1681109877613	1681109894019	1681109894019	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			ok		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
wrr3qniiobgwjnhfrm4wborcpe	1681110096883	1681110112641	1681110112641	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			okoko		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
7ci34gn8wpy58q7wgnyhcr9ekw	1681109921539	1681109935122	1681109935122	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klklklklk		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
guyqtkyqzfbbteo9rgigiqr9zr	1681109996936	1681109996936	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			kokok		{}		[]	[]	f	0	f	\N
pi7xjx63k78tt85rs7g7fqoh5a	1681111635619	1681111646129	1681111646129	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klklk		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
xsg4cja6ntn77bp3p4tb7chucc	1681111752983	1681111765576	1681111765576	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			okok		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
8ytu3cqxabg37pmncnmtkrigta	1681111784660	1681111790297	1681111790297	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklkl		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
owjaoo6kdiyfdr51zxtpzbq9or	1681111858948	1681111865544	1681111865544	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklkl		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
own1mrrtufgrpb3uzzi16zm9sa	1681110155187	1681110163017	1681110163017	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			okoko		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
bnwdb4d5zidkpytt9kbkw3wr1o	1681110199842	1681110206371	1681110206371	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klklk		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
d1fyr6pep7rbzf599tyoup7jaw	1681110350908	1681110369171	1681110369171	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klkl		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
sf9izwzykprzxespmqd6g5djne	1681110670584	1681110677865	1681110677865	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklkl		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
mkxdapuzrffyjf8rtfgbkdhmgh	1681110739946	1681110763917	1681110763917	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			okok		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
uhmc1pepubbzmkio4fsgrt9euc	1681111091423	1681111100250	1681111100250	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklklkl		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
d6xz98s36ifamb8bgb7i33q4ge	1681111149752	1681111157173	1681111157173	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklklklk		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
3q5iruxauj8xzy77binktxsjxh	1681111207737	1681111220756	1681111220756	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klklkl		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
1p7rggr5nibu5dm43ckx1sto7e	1681111430717	1681111443315	1681111443315	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klkl		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
gx1ws9z9r7grxdesidhhk8kpqe	1681111483207	1681111489968	1681111489968	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klkl		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
58ihks1x7fgzxr61webaxf4rsw	1681111594694	1681111600511	1681111600511	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr			klklk		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
4o9o4cm5zj888ncstm88gp7yze	1681111875167	1681111882393	1681111882393	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			klklklk		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
ss3sf8yfmfgm8jxp4ea8mw1ngh	1681112027824	1681112027824	0	whida44gqpyfierua1wfrnbxtr	hb8cxm688f86zgrejdmgdr7qsc			admin joined the channel.	system_join_channel	{"username": "admin"}		[]	[]	f	0	f	\N
hqq5f7fz1b86b8q6c17n3g4fwy	1681112040857	1681112040857	0	whida44gqpyfierua1wfrnbxtr	hb8cxm688f86zgrejdmgdr7qsc			matrix.bridge added to the channel by admin.	system_add_to_channel	{"userId": "whida44gqpyfierua1wfrnbxtr", "username": "admin", "addedUserId": "geds3gxhdf81dccdrm8bfx37ry", "addedUsername": "matrix.bridge"}		[]	[]	f	0	f	\N
fatm6k7jufnp9js41mxacn49ma	1681112041994	1681112041994	0	geds3gxhdf81dccdrm8bfx37ry	hb8cxm688f86zgrejdmgdr7qsc			New matrix room Stockholm Office with alias stockholm-office mapped to the channel.		{}		[]	[]	f	0	f	\N
6cnowbhpdj8ibjo96rsfihdpxe	1681112066949	1681112066949	0	e343y5ecu7dyujwqm7yfimh1je	hb8cxm688f86zgrejdmgdr7qsc			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
3ohnrepi77rstqr8kiqjgda1gy	1681112124110	1681112124110	0	e343y5ecu7dyujwqm7yfimh1je	hb8cxm688f86zgrejdmgdr7qsc			klklklkl		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
p8nwo9xfo7d45jn7pbcte9xxkc	1681112138440	1681112138440	0	geds3gxhdf81dccdrm8bfx37ry	hb8cxm688f86zgrejdmgdr7qsc			matrix_user1.matrix added to the channel by matrix.bridge.	system_add_to_channel	{"userId": "geds3gxhdf81dccdrm8bfx37ry", "username": "matrix.bridge", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
ebs1stec9pympyu6s6bmzfbwna	1681112158825	1681112158825	0	bgct5icpib883fx619bh3cfu6h	hb8cxm688f86zgrejdmgdr7qsc			klklkl		{}		[]	[]	f	0	f	\N
zqa6ppxuifd49qb3qq8h1rgnwe	1681112169868	1681112179404	1681112179404	e343y5ecu7dyujwqm7yfimh1je	hb8cxm688f86zgrejdmgdr7qsc			klklk		{"deleteBy": "e343y5ecu7dyujwqm7yfimh1je", "disable_group_highlight": true}		[]	[]	f	0	f	\N
oi5phjhw1fya5cmxtbnu3pyjew	1681112190186	1681112197386	1681112197386	bgct5icpib883fx619bh3cfu6h	hb8cxm688f86zgrejdmgdr7qsc			klkklkl		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
wu79mxboipry7qhdcwioudmnmw	1681112408121	1681112408121	0	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
z5h47be8ppyytje8fnicwjuwcr	1681112421039	1681112421039	0	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c			matrix.bridge added to the channel by user2.mm.	system_add_to_channel	{"userId": "e343y5ecu7dyujwqm7yfimh1je", "username": "user2.mm", "addedUserId": "geds3gxhdf81dccdrm8bfx37ry", "addedUsername": "matrix.bridge"}		[]	[]	f	0	f	\N
hk6zhdbp3igh3qa96azrkgnggr	1681112421170	1681112421170	0	geds3gxhdf81dccdrm8bfx37ry	8tmxnejrb3fhxb6p91b7358y3c			Private channels implementation in progress		{}		[]	[]	f	0	f	\N
hgryyfof9bfs3d4bcnobkr7ajr	1681112441760	1681112441760	0	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c			matrix_user1.matrix added to the channel by user2.mm.	system_add_to_channel	{"userId": "e343y5ecu7dyujwqm7yfimh1je", "username": "user2.mm", "addedUserId": "bgct5icpib883fx619bh3cfu6h", "addedUsername": "matrix_user1.matrix"}		[]	[]	f	0	f	\N
6r9dqg8egpgj8kyn4xn76yikwy	1681112446832	1681112446832	0	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c			klklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
rzzjyo8j3jnbictk5d1rhpd7ry	1681112468026	1681112468026	0	bgct5icpib883fx619bh3cfu6h	8tmxnejrb3fhxb6p91b7358y3c			okok		{}		[]	[]	f	0	f	\N
64wo56jwi7dfjrsjs6gyu59omr	1681112485148	1681112493788	1681112493788	bgct5icpib883fx619bh3cfu6h	8tmxnejrb3fhxb6p91b7358y3c			Delete this		{"deleteBy": "geds3gxhdf81dccdrm8bfx37ry"}		[]	[]	f	0	f	\N
5cftof5o33ncb8eb59rtjq8c4c	1681112527887	1681112527887	0	e343y5ecu7dyujwqm7yfimh1je	8tmxnejrb3fhxb6p91b7358y3c			# H1\n## H2		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
fgosyeunr78f3gz976jh53jmcw	1681114924096	1681114924096	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Culpa recusandae numquam reprehenderit tenetur accusamus. Excepturi libero omnis consectetur provident cupiditate. Quas soluta delectus distinctio. Molestias quos maxime deserunt ea ullam eaque. Quas odio dolor animi corrupti. Ipsum eaque assumenda eveniet dolor voluptatibus et suscipit consequatur officia.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
b9ba1f3ag3dcurxdcg18snpj7o	1681127250694	1681127250694	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
m4pkwajmcfrkzfy189omzwjoey	1681127253421	1681127253421	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
g6wyjbhip3y3fm5zeo8x4z68ca	1681127334725	1681127334725	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Minima minima atque ipsam nihil consequuntur. Dignissimos expedita fuga velit eveniet soluta voluptatibus cum pariatur mollitia. Sed neque tempore odit sapiente cum pariatur et. Fugit ratione molestiae amet impedit. Animi dignissimos pariatur provident nihil. Optio earum consectetur modi pariatur quis quae aspernatur alias.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
rdhrz9rrsi87bjynzzwmzxyqwy	1681129977059	1681129977059	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nIf we override the protocol, we can get to the PCI transmitter through the back-end RAM protocol!\n from Lea_Keeling@yahoo.com		{}		[]	[]	f	0	f	\N
sfst8obffbfexn6tzfrsio8nur	1681130101161	1681130101161	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nTry to override the DNS monitor, maybe it will parse the 1080p transmitter!\n from Edwardo_Schuster45@gmail.com		{}		[]	[]	f	0	f	\N
oy8bqgfpxby6mcbbw56dhqqyhh	1681130333155	1681130333155	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nTry to navigate the CLI firewall, maybe it will parse the wireless system!\n from Vaughn.Steuber@yahoo.com		{}		[]	[]	f	0	f	\N
4qq4a1iw1tft9qncsjcmk3sihc	1681130351030	1681130351030	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
s3n6jg4yupde9kaskm5sod1w9c	1681130352977	1681130352977	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
eyzs5k4p4387zqsjgqq3oeq4kr	1681130481519	1681130481519	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Eos commodi quaerat placeat cupiditate at velit repudiandae. Recusandae voluptatibus ipsam et dolore suscipit iste non aliquid nulla. Perferendis eum beatae eligendi minus id cumque dolorem illum. Nesciunt architecto delectus maxime deserunt. Ducimus nemo corrupti qui perspiciatis exercitationem possimus. Sit voluptate repellat ea corporis ullam.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
uouh79iypp8b3pade834ox9f7w	1681133331479	1681133331479	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Recusandae pariatur voluptatibus facere molestiae dolorum repellat vel dignissimos dicta. Incidunt officia libero ea magnam iure architecto nesciunt veniam sed. Praesentium deleniti sequi.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
sntjqaj5wjy5umyebw181hcayw	1681133953497	1681133953497	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Veniam ipsam doloremque. Nesciunt sequi doloribus pariatur vitae. Est illo soluta eos vel atque eum.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
8n8ep6go7inzmppbofcxqdk6ow	1681134078526	1681134078526	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Vel pariatur mollitia illo cumque doloribus voluptatum iusto et. Cum aperiam delectus illum. Voluptatibus ratione enim qui qui. Vitae quae ullam. Autem sint consectetur quam saepe distinctio reiciendis. Optio maxime similique veritatis.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
9ru7heb8itngbxxau75sobdx6r	1681134180199	1681134180199	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Perferendis nesciunt veniam molestias. Ut odit eius voluptatibus eius nisi ullam aspernatur perferendis expedita. Repellendus a iure soluta et ea quod.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
7nbdnm9uufdo3y5qjm6jdrdmoy	1681134661800	1681134661800	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Incidunt rerum aspernatur illo iusto voluptatem deleniti. Explicabo voluptatibus ipsum magnam fugiat incidunt quis. Quas delectus provident minima necessitatibus fugiat aliquid vitae unde cumque. Nisi aspernatur eveniet officia debitis.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
goqcp95733rwdbehw61j76nufo	1681135449385	1681135449385	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Eius animi ad facere magni reprehenderit. Quod numquam sed sapiente minima reiciendis. Numquam similique porro tempora laborum officia autem corrupti. Incidunt eos quae numquam animi minima expedita enim praesentium inventore.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
u3yy4srsxfb5t8qb6h3cjqdwmc	1681135902685	1681135902685	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Natus ea nisi repellendus. Enim debitis et quas architecto aliquam dolorem. Nulla inventore eligendi laborum et hic occaecati incidunt quidem.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
n596gmzzwigb8ko3wq4s5dkcqy	1681136143499	1681136143499	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
1zm79ep3qbfopxuuxnhgya46ww	1681136145689	1681136145689	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
smtafzhzf3dufni7j1epeyhehr	1681136146754	1681136146754	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Timestamp=1681136141569		{}		[]	[]	f	0	f	\N
957i1mmqdpb4i8tjszhs3beqcy	1681136228721	1681136228721	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Neque officiis explicabo magnam alias assumenda minus facilis. Enim iusto eum. Eaque perspiciatis praesentium labore inventore commodi dolor.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
s7d8k8qda7n9bdmajbdxuhfica	1681136300480	1681136300480	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			klklklk		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
eshrq1e7wtd48rexx68s465z7o	1681136414088	1681136414088	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			**Bye Bye**		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
1fszhkwxqtrk9qfz44m6ynrfzh	1681136436618	1681136436618	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			```Java code```		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
71h6n8tw5jfezrqqftp7z58wyr	1681136473212	1681136473212	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			[ddd](dd)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
dqab4t77z7di3bz5ztbnjw3wrc	1681136673996	1681136673996	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Accusamus illo eum ea quia minus magni sint. Fugiat quo assumenda quisquam quidem. Autem odio illum ipsam nihil voluptatibus sit vel ea perspiciatis. Unde quaerat neque dolore suscipit. Aspernatur alias ea quia.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
8sdruebf1bgommicre8wsffmnw	1681136675383	1681136675383	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			["Playwright dev"](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
qdzo9feif7dhmx8ed941gn1a1e	1681136823257	1681136823257	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
szabytnmgtgximchtz6f5gymcr	1681136825354	1681136825354	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
tnrskf5tufdz38mgotxhhfux6r	1681136826834	1681136826834	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Timestamp=1681136821379		{}		[]	[]	f	0	f	\N
3p8hmbuj1pbipftkk439b519gh	1681136897747	1681136897747	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Reprehenderit adipisci unde facere harum aperiam maiores quae. Hic quam cumque vitae. Voluptatibus asperiores ducimus possimus. Doloremque eveniet quasi atque aperiam. Rem vero accusamus omnis aliquam error. Perferendis aperiam molestiae ex cum nisi.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
qirujudpgp89mr8rq7ogo9ktgc	1681136899597	1681136899597	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Look at the site \n["Playwright test site"](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
84jygo7te3r19pkweapf81opga	1681136980357	1681136980357	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Similique accusamus quidem soluta saepe. Eius sequi ratione harum et rerum repellendus. Iusto ducimus veritatis ipsum sit facere neque cupiditate cupiditate. Perspiciatis quidem quo dolorum fuga quidem deleniti autem odit magnam.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
mjh9j49ryjgqxcu17qje5ciiuo	1681136983227	1681136983227	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Look at the site \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
39cbdngkhjr15jsgoejdyfeyme	1681137031076	1681137031076	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			[](url)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
9qhoih3c6inm78fkuboa9t9tye	1681137125354	1681137125354	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Provident occaecati molestias aliquam aliquid officia hic. Veritatis vel quas natus nulla unde modi ipsa. Debitis voluptatum error fuga occaecati ex ad ut. Voluptatem laudantium architecto minus laudantium quaerat quaerat repellendus.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
a3r4t96rxty93rzomtrsn9yzsa	1681137127100	1681137127100	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
oht9esbuhjfj3ymmqwaxeooena	1681137206629	1681137206629	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
f6o9o5du5jyx3jknuid5p8k18y	1681137209180	1681137209180	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
9wo84cbg9brfjc34bosn3eh9ue	1681137210241	1681137210241	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Timestamp=1681137204329		{}		[]	[]	f	0	f	\N
nhn1865bu3n6unx8gox65ychnr	1681214789736	1681214789736	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Eveniet beatae consectetur quas eveniet iusto ipsa labore. Ullam magni doloribus perspiciatis nulla sequi aspernatur dolore sed qui. Facilis blanditiis tenetur. Sed totam quia quis tempore maxime fugiat architecto quia. Sunt incidunt harum nisi dignissimos vero enim qui tempore.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
h7zmtg91u3yuzkk44wb7wjsufa	1681214791609	1681214791609	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
garfgr99ujyixfrdkyykgfu1ko	1681214860869	1681214860869	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Playwright Test - Message from Element 		{}		[]	[]	f	0	f	\N
ewiabjpc5bd4xecrzg7yg7653c	1681214862310	1681214862310	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			URL=http://localhost:8080 risky Browser=false 		{}		[]	[]	f	0	f	\N
afo55faruidoix3qnmt7icke8o	1681214863422	1681214863422	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Timestamp=1681214859756		{}		[]	[]	f	0	f	\N
maxdnsck67d5pdz6kjg69haw5e	1681214899961	1681214899961	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Cumque at occaecati ex ut eum sequi corporis. Impedit dicta a architecto nisi earum. Sunt quod est porro illum perferendis. Qui ducimus facilis deleniti ipsam beatae sint doloremque. Harum magni ea.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
ow611168sby87gjukfxcrehrzo	1681214901294	1681214901294	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
h5fx6rqd67rffkk76zodofm4to	1681298586964	1681298586964	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Tempore beatae tenetur expedita. Repellendus incidunt laudantium eum. Quas nobis tenetur soluta optio.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
e7iiuai6d7dgxnexogb68gxdfa	1681298589246	1681298589246	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
uisshjjtuif7uk5migwjmcwy3r	1681299111350	1681299111350	0	e343y5ecu7dyujwqm7yfimh1je	bk454rpi9byk9nqgbebmsyxd6o			user2.mm joined the team.	system_join_team	{"username": "user2.mm"}		[]	[]	f	0	f	\N
ib7xrrfoibfxdghpu7cin6qe8r	1681299111461	1681299111461	0	e343y5ecu7dyujwqm7yfimh1je	44bx8k5kpjdnigcyurthgn733y			user2.mm joined the channel.	system_join_channel	{"username": "user2.mm"}		[]	[]	f	0	f	\N
x5n3urnmgin67xg3obwm6d9s7c	1681300768456	1681300768456	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Dignissimos officia assumenda quaerat repellendus quia assumenda alias maxime libero. Magnam vitae adipisci unde suscipit vero modi. Laudantium enim corporis ducimus dolor nisi voluptatum accusamus. Numquam deleniti ipsam praesentium mollitia aut nostrum. Earum quasi nostrum deserunt eius nihil. At praesentium deleniti sit doloremque vitae vero exercitationem blanditiis.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
epgieupoeifciq6xfds7hn11na	1681300771569	1681300771569	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
s4fc1ryk4f8fjjakfggqna5xee	1681301002631	1681301002631	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Animi quasi quos aliquam beatae corporis sit eligendi libero nulla. Ab consectetur nesciunt excepturi officia autem. Est provident alias corrupti exercitationem iure autem vel ratione. Omnis fugiat tenetur dignissimos saepe maiores vero eveniet. Non exercitationem soluta.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
ibkfxtu3f3faugqbrioztt5uuo	1681301004041	1681301004041	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
whzpjgs3hbdz5komizrah7fxch	1681301109457	1681301109457	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			Sequi ut veritatis voluptatibus asperiores nisi itaque vero. Maxime ipsam ex. Praesentium deleniti eligendi mollitia ratione. Soluta consectetur asperiores sint debitis sequi aliquam delectus.		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
fjfrd31wdtdt7b18un6cxsutoo	1681301111397	1681301111397	0	ygmycw6rnff7igko8gwbqchujr	giyj94p1fp86p8zs9z6u5b3ujh			\n**Look at the Playwright site** \n[Playwright test site](https://playwright.dev/)		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
gukfwpdgaifpue5n7x5wa4gczh	1681303898664	1681303898664	0	e343y5ecu7dyujwqm7yfimh1je	giyj94p1fp86p8zs9z6u5b3ujh			klklkl		{"disable_group_highlight": true}		[]	[]	f	0	f	\N
qpwgsx7sf7rr8jmuggzqb4onxo	1681306484818	1681306484818	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nThe SQL application is down, index the online bus so we can copy the RSS card!\n from Brenna38@hotmail.com		{}		[]	[]	f	0	f	\N
866omeytapgwf8uraxqskyi6aw	1681306675519	1681306675519	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nWe need to back up the neural SAS panel!\n from Gerda.Weissnat45@gmail.com		{}		[]	[]	f	0	f	\N
jtgaz61xujffxf9az19t8kcjdy	1681307388041	1681307388041	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nTry to bypass the AGP capacitor, maybe it will override the cross-platform bus!\n from Dock91@yahoo.com		{}		[]	[]	f	0	f	\N
4bx8u9wijibx3p1pbq4c65p5ma	1681307794710	1681307794710	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nUse the cross-platform FTP monitor, then you can parse the online bus!\n from Yoshiko.Sauer54@gmail.com		{}		[]	[]	f	0	f	\N
aeh7a41fq3gktfc4me3aj9mmcw	1681307925395	1681307925395	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nI'll parse the online RAM array, that should bandwidth the SMTP array!\n from Vena_Windler@hotmail.com		{}		[]	[]	f	0	f	\N
icj8y6g8kbrkmgmxcjbny3kguy	1681308003749	1681308003749	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nI'll override the open-source HTTP circuit, that should monitor the AI matrix!\n from Sherwood26@yahoo.com		{}		[]	[]	f	0	f	\N
81whphpzoir13bbat867pdntqh	1681308915123	1681308915123	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nIf we quantify the bus, we can get to the OCR program through the online TCP hard drive!\n from Isabelle.Stroman@yahoo.com		{}		[]	[]	f	0	f	\N
qoykzxt7jbg9pknaxj98baa9ra	1681309189301	1681309189301	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\noverriding the alarm won't do anything, we need to navigate the virtual TCP pixel!\n from Benedict_White@gmail.com		{}		[]	[]	f	0	f	\N
uap5hupe6tbbjq1jjqkm79autr	1681309425851	1681309425851	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nsynthesizing the interface won't do anything, we need to synthesize the cross-platform OCR application!\n from Blanche_Conroy75@yahoo.com		{}		[]	[]	f	0	f	\N
75i5ktoziigitybytig9qub4wh	1681310364799	1681310364799	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nThe HEX alarm is down, quantify the neural bus so we can override the CSS capacitor!\n from Ona.Stiedemann@gmail.com		{}		[]	[]	f	0	f	\N
h3wgrtemubyntfrszdmzjmtm4h	1681310412297	1681310412297	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nI'll reboot the open-source THX hard drive, that should program the CSS microchip!\n from Guiseppe_Kovacek17@hotmail.com		{}		[]	[]	f	0	f	\N
37ntqszjebbojbbztyaqdkwkco	1681310919584	1681310919584	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nI'll reboot the optical FTP firewall, that should monitor the SDD array!\n from Ethyl76@yahoo.com		{}		[]	[]	f	0	f	\N
gb5ukga4utnu5jhexzezm4yhda	1681313817936	1681313817936	0	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr	iwf9qjrqm7g1pxjtfrotp1izuo		klklkl		{}		[]	[]	f	0	f	\N
8nn6f9s95pfg7qd4i9yipsdxbc	1681313848427	1681313848427	0	e343y5ecu7dyujwqm7yfimh1je	p7retz8iwtgzdrdceqw13fwmbr	iwf9qjrqm7g1pxjtfrotp1izuo		klkl		{}		[]	[]	f	0	f	\N
iwf9qjrqm7g1pxjtfrotp1izuo	1681312264373	1681313848427	0	bgct5icpib883fx619bh3cfu6h	p7retz8iwtgzdrdceqw13fwmbr			Strange message seen:\nTry to transmit the XSS hard drive, maybe it will transmit the auxiliary firewall!\n from Ervin74@hotmail.com		{}		[]	[]	f	0	f	\N
\.


--
-- Data for Name: postspriority; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.postspriority (postid, channelid, priority, requestedack, persistentnotifications) FROM stdin;
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.preferences (userid, category, name, value) FROM stdin;
whida44gqpyfierua1wfrnbxtr	tutorial_step	whida44gqpyfierua1wfrnbxtr	0
whida44gqpyfierua1wfrnbxtr	insights	insights_tutorial_state	{"insights_modal_viewed":true}
whida44gqpyfierua1wfrnbxtr	onboarding_task_list	onboarding_task_list_show	true
whida44gqpyfierua1wfrnbxtr	recommended_next_steps	hide	true
whida44gqpyfierua1wfrnbxtr	onboarding_task_list	onboarding_task_list_open	false
geds3gxhdf81dccdrm8bfx37ry	tutorial_step	geds3gxhdf81dccdrm8bfx37ry	0
geds3gxhdf81dccdrm8bfx37ry	insights	insights_tutorial_state	{"insights_modal_viewed":true}
geds3gxhdf81dccdrm8bfx37ry	onboarding_task_list	onboarding_task_list_show	true
geds3gxhdf81dccdrm8bfx37ry	recommended_next_steps	hide	true
geds3gxhdf81dccdrm8bfx37ry	onboarding_task_list	onboarding_task_list_open	false
ygmycw6rnff7igko8gwbqchujr	tutorial_step	ygmycw6rnff7igko8gwbqchujr	0
ygmycw6rnff7igko8gwbqchujr	insights	insights_tutorial_state	{"insights_modal_viewed":true}
ygmycw6rnff7igko8gwbqchujr	onboarding_task_list	onboarding_task_list_show	true
ygmycw6rnff7igko8gwbqchujr	recommended_next_steps	hide	true
ygmycw6rnff7igko8gwbqchujr	onboarding_task_list	onboarding_task_list_open	false
bgct5icpib883fx619bh3cfu6h	recommended_next_steps	hide	false
bgct5icpib883fx619bh3cfu6h	tutorial_step	bgct5icpib883fx619bh3cfu6h	0
bgct5icpib883fx619bh3cfu6h	insights	insights_tutorial_state	{"insights_modal_viewed":true}
geds3gxhdf81dccdrm8bfx37ry	channel_approximate_view_time		1678033562703
wq6i7sbf4tnqzbssbn7gy7cjcc	recommended_next_steps	hide	false
wq6i7sbf4tnqzbssbn7gy7cjcc	tutorial_step	wq6i7sbf4tnqzbssbn7gy7cjcc	0
wq6i7sbf4tnqzbssbn7gy7cjcc	insights	insights_tutorial_state	{"insights_modal_viewed":true}
e343y5ecu7dyujwqm7yfimh1je	tutorial_step	e343y5ecu7dyujwqm7yfimh1je	0
e343y5ecu7dyujwqm7yfimh1je	insights	insights_tutorial_state	{"insights_modal_viewed":true}
e343y5ecu7dyujwqm7yfimh1je	onboarding_task_list	onboarding_task_list_show	true
e343y5ecu7dyujwqm7yfimh1je	recommended_next_steps	hide	true
e343y5ecu7dyujwqm7yfimh1je	onboarding_task_list	onboarding_task_list_open	false
596q88qz87nbzbddntjm5xi6fh	recommended_next_steps	hide	false
596q88qz87nbzbddntjm5xi6fh	tutorial_step	596q88qz87nbzbddntjm5xi6fh	0
596q88qz87nbzbddntjm5xi6fh	insights	insights_tutorial_state	{"insights_modal_viewed":true}
e343y5ecu7dyujwqm7yfimh1je	group_channel_show	k17btosn9bbniczjj96ttnzido	true
e343y5ecu7dyujwqm7yfimh1je	channel_open_time	k17btosn9bbniczjj96ttnzido	1679415349875
ygmycw6rnff7igko8gwbqchujr	group_channel_show	k17btosn9bbniczjj96ttnzido	true
ygmycw6rnff7igko8gwbqchujr	channel_open_time	k17btosn9bbniczjj96ttnzido	1679415382812
e343y5ecu7dyujwqm7yfimh1je	group_channel_show	xnbbfxbs1i87z8xp5mc5pxo3yw	true
e343y5ecu7dyujwqm7yfimh1je	channel_open_time	xnbbfxbs1i87z8xp5mc5pxo3yw	1679416050103
whida44gqpyfierua1wfrnbxtr	channel_approximate_view_time		1681112060841
e343y5ecu7dyujwqm7yfimh1je	drafts	drafts_tour_tip_showed	{"drafts_tour_tip_showed":true}
e343y5ecu7dyujwqm7yfimh1je	crt_thread_pane_step	e343y5ecu7dyujwqm7yfimh1je	999
ygmycw6rnff7igko8gwbqchujr	channel_approximate_view_time		1681302158521
ygmycw6rnff7igko8gwbqchujr	drafts	drafts_tour_tip_showed	{"drafts_tour_tip_showed":true}
e343y5ecu7dyujwqm7yfimh1je	channel_approximate_view_time		1681313833311
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
whida44gqpyfierua1wfrnbxtr	use_case_survey	1	1675955707
whida44gqpyfierua1wfrnbxtr	june15-cloud-freemium	1	1675955707
whida44gqpyfierua1wfrnbxtr	desktop_upgrade_v5.2	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-admin-disabled	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-admin-default_off	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-user-default-on	1	1675955707
whida44gqpyfierua1wfrnbxtr	crt-user-always-on	1	1675955707
whida44gqpyfierua1wfrnbxtr	v6.0_user_introduction	1	1675955707
whida44gqpyfierua1wfrnbxtr	v6.2_boards	1	1675955707
whida44gqpyfierua1wfrnbxtr	unsupported-server-v5.37	1	1675955707
geds3gxhdf81dccdrm8bfx37ry	use_case_survey	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	june15-cloud-freemium	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	desktop_upgrade_v5.2	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-admin-disabled	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-admin-default_off	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-user-default-on	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	crt-user-always-on	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	v6.0_user_introduction	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	v6.2_boards	1	1675956108
geds3gxhdf81dccdrm8bfx37ry	unsupported-server-v5.37	1	1675956108
ygmycw6rnff7igko8gwbqchujr	use_case_survey	1	1675956418
ygmycw6rnff7igko8gwbqchujr	june15-cloud-freemium	1	1675956418
ygmycw6rnff7igko8gwbqchujr	desktop_upgrade_v5.2	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-admin-disabled	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-admin-default_off	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-user-default-on	1	1675956418
ygmycw6rnff7igko8gwbqchujr	crt-user-always-on	1	1675956418
ygmycw6rnff7igko8gwbqchujr	v6.0_user_introduction	1	1675956418
ygmycw6rnff7igko8gwbqchujr	v6.2_boards	1	1675956418
ygmycw6rnff7igko8gwbqchujr	unsupported-server-v5.37	1	1675956418
bgct5icpib883fx619bh3cfu6h	use_case_survey	1	1676646214
bgct5icpib883fx619bh3cfu6h	june15-cloud-freemium	1	1676646214
bgct5icpib883fx619bh3cfu6h	desktop_upgrade_v5.2	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-admin-disabled	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-admin-default_off	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-user-default-on	1	1676646214
bgct5icpib883fx619bh3cfu6h	crt-user-always-on	1	1676646214
bgct5icpib883fx619bh3cfu6h	v6.0_user_introduction	1	1676646214
bgct5icpib883fx619bh3cfu6h	v6.2_boards	1	1676646214
bgct5icpib883fx619bh3cfu6h	unsupported-server-v5.37	1	1676646214
wq6i7sbf4tnqzbssbn7gy7cjcc	use_case_survey	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	june15-cloud-freemium	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	desktop_upgrade_v5.2	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-admin-disabled	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-admin-default_off	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-user-default-on	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	crt-user-always-on	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	v6.0_user_introduction	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	v6.2_boards	1	1678611367
wq6i7sbf4tnqzbssbn7gy7cjcc	unsupported-server-v5.37	1	1678611367
e343y5ecu7dyujwqm7yfimh1je	use_case_survey	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	june15-cloud-freemium	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	desktop_upgrade_v5.2	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-admin-disabled	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-admin-default_off	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-user-default-on	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	crt-user-always-on	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	v6.0_user_introduction	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	v6.2_boards	1	1678611392
e343y5ecu7dyujwqm7yfimh1je	unsupported-server-v5.37	1	1678611392
596q88qz87nbzbddntjm5xi6fh	use_case_survey	1	1679412884
596q88qz87nbzbddntjm5xi6fh	june15-cloud-freemium	1	1679412884
596q88qz87nbzbddntjm5xi6fh	desktop_upgrade_v5.2	1	1679412884
596q88qz87nbzbddntjm5xi6fh	crt-admin-disabled	1	1679412884
596q88qz87nbzbddntjm5xi6fh	crt-admin-default_off	1	1679412884
596q88qz87nbzbddntjm5xi6fh	crt-user-default-on	1	1679412884
596q88qz87nbzbddntjm5xi6fh	crt-user-always-on	1	1679412884
596q88qz87nbzbddntjm5xi6fh	v6.0_user_introduction	1	1679412884
596q88qz87nbzbddntjm5xi6fh	v6.2_boards	1	1679412884
596q88qz87nbzbddntjm5xi6fh	unsupported-server-v5.37	1	1679412884
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
p7retz8iwtgzdrdceqw13fwmbr	0	ebxg8q3pzbdrdjo7xx1qqw3guy	Town Square	town-square		
giyj94p1fp86p8zs9z6u5b3ujh	0	ebxg8q3pzbdrdjo7xx1qqw3guy	Off-Topic	off-topic		
9wp7xhh6f7namrfm1asziaf9nh	0	ebxg8q3pzbdrdjo7xx1qqw3guy	After Work	after-work		An channel for afterwork 
rk4gdc4whjnupqoad46hwa9cme	0	ebxg8q3pzbdrdjo7xx1qqw3guy	My Public Room	my-public-room		
hb8cxm688f86zgrejdmgdr7qsc	0	ebxg8q3pzbdrdjo7xx1qqw3guy	Stockholm Office	stockholm-office		
bk454rpi9byk9nqgbebmsyxd6o	0	rjartdbsbtrfjfk9k9argymhqw	Town Square	town-square		
44bx8k5kpjdnigcyurthgn733y	0	rjartdbsbtrfjfk9k9argymhqw	Off-Topic	off-topic		
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.reactions (userid, postid, emojiname, createat, updateat, deleteat, remoteid, channelid) FROM stdin;
\.


--
-- Data for Name: recentsearches; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.recentsearches (userid, searchpointer, query, createat) FROM stdin;
\.


--
-- Data for Name: remoteclusters; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.remoteclusters (remoteid, remoteteamid, name, displayname, siteurl, createat, lastpingat, token, remotetoken, topics, creatorid) FROM stdin;
\.


--
-- Data for Name: retentionpolicies; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpolicies (id, displayname, postduration) FROM stdin;
\.


--
-- Data for Name: retentionpolicieschannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpolicieschannels (policyid, channelid) FROM stdin;
\.


--
-- Data for Name: retentionpoliciesteams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.retentionpoliciesteams (policyid, teamid) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.roles (id, name, displayname, description, createat, updateat, deleteat, permissions, schememanaged, builtin) FROM stdin;
yigz7aqrufbxzbsje4ksge63kh	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1675955399801	1680689067995	0	 read_channel add_reaction remove_reaction upload_file edit_post create_post use_channel_mentions use_slash_commands	t	t
95hg91qcgtbfdmy58tj8korihc	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1675955399989	1680689068030	0	 use_group_mentions use_channel_mentions create_post	f	t
durmjtyhz7b3jm7zd9nwyd5r4h	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1675955399992	1680689068034	0	 playbook_public_make_private playbook_public_manage_members playbook_public_manage_roles playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties	t	t
oiccxi68rbfb7ccp98f6re739c	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1675955399994	1680689068045	0	 run_manage_members run_manage_properties	t	t
6tcppqipcjn7tyx95ob3hidk5o	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1675955399997	1680689068049	0	 use_channel_mentions use_group_mentions create_post	f	t
suok4s677bg6dn9mrcbfk36qgr	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1675955400002	1680689068058	0	 create_user_access_token read_user_access_token revoke_user_access_token	f	t
dxx7j8g8xjyburhseoe7wjix1w	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1675955399752	1680689068071	0	 create_post import_team manage_others_outgoing_webhooks convert_public_channel_to_private manage_outgoing_webhooks delete_others_posts manage_public_channel_members manage_others_incoming_webhooks manage_team manage_incoming_webhooks manage_private_channel_members add_reaction playbook_private_manage_roles use_channel_mentions remove_user_from_team manage_team_roles read_private_channel_groups manage_channel_roles manage_slash_commands remove_reaction manage_others_slash_commands delete_post playbook_public_manage_roles use_group_mentions read_public_channel_groups convert_private_channel_to_public	t	t
uq7ezmofotri9qsgc5gf3uoofw	custom_group_user	authentication.roles.custom_group_user.name	authentication.roles.custom_group_user.description	1675955399680	1680689068081	0		f	f
siuyt5wdhtrpmxrdhjc9spybsr	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1675955399687	1680689068084	0	 add_user_to_team create_public_channel join_public_channels view_team read_public_channel create_private_channel invite_user playbook_public_create list_team_channels playbook_private_create	t	t
h1xwa95pmjrpi8fsfdo1ky4z3c	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1675955399713	1680689068088	0	 use_group_mentions use_channel_mentions create_post_public	f	t
5oxheqbnqpgx8d147eeu4ywa7o	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1675955399968	1680689068097	0	 restore_custom_group create_custom_group edit_custom_group delete_custom_group manage_custom_group_members	f	t
9xm3gn7bsprczjtm98oqaxkcae	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1675955399816	1680689068104	0	 view_members create_team edit_custom_group delete_emojis create_emojis join_public_teams create_custom_group create_group_channel restore_custom_group delete_custom_group manage_custom_group_members list_public_teams create_direct_channel	t	t
zpcdxpmr1tg73jprtpiwmx6zpa	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1675955400022	1680689068113	0	 assign_system_admin_role delete_post edit_others_posts get_saml_cert_status add_user_to_team sysconsole_write_authentication_ldap sysconsole_write_user_management_permissions sysconsole_read_integrations_gif sysconsole_read_compliance_custom_terms_of_service view_members sysconsole_write_environment_rate_limiting list_users_without_team sysconsole_read_authentication_password sysconsole_write_products_boards manage_public_channel_members sysconsole_read_user_management_teams sysconsole_read_site_notices sysconsole_read_environment_rate_limiting read_channel sysconsole_write_authentication_signup run_manage_members create_post_ephemeral sysconsole_read_environment_logging sysconsole_write_authentication_mfa join_public_teams create_compliance_export_job create_group_channel manage_private_channel_members sysconsole_read_compliance_compliance_export purge_elasticsearch_indexes convert_public_channel_to_private invite_user purge_bleve_indexes sysconsole_read_authentication_mfa sysconsole_write_authentication_guest_access playbook_private_view manage_public_channel_properties invalidate_caches sysconsole_read_reporting_team_statistics sysconsole_write_compliance_compliance_monitoring sysconsole_read_environment_developer get_logs edit_other_users sysconsole_write_site_emoji read_bots sysconsole_write_site_notices sysconsole_read_reporting_server_logs sysconsole_read_reporting_site_statistics use_channel_mentions test_site_url recycle_database_connections sysconsole_write_integrations_bot_accounts remove_ldap_public_cert read_user_access_token create_post convert_private_channel_to_public sysconsole_write_user_management_users sysconsole_write_site_notifications sysconsole_write_integrations_cors sysconsole_read_site_users_and_teams sysconsole_write_compliance_data_retention_policy sysconsole_write_user_management_system_roles read_elasticsearch_post_indexing_job create_ldap_sync_job read_license_information get_analytics remove_saml_idp_cert sysconsole_write_user_management_groups playbook_private_manage_roles sysconsole_write_environment_developer manage_outgoing_webhooks sysconsole_write_environment_logging read_others_bots create_public_channel sysconsole_write_site_posts playbook_public_make_private manage_system_wide_oauth sysconsole_write_user_management_channels create_private_channel read_audits manage_private_channel_properties manage_secure_connections create_data_retention_job test_ldap sysconsole_write_environment_web_server add_saml_idp_cert manage_oauth read_deleted_posts sysconsole_write_environment_database sysconsole_read_experimental_features sysconsole_read_authentication_ldap sysconsole_write_integrations_gif remove_ldap_private_cert sysconsole_read_plugins playbook_private_manage_properties run_view promote_guest create_user_access_token manage_channel_roles sysconsole_write_environment_session_lengths sysconsole_read_environment_elasticsearch sysconsole_read_environment_database sysconsole_read_user_management_system_roles sysconsole_write_integrations_integration_management run_manage_properties sysconsole_write_user_management_teams sysconsole_read_environment_performance_monitoring playbook_public_view add_ldap_private_cert sysconsole_read_environment_push_notification_server sysconsole_read_environment_image_proxy sysconsole_write_reporting_site_statistics delete_public_channel get_public_link reload_config sysconsole_read_integrations_integration_management create_bot delete_others_emojis sysconsole_write_environment_high_availability delete_custom_group run_create restore_custom_group sysconsole_read_environment_web_server upload_file remove_saml_public_cert create_elasticsearch_post_aggregation_job sysconsole_read_site_file_sharing_and_downloads manage_others_outgoing_webhooks sysconsole_read_experimental_bleve sysconsole_read_integrations_bot_accounts sysconsole_write_compliance_custom_terms_of_service sysconsole_read_environment_smtp sysconsole_read_site_notifications delete_others_posts sysconsole_write_authentication_email manage_slash_commands sysconsole_read_user_management_groups sysconsole_write_plugins demote_to_guest sysconsole_read_products_boards sysconsole_read_site_public_links sysconsole_read_experimental_feature_flags manage_others_bots read_private_channel_groups create_direct_channel join_private_teams read_public_channel playbook_public_manage_members sysconsole_read_authentication_openid manage_system sysconsole_write_reporting_team_statistics sysconsole_write_about_edition_and_license download_compliance_export_result sysconsole_write_experimental_feature_flags remove_user_from_team manage_jobs sysconsole_write_environment_file_storage manage_bots sysconsole_read_site_posts assign_bot sysconsole_read_authentication_saml sysconsole_read_site_announcement_banner manage_incoming_webhooks test_s3 playbook_public_create manage_license_information sysconsole_read_authentication_guest_access sysconsole_write_environment_smtp create_elasticsearch_post_indexing_job list_team_channels sysconsole_read_environment_session_lengths read_other_users_teams sysconsole_read_authentication_email sysconsole_write_environment_elasticsearch manage_shared_channels create_post_bleve_indexes_job manage_team_roles remove_reaction sysconsole_write_experimental_bleve sysconsole_write_authentication_openid create_custom_group edit_post view_team sysconsole_write_experimental_features add_reaction sysconsole_write_site_announcement_banner test_elasticsearch sysconsole_read_site_customization playbook_private_create sysconsole_write_billing read_public_channel_groups read_jobs sysconsole_read_user_management_users sysconsole_write_site_users_and_teams revoke_user_access_token create_emojis sysconsole_write_compliance_compliance_export sysconsole_write_authentication_password sysconsole_write_authentication_saml read_data_retention_job add_saml_public_cert use_slash_commands sysconsole_write_site_public_links sysconsole_write_site_file_sharing_and_downloads get_saml_metadata_from_idp playbook_private_manage_members use_group_mentions playbook_private_make_public sysconsole_read_billing list_private_teams invite_guest read_ldap_sync_job remove_others_reactions import_team manage_custom_group_members sysconsole_read_compliance_data_retention_policy sysconsole_write_site_customization sysconsole_write_environment_performance_monitoring sysconsole_read_authentication_signup sysconsole_read_compliance_compliance_monitoring manage_others_slash_commands sysconsole_read_site_localization sysconsole_write_reporting_server_logs edit_brand sysconsole_read_user_management_channels delete_emojis read_compliance_export_job sysconsole_write_environment_push_notification_server delete_private_channel sysconsole_write_site_localization manage_team invalidate_email_invite create_post_public sysconsole_read_site_emoji sysconsole_read_about_edition_and_license edit_custom_group add_ldap_public_cert sysconsole_read_integrations_cors remove_saml_private_cert sysconsole_write_environment_image_proxy sysconsole_read_user_management_permissions list_public_teams sysconsole_read_environment_high_availability manage_roles sysconsole_read_environment_file_storage create_team playbook_public_manage_properties playbook_public_manage_roles read_elasticsearch_post_aggregation_job join_public_channels test_email manage_others_incoming_webhooks add_saml_private_cert	t	t
soowykci5bbtmdt4zj5mghzfgc	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1675955399807	1680689068121	0	 manage_private_channel_members edit_post use_slash_commands delete_public_channel get_public_link read_public_channel_groups manage_public_channel_members use_channel_mentions read_channel add_reaction delete_post manage_public_channel_properties create_post read_private_channel_groups delete_private_channel use_group_mentions remove_reaction upload_file manage_private_channel_properties	t	t
dmd5563itjbi9fu4m1o8m3q85a	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1675955399818	1680689068130	0	 run_create playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view playbook_private_manage_members playbook_private_manage_properties	t	t
37haby5hsprzjcpthk9nknw67c	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1675955399824	1680689068132	0	 run_view	t	t
rmhu9x96s7b7xpnw963oohxinw	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1675955399831	1680689068134	0	 create_direct_channel create_group_channel	t	t
ce76ynxpppg6zgd4y56fmzyhge	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1675955399837	1680689068136	0	 use_channel_mentions use_group_mentions create_post_public	f	t
ccqanx7yw3d48m1nr5n87mgm6r	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1675955399813	1680689067999	0	 view_team	t	t
3txaajmfp3gmxxz4co5my9m1er	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1675955399984	1680689068009	0	 remove_reaction use_group_mentions read_private_channel_groups manage_public_channel_members create_post manage_private_channel_members manage_channel_roles add_reaction read_public_channel_groups use_channel_mentions	t	t
3s75xbpn8i8dddzzsyhe7udmma	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1675955399893	1680689068138	0	 join_private_teams manage_team_roles sysconsole_read_user_management_channels manage_private_channel_members convert_private_channel_to_public read_public_channel sysconsole_read_user_management_teams sysconsole_read_user_management_permissions sysconsole_read_authentication_saml read_channel join_public_teams sysconsole_read_authentication_password manage_private_channel_properties manage_public_channel_members remove_user_from_team delete_public_channel sysconsole_read_authentication_signup view_team sysconsole_read_authentication_ldap sysconsole_write_user_management_teams read_ldap_sync_job convert_public_channel_to_private manage_team add_user_to_team sysconsole_read_user_management_groups sysconsole_read_authentication_mfa read_private_channel_groups delete_private_channel list_public_teams sysconsole_write_user_management_channels list_private_teams sysconsole_read_authentication_guest_access sysconsole_read_authentication_email manage_channel_roles sysconsole_read_authentication_openid test_ldap read_public_channel_groups manage_public_channel_properties sysconsole_write_user_management_groups	f	t
n96z5yt587yizmuqkj5g7f79jh	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1675955399924	1680689068141	0	 sysconsole_read_authentication_password get_analytics read_private_channel_groups sysconsole_read_site_posts sysconsole_read_authentication_guest_access read_elasticsearch_post_indexing_job sysconsole_read_plugins sysconsole_read_authentication_signup sysconsole_read_user_management_teams read_public_channel_groups get_logs sysconsole_read_environment_logging read_data_retention_job read_ldap_sync_job read_license_information sysconsole_read_environment_rate_limiting read_public_channel sysconsole_read_authentication_mfa sysconsole_read_environment_developer sysconsole_read_environment_high_availability sysconsole_read_authentication_ldap sysconsole_read_authentication_email sysconsole_read_environment_performance_monitoring sysconsole_read_environment_database read_audits sysconsole_read_environment_push_notification_server sysconsole_read_user_management_groups sysconsole_read_user_management_permissions sysconsole_read_products_boards download_compliance_export_result sysconsole_read_reporting_server_logs list_private_teams sysconsole_read_environment_file_storage sysconsole_read_compliance_compliance_export sysconsole_read_environment_smtp sysconsole_read_site_announcement_banner sysconsole_read_authentication_openid sysconsole_read_site_file_sharing_and_downloads read_other_users_teams sysconsole_read_user_management_channels sysconsole_read_site_emoji sysconsole_read_site_notifications sysconsole_read_compliance_compliance_monitoring sysconsole_read_site_users_and_teams sysconsole_read_experimental_feature_flags read_elasticsearch_post_aggregation_job list_public_teams sysconsole_read_reporting_site_statistics sysconsole_read_environment_image_proxy sysconsole_read_experimental_bleve sysconsole_read_integrations_gif test_ldap sysconsole_read_experimental_features read_channel sysconsole_read_authentication_saml sysconsole_read_reporting_team_statistics read_compliance_export_job sysconsole_read_site_customization sysconsole_read_site_public_links sysconsole_read_environment_session_lengths sysconsole_read_compliance_data_retention_policy sysconsole_read_environment_elasticsearch sysconsole_read_site_notices sysconsole_read_about_edition_and_license view_team sysconsole_read_user_management_users sysconsole_read_environment_web_server sysconsole_read_integrations_integration_management sysconsole_read_integrations_cors sysconsole_read_site_localization sysconsole_read_compliance_custom_terms_of_service sysconsole_read_integrations_bot_accounts	f	t
3m3dgkrw3byb9p16enpthrpo8w	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1675955400010	1680689068143	0	 sysconsole_write_site_notifications join_private_teams read_elasticsearch_post_aggregation_job sysconsole_write_environment_session_lengths sysconsole_read_user_management_teams manage_public_channel_properties sysconsole_write_environment_rate_limiting sysconsole_write_products_boards read_private_channel_groups read_elasticsearch_post_indexing_job sysconsole_write_integrations_gif sysconsole_read_environment_elasticsearch convert_public_channel_to_private remove_user_from_team sysconsole_read_reporting_server_logs sysconsole_write_site_file_sharing_and_downloads sysconsole_read_reporting_team_statistics sysconsole_write_user_management_permissions sysconsole_read_environment_web_server sysconsole_read_authentication_ldap view_team delete_public_channel sysconsole_read_site_public_links sysconsole_read_environment_image_proxy sysconsole_write_user_management_groups sysconsole_read_site_emoji sysconsole_write_environment_smtp sysconsole_write_user_management_channels sysconsole_read_site_notices sysconsole_read_environment_push_notification_server test_s3 sysconsole_read_environment_developer sysconsole_read_integrations_gif sysconsole_read_reporting_site_statistics sysconsole_read_site_localization sysconsole_read_environment_rate_limiting sysconsole_write_site_customization sysconsole_read_site_customization manage_team add_user_to_team sysconsole_read_site_posts list_public_teams sysconsole_write_integrations_cors sysconsole_read_authentication_saml test_ldap sysconsole_write_environment_push_notification_server sysconsole_read_environment_performance_monitoring sysconsole_write_integrations_integration_management recycle_database_connections sysconsole_read_environment_session_lengths test_elasticsearch sysconsole_read_authentication_guest_access delete_private_channel sysconsole_read_user_management_permissions sysconsole_read_environment_smtp sysconsole_write_environment_database reload_config manage_private_channel_properties sysconsole_read_products_boards sysconsole_write_site_localization read_channel sysconsole_read_site_announcement_banner read_license_information sysconsole_write_environment_logging read_public_channel sysconsole_read_site_file_sharing_and_downloads sysconsole_write_environment_image_proxy get_analytics get_logs sysconsole_write_environment_high_availability sysconsole_read_site_users_and_teams sysconsole_write_site_users_and_teams sysconsole_write_site_public_links convert_private_channel_to_public invalidate_caches create_elasticsearch_post_indexing_job manage_private_channel_members join_public_teams create_elasticsearch_post_aggregation_job read_ldap_sync_job sysconsole_read_integrations_integration_management sysconsole_write_site_announcement_banner sysconsole_read_authentication_openid sysconsole_read_integrations_bot_accounts sysconsole_read_about_edition_and_license sysconsole_read_authentication_mfa sysconsole_write_site_notices manage_public_channel_members sysconsole_read_environment_file_storage sysconsole_write_integrations_bot_accounts sysconsole_read_authentication_signup sysconsole_write_environment_performance_monitoring sysconsole_read_plugins sysconsole_read_authentication_password sysconsole_read_environment_logging sysconsole_read_environment_database sysconsole_read_user_management_channels test_site_url edit_brand sysconsole_write_site_posts sysconsole_read_site_notifications sysconsole_write_environment_elasticsearch sysconsole_read_user_management_groups test_email purge_elasticsearch_indexes manage_team_roles sysconsole_write_user_management_teams sysconsole_write_environment_file_storage sysconsole_read_environment_high_availability list_private_teams sysconsole_write_environment_developer manage_channel_roles sysconsole_read_integrations_cors sysconsole_write_site_emoji read_public_channel_groups sysconsole_read_authentication_email sysconsole_write_environment_web_server	f	t
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.schemes (id, name, displayname, description, createat, updateat, deleteat, scope, defaultteamadminrole, defaultteamuserrole, defaultchanneladminrole, defaultchanneluserrole, defaultteamguestrole, defaultchannelguestrole, defaultplaybookadminrole, defaultplaybookmemberrole, defaultrunadminrole, defaultrunmemberrole) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sessions (id, token, createat, expiresat, lastactivityat, userid, deviceid, roles, isoauth, props, expirednotify) FROM stdin;
dzz9oi8n3p885etb9swkuy8rdc	5nwpuda7t3bsfpyh96q7g6mn7c	1679129901641	1681721901641	1679234377492	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "ti7dbx6xrf8xfb6qasnfkoap4h", "isSaml": "false", "browser": "Chrome/111.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
i1k6tpebb3bjmcaxfw3mezjqkr	gf58ypyk3py95rcuez3g7zjssa	1681109870634	1683890425539	1681384326094	e343y5ecu7dyujwqm7yfimh1je		system_user	f	{"os": "Mac OS", "csrf": "c4x1ap9j7ib1uyaekctjxw7wsr", "isSaml": "false", "browser": "Chrome/111.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
3776ou8tejyodjr9d8sse5e5th	no6waexgy7bsfmsk3qmt787qmy	1679410009395	1682002009394	1679415355994	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "nftqe8usstg39jhyopwsp54bpr", "isSaml": "false", "browser": "Safari/16.3", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
ge6j8ahuz3f8xc44gr74snq1de	werd9x45rbd3tkdr75hzjmwpgc	1679410284126	1682002284126	1679416002676	e343y5ecu7dyujwqm7yfimh1je		system_user	f	{"os": "Mac OS", "csrf": "qawp3jfksp8edk7dqof1jrb5yh", "isSaml": "false", "browser": "Chrome/111.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
85g6f6sddfrymxb9cdyorooy9w	34igj4gyspyh7bm7b1hyoqdaww	1681111980770	1683703980770	1681384353585	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "Mac OS", "csrf": "z96yx5r1zpg9jqycafoosenpwh", "isSaml": "false", "browser": "Safari/16.4", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
keqpnfh4ztdt7c4rj5xr9nk6sr	mr44gx7bwjd9z8i5wqdhxh41yr	1680689074356	0	1680689074356	nphyqs6wq3f4xb317o5eifbzeh			f	{}	f
y978n4jxf7b79ph3ccwfoproeh	bxfcapjqiina9xayxw6y65ubwh	1676646213933	4830246213933	1681385134995	geds3gxhdf81dccdrm8bfx37ry		system_user system_admin	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "smw3ipoqajyrdxie69w464cy9e"}	f
17qdxa1ps3b9zxtg81mhsmrttc	zbobs1dw5jgrtby9hkcz3dkpjy	1678032959918	4831632959918	1681385135445	bgct5icpib883fx619bh3cfu6h		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "gbrc7c89sbfepjfxyijj5bkwyh"}	f
nw4w8ecnz7gy9rt3wm4k68ziqe	i8bz3eaobffm7rgwfrohhjobwa	1678611372912	4832211372912	1681385135549	wq6i7sbf4tnqzbssbn7gy7cjcc		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "nqkt9swge3n87xo18tsdutbryr"}	f
3q5kzouzsj8epp6pchjzuwx6io	ikt4wiy53brdzyt7hn4dad77ch	1679412934949	4833012934949	1681385135673	596q88qz87nbzbddntjm5xi6fh		system_user	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "fymei7fmxtfwpqc89g6a4egubc"}	f
rips3s1pk38oix6k53zrs6sqkc	ufoqwfcjzi8kufmziazgad54ya	1681393939079	0	1681393939079	nphyqs6wq3f4xb317o5eifbzeh			f	{}	f
my3rx6qssb8rtei434uuosg53h	wm5qr9wzupdefj48zwzjn754er	1681302775790	1683894775789	1681303132907	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "dc619khknbrt9fhoxyaf37aazy", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
xmuxszyjbbympqhfyr6itrop5o	fu3am93nmjn1jgo6z53csimbee	1681306483666	1683898483666	1681306483666	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "nn4nziqskpbsdrzop1d3q4twuw", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
s74dnu5u9fnd7m6goma7hu18uw	mw7mxxa3wjbkzqd777e8zxp1wh	1681307387520	1683899387519	1681307387520	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "1rnrfntw7bncmdpajopc44j57y", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
uqn7dfy4xtf3ixmnfwi5s8yobh	443et5kwibdr5dqjus35gbstre	1681309188707	1683901188707	1681309188707	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "tutnd8dtdbdf7xpzaig6h7u7rh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
x9tpqtxukfbgfqhro7whsbfokh	y4hpc966yjfu3qf5znxyigrr9o	1681125240448	1683717240447	1681125240448	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "eyet1jqyat86jp3zjsi1zba3jh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
hpba3z6zsp889qfcfdejf38g1e	swc4sws8yiry7emkhwsq8iomoc	1681125347489	1683717347489	1681125347489	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "9ywigcwoyinwtmje49idax6ixh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
fo4846aaei8i38kq9kmhb86xnr	bxfcapjqiina9xayxw6y65ubwh	1676646213929	4830246213929	1681128700928	geds3gxhdf81dccdrm8bfx37ry		system_user system_admin	f	{"type": "UserAccessToken", "is_guest": "false", "user_access_token_id": "smw3ipoqajyrdxie69w464cy9e"}	f
rn4juqasatr89gdqj3mgikgfbw	qsb9ibry8jgo3xme5mpmqqebke	1681311951655	1683903951655	1681311951655	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "d88beewehfbfugjdb4i4h7m5za", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
j1htwq4pxjf9mjoa978mamq4ne	c8yxgacbcjykicmw134itt4yny	1681125392407	1683717392407	1681125392407	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "ymtiafikt3bfuqxim93fdd31po", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
1xk8og3rst8o3efxr8ygfm1yfh	tuwuurbccfrc8pxi4xpzttaeya	1681125499755	1683717499755	1681125499755	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "hgpb1ezwkpra9po5sime7ab97c", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
ki6mx7yhg3nxjx4rp4s4rd3byw	ouax71ch87bdtdzp1odim8ttio	1681125860310	1683717860310	1681125860310	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "8m14sif1npdptj9nxbsixuj4io", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
184sd4isgjnmxk73sw8oak8rao	zsdb5qainf83tryxm3mxej5o8y	1681126009304	1683718009304	1681126009304	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "ne3ksgqryi8pdbtu54mc7qwu5y", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
9z3gyxgg7tb3pc3zab8wxf4ruh	69g6gk81rty97yx6yz8i35yqbo	1681126158408	1683718158408	1681126158408	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "bj4ktsfeff8djg3ymaf6yyrzya", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
d7iwe1d7e3fjbdpk4a1ae96bwo	j7jkufs8etd98jm1g4tu5ax8je	1681126174181	1683718174181	1681126174181	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "utsmm3x7sb8bje45euf7794nch", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
prnhrdnr3tffpx9b3jgqxn3a3y	4eiqbn9fifrejcgyrrm96pdu1r	1681126291799	1683718291799	1681126291799	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "t5147yzbyid4zcbjad5q4oxieo", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
fsuaqyismpga786gp4s4adnb8a	jkonr9hz5tyoicpfmiiaozd94a	1681126420181	1683718420181	1681126420181	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "g61puru44igx5nx357pk81je9w", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
yqiqgkh6zbd8pmswx57snuwoxr	j3mrgupq9fytubebss3as37yne	1681126586922	1683718586922	1681126586922	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "63ctdmnfkpfi8bcceinajj1tja", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
qoxkhmofhffnxf58cot5wz5cje	cwi89q1an7rszg6t4ojp4yhibo	1681126645760	1683718645760	1681126645760	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "b4d75hut47rttcn4ertk5jmwao", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
1osnofctkffxxgejwtnkw4pshr	81pecj1kbbrzxqpmjx6gmaejzc	1681127794927	1683719794927	1681127794927	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "cb674xwot7rdtjru3x7ysz39ra", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
1bc8bjqqppfyzc99393yj8wsta	33icahy4w3dtxx47pt9pufrf6h	1681127810261	1683719810261	1681127810261	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "oppx9ezbxj8idr1o5k9aqetiqo", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
fhjjanxsujybifpmfjkjpfrk9r	p1hsf1zkqiyt7jmncgr9f95axy	1681127895634	1683719895634	1681127895634	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "ywnhtipc7pyjtpeg3nmmdnzcqc", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
tue4h5sq1bgq9f7h563coz3eao	3q67sx5cfbg9ukcqec9dzzf9nr	1681128165264	1683720165264	1681128165264	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "3pkiwqzwfb8m7rmh4m6h7nbwzh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
kxjar1rahinrue3idzdce95utw	qoe9178frpnjfekdqq9zteqicr	1681128235476	1683720235476	1681128235476	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "ax1sb9bnetr9ubi7ojhr7jiqwr", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
dhk79q8my7bxppwj9sxb8nqxhy	st6kw3psrifs7km35o4krfxhoo	1681128611553	1683720611553	1681128611553	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "mexjsgksz7bqtdesm5puypksxr", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
drn51htewp8omn1e9tw7atezky	jedxgmfpiida8xtxagb9agqkir	1681128640853	1683720640853	1681128640853	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "moitgwpq5tbnpfihbb77837roa", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
yqfqgghqdj8ddejduxyax76x7a	uqmxfbmysbbrffb7593m6trt1a	1681128679505	1683720679505	1681128679505	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "3rmzctoe4f81fx5agzhe3ttkqa", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
ofn6pxhi9jbuueamjqifcps6ty	i8zp17yx4p8nzqpi7gru3axc4r	1681128726267	1683720726267	1681128726267	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "yhdjhf741jywfxgj8s7nrujhwc", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
abt45onof3r45xdnthj5kozbiw	bgfou7f4nfdktn89roi7zuy5xo	1681128848463	1683720848463	1681128848463	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "tnw3ymjua7f8ikcqxn9rjiccba", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
hitnzj8h3irp9k3h4gif7c8udy	xnb54kyriid35d85doxpncyx6o	1681128892673	1683720892673	1681128892673	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "weupbch3ctnb9p9n18u6idkhio", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
8gowo5sx7tfyzcipqq8h88w6qr	1ih19iz5firzxy8z4ooe55ztfy	1681129573110	1683721573110	1681129573110	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "q7r9dzqb77nqbkhs493pr4bxth", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
h6e5m4iebpbhfb88i867srk73w	hh66oz7e37gobkrqicswsoazth	1681129576907	1683721576907	1681129576907	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "cnqb4gwoxjy73byb9g8g4nczgh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
dq388qibsfrrxcm4877ybb9pdc	hoijy6j46f8q5q89ne3utdbe1w	1681129741517	1683721741517	1681129741517	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "81ky857813niuqcrmfusjx55ua", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
1zajwirgkfdiuc6ccukpxn8w4a	iunjknimuifndeu5zm154r3mhe	1681129976547	1683721976547	1681129976547	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "59ytjte7kpbapg65mz1fpocejr", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
cr51okhxwb8rpkgcdns83oo6qr	pmgso4f733bpxktingjwgwuoir	1681130100681	1683722100681	1681130100681	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "y5ece5r1ojgw5xstu333hcotsh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
sk5fcndp978tzf1yzcmyh8fibo	f6gerhgnyifebd5qgmf1eg4whr	1681130260611	1683722260611	1681130260611	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "5ybc1w9a8bdi7ghzywdrxog1zc", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
3ng7wrtur7n9tp4hxrcdm3k5by	obxdyonyw7bfj8wzuj4ki9oado	1681130324546	1683722324546	1681130324546	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "19mwidt1z3yg5pyojof5u97uwe", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
k49pyo85cfbqzq9bdnikzm5d3c	shkag4ybepgexp7bcuybfk6a5e	1681130325293	1683722325293	1681130325293	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "ueub8h8kui8p7jpr8p1tuse7ir", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
qbksy37r1tgb5xbkym6dygbhay	jroheiuh6tdxzcmta7yth6tn4e	1681130332149	1683722332149	1681130332149	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "o4xmdarj93ysdrioajo4obddao", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
e1f3a9rp4bneurcfkfmwhwq9ca	aca4mj8mtb87ieapb7fdmpfb4r	1681130383595	1683722383595	1681130383595	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "ejmcd15jwfdd5pfso5unechibe", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
j6g8b63nr7yxjjk93usp7xf1za	oecfo7o7x3yuue7cj5eprdu73e	1681302152381	1683894152381	1681302152381	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "bhg7ba1oui8n5prmk8dyraiohr", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
m91o3jrbmbdabduta8i97unxjc	o4j1eopai7n9jxtr9nzyhabxzc	1681302555250	1683894555249	1681302555250	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "588ue873hidi7dshnnt9binb7a", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
7rzmwgiz4tf33pz311rchesyjw	u5z6i9horjr95ymjist4m1h53a	1681303325211	1683895325211	1681303325211	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "qnry5ojorpd4zgfeqjf4dc3dkw", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
g1pmtocr43ftxmz4x4gqr391zy	iog9frakxiyb7kf1h6s6u7jhfc	1681306675125	1683898675125	1681306675125	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "6n5o18pehiy9jfh4zrdbkuy7uh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
j8b4ych7tbgt5pa19bsukojyqh	wpdg54c8sb8yz8kab4zrzcjchr	1681306721037	1683898721037	1681306721037	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "ps51hr8g67ymjnr33wku8n75uy", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
5tub8jnzxjgozes1ubefxh4gwh	qcaknx7eqfyzjd5xgzwwq97gxw	1681306745383	1683898745382	1681306745383	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "yt7y18jsipyp8pok4wkzqrgfho", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
q4bqw8ujztykdcpa4ynihy4g4a	rb5y5z5j5tbcmesi7j7zqo3sbe	1681307924641	1683899924641	1681307924641	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "b3jkw3ywz3yytpdsyw5mzripew", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
563yhbctn7gw9x4gpd47aupeke	cx1zh7iqetr7dkc3q3wyq8d1ce	1681308003342	1683900003342	1681308003342	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "bopqftsqkjbz7pcn4m88i7nxfy", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
8kp6erua9tf1ir7ohk58pgb94r	7yubpjy7opdomykp71qr97ystw	1681309425369	1683901425369	1681309425369	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "81c53m884pdn9my6tsak5fus6h", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
i1po5nrdgtdfxpuqd91ubgg6ea	su1wo3djiffp7x5m7f19ync1se	1681312037194	1683904037194	1681312037194	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "sxhpazai9fniupeikmfctrjkur", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
mrkmmjk1t7bsbg5tig4wmdnxoa	tq8cxt7aa7fcfgn95zo6qs4qce	1681312247369	1683904247369	1681312247369	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "pofm8fwnx3gt8gew7yye15w3ry", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
i6474fe9cfrd3gax3qjzxmt7dy	r87putheaibwzr7mo9n4rir14a	1681133218686	1683725218686	1681133218686	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "6hscd7jgxfnkf8x3e7hf4otx9h", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
ptg9hp4sciywtg6fpy8ijdstwc	3fynigbfi3yqz8koy7qy5qus3e	1681302296829	1683894296829	1681302296829	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "thedd616mbyz78c5udxzgy495y", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
h8na6s16jff6xqh8opz37q6p3c	inxd1jdf6tdzdksgtdr5a9wgto	1681303424411	1683895424411	1681303424411	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "Mac OS", "csrf": "i7yo4mom5tfp9ncjwnrnfk79je", "isSaml": "false", "browser": "Chrome/112.0", "isMobile": "false", "is_guest": "false", "platform": "Macintosh", "isOAuthUser": "false"}	f
eq4ku4o937neuntmi83kz4kikc	yrsaxjskebgyxmj6sh3mtj3j6o	1681214504954	1683806504951	1681214504954	whida44gqpyfierua1wfrnbxtr		system_admin system_user	f	{"os": "", "csrf": "wtcb1cweotnefqmxna9heineke", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
khbrwxg957fqtedfn5xsc5roxe	365pjr981pgz58xyn7s4iwsb9o	1681306953149	1683898953149	1681306953149	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "b3t1z6dhuirqmeiodg6fmhoiih", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
r19cpn9nbbfcmezd7y4g5ixhso	xnf7j6idjf87pborape533prha	1681306981308	1683898981308	1681306981308	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "xicobsr4fpgixfhaju856ibqzc", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
3phret7i7pbtjcbzmnxsukm6nr	zaqtmnt7qjbbb8mfb4md5bhcso	1681307215669	1683899215669	1681307215669	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "7994xx9wftnb9kbamtbj3hsmhh", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
s7bd6fgs7pr5zkncfjdczznhrw	enjybd1wy7y75phb8pdug47bxa	1681307794057	1683899794057	1681307794057	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "jz3gziz5rpd97q5yywrhbswniy", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
x5nbwwjywbyabecwi55tcbjc1c	dif8bprb57r88komxiaerhmhar	1681308914427	1683900914427	1681308914427	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "3cy5ehg7qbb4u87gtfn8igmnka", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
gmpdyjsdkjbob8ofxueqswac3h	hceup1cm6tb43ci1tig8uyp5eh	1681310364247	1683902364247	1681310364247	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "cxcghwqz87dafdawygf55higsy", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
sxe54rhx9ib7bryouw3hi8cn4y	m16un78wjbyxfdzyg6z5q6ip9r	1681310411879	1683902411879	1681310411879	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "u3ynspzcqfbdbc4e5e6ibea7yr", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
67cg6xkgp3yuicaoq14mneaw6y	fut7i7hxdffejkh5or4tskfxba	1681310919197	1683902919197	1681310919197	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "z69dpsxfj3bhupaf7rjs8n4bfa", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
643z3ocdqff8xeg8iq6ocrcoew	k4ejk6sen7gcfgxgiw57idxobo	1681314452330	1683906452330	1681314452330	ygmycw6rnff7igko8gwbqchujr		system_user	f	{"os": "", "csrf": "6emtbw4umfrw5mygg5fdkp89re", "isSaml": "false", "browser": "Unknown/0.0", "isMobile": "false", "is_guest": "false", "platform": "Windows", "isOAuthUser": "false"}	f
\.


--
-- Data for Name: sharedchannelattachments; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelattachments (id, fileid, remoteid, createat, lastsyncat) FROM stdin;
\.


--
-- Data for Name: sharedchannelremotes; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelremotes (id, channelid, creatorid, createat, updateat, isinviteaccepted, isinviteconfirmed, remoteid, lastpostupdateat, lastpostid) FROM stdin;
\.


--
-- Data for Name: sharedchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannels (channelid, teamid, home, readonly, sharename, sharedisplayname, sharepurpose, shareheader, creatorid, createat, updateat, remoteid) FROM stdin;
\.


--
-- Data for Name: sharedchannelusers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sharedchannelusers (id, userid, remoteid, createat, lastsyncat, channelid) FROM stdin;
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname, muted, collapsed) FROM stdin;
favorites_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_bgct5icpib883fx619bh3cfu6h_ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
favorites_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_wq6i7sbf4tnqzbssbn7gy7cjcc_ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
direct_messages_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
favorites_596q88qz87nbzbddntjm5xi6fh_ebxg8q3pzbdrdjo7xx1qqw3guy	596q88qz87nbzbddntjm5xi6fh	ebxg8q3pzbdrdjo7xx1qqw3guy	0		favorites	Favorites	f	f
channels_596q88qz87nbzbddntjm5xi6fh_ebxg8q3pzbdrdjo7xx1qqw3guy	596q88qz87nbzbddntjm5xi6fh	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
direct_messages_596q88qz87nbzbddntjm5xi6fh_ebxg8q3pzbdrdjo7xx1qqw3guy	596q88qz87nbzbddntjm5xi6fh	ebxg8q3pzbdrdjo7xx1qqw3guy	20	recent	direct_messages	Direct Messages	f	f
channels_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
favorites_e343y5ecu7dyujwqm7yfimh1je_rjartdbsbtrfjfk9k9argymhqw	e343y5ecu7dyujwqm7yfimh1je	rjartdbsbtrfjfk9k9argymhqw	0		favorites	Favorites	f	f
channels_e343y5ecu7dyujwqm7yfimh1je_rjartdbsbtrfjfk9k9argymhqw	e343y5ecu7dyujwqm7yfimh1je	rjartdbsbtrfjfk9k9argymhqw	10		channels	Channels	f	f
direct_messages_e343y5ecu7dyujwqm7yfimh1je_rjartdbsbtrfjfk9k9argymhqw	e343y5ecu7dyujwqm7yfimh1je	rjartdbsbtrfjfk9k9argymhqw	20	recent	direct_messages	Direct Messages	f	f
channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je	ebxg8q3pzbdrdjo7xx1qqw3guy	10		channels	Channels	f	f
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
giyj94p1fp86p8zs9z6u5b3ujh	geds3gxhdf81dccdrm8bfx37ry	channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	10
p7retz8iwtgzdrdceqw13fwmbr	geds3gxhdf81dccdrm8bfx37ry	channels_geds3gxhdf81dccdrm8bfx37ry_ebxg8q3pzbdrdjo7xx1qqw3guy	20
rk4gdc4whjnupqoad46hwa9cme	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	0
9wp7xhh6f7namrfm1asziaf9nh	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	10
giyj94p1fp86p8zs9z6u5b3ujh	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	20
p7retz8iwtgzdrdceqw13fwmbr	ygmycw6rnff7igko8gwbqchujr	channels_ygmycw6rnff7igko8gwbqchujr_ebxg8q3pzbdrdjo7xx1qqw3guy	30
hb8cxm688f86zgrejdmgdr7qsc	whida44gqpyfierua1wfrnbxtr	channels_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	0
giyj94p1fp86p8zs9z6u5b3ujh	whida44gqpyfierua1wfrnbxtr	channels_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	10
p7retz8iwtgzdrdceqw13fwmbr	whida44gqpyfierua1wfrnbxtr	channels_whida44gqpyfierua1wfrnbxtr_ebxg8q3pzbdrdjo7xx1qqw3guy	20
8tmxnejrb3fhxb6p91b7358y3c	e343y5ecu7dyujwqm7yfimh1je	channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	0
hb8cxm688f86zgrejdmgdr7qsc	e343y5ecu7dyujwqm7yfimh1je	channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	10
9wp7xhh6f7namrfm1asziaf9nh	e343y5ecu7dyujwqm7yfimh1je	channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	20
giyj94p1fp86p8zs9z6u5b3ujh	e343y5ecu7dyujwqm7yfimh1je	channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	30
p7retz8iwtgzdrdceqw13fwmbr	e343y5ecu7dyujwqm7yfimh1je	channels_e343y5ecu7dyujwqm7yfimh1je_ebxg8q3pzbdrdjo7xx1qqw3guy	40
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
596q88qz87nbzbddntjm5xi6fh	offline	f	1679412935217	0	
wq6i7sbf4tnqzbssbn7gy7cjcc	offline	f	1679416093741	0	
bgct5icpib883fx619bh3cfu6h	offline	f	1681312264580	0	
geds3gxhdf81dccdrm8bfx37ry	offline	f	1681385158085	0	
e343y5ecu7dyujwqm7yfimh1je	offline	f	1681385158088	0	
whida44gqpyfierua1wfrnbxtr	offline	f	1681385158092	0	
ygmycw6rnff7igko8gwbqchujr	offline	f	1681303511707	0	
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.systems (name, value) FROM stdin;
CRTChannelMembershipCountsMigrationComplete	true
CRTThreadCountsAndUnreadsMigrationComplete	true
AsymmetricSigningKey	{"ecdsa_key":{"curve":"P-256","x":60581695069711960390006342233346342337919323610595164976945745154618296289272,"y":27256658457734069685286994869610575277405935570818687355893748260913908058768,"d":65848915887861549171349767132686020608299128055797728715643672013708470201362}}
DiagnosticId	o9fwnewhrfn8br43wgtj4cbkro
FirstServerRunTimestamp	1675955399883
AdvancedPermissionsMigrationComplete	true
EmojisPermissionsMigrationComplete	true
GuestRolesCreationMigrationComplete	true
SystemConsoleRolesCreationMigrationComplete	true
CustomGroupAdminRoleCreationMigrationComplete	true
emoji_permissions_split	true
webhook_permissions_split	true
list_join_public_private_teams	true
remove_permanent_delete_user	true
add_bot_permissions	true
apply_channel_manage_delete_to_channel_user	true
remove_channel_manage_delete_from_team_user	true
view_members_new_permission	true
add_manage_guests_permissions	true
channel_moderations_permissions	true
add_use_group_mentions_permission	true
add_system_console_permissions	true
add_convert_channel_permissions	true
manage_shared_channel_permissions	true
manage_secure_connections_permissions	true
add_system_roles_permissions	true
add_billing_permissions	true
download_compliance_export_results	true
experimental_subsection_permissions	true
authentication_subsection_permissions	true
integrations_subsection_permissions	true
site_subsection_permissions	true
compliance_subsection_permissions	true
environment_subsection_permissions	true
about_subsection_permissions	true
reporting_subsection_permissions	true
test_email_ancillary_permission	true
playbooks_permissions	true
custom_groups_permissions	true
playbooks_manage_roles	true
products_boards	true
ContentExtractionConfigDefaultTrueMigrationComplete	true
PlaybookRolesCreationMigrationComplete	true
RemainingSchemaMigrations	true
PostActionCookieSecret	{"key":"1b6qKeFPcn3l3kqRRQNxZXtcD0eX2wyDsY2OkndMkyo="}
InstallationDate	1675955407698
migration_advanced_permissions_phase_2	true
FirstAdminSetupComplete	true
custom_groups_permission_restore	true
PostPriorityConfigDefaultTrueMigrationComplete	true
LastSecurityTime	1681393904133
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
ebxg8q3pzbdrdjo7xx1qqw3guy	whida44gqpyfierua1wfrnbxtr		0	t	t	f	1675955722063
ebxg8q3pzbdrdjo7xx1qqw3guy	geds3gxhdf81dccdrm8bfx37ry		0	t	f	f	1675956111670
ebxg8q3pzbdrdjo7xx1qqw3guy	ygmycw6rnff7igko8gwbqchujr		0	t	f	f	1675956421284
ebxg8q3pzbdrdjo7xx1qqw3guy	bgct5icpib883fx619bh3cfu6h		0	t	f	f	1676646214604
ebxg8q3pzbdrdjo7xx1qqw3guy	wq6i7sbf4tnqzbssbn7gy7cjcc		0	t	f	f	1678611368085
ebxg8q3pzbdrdjo7xx1qqw3guy	e343y5ecu7dyujwqm7yfimh1je		0	t	f	f	1678611396619
ebxg8q3pzbdrdjo7xx1qqw3guy	596q88qz87nbzbddntjm5xi6fh		0	t	f	f	1679412884640
rjartdbsbtrfjfk9k9argymhqw	e343y5ecu7dyujwqm7yfimh1je		0	t	t	f	1681299111133
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, schemeid, allowopeninvite, lastteamiconupdate, groupconstrained, cloudlimitsarchived) FROM stdin;
ebxg8q3pzbdrdjo7xx1qqw3guy	1675955722030	1675955743965	0	Default	default		admin@localhost.com	O			mxwqwnwjg3fbbr3o3xpfuw6a3y	\N	t	0	\N	f
rjartdbsbtrfjfk9k9argymhqw	1681299111059	1681299111059	0	MyTeam	myteam		user2.mm@localhost.com	O			oguqzkyto3ns5nospbqae346or	\N	f	0	\N	f
\.


--
-- Data for Name: termsofservice; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.termsofservice (id, createat, userid, text) FROM stdin;
\.


--
-- Data for Name: threadmemberships; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.threadmemberships (postid, userid, following, lastviewed, lastupdated, unreadmentions) FROM stdin;
iwf9qjrqm7g1pxjtfrotp1izuo	bgct5icpib883fx619bh3cfu6h	t	0	1681313818028	0
iwf9qjrqm7g1pxjtfrotp1izuo	e343y5ecu7dyujwqm7yfimh1je	t	1681313849298	1681313849349	0
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.threads (postid, replycount, lastreplyat, participants, channelid, threaddeleteat, threadteamid) FROM stdin;
iwf9qjrqm7g1pxjtfrotp1izuo	2	1681313848427	["e343y5ecu7dyujwqm7yfimh1je"]	p7retz8iwtgzdrdceqw13fwmbr	\N	ebxg8q3pzbdrdjo7xx1qqw3guy
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.tokens (token, createat, type, extra) FROM stdin;
\.


--
-- Data for Name: trueupreviewhistory; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.trueupreviewhistory (duedate, completed) FROM stdin;
\.


--
-- Data for Name: uploadsessions; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.uploadsessions (id, type, createat, userid, channelid, filename, path, filesize, fileoffset, remoteid, reqfileid) FROM stdin;
\.


--
-- Data for Name: useraccesstokens; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.useraccesstokens (id, token, userid, description, isactive) FROM stdin;
smw3ipoqajyrdxie69w464cy9e	bxfcapjqiina9xayxw6y65ubwh	geds3gxhdf81dccdrm8bfx37ry	New Bridge Token	t
gbrc7c89sbfepjfxyijj5bkwyh	zbobs1dw5jgrtby9hkcz3dkpjy	bgct5icpib883fx619bh3cfu6h	bridge	t
1wnn4juj47nhuqu6rnbsknpqjh	eox7ugyfujbbdpy4drb1w14nqy	ygmycw6rnff7igko8gwbqchujr	For the bridge	t
mnr319koxbdzibwaihhtetpxsw	deges64nuprjdrke65zqfp7fkw	ygmycw6rnff7igko8gwbqchujr	For the bridge	t
nqkt9swge3n87xo18tsdutbryr	i8bz3eaobffm7rgwfrohhjobwa	wq6i7sbf4tnqzbssbn7gy7cjcc	For the bridge	t
fst4r7d4ninxtexjknn4y4ooqa	s34w4m8qw7dybmn4qb8qfwyhfr	e343y5ecu7dyujwqm7yfimh1je	For the bridge	t
fymei7fmxtfwpqc89g6a4egubc	ikt4wiy53brdzyt7hn4dad77ch	596q88qz87nbzbddntjm5xi6fh	For the bridge	t
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.usergroups (id, name, displayname, description, source, remoteid, createat, updateat, deleteat, allowreference) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.users (id, createat, updateat, deleteat, username, password, authdata, authservice, email, emailverified, nickname, firstname, lastname, roles, allowmarketing, props, notifyprops, lastpasswordupdate, lastpictureupdate, failedattempts, locale, mfaactive, mfasecret, "position", timezone, remoteid) FROM stdin;
g6hetueczp8wif38h7o3o1pcyc	1675955410087	1675955410087	0	boards		\N		boards@localhost	f		Boards		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955410087	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
59858ksa4ircjd9a5811negojr	1675955999723	1675955999723	0	system-bot		\N		system-bot@localhost	f		System		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955999723	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
geds3gxhdf81dccdrm8bfx37ry	1675956108535	1675956222140	0	matrix.bridge	$2a$10$JXCrzoCJTcpdLmjN1XYghuFiZOizqFjNvlAoSCjt5mhkgJl6owVhu	\N		matrix.bridge@localhost.com	f				system_user system_admin	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675956108535	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
wq6i7sbf4tnqzbssbn7gy7cjcc	1678611367465	1679130437827	0	matrix_user2.matrix	$2a$10$Kj2G4VTsS3boBXjoLlSGU.PTIpAwfrpnmikFUctIOqBXVQAEOQWb6	\N		devnull-uszv_qq4l94sqhy7@localhost	t		user2.matrix		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1678611367465	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
bgct5icpib883fx619bh3cfu6h	1676646214332	1679130437807	0	matrix_user1.matrix	$2a$10$q9SUFyaY6Lra0k7p8YK0YOqT9gP0GS3qw1X8dELNq2PrkEYPBilsW	\N		devnull-t6oqx2s4cgfznyuj@localhost	t		user1.matrix		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1676646214332	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
596q88qz87nbzbddntjm5xi6fh	1679412883811	1679412884652	0	matrix_user3.matrix	$2a$10$1PR83y8Vz991yrid/eIEme/gpB/zalgryAHDTHXzNd91uGwYYeElO	\N		user3.matrix@localhost.com	t				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1679412883811	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
nphyqs6wq3f4xb317o5eifbzeh	1680689074277	1680689074277	0	calls		\N		calls@localhost	f		Calls		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1680689074277	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
uzpc4t1qkjbt3gspmrtmuzrimw	1675955407698	1681109794122	0	appsbot		\N		appsbot@localhost	f		Mattermost Apps		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955407698	1681109794122	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
nm4raj8trpgetcnutzc8icka7r	1675955408397	1681109794444	0	playbooks		\N		playbooks@localhost	f		Playbooks		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955408397	1681109794444	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
ygmycw6rnff7igko8gwbqchujr	1675956418277	1675956421298	0	user1.mm	$2a$10$P31EGMdOVpLdPjTky0zd6u6BSLvOMix7MvPxqO5D5k1bf/Pqv/yYK	\N		user1.mm@localhost.com	f				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675956418277	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
whida44gqpyfierua1wfrnbxtr	1675955707161	1675955722081	0	admin	$2a$10$F/SOv8pg1NY3p9ZH6USjxOLr02DqMH4SgTEUnKVZlqPLtrkL.lNEK	\N		admin@localhost.com	f				system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1675955707161	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
e343y5ecu7dyujwqm7yfimh1je	1678611392548	1681299111165	0	user2.mm	$2a$10$vBYh6HG1k6KG50zVq05mW.5XanoPoJ.G6pbypi5.1cImTp0QtGKky	\N		user2.mm@localhost.com	f				system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1678611392548	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N
\.


--
-- Data for Name: usertermsofservice; Type: TABLE DATA; Schema: public; Owner: mattermost
--

COPY public.usertermsofservice (userid, termsofserviceid, createat) FROM stdin;
\.


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: bots bots_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_pkey PRIMARY KEY (userid);


--
-- Name: channelmemberhistory channelmemberhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channelmemberhistory
    ADD CONSTRAINT channelmemberhistory_pkey PRIMARY KEY (channelid, userid, jointime);


--
-- Name: channelmembers channelmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channelmembers
    ADD CONSTRAINT channelmembers_pkey PRIMARY KEY (channelid, userid);


--
-- Name: channels channels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: clusterdiscovery clusterdiscovery_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.clusterdiscovery
    ADD CONSTRAINT clusterdiscovery_pkey PRIMARY KEY (id);


--
-- Name: commands commands_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.commands
    ADD CONSTRAINT commands_pkey PRIMARY KEY (id);


--
-- Name: commandwebhooks commandwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.commandwebhooks
    ADD CONSTRAINT commandwebhooks_pkey PRIMARY KEY (id);


--
-- Name: compliances compliances_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.compliances
    ADD CONSTRAINT compliances_pkey PRIMARY KEY (id);


--
-- Name: db_lock db_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.db_lock
    ADD CONSTRAINT db_lock_pkey PRIMARY KEY (id);


--
-- Name: db_migrations db_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.db_migrations
    ADD CONSTRAINT db_migrations_pkey PRIMARY KEY (version);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (userid, channelid, rootid);


--
-- Name: emoji emoji_name_deleteat_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_name_deleteat_key UNIQUE (name, deleteat);


--
-- Name: emoji emoji_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_pkey PRIMARY KEY (id);


--
-- Name: fileinfo fileinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.fileinfo
    ADD CONSTRAINT fileinfo_pkey PRIMARY KEY (id);


--
-- Name: focalboard_blocks_history focalboard_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_blocks_history
    ADD CONSTRAINT focalboard_blocks_pkey PRIMARY KEY (id, insert_at);


--
-- Name: focalboard_blocks focalboard_blocks_pkey1; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_blocks
    ADD CONSTRAINT focalboard_blocks_pkey1 PRIMARY KEY (id);


--
-- Name: focalboard_board_members_history focalboard_board_members_history_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_board_members_history
    ADD CONSTRAINT focalboard_board_members_history_pkey PRIMARY KEY (board_id, user_id, insert_at);


--
-- Name: focalboard_board_members focalboard_board_members_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_board_members
    ADD CONSTRAINT focalboard_board_members_pkey PRIMARY KEY (board_id, user_id);


--
-- Name: focalboard_boards_history focalboard_boards_history_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_boards_history
    ADD CONSTRAINT focalboard_boards_history_pkey PRIMARY KEY (id, insert_at);


--
-- Name: focalboard_boards focalboard_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_boards
    ADD CONSTRAINT focalboard_boards_pkey PRIMARY KEY (id);


--
-- Name: focalboard_categories focalboard_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_categories
    ADD CONSTRAINT focalboard_categories_pkey PRIMARY KEY (id);


--
-- Name: focalboard_category_boards focalboard_category_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_category_boards
    ADD CONSTRAINT focalboard_category_boards_pkey PRIMARY KEY (id);


--
-- Name: focalboard_notification_hints focalboard_notification_hints_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_notification_hints
    ADD CONSTRAINT focalboard_notification_hints_pkey PRIMARY KEY (block_id);


--
-- Name: focalboard_preferences focalboard_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_preferences
    ADD CONSTRAINT focalboard_preferences_pkey PRIMARY KEY (userid, category, name);


--
-- Name: focalboard_schema_migrations focalboard_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_schema_migrations
    ADD CONSTRAINT focalboard_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: focalboard_sessions focalboard_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_sessions
    ADD CONSTRAINT focalboard_sessions_pkey PRIMARY KEY (id);


--
-- Name: focalboard_sharing focalboard_sharing_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_sharing
    ADD CONSTRAINT focalboard_sharing_pkey PRIMARY KEY (id);


--
-- Name: focalboard_subscriptions focalboard_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_subscriptions
    ADD CONSTRAINT focalboard_subscriptions_pkey PRIMARY KEY (block_id, subscriber_id);


--
-- Name: focalboard_system_settings focalboard_system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_system_settings
    ADD CONSTRAINT focalboard_system_settings_pkey PRIMARY KEY (id);


--
-- Name: focalboard_users focalboard_users_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_users
    ADD CONSTRAINT focalboard_users_pkey PRIMARY KEY (id);


--
-- Name: focalboard_teams focalboard_workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_teams
    ADD CONSTRAINT focalboard_workspaces_pkey PRIMARY KEY (id);


--
-- Name: groupchannels groupchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupchannels
    ADD CONSTRAINT groupchannels_pkey PRIMARY KEY (groupid, channelid);


--
-- Name: groupmembers groupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_pkey PRIMARY KEY (groupid, userid);


--
-- Name: groupteams groupteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.groupteams
    ADD CONSTRAINT groupteams_pkey PRIMARY KEY (groupid, teamid);


--
-- Name: incomingwebhooks incomingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.incomingwebhooks
    ADD CONSTRAINT incomingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: ir_category_item ir_category_item_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category_item
    ADD CONSTRAINT ir_category_item_pkey PRIMARY KEY (categoryid, itemid, type);


--
-- Name: ir_category ir_category_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category
    ADD CONSTRAINT ir_category_pkey PRIMARY KEY (id);


--
-- Name: ir_channelaction ir_channelaction_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_channelaction
    ADD CONSTRAINT ir_channelaction_pkey PRIMARY KEY (id);


--
-- Name: ir_incident ir_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_incident
    ADD CONSTRAINT ir_incident_pkey PRIMARY KEY (id);


--
-- Name: ir_metric ir_metric_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_pkey PRIMARY KEY (incidentid, metricconfigid);


--
-- Name: ir_metricconfig ir_metricconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metricconfig
    ADD CONSTRAINT ir_metricconfig_pkey PRIMARY KEY (id);


--
-- Name: ir_playbook ir_playbook_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbook
    ADD CONSTRAINT ir_playbook_pkey PRIMARY KEY (id);


--
-- Name: ir_playbookautofollow ir_playbookautofollow_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookautofollow
    ADD CONSTRAINT ir_playbookautofollow_pkey PRIMARY KEY (playbookid, userid);


--
-- Name: ir_playbookmember ir_playbookmember_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_pkey PRIMARY KEY (memberid, playbookid);


--
-- Name: ir_playbookmember ir_playbookmember_playbookid_memberid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_playbookid_memberid_key UNIQUE (playbookid, memberid);


--
-- Name: ir_run_participants ir_run_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_run_participants
    ADD CONSTRAINT ir_run_participants_pkey PRIMARY KEY (incidentid, userid);


--
-- Name: ir_statusposts ir_statusposts_incidentid_postid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_incidentid_postid_key UNIQUE (incidentid, postid);


--
-- Name: ir_statusposts ir_statusposts_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_pkey PRIMARY KEY (incidentid, postid);


--
-- Name: ir_system ir_system_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_system
    ADD CONSTRAINT ir_system_pkey PRIMARY KEY (skey);


--
-- Name: ir_timelineevent ir_timelineevent_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_timelineevent
    ADD CONSTRAINT ir_timelineevent_pkey PRIMARY KEY (id);


--
-- Name: ir_userinfo ir_userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_userinfo
    ADD CONSTRAINT ir_userinfo_pkey PRIMARY KEY (id);


--
-- Name: ir_viewedchannel ir_viewedchannel_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_viewedchannel
    ADD CONSTRAINT ir_viewedchannel_pkey PRIMARY KEY (channelid, userid);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: linkmetadata linkmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.linkmetadata
    ADD CONSTRAINT linkmetadata_pkey PRIMARY KEY (hash);


--
-- Name: notifyadmin notifyadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.notifyadmin
    ADD CONSTRAINT notifyadmin_pkey PRIMARY KEY (userid, requiredfeature, requiredplan);


--
-- Name: oauthaccessdata oauthaccessdata_clientid_userid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_clientid_userid_key UNIQUE (clientid, userid);


--
-- Name: oauthaccessdata oauthaccessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_pkey PRIMARY KEY (token);


--
-- Name: oauthapps oauthapps_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthapps
    ADD CONSTRAINT oauthapps_pkey PRIMARY KEY (id);


--
-- Name: oauthauthdata oauthauthdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.oauthauthdata
    ADD CONSTRAINT oauthauthdata_pkey PRIMARY KEY (code);


--
-- Name: outgoingwebhooks outgoingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.outgoingwebhooks
    ADD CONSTRAINT outgoingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: pluginkeyvaluestore pluginkeyvaluestore_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.pluginkeyvaluestore
    ADD CONSTRAINT pluginkeyvaluestore_pkey PRIMARY KEY (pluginid, pkey);


--
-- Name: postacknowledgements postacknowledgements_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.postacknowledgements
    ADD CONSTRAINT postacknowledgements_pkey PRIMARY KEY (postid, userid);


--
-- Name: postreminders postreminders_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.postreminders
    ADD CONSTRAINT postreminders_pkey PRIMARY KEY (postid, userid);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: postspriority postspriority_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.postspriority
    ADD CONSTRAINT postspriority_pkey PRIMARY KEY (postid);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (userid, category, name);


--
-- Name: productnoticeviewstate productnoticeviewstate_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.productnoticeviewstate
    ADD CONSTRAINT productnoticeviewstate_pkey PRIMARY KEY (userid, noticeid);


--
-- Name: publicchannels publicchannels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: publicchannels publicchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_pkey PRIMARY KEY (id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (postid, userid, emojiname);


--
-- Name: recentsearches recentsearches_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.recentsearches
    ADD CONSTRAINT recentsearches_pkey PRIMARY KEY (userid, searchpointer);


--
-- Name: remoteclusters remoteclusters_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.remoteclusters
    ADD CONSTRAINT remoteclusters_pkey PRIMARY KEY (remoteid, name);


--
-- Name: retentionpolicies retentionpolicies_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicies
    ADD CONSTRAINT retentionpolicies_pkey PRIMARY KEY (id);


--
-- Name: retentionpolicieschannels retentionpolicieschannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT retentionpolicieschannels_pkey PRIMARY KEY (channelid);


--
-- Name: retentionpoliciesteams retentionpoliciesteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT retentionpoliciesteams_pkey PRIMARY KEY (teamid);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schemes schemes_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_name_key UNIQUE (name);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelattachments sharedchannelattachments_fileid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_fileid_remoteid_key UNIQUE (fileid, remoteid);


--
-- Name: sharedchannelattachments sharedchannelattachments_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelremotes sharedchannelremotes_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_channelid_remoteid_key UNIQUE (channelid, remoteid);


--
-- Name: sharedchannelremotes sharedchannelremotes_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_pkey PRIMARY KEY (id, channelid);


--
-- Name: sharedchannels sharedchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_pkey PRIMARY KEY (channelid);


--
-- Name: sharedchannels sharedchannels_sharename_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_sharename_teamid_key UNIQUE (sharename, teamid);


--
-- Name: sharedchannelusers sharedchannelusers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelusers sharedchannelusers_userid_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_userid_channelid_remoteid_key UNIQUE (userid, channelid, remoteid);


--
-- Name: sidebarcategories sidebarcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sidebarcategories
    ADD CONSTRAINT sidebarcategories_pkey PRIMARY KEY (id);


--
-- Name: sidebarchannels sidebarchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.sidebarchannels
    ADD CONSTRAINT sidebarchannels_pkey PRIMARY KEY (channelid, userid, categoryid);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (userid);


--
-- Name: systems systems_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pkey PRIMARY KEY (name);


--
-- Name: teammembers teammembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teammembers
    ADD CONSTRAINT teammembers_pkey PRIMARY KEY (teamid, userid);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: termsofservice termsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.termsofservice
    ADD CONSTRAINT termsofservice_pkey PRIMARY KEY (id);


--
-- Name: threadmemberships threadmemberships_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.threadmemberships
    ADD CONSTRAINT threadmemberships_pkey PRIMARY KEY (postid, userid);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (postid);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (token);


--
-- Name: trueupreviewhistory trueupreviewhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.trueupreviewhistory
    ADD CONSTRAINT trueupreviewhistory_pkey PRIMARY KEY (duedate);


--
-- Name: focalboard_category_boards unique_user_category_board; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.focalboard_category_boards
    ADD CONSTRAINT unique_user_category_board UNIQUE (user_id, board_id);


--
-- Name: uploadsessions uploadsessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.uploadsessions
    ADD CONSTRAINT uploadsessions_pkey PRIMARY KEY (id);


--
-- Name: useraccesstokens useraccesstokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_pkey PRIMARY KEY (id);


--
-- Name: useraccesstokens useraccesstokens_token_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_token_key UNIQUE (token);


--
-- Name: usergroups usergroups_name_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_name_key UNIQUE (name);


--
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (id);


--
-- Name: usergroups usergroups_source_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_source_remoteid_key UNIQUE (source, remoteid);


--
-- Name: users users_authdata_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_authdata_key UNIQUE (authdata);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: usertermsofservice usertermsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.usertermsofservice
    ADD CONSTRAINT usertermsofservice_pkey PRIMARY KEY (userid);


--
-- Name: idx_audits_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_audits_user_id ON public.audits USING btree (userid);


--
-- Name: idx_blocks_board_id_parent_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_blocks_board_id_parent_id ON public.focalboard_blocks USING btree (board_id, parent_id);


--
-- Name: idx_board_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_board_channel_id ON public.focalboard_boards USING btree (channel_id);


--
-- Name: idx_board_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_board_team_id ON public.focalboard_boards USING btree (team_id, is_template);


--
-- Name: idx_boardmembers_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembers_user_id ON public.focalboard_board_members USING btree (user_id);


--
-- Name: idx_boardmembershistory_board_id_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembershistory_board_id_user_id ON public.focalboard_board_members_history USING btree (board_id, user_id);


--
-- Name: idx_boardmembershistory_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_boardmembershistory_user_id ON public.focalboard_board_members_history USING btree (user_id);


--
-- Name: idx_categories_user_id_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_categories_user_id_team_id ON public.focalboard_categories USING btree (user_id, team_id);


--
-- Name: idx_categoryboards_category_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_categoryboards_category_id ON public.focalboard_category_boards USING btree (category_id);


--
-- Name: idx_channel_search_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channel_search_txt ON public.channels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_channelmembers_channel_id_scheme_guest_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_channel_id_scheme_guest_user_id ON public.channelmembers USING btree (channelid, schemeguest, userid);


--
-- Name: idx_channelmembers_user_id_channel_id_last_viewed_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channelmembers_user_id_channel_id_last_viewed_at ON public.channelmembers USING btree (userid, channelid, lastviewedat);


--
-- Name: idx_channels_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_create_at ON public.channels USING btree (createat);


--
-- Name: idx_channels_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_delete_at ON public.channels USING btree (deleteat);


--
-- Name: idx_channels_displayname_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_displayname_lower ON public.channels USING btree (lower((displayname)::text));


--
-- Name: idx_channels_name_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_name_lower ON public.channels USING btree (lower((name)::text));


--
-- Name: idx_channels_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_scheme_id ON public.channels USING btree (schemeid);


--
-- Name: idx_channels_team_id_display_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_team_id_display_name ON public.channels USING btree (teamid, displayname);


--
-- Name: idx_channels_team_id_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_team_id_type ON public.channels USING btree (teamid, type);


--
-- Name: idx_channels_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_channels_update_at ON public.channels USING btree (updateat);


--
-- Name: idx_command_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_create_at ON public.commands USING btree (createat);


--
-- Name: idx_command_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_delete_at ON public.commands USING btree (deleteat);


--
-- Name: idx_command_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_team_id ON public.commands USING btree (teamid);


--
-- Name: idx_command_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_update_at ON public.commands USING btree (updateat);


--
-- Name: idx_command_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_command_webhook_create_at ON public.commandwebhooks USING btree (createat);


--
-- Name: idx_emoji_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_create_at ON public.emoji USING btree (createat);


--
-- Name: idx_emoji_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_delete_at ON public.emoji USING btree (deleteat);


--
-- Name: idx_emoji_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_emoji_update_at ON public.emoji USING btree (updateat);


--
-- Name: idx_fileinfo_content_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_content_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, content));


--
-- Name: idx_fileinfo_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_create_at ON public.fileinfo USING btree (createat);


--
-- Name: idx_fileinfo_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_delete_at ON public.fileinfo USING btree (deleteat);


--
-- Name: idx_fileinfo_extension_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_extension_at ON public.fileinfo USING btree (extension);


--
-- Name: idx_fileinfo_name_splitted; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_name_splitted ON public.fileinfo USING gin (to_tsvector('english'::regconfig, translate((name)::text, '.,-'::text, '   '::text)));


--
-- Name: idx_fileinfo_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_name_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: idx_fileinfo_postid_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_postid_at ON public.fileinfo USING btree (postid);


--
-- Name: idx_fileinfo_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_fileinfo_update_at ON public.fileinfo USING btree (updateat);


--
-- Name: idx_focalboard_preferences_category; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_focalboard_preferences_category ON public.focalboard_preferences USING btree (category);


--
-- Name: idx_focalboard_preferences_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_focalboard_preferences_name ON public.focalboard_preferences USING btree (name);


--
-- Name: idx_groupchannels_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupchannels_channelid ON public.groupchannels USING btree (channelid);


--
-- Name: idx_groupchannels_schemeadmin; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupchannels_schemeadmin ON public.groupchannels USING btree (schemeadmin);


--
-- Name: idx_groupmembers_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupmembers_create_at ON public.groupmembers USING btree (createat);


--
-- Name: idx_groupteams_schemeadmin; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupteams_schemeadmin ON public.groupteams USING btree (schemeadmin);


--
-- Name: idx_groupteams_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_groupteams_teamid ON public.groupteams USING btree (teamid);


--
-- Name: idx_incoming_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_create_at ON public.incomingwebhooks USING btree (createat);


--
-- Name: idx_incoming_webhook_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_delete_at ON public.incomingwebhooks USING btree (deleteat);


--
-- Name: idx_incoming_webhook_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_team_id ON public.incomingwebhooks USING btree (teamid);


--
-- Name: idx_incoming_webhook_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_update_at ON public.incomingwebhooks USING btree (updateat);


--
-- Name: idx_incoming_webhook_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_incoming_webhook_user_id ON public.incomingwebhooks USING btree (userid);


--
-- Name: idx_jobs_status_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_jobs_status_type ON public.jobs USING btree (status, type);


--
-- Name: idx_jobs_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_jobs_type ON public.jobs USING btree (type);


--
-- Name: idx_link_metadata_url_timestamp; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_link_metadata_url_timestamp ON public.linkmetadata USING btree (url, "timestamp");


--
-- Name: idx_notice_views_notice_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_notice_views_notice_id ON public.productnoticeviewstate USING btree (noticeid);


--
-- Name: idx_notice_views_timestamp; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_notice_views_timestamp ON public.productnoticeviewstate USING btree ("timestamp");


--
-- Name: idx_oauthaccessdata_refresh_token; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthaccessdata_refresh_token ON public.oauthaccessdata USING btree (refreshtoken);


--
-- Name: idx_oauthaccessdata_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthaccessdata_user_id ON public.oauthaccessdata USING btree (userid);


--
-- Name: idx_oauthapps_creator_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_oauthapps_creator_id ON public.oauthapps USING btree (creatorid);


--
-- Name: idx_outgoing_webhook_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_create_at ON public.outgoingwebhooks USING btree (createat);


--
-- Name: idx_outgoing_webhook_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_delete_at ON public.outgoingwebhooks USING btree (deleteat);


--
-- Name: idx_outgoing_webhook_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_team_id ON public.outgoingwebhooks USING btree (teamid);


--
-- Name: idx_outgoing_webhook_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_outgoing_webhook_update_at ON public.outgoingwebhooks USING btree (updateat);


--
-- Name: idx_postreminders_targettime; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_postreminders_targettime ON public.postreminders USING btree (targettime);


--
-- Name: idx_posts_channel_id_delete_at_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_channel_id_delete_at_create_at ON public.posts USING btree (channelid, deleteat, createat);


--
-- Name: idx_posts_channel_id_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_channel_id_update_at ON public.posts USING btree (channelid, updateat);


--
-- Name: idx_posts_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_create_at ON public.posts USING btree (createat);


--
-- Name: idx_posts_create_at_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_create_at_id ON public.posts USING btree (createat, id);


--
-- Name: idx_posts_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_delete_at ON public.posts USING btree (deleteat);


--
-- Name: idx_posts_hashtags_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_hashtags_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (hashtags)::text));


--
-- Name: idx_posts_is_pinned; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_is_pinned ON public.posts USING btree (ispinned);


--
-- Name: idx_posts_message_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_message_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (message)::text));


--
-- Name: idx_posts_original_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_original_id ON public.posts USING btree (originalid);


--
-- Name: idx_posts_root_id_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_root_id_delete_at ON public.posts USING btree (rootid, deleteat);


--
-- Name: idx_posts_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_update_at ON public.posts USING btree (updateat);


--
-- Name: idx_posts_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_posts_user_id ON public.posts USING btree (userid);


--
-- Name: idx_preferences_category; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_preferences_category ON public.preferences USING btree (category);


--
-- Name: idx_preferences_name; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_preferences_name ON public.preferences USING btree (name);


--
-- Name: idx_publicchannels_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_delete_at ON public.publicchannels USING btree (deleteat);


--
-- Name: idx_publicchannels_displayname_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_displayname_lower ON public.publicchannels USING btree (lower((displayname)::text));


--
-- Name: idx_publicchannels_name_lower; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_name_lower ON public.publicchannels USING btree (lower((name)::text));


--
-- Name: idx_publicchannels_search_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_search_txt ON public.publicchannels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_publicchannels_team_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_publicchannels_team_id ON public.publicchannels USING btree (teamid);


--
-- Name: idx_reactions_channel_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_reactions_channel_id ON public.reactions USING btree (channelid);


--
-- Name: idx_retentionpolicies_displayname; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpolicies_displayname ON public.retentionpolicies USING btree (displayname);


--
-- Name: idx_retentionpolicieschannels_policyid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpolicieschannels_policyid ON public.retentionpolicieschannels USING btree (policyid);


--
-- Name: idx_retentionpoliciesteams_policyid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_retentionpoliciesteams_policyid ON public.retentionpoliciesteams USING btree (policyid);


--
-- Name: idx_schemes_channel_admin_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_admin_role ON public.schemes USING btree (defaultchanneladminrole);


--
-- Name: idx_schemes_channel_guest_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_guest_role ON public.schemes USING btree (defaultchannelguestrole);


--
-- Name: idx_schemes_channel_user_role; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_schemes_channel_user_role ON public.schemes USING btree (defaultchanneluserrole);


--
-- Name: idx_sessions_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_create_at ON public.sessions USING btree (createat);


--
-- Name: idx_sessions_expires_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_expires_at ON public.sessions USING btree (expiresat);


--
-- Name: idx_sessions_last_activity_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_last_activity_at ON public.sessions USING btree (lastactivityat);


--
-- Name: idx_sessions_token; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_token ON public.sessions USING btree (token);


--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sessions_user_id ON public.sessions USING btree (userid);


--
-- Name: idx_sharedchannelusers_remote_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sharedchannelusers_remote_id ON public.sharedchannelusers USING btree (remoteid);


--
-- Name: idx_sidebarcategories_userid_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_sidebarcategories_userid_teamid ON public.sidebarcategories USING btree (userid, teamid);


--
-- Name: idx_status_status_dndendtime; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_status_status_dndendtime ON public.status USING btree (status, dndendtime);


--
-- Name: idx_subscriptions_subscriber_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_subscriptions_subscriber_id ON public.focalboard_subscriptions USING btree (subscriber_id);


--
-- Name: idx_teammembers_createat; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_createat ON public.teammembers USING btree (createat);


--
-- Name: idx_teammembers_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_delete_at ON public.teammembers USING btree (deleteat);


--
-- Name: idx_teammembers_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teammembers_user_id ON public.teammembers USING btree (userid);


--
-- Name: idx_teams_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_create_at ON public.teams USING btree (createat);


--
-- Name: idx_teams_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_delete_at ON public.teams USING btree (deleteat);


--
-- Name: idx_teams_invite_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_invite_id ON public.teams USING btree (inviteid);


--
-- Name: idx_teams_scheme_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_scheme_id ON public.teams USING btree (schemeid);


--
-- Name: idx_teams_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_teams_update_at ON public.teams USING btree (updateat);


--
-- Name: idx_thread_memberships_last_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_last_update_at ON public.threadmemberships USING btree (lastupdated);


--
-- Name: idx_thread_memberships_last_view_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_last_view_at ON public.threadmemberships USING btree (lastviewed);


--
-- Name: idx_thread_memberships_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_thread_memberships_user_id ON public.threadmemberships USING btree (userid);


--
-- Name: idx_threads_channel_id_last_reply_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_threads_channel_id_last_reply_at ON public.threads USING btree (channelid, lastreplyat);


--
-- Name: idx_uploadsessions_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_create_at ON public.uploadsessions USING btree (createat);


--
-- Name: idx_uploadsessions_type; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_type ON public.uploadsessions USING btree (type);


--
-- Name: idx_uploadsessions_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_uploadsessions_user_id ON public.uploadsessions USING btree (userid);


--
-- Name: idx_user_access_tokens_user_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_user_access_tokens_user_id ON public.useraccesstokens USING btree (userid);


--
-- Name: idx_usergroups_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_delete_at ON public.usergroups USING btree (deleteat);


--
-- Name: idx_usergroups_displayname; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_displayname ON public.usergroups USING btree (displayname);


--
-- Name: idx_usergroups_remote_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_usergroups_remote_id ON public.usergroups USING btree (remoteid);


--
-- Name: idx_users_all_no_full_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_all_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((username)::text || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_all_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_all_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_create_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_create_at ON public.users USING btree (createat);


--
-- Name: idx_users_delete_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_delete_at ON public.users USING btree (deleteat);


--
-- Name: idx_users_email_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_email_lower_textpattern ON public.users USING btree (lower((email)::text) text_pattern_ops);


--
-- Name: idx_users_firstname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_firstname_lower_textpattern ON public.users USING btree (lower((firstname)::text) text_pattern_ops);


--
-- Name: idx_users_lastname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_lastname_lower_textpattern ON public.users USING btree (lower((lastname)::text) text_pattern_ops);


--
-- Name: idx_users_names_no_full_name_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_names_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((username)::text || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_names_txt; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_names_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_nickname_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_nickname_lower_textpattern ON public.users USING btree (lower((nickname)::text) text_pattern_ops);


--
-- Name: idx_users_update_at; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_update_at ON public.users USING btree (updateat);


--
-- Name: idx_users_username_lower_textpattern; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX idx_users_username_lower_textpattern ON public.users USING btree (lower((username)::text) text_pattern_ops);


--
-- Name: ir_category_item_categoryid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_category_item_categoryid ON public.ir_category_item USING btree (categoryid);


--
-- Name: ir_category_teamid_userid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_category_teamid_userid ON public.ir_category USING btree (teamid, userid);


--
-- Name: ir_channelaction_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_channelaction_channelid ON public.ir_channelaction USING btree (channelid);


--
-- Name: ir_incident_channelid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_channelid ON public.ir_incident USING btree (channelid);


--
-- Name: ir_incident_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_teamid ON public.ir_incident USING btree (teamid);


--
-- Name: ir_incident_teamid_commanderuserid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_incident_teamid_commanderuserid ON public.ir_incident USING btree (teamid, commanderuserid);


--
-- Name: ir_metric_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metric_incidentid ON public.ir_metric USING btree (incidentid);


--
-- Name: ir_metric_metricconfigid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metric_metricconfigid ON public.ir_metric USING btree (metricconfigid);


--
-- Name: ir_metricconfig_playbookid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_metricconfig_playbookid ON public.ir_metricconfig USING btree (playbookid);


--
-- Name: ir_playbook_teamid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbook_teamid ON public.ir_playbook USING btree (teamid);


--
-- Name: ir_playbook_updateat; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbook_updateat ON public.ir_playbook USING btree (updateat);


--
-- Name: ir_playbookmember_memberid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbookmember_memberid ON public.ir_playbookmember USING btree (memberid);


--
-- Name: ir_playbookmember_playbookid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_playbookmember_playbookid ON public.ir_playbookmember USING btree (playbookid);


--
-- Name: ir_run_participants_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_run_participants_incidentid ON public.ir_run_participants USING btree (incidentid);


--
-- Name: ir_run_participants_userid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_run_participants_userid ON public.ir_run_participants USING btree (userid);


--
-- Name: ir_statusposts_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_statusposts_incidentid ON public.ir_statusposts USING btree (incidentid);


--
-- Name: ir_statusposts_postid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_statusposts_postid ON public.ir_statusposts USING btree (postid);


--
-- Name: ir_timelineevent_id; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_timelineevent_id ON public.ir_timelineevent USING btree (id);


--
-- Name: ir_timelineevent_incidentid; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE INDEX ir_timelineevent_incidentid ON public.ir_timelineevent USING btree (incidentid);


--
-- Name: remote_clusters_site_url_unique; Type: INDEX; Schema: public; Owner: mattermost
--

CREATE UNIQUE INDEX remote_clusters_site_url_unique ON public.remoteclusters USING btree (siteurl, remoteteamid);


--
-- Name: retentionpolicieschannels fk_retentionpolicieschannels_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT fk_retentionpolicieschannels_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: retentionpoliciesteams fk_retentionpoliciesteams_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT fk_retentionpoliciesteams_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: ir_category_item ir_category_item_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_category_item
    ADD CONSTRAINT ir_category_item_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.ir_category(id);


--
-- Name: ir_metric ir_metric_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_metric ir_metric_metricconfigid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metric
    ADD CONSTRAINT ir_metric_metricconfigid_fkey FOREIGN KEY (metricconfigid) REFERENCES public.ir_metricconfig(id);


--
-- Name: ir_metricconfig ir_metricconfig_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_metricconfig
    ADD CONSTRAINT ir_metricconfig_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_playbookautofollow ir_playbookautofollow_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookautofollow
    ADD CONSTRAINT ir_playbookautofollow_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_playbookmember ir_playbookmember_playbookid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_playbookmember
    ADD CONSTRAINT ir_playbookmember_playbookid_fkey FOREIGN KEY (playbookid) REFERENCES public.ir_playbook(id);


--
-- Name: ir_run_participants ir_run_participants_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_run_participants
    ADD CONSTRAINT ir_run_participants_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_statusposts ir_statusposts_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_statusposts
    ADD CONSTRAINT ir_statusposts_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- Name: ir_timelineevent ir_timelineevent_incidentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mattermost
--

ALTER TABLE ONLY public.ir_timelineevent
    ADD CONSTRAINT ir_timelineevent_incidentid_fkey FOREIGN KEY (incidentid) REFERENCES public.ir_incident(id);


--
-- PostgreSQL database dump complete
--

