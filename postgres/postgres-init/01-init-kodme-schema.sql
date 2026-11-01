--
-- PostgreSQL database dump
--

\restrict n0GOcOUv9GKoFZT0tAEd8x826qiL17mI1bIoH7wXHNGLaEUDdi81FSOJSIxdzQ4

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-10 15:39:57 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.user_totp DROP CONSTRAINT IF EXISTS user_totp_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.user_passkeys DROP CONSTRAINT IF EXISTS user_passkeys_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_foreign_role_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_foreign_avatar_document_id;
ALTER TABLE IF EXISTS ONLY public.themes DROP CONSTRAINT IF EXISTS themes_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks_members DROP CONSTRAINT IF EXISTS stickerpaks_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks_members DROP CONSTRAINT IF EXISTS stickerpaks_members_foreign_stickerpak_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks DROP CONSTRAINT IF EXISTS stickerpacks_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.reactions DROP CONSTRAINT IF EXISTS reactions_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_sticker_document_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_reply_to_message_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_forwarded_to_message_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_foreign_message_id;
ALTER TABLE IF EXISTS ONLY public.meets_members DROP CONSTRAINT IF EXISTS meets_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.meets_members DROP CONSTRAINT IF EXISTS meets_members_foreign_meet_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_thumbnail_document_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_chat_channel_id;
ALTER TABLE IF EXISTS ONLY public.main_folders DROP CONSTRAINT IF EXISTS main_folders_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_foreign_folder_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_foreign_storage_id;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_foreign_contact_user_id;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_foreign_last_viewed_comment_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_sticker_document_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_reply_to_comment_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_foreign_owner_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_foreign_item_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_foreign_link_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_foreign_link_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_parent_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_owner_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_document_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_foreign_last_viewed_message_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_foreign_last_accessed_message_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_topic_for_group_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_group_for_channel_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_avatar_document_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_created_user_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_foreign_call_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_foreign_created_user_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts_members DROP CONSTRAINT IF EXISTS broadcasts_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts_members DROP CONSTRAINT IF EXISTS broadcasts_members_foreign_cast_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_foreign_thumbnail_document_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_foreign_chat_channel_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_created_user_id;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_foreign_document_id;
DROP INDEX IF EXISTS public.idx_user_passkeys_user;
DROP INDEX IF EXISTS public.fki_user_totp_foreign_user_id;
DROP INDEX IF EXISTS public.fki_user_passkeys_foreign_user_id;
DROP INDEX IF EXISTS public.idx_reactions_entity;
DROP INDEX IF EXISTS public.idx_messages_deleted_user_message;
DROP INDEX IF EXISTS public.idx_messages_deleted_message_user;
DROP INDEX IF EXISTS public.idx_media_processing_queue_status;
DROP INDEX IF EXISTS public.idx_comments_members_entity;
DROP INDEX IF EXISTS public.idx_comments_entity;
DROP INDEX IF EXISTS public.idx_cloud_share_links_owner_item;
DROP INDEX IF EXISTS public.idx_cloud_share_link_saved_user_link;
DROP INDEX IF EXISTS public.idx_cloud_share_link_members_link_user;
DROP INDEX IF EXISTS public.idx_cloud_items_owner_parent_deleted;
DROP INDEX IF EXISTS public.idx_channels_members_user_channel_subscribed;
DROP INDEX IF EXISTS public.idx_channels_members_channel_user;
DROP INDEX IF EXISTS public.idx_calls_members_call;
DROP INDEX IF EXISTS public.idx_calls_members_active_user;
DROP INDEX IF EXISTS public.idx_calls_active_channel;
DROP INDEX IF EXISTS public.idx_attachments_entity;
DROP INDEX IF EXISTS public.idx_attachments_context_type_id;
DROP INDEX IF EXISTS public.idx_attachments_cloud_context;
DROP INDEX IF EXISTS public.fki_users_foreign_role_id;
DROP INDEX IF EXISTS public.fki_users_foreign_avatar_document_id;
DROP INDEX IF EXISTS public.fki_themes_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_stickerpacks_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_reactions_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_photoalbums_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_messages_foreign_sticker_document_id;
DROP INDEX IF EXISTS public.fki_messages_foreign_reply_to_mesage_id;
DROP INDEX IF EXISTS public.fki_messages_foreign_forwarded_to_message_id;
DROP INDEX IF EXISTS public.fki_messages_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_messages_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_messages_deleted_foreign_user_id;
DROP INDEX IF EXISTS public.fki_messages_deleted_foreign_message_id;
DROP INDEX IF EXISTS public.fki_meets_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_meets_members_foreign_meet_id;
DROP INDEX IF EXISTS public.fki_meets_members_foreign_invite_id;
DROP INDEX IF EXISTS public.fki_meets_foreign_thumbnail_document_id;
DROP INDEX IF EXISTS public.fki_meets_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_meets_foreign_chat_channel_id;
DROP INDEX IF EXISTS public.fki_main_folders_foreign_user_id;
DROP INDEX IF EXISTS public.fki_main_folders_channels_foreign_folder_id;
DROP INDEX IF EXISTS public.fki_main_folders_channels_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_invites_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_documents_foreign_storage_id;
DROP INDEX IF EXISTS public.fki_documents_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_contacts_foreign_user_id;
DROP INDEX IF EXISTS public.fki_contacts_foreign_contact_user_id;
DROP INDEX IF EXISTS public.fki_comments_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_comments_members_foreign_last_viewed_comment_id;
DROP INDEX IF EXISTS public.fki_comments_foreign_sticker_document_id;
DROP INDEX IF EXISTS public.fki_comments_foreign_reply_to_comment_id;
DROP INDEX IF EXISTS public.fki_comments_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_cloud_share_links_foreign_owner_user_id;
DROP INDEX IF EXISTS public.fki_cloud_share_links_foreign_item_id;
DROP INDEX IF EXISTS public.fki_cloud_share_link_saved_foreign_user_id;
DROP INDEX IF EXISTS public.fki_cloud_share_link_saved_foreign_link_id;
DROP INDEX IF EXISTS public.fki_cloud_share_link_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_cloud_share_link_members_foreign_link_id;
DROP INDEX IF EXISTS public.fki_cloud_items_foreign_parent_id;
DROP INDEX IF EXISTS public.fki_cloud_items_foreign_owner_user_id;
DROP INDEX IF EXISTS public.fki_cloud_items_foreign_document_id;
DROP INDEX IF EXISTS public.fki_channels_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_channels_members_foreign_last_viewed_message_id;
DROP INDEX IF EXISTS public.fki_channels_members_foreign_last_accessed_message_id;
DROP INDEX IF EXISTS public.fki_channels_members_foreign_invite_id;
DROP INDEX IF EXISTS public.fki_channels_members_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_channels_foreign_topic_for_group_id;
DROP INDEX IF EXISTS public.fki_channels_foreign_group_for_channel_id;
DROP INDEX IF EXISTS public.fki_channels_foreign_avatar_document_id;
DROP INDEX IF EXISTS public.fki_channels_created_user_id;
DROP INDEX IF EXISTS public.fki_calls_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_calls_members_foreign_call_id;
DROP INDEX IF EXISTS public.fki_calls_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_calls_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_broadcasts_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_broadcasts_members_foreign_invite_id;
DROP INDEX IF EXISTS public.fki_broadcasts_members_foreign_cast_id;
DROP INDEX IF EXISTS public.fki_broadcasts_foreign_thumbnail_document_id;
DROP INDEX IF EXISTS public.fki_broadcasts_foreign_chat_channel_id;
DROP INDEX IF EXISTS public.fki_broadcasts_created_user_id;
DROP INDEX IF EXISTS public.fki_attaches_foreign_document_id;
DROP INDEX IF EXISTS public.cloud_items_unique_folder_name;
ALTER TABLE IF EXISTS ONLY public.user_totp DROP CONSTRAINT IF EXISTS user_totp_primary_id;
ALTER TABLE IF EXISTS ONLY public.user_passkeys DROP CONSTRAINT IF EXISTS user_passkeys_primary_credential_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_primary_id;
ALTER TABLE IF EXISTS ONLY public._user_roles DROP CONSTRAINT IF EXISTS user_roles_primary_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS unique_bot_token;
ALTER TABLE IF EXISTS ONLY public.themes DROP CONSTRAINT IF EXISTS themes_primary_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks_members DROP CONSTRAINT IF EXISTS stickerpaks_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks_members DROP CONSTRAINT IF EXISTS stickerpaks_members_unique_user_id_and_stickerpak_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks DROP CONSTRAINT IF EXISTS stickerpacks_primary_id;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_unique_token;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_primary_id;
ALTER TABLE IF EXISTS ONLY public.reactions DROP CONSTRAINT IF EXISTS reactions_primary_id;
ALTER TABLE IF EXISTS ONLY public.push_notifications DROP CONSTRAINT IF EXISTS push_notifications_primary_id;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_unique_owner_id__owner_type__type;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_primary_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_primary_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_primary_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_primary_id;
ALTER TABLE IF EXISTS ONLY public.meets_members DROP CONSTRAINT IF EXISTS meets_members_unique_user_id_and_meet_id;
ALTER TABLE IF EXISTS ONLY public.meets_members DROP CONSTRAINT IF EXISTS meets_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.media_processing_queue DROP CONSTRAINT IF EXISTS media_processing_queue_primary_document_id;
ALTER TABLE IF EXISTS ONLY public.main_folders DROP CONSTRAINT IF EXISTS main_folders_primary_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_unique_channel_id_folder_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_primary_id;
ALTER TABLE IF EXISTS ONLY public.links DROP CONSTRAINT IF EXISTS links_unique_link;
ALTER TABLE IF EXISTS ONLY public.links DROP CONSTRAINT IF EXISTS links_unique_entity_id;
ALTER TABLE IF EXISTS ONLY public.links DROP CONSTRAINT IF EXISTS links_primary_id;
ALTER TABLE IF EXISTS ONLY public.invites DROP CONSTRAINT IF EXISTS invites_unique_link;
ALTER TABLE IF EXISTS ONLY public.invites DROP CONSTRAINT IF EXISTS invites_primary_id;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_primary_id;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_primary_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_primary_id;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_unique_user_id_and_entity;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_unique_link;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_primary_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_unique_user_link;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_primary_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_unique_link_user;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_primary_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_primary_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_unique_user_id_and_channel_id;
ALTER TABLE IF EXISTS ONLY public.channels_members DROP CONSTRAINT IF EXISTS channels_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_primary_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_unique_call_id_and_user_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_primary_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts_members DROP CONSTRAINT IF EXISTS broadcasts_members_unique_user_id_and_cast_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts_members DROP CONSTRAINT IF EXISTS broadcasts_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_unique_document_id__entity_id__entity_type;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_primary_id;
ALTER TABLE IF EXISTS ONLY public._storages DROP CONSTRAINT IF EXISTS _storages_unique_host_url;
ALTER TABLE IF EXISTS ONLY public._storages DROP CONSTRAINT IF EXISTS _storages_primary_id;
DROP TABLE IF EXISTS public.user_totp;
DROP TABLE IF EXISTS public.user_passkeys;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.themes;
DROP TABLE IF EXISTS public.stickerpaks_members;
DROP TABLE IF EXISTS public.stickerpaks;
DROP TABLE IF EXISTS public.sessions;
DROP TABLE IF EXISTS public.reactions;
DROP TABLE IF EXISTS public.push_notifications;
DROP TABLE IF EXISTS public.photoalbums;
DROP TABLE IF EXISTS public.messages_deleted;
DROP TABLE IF EXISTS public.messages;
DROP TABLE IF EXISTS public.meets_members;
DROP TABLE IF EXISTS public.meets;
DROP TABLE IF EXISTS public.media_processing_queue;
DROP TABLE IF EXISTS public.main_folders_channels;
DROP TABLE IF EXISTS public.main_folders;
DROP TABLE IF EXISTS public.links;
DROP TABLE IF EXISTS public.invites;
DROP TABLE IF EXISTS public.documents;
DROP TABLE IF EXISTS public.contacts;
DROP TABLE IF EXISTS public.comments_members;
DROP TABLE IF EXISTS public.comments;
DROP TABLE IF EXISTS public.cloud_share_links;
DROP TABLE IF EXISTS public.cloud_share_link_saved;
DROP TABLE IF EXISTS public.cloud_share_link_members;
DROP TABLE IF EXISTS public.cloud_items;
DROP TABLE IF EXISTS public.channels_members;
DROP TABLE IF EXISTS public.channels;
DROP TABLE IF EXISTS public.calls_members;
DROP TABLE IF EXISTS public.calls;
DROP TABLE IF EXISTS public.broadcasts_members;
DROP TABLE IF EXISTS public.broadcasts;
DROP TABLE IF EXISTS public.bots_apps;
DROP TABLE IF EXISTS public.attachments;
DROP TABLE IF EXISTS public._user_roles;
DROP TABLE IF EXISTS public._storages;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 5 (class 2615 OID 16385)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16386)
-- Name: _storages; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._storages (
    id uuid NOT NULL,
    name character varying NOT NULL,
    about character varying,
    host_url character varying CONSTRAINT _storages_host_not_null NOT NULL,
    created_at timestamp without time zone CONSTRAINT _storages_date_created_not_null NOT NULL,
    is_enabled boolean DEFAULT false CONSTRAINT _storages_enabled_not_null NOT NULL
);


ALTER TABLE public._storages OWNER TO kodme;

--
-- TOC entry 220 (class 1259 OID 16397)
-- Name: _user_roles; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._user_roles (
    id uuid CONSTRAINT user_roles_id_not_null NOT NULL,
    roles jsonb CONSTRAINT user_roles_roles_not_null NOT NULL,
    is_blocked boolean DEFAULT false CONSTRAINT user_roles_blocked_not_null NOT NULL,
    name character varying(125) CONSTRAINT user_roles_name_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT user_roles_deleted_not_null NOT NULL,
    about character varying(255)
);


ALTER TABLE public._user_roles OWNER TO kodme;

--
-- TOC entry 221 (class 1259 OID 16409)
-- Name: attachments; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.attachments (
    id uuid CONSTRAINT attaches_id_not_null NOT NULL,
    document_id uuid CONSTRAINT attaches_for_document_id_not_null NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    entity_context jsonb DEFAULT '{}'::jsonb CONSTRAINT attachments_context_not_null NOT NULL
);


ALTER TABLE public.attachments OWNER TO kodme;

--
-- TOC entry 222 (class 1259 OID 16420)
-- Name: bots_apps; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.bots_apps (
    id uuid NOT NULL,
    bot_id uuid NOT NULL,
    url character varying NOT NULL,
    name character varying NOT NULL,
    link character varying,
    about character varying,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.bots_apps OWNER TO kodme;

--
-- TOC entry 223 (class 1259 OID 16430)
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.broadcasts (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    name character varying(128) NOT NULL,
    about character varying(255),
    is_public boolean DEFAULT true CONSTRAINT broadcasts_public_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT broadcasts_date_created_not_null NOT NULL,
    chat_channel_id uuid,
    is_chat boolean DEFAULT true CONSTRAINT broadcasts_chat_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT broadcasts_deleted_not_null NOT NULL,
    thumbnail_document_id uuid,
    rtmp_ingress_id character varying,
    rtmp_ingress_key character varying,
    whip_ingress_id character varying,
    whip_ingress_key character varying
);


ALTER TABLE public.broadcasts OWNER TO kodme;

--
-- TOC entry 224 (class 1259 OID 16445)
-- Name: broadcasts_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.broadcasts_members (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    cast_id uuid NOT NULL,
    subscribed_at timestamp with time zone NOT NULL,
    is_subscribed boolean DEFAULT false NOT NULL,
    is_notifications boolean DEFAULT false NOT NULL,
    invite_id uuid
);


ALTER TABLE public.broadcasts_members OWNER TO kodme;

--
-- TOC entry 250 (class 1259 OID 24613)
-- Name: calls; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.calls (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    channel_id uuid,
    status character varying DEFAULT 'ringing'::character varying NOT NULL,
    started_at timestamp with time zone NOT NULL,
    accepted_at timestamp with time zone,
    ended_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.calls OWNER TO kodme;

--
-- TOC entry 251 (class 1259 OID 24640)
-- Name: calls_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.calls_members (
    id uuid NOT NULL,
    call_id uuid NOT NULL,
    user_id uuid NOT NULL,
    invited_at timestamp with time zone NOT NULL,
    joined_at timestamp with time zone,
    left_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.calls_members OWNER TO kodme;

--
-- TOC entry 225 (class 1259 OID 16456)
-- Name: channels; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.channels (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    name character varying(128),
    type integer DEFAULT 1 NOT NULL,
    about character varying(255),
    group_for_channel_id uuid,
    topic_for_group_id uuid,
    is_public boolean DEFAULT true CONSTRAINT channels_public_not_null NOT NULL,
    is_posting boolean DEFAULT false CONSTRAINT channels_posting_not_null NOT NULL,
    is_commenting boolean DEFAULT false CONSTRAINT channels_commenting_not_null NOT NULL,
    working_hours jsonb,
    created_at timestamp with time zone CONSTRAINT channels_date_created_not_null NOT NULL,
    is_blocked boolean DEFAULT false CONSTRAINT channels_blocked_not_null NOT NULL,
    locations jsonb,
    avatar_document_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT channels_deleted_not_null NOT NULL,
    last_pts bigint DEFAULT 0,
    can_forward_messages boolean DEFAULT true NOT NULL
);


ALTER TABLE public.channels OWNER TO kodme;

--
-- TOC entry 226 (class 1259 OID 16479)
-- Name: channels_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.channels_members (
    id uuid CONSTRAINT subscribers_id_not_null NOT NULL,
    user_id uuid CONSTRAINT subscribers_for_user_id_not_null NOT NULL,
    channel_id uuid,
    subscribed_at timestamp with time zone CONSTRAINT subscribers_date_subscribed_not_null NOT NULL,
    last_viewed_message_id uuid,
    last_accessed_message_id uuid,
    is_access boolean DEFAULT true CONSTRAINT subscribers_access_not_null NOT NULL,
    is_blocked boolean DEFAULT false CONSTRAINT subscribers_blocked_not_null NOT NULL,
    is_subscribed boolean DEFAULT false CONSTRAINT subscribers_subscribed_not_null NOT NULL,
    is_notifications boolean DEFAULT true CONSTRAINT subscribers_notifications_not_null NOT NULL,
    invite_id uuid,
    can_deleted_message boolean,
    can_clean_messages boolean,
    is_moderator boolean,
    can_restrict_members boolean,
    can_invite_users boolean,
    can_pin_messages boolean
);


ALTER TABLE public.channels_members OWNER TO kodme;

--
-- TOC entry 227 (class 1259 OID 16493)
-- Name: cloud_items; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.cloud_items (
    id uuid NOT NULL,
    owner_user_id uuid NOT NULL,
    parent_id uuid,
    item_type character varying(16) CONSTRAINT cloud_items_type_not_null NOT NULL,
    name character varying(255) NOT NULL,
    document_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT cloud_items_deleted_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT cloud_items_date_created_not_null NOT NULL,
    CONSTRAINT cloud_items_document_rule CHECK (((((item_type)::text = ('folder'::character varying)::text) AND (document_id IS NULL)) OR (((item_type)::text = ('file'::character varying)::text) AND (document_id IS NOT NULL)))),
    CONSTRAINT cloud_items_type_valid CHECK (((item_type)::text = ANY (ARRAY[('folder'::character varying)::text, ('file'::character varying)::text])))
);


ALTER TABLE public.cloud_items OWNER TO kodme;

--
-- TOC entry 228 (class 1259 OID 16505)
-- Name: cloud_share_link_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.cloud_share_link_members (
    id uuid NOT NULL,
    link_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone CONSTRAINT cloud_share_link_members_date_created_not_null NOT NULL
);


ALTER TABLE public.cloud_share_link_members OWNER TO kodme;

--
-- TOC entry 229 (class 1259 OID 16512)
-- Name: cloud_share_link_saved; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.cloud_share_link_saved (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    link_id uuid NOT NULL,
    opened_at timestamp with time zone CONSTRAINT cloud_share_link_saved_date_opened_not_null NOT NULL
);


ALTER TABLE public.cloud_share_link_saved OWNER TO kodme;

--
-- TOC entry 230 (class 1259 OID 16519)
-- Name: cloud_share_links; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.cloud_share_links (
    id uuid NOT NULL,
    owner_user_id uuid NOT NULL,
    item_id uuid NOT NULL,
    link character varying(64) NOT NULL,
    access_level character varying(16) DEFAULT 'read'::character varying CONSTRAINT cloud_share_links_access_not_null NOT NULL,
    expires_at timestamp with time zone,
    is_deleted boolean DEFAULT false CONSTRAINT cloud_share_links_deleted_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT cloud_share_links_date_created_not_null NOT NULL,
    CONSTRAINT cloud_share_links_access_valid CHECK (((access_level)::text = ANY (ARRAY[('read'::character varying)::text, ('write'::character varying)::text])))
);


ALTER TABLE public.cloud_share_links OWNER TO kodme;

--
-- TOC entry 231 (class 1259 OID 16532)
-- Name: comments; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.comments (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    text character varying(4096) NOT NULL,
    reply_to_comment_id uuid,
    created_at timestamp with time zone CONSTRAINT comments_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_deleted boolean DEFAULT false CONSTRAINT comments_deleted_not_null NOT NULL,
    sticker_document_id uuid,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL
);


ALTER TABLE public.comments OWNER TO kodme;

--
-- TOC entry 232 (class 1259 OID 16545)
-- Name: comments_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.comments_members (
    id uuid NOT NULL,
    user_id uuid CONSTRAINT comments_members_for_user_id_not_null NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    last_viewed_comment_id uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comments_members OWNER TO kodme;

--
-- TOC entry 233 (class 1259 OID 16556)
-- Name: contacts; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.contacts (
    id uuid NOT NULL,
    user_id uuid CONSTRAINT contacts_for_user_id_not_null NOT NULL,
    contact_user_id uuid CONSTRAINT contacts_target_user_id_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT contacts_date_created_not_null NOT NULL,
    is_blocked boolean DEFAULT false CONSTRAINT contacts_blocked_not_null NOT NULL
);


ALTER TABLE public.contacts OWNER TO kodme;

--
-- TOC entry 234 (class 1259 OID 16565)
-- Name: documents; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.documents (
    id uuid NOT NULL,
    file_name character varying,
    size bigint,
    mime_type character varying,
    created_user_id uuid,
    created_at timestamp with time zone CONSTRAINT documents_date_created_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT documents_deleted_not_null NOT NULL,
    extname character varying,
    storage_id uuid,
    metadata jsonb
);


ALTER TABLE public.documents OWNER TO kodme;

--
-- TOC entry 235 (class 1259 OID 16575)
-- Name: invites; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.invites (
    id uuid NOT NULL,
    link character varying NOT NULL,
    name character varying(64) NOT NULL,
    created_at timestamp with time zone CONSTRAINT invites_date_created_not_null NOT NULL,
    expires_at date,
    is_deleted boolean DEFAULT false CONSTRAINT invites_deleted_not_null NOT NULL,
    created_user_id uuid NOT NULL,
    max_users integer DEFAULT 0 CONSTRAINT invites_max_uses_not_null NOT NULL,
    count_uses integer DEFAULT 0 NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL
);


ALTER TABLE public.invites OWNER TO kodme;

--
-- TOC entry 236 (class 1259 OID 16593)
-- Name: links; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.links (
    id uuid NOT NULL,
    link character varying(32) NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL
);


ALTER TABLE public.links OWNER TO kodme;

--
-- TOC entry 237 (class 1259 OID 16602)
-- Name: main_folders; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.main_folders (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.main_folders OWNER TO kodme;

--
-- TOC entry 238 (class 1259 OID 16608)
-- Name: main_folders_channels; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.main_folders_channels (
    id uuid NOT NULL,
    folder_id uuid NOT NULL,
    channel_id uuid NOT NULL
);


ALTER TABLE public.main_folders_channels OWNER TO kodme;

--
-- Name: media_processing_queue; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.media_processing_queue (
    document_id uuid CONSTRAINT media_processing_queue_document_id_not_null NOT NULL,
    status character varying DEFAULT 'pending' CONSTRAINT media_processing_queue_status_not_null NOT NULL,
    attempts integer DEFAULT 0 CONSTRAINT media_processing_queue_attempts_not_null NOT NULL,
    error_code character varying,
    error_detail text,
    payload jsonb CONSTRAINT media_processing_queue_payload_not_null NOT NULL,
    metadata jsonb,
    worker_id character varying,
    lease_until timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT media_processing_queue_date_created_not_null NOT NULL,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    CONSTRAINT media_processing_queue_status_valid CHECK ((status = ANY (ARRAY['pending'::character varying, 'processing'::character varying, 'done'::character varying, 'failed'::character varying])))
);


ALTER TABLE public.media_processing_queue OWNER TO kodme;

--
-- TOC entry 239 (class 1259 OID 16614)
-- Name: meets; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.meets (
    id uuid CONSTRAINT conferences_id_not_null NOT NULL,
    created_user_id uuid CONSTRAINT conferences_created_user_id_not_null NOT NULL,
    name character varying(128) CONSTRAINT conferences_name_not_null NOT NULL,
    about character varying(255),
    is_public boolean DEFAULT true CONSTRAINT conferences_public_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT conferences_date_created_not_null NOT NULL,
    chat_channel_id uuid,
    is_chat boolean DEFAULT true CONSTRAINT conferences_chat_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT conferences_deleted_not_null NOT NULL,
    thumbnail_document_id uuid
);


ALTER TABLE public.meets OWNER TO kodme;

--
-- TOC entry 240 (class 1259 OID 16627)
-- Name: meets_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.meets_members (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    meet_id uuid NOT NULL,
    subscribed_at timestamp with time zone NOT NULL,
    is_subscribed boolean DEFAULT false NOT NULL,
    is_notifications boolean DEFAULT false NOT NULL,
    invite_id uuid
);


ALTER TABLE public.meets_members OWNER TO kodme;

--
-- TOC entry 241 (class 1259 OID 16638)
-- Name: messages; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.messages (
    id uuid CONSTRAINT posts_id_not_null NOT NULL,
    created_user_id uuid,
    channel_id uuid,
    text character varying(4096),
    reply_to_message_id uuid,
    created_at timestamp with time zone CONSTRAINT posts_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_pinned boolean DEFAULT false CONSTRAINT posts_pinned_not_null NOT NULL,
    is_commenting boolean DEFAULT false CONSTRAINT posts_commenting_not_null NOT NULL,
    sticker_document_id uuid,
    buttons jsonb,
    forwarded_to_message_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT posts_deleted_not_null NOT NULL,
    entities jsonb DEFAULT '[]'::jsonb CONSTRAINT posts_entities_not_null NOT NULL,
    pts bigint DEFAULT 0,
    action_type character varying,
    action_payload jsonb
);


ALTER TABLE public.messages OWNER TO kodme;

--
-- TOC entry 242 (class 1259 OID 16654)
-- Name: messages_deleted; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.messages_deleted (
    id uuid CONSTRAINT posts_deleted_id_not_null NOT NULL,
    message_id uuid CONSTRAINT posts_deleted_for_post_id_not_null NOT NULL,
    user_id uuid CONSTRAINT posts_deleted_for_user_id_not_null NOT NULL,
    deleted_at timestamp with time zone CONSTRAINT posts_deleted_date_deleted_not_null NOT NULL,
    pts bigint
);


ALTER TABLE public.messages_deleted OWNER TO kodme;

--
-- TOC entry 243 (class 1259 OID 16661)
-- Name: photoalbums; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.photoalbums (
    id uuid NOT NULL,
    name character varying(64) NOT NULL,
    created_user_id uuid NOT NULL,
    created_at timestamp with time zone CONSTRAINT photoalbums_date_created_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT photoalbums_deleted_not_null NOT NULL,
    is_public boolean DEFAULT true CONSTRAINT photoalbums_public_not_null NOT NULL,
    about character varying(255),
    entity_type character varying CONSTRAINT photoalbums_owner_type_not_null NOT NULL,
    entity_id uuid CONSTRAINT photoalbums_awner_id_not_null NOT NULL,
    type character varying
);


ALTER TABLE public.photoalbums OWNER TO kodme;

--
-- TOC entry 244 (class 1259 OID 16676)
-- Name: push_notifications; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.push_notifications (
    id uuid NOT NULL,
    user_id uuid CONSTRAINT push_notifications_for_user_id_not_null NOT NULL,
    session_id uuid CONSTRAINT push_notifications_for_session_id_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT push_notifications_date_created_not_null NOT NULL,
    data jsonb
);


ALTER TABLE public.push_notifications OWNER TO kodme;

--
-- TOC entry 245 (class 1259 OID 16685)
-- Name: reactions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.reactions (
    created_user_id uuid NOT NULL,
    reaction character varying NOT NULL,
    created_at timestamp with time zone CONSTRAINT reactions_date_created_not_null NOT NULL,
    id uuid NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL
);


ALTER TABLE public.reactions OWNER TO kodme;

--
-- TOC entry 246 (class 1259 OID 16696)
-- Name: sessions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.sessions (
    id uuid NOT NULL,
    user_id uuid CONSTRAINT sessions_for_user_id_not_null NOT NULL,
    token character(128),
    platform character varying,
    confirm_code text,
    confirm_code_created_at timestamp with time zone,
    last_login_at timestamp with time zone,
    is_blocked boolean DEFAULT false CONSTRAINT sessions_blocked_not_null NOT NULL,
    secret_key jsonb,
    last_action_at timestamp with time zone,
    user_agent character varying,
    web_push json,
    fcm_push character varying,
    hms_push character varying,
    confirm_code_attempts integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sessions OWNER TO kodme;

--
-- TOC entry 247 (class 1259 OID 16707)
-- Name: stickerpaks; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.stickerpaks (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    name character varying(64) NOT NULL,
    created_at timestamp with time zone CONSTRAINT stickerpaks_date_created_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT stickerpaks_deleted_not_null NOT NULL,
    about character varying(255),
    is_public boolean DEFAULT true CONSTRAINT stickerpaks_public_not_null NOT NULL
);


ALTER TABLE public.stickerpaks OWNER TO kodme;

--
-- TOC entry 3876 (class 1259 OID 24668)
-- Name: stickerpaks_members; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.stickerpaks_members (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    stickerpak_id uuid NOT NULL,
    subscribed_at timestamp with time zone CONSTRAINT stickerpaks_members_subscribed_at_not_null NOT NULL
);


ALTER TABLE public.stickerpaks_members OWNER TO kodme;

--
-- TOC entry 248 (class 1259 OID 16718)
-- Name: themes; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.themes (
    id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    name character varying(64) NOT NULL,
    style text NOT NULL,
    is_public boolean DEFAULT true CONSTRAINT themes_public_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT themes_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_deleted boolean DEFAULT false CONSTRAINT themes_deleted_not_null NOT NULL
);


ALTER TABLE public.themes OWNER TO kodme;

--
-- TOC entry 3891 (class 1259 OID 24700)
-- Name: user_passkeys; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.user_passkeys (
    credential_id text CONSTRAINT user_passkeys_credential_id_not_null NOT NULL,
    user_id uuid CONSTRAINT user_passkeys_for_user_id_not_null NOT NULL,
    name character varying(64) CONSTRAINT user_passkeys_name_not_null NOT NULL,
    public_key bytea CONSTRAINT user_passkeys_public_key_not_null NOT NULL,
    sign_count bigint DEFAULT 0 CONSTRAINT user_passkeys_sign_count_not_null NOT NULL,
    transports jsonb,
    created_at timestamp with time zone CONSTRAINT user_passkeys_date_created_not_null NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE public.user_passkeys OWNER TO kodme;

--
-- TOC entry 3892 (class 1259 OID 24710)
-- Name: user_totp; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.user_totp (
    user_id uuid CONSTRAINT user_totp_for_user_id_not_null NOT NULL,
    secret character varying(64) CONSTRAINT user_totp_secret_not_null NOT NULL,
    is_confirmed boolean DEFAULT false CONSTRAINT user_totp_confirmed_not_null NOT NULL,
    last_counter bigint DEFAULT 0 CONSTRAINT user_totp_last_counter_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT user_totp_date_created_not_null NOT NULL,
    confirmed_at timestamp with time zone
);


ALTER TABLE public.user_totp OWNER TO kodme;

--
-- TOC entry 249 (class 1259 OID 16732)
-- Name: users; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    first_name character varying(64),
    last_name character varying(64),
    bio character varying(140),
    created_at timestamp with time zone CONSTRAINT users_date_created_not_null NOT NULL,
    hash_password text,
    salt character(21),
    date_birth_day timestamp with time zone,
    is_blocked boolean DEFAULT false CONSTRAINT users_blocked_not_null NOT NULL,
    unblocked_at timestamp with time zone,
    email character varying(125),
    broadcast_token uuid,
    role_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT users_deleted_not_null NOT NULL,
    is_bot boolean DEFAULT false NOT NULL,
    bot_created_user_id uuid,
    bot_token character(128),
    bot_commands jsonb,
    restore_confirm_code character(4),
    avatar_document_id uuid,
    blocked_at timestamp with time zone,
    privacy_messages character varying DEFAULT 'all'::character varying NOT NULL,
    privacy_calls character varying DEFAULT 'all'::character varying NOT NULL,
    privacy_messages_voice character varying DEFAULT 'all'::character varying NOT NULL,
    privacy_sharing_files character varying DEFAULT 'all'::character varying NOT NULL,
    privacy_search_users character varying DEFAULT 'all'::character varying NOT NULL,
    notify_action_accounts boolean DEFAULT true NOT NULL,
    notify_calls boolean DEFAULT true NOT NULL,
    notify_messages boolean DEFAULT true NOT NULL,
    notify_comments boolean DEFAULT true NOT NULL,
    notify_reply_message boolean DEFAULT true NOT NULL,
    restore_confirm_code_hash text,
    code_confirm_created_at timestamp with time zone,
    code_confirm_attempts integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO kodme;

--
-- TOC entry 3488 (class 2606 OID 16772)
-- Name: _storages _storages_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._storages
    ADD CONSTRAINT _storages_primary_id PRIMARY KEY (id);


--
-- TOC entry 3490 (class 2606 OID 16774)
-- Name: _storages _storages_unique_host_url; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._storages
    ADD CONSTRAINT _storages_unique_host_url UNIQUE (host_url);


--
-- TOC entry 3494 (class 2606 OID 16776)
-- Name: attachments attachments_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_primary_id PRIMARY KEY (id);


--
-- TOC entry 3496 (class 2606 OID 16778)
-- Name: attachments attachments_unique_document_id__entity_id__entity_type; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_unique_document_id__entity_id__entity_type UNIQUE (document_id, entity_id, entity_type);


--
-- TOC entry 3507 (class 2606 OID 16780)
-- Name: broadcasts_members broadcasts_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts_members
    ADD CONSTRAINT broadcasts_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3509 (class 2606 OID 16782)
-- Name: broadcasts_members broadcasts_members_unique_user_id_and_cast_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts_members
    ADD CONSTRAINT broadcasts_members_unique_user_id_and_cast_id UNIQUE (user_id, cast_id);


--
-- TOC entry 3502 (class 2606 OID 16784)
-- Name: broadcasts broadcasts_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_primary_id PRIMARY KEY (id);


--
-- TOC entry 3657 (class 2606 OID 24650)
-- Name: calls_members calls_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3659 (class 2606 OID 24652)
-- Name: calls_members calls_members_unique_call_id_and_user_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_unique_call_id_and_user_id UNIQUE (call_id, user_id);


--
-- TOC entry 3652 (class 2606 OID 24626)
-- Name: calls calls_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_primary_id PRIMARY KEY (id);


--
-- TOC entry 3520 (class 2606 OID 16786)
-- Name: channels_members channels_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3522 (class 2606 OID 16788)
-- Name: channels_members channels_members_unique_user_id_and_channel_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_unique_user_id_and_channel_id UNIQUE (user_id, channel_id);


--
-- TOC entry 3514 (class 2606 OID 16790)
-- Name: channels channels_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_primary_id PRIMARY KEY (id);


--
-- TOC entry 3531 (class 2606 OID 16792)
-- Name: cloud_items cloud_items_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_primary_id PRIMARY KEY (id);


--
-- TOC entry 3538 (class 2606 OID 16794)
-- Name: cloud_share_link_members cloud_share_link_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3540 (class 2606 OID 16796)
-- Name: cloud_share_link_members cloud_share_link_members_unique_link_user; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_unique_link_user UNIQUE (link_id, user_id);


--
-- TOC entry 3545 (class 2606 OID 16798)
-- Name: cloud_share_link_saved cloud_share_link_saved_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_primary_id PRIMARY KEY (id);


--
-- TOC entry 3547 (class 2606 OID 16800)
-- Name: cloud_share_link_saved cloud_share_link_saved_unique_user_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_unique_user_link UNIQUE (user_id, link_id);


--
-- TOC entry 3552 (class 2606 OID 16802)
-- Name: cloud_share_links cloud_share_links_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_primary_id PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 16804)
-- Name: cloud_share_links cloud_share_links_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_unique_link UNIQUE (link);


--
-- TOC entry 3565 (class 2606 OID 16806)
-- Name: comments_members comments_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3567 (class 2606 OID 16808)
-- Name: comments_members comments_members_unique_user_id_and_entity; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_unique_user_id_and_entity UNIQUE (user_id, entity_id, entity_type);


--
-- TOC entry 3559 (class 2606 OID 16810)
-- Name: comments comments_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_primary_id PRIMARY KEY (id);


--
-- TOC entry 3572 (class 2606 OID 16812)
-- Name: contacts contacts_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_primary_id PRIMARY KEY (id);


--
-- TOC entry 3576 (class 2606 OID 16814)
-- Name: documents documents_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_primary_id PRIMARY KEY (id);


--
-- TOC entry 3581 (class 2606 OID 16816)
-- Name: invites invites_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_primary_id PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 16818)
-- Name: invites invites_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_unique_link UNIQUE (link);


--
-- TOC entry 3585 (class 2606 OID 16820)
-- Name: links links_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_primary_id PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 16822)
-- Name: links links_unique_entity_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_unique_entity_id UNIQUE (entity_id);


--
-- TOC entry 3589 (class 2606 OID 16824)
-- Name: links links_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_unique_link UNIQUE (link);


--
-- TOC entry 3596 (class 2606 OID 16826)
-- Name: main_folders_channels main_folders_channels_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_primary_id PRIMARY KEY (id);


--
-- TOC entry 3598 (class 2606 OID 16828)
-- Name: main_folders_channels main_folders_channels_unique_channel_id_folder_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_unique_channel_id_folder_id UNIQUE (folder_id, channel_id);


--
-- TOC entry 3592 (class 2606 OID 16830)
-- Name: main_folders main_folders_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders
    ADD CONSTRAINT main_folders_primary_id PRIMARY KEY (id);


--
-- Name: media_processing_queue media_processing_queue_primary_document_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.media_processing_queue
    ADD CONSTRAINT media_processing_queue_primary_document_id PRIMARY KEY (document_id);


--
-- TOC entry 3608 (class 2606 OID 16832)
-- Name: meets_members meets_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets_members
    ADD CONSTRAINT meets_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3610 (class 2606 OID 16834)
-- Name: meets_members meets_members_unique_user_id_and_meet_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets_members
    ADD CONSTRAINT meets_members_unique_user_id_and_meet_id UNIQUE (user_id, meet_id);


--
-- TOC entry 3603 (class 2606 OID 16836)
-- Name: meets meets_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_primary_id PRIMARY KEY (id);


--
-- TOC entry 3623 (class 2606 OID 16838)
-- Name: messages_deleted messages_deleted_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_primary_id PRIMARY KEY (id);


--
-- TOC entry 3617 (class 2606 OID 16840)
-- Name: messages messages_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_primary_id PRIMARY KEY (id);


--
-- TOC entry 3626 (class 2606 OID 16842)
-- Name: photoalbums photoalbums_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_primary_id PRIMARY KEY (id);


--
-- TOC entry 3628 (class 2606 OID 16844)
-- Name: photoalbums photoalbums_unique_owner_id__owner_type__type; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_unique_owner_id__owner_type__type UNIQUE (entity_type, entity_id, type);


--
-- TOC entry 3630 (class 2606 OID 16846)
-- Name: push_notifications push_notifications_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT push_notifications_primary_id PRIMARY KEY (id);


--
-- TOC entry 3634 (class 2606 OID 16848)
-- Name: reactions reactions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_primary_id PRIMARY KEY (id);


--
-- TOC entry 3636 (class 2606 OID 16850)
-- Name: sessions sessions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_primary_id PRIMARY KEY (id);


--
-- TOC entry 3638 (class 2606 OID 16852)
-- Name: sessions sessions_unique_token; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_unique_token UNIQUE (token);


--
-- TOC entry 3641 (class 2606 OID 16854)
-- Name: stickerpaks stickerpacks_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks
    ADD CONSTRAINT stickerpacks_primary_id PRIMARY KEY (id);








--
-- TOC entry 3879 (class 2606 OID 24671)
-- Name: stickerpaks_members stickerpaks_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks_members
    ADD CONSTRAINT stickerpaks_members_primary_id PRIMARY KEY (id);


--
-- TOC entry 3880 (class 2606 OID 24672)
-- Name: stickerpaks_members stickerpaks_members_unique_user_id_and_stickerpak_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks_members
    ADD CONSTRAINT stickerpaks_members_unique_user_id_and_stickerpak_id UNIQUE (user_id, stickerpak_id);


--
-- TOC entry 3644 (class 2606 OID 16856)
-- Name: themes themes_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_primary_id PRIMARY KEY (id);


--
-- TOC entry 3648 (class 2606 OID 16858)
-- Name: users unique_bot_token; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_bot_token UNIQUE (bot_token);

--
-- TOC entry 3893 (class 2606 OID 24721)
-- Name: user_passkeys user_passkeys_primary_credential_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_primary_credential_id PRIMARY KEY (credential_id);



--
-- TOC entry 3492 (class 2606 OID 16860)
-- Name: _user_roles user_roles_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._user_roles
    ADD CONSTRAINT user_roles_primary_id PRIMARY KEY (id);

--
-- TOC entry 3894 (class 2606 OID 24726)
-- Name: user_totp user_totp_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_totp
    ADD CONSTRAINT user_totp_primary_id PRIMARY KEY (user_id);



--
-- TOC entry 3650 (class 2606 OID 16862)
-- Name: users users_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_primary_id PRIMARY KEY (id);


--
-- TOC entry 3532 (class 1259 OID 16863)
-- Name: cloud_items_unique_folder_name; Type: INDEX; Schema: public; Owner: kodme
--

CREATE UNIQUE INDEX cloud_items_unique_folder_name ON public.cloud_items USING btree (owner_user_id, COALESCE(parent_id, '00000000-0000-0000-0000-000000000000'::uuid), name) WHERE (((item_type)::text = ('folder'::character varying)::text) AND (is_deleted = false));


--
-- TOC entry 3497 (class 1259 OID 16864)
-- Name: fki_attaches_foreign_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_attaches_foreign_document_id ON public.attachments USING btree (document_id);


--
-- TOC entry 3503 (class 1259 OID 16865)
-- Name: fki_broadcasts_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_created_user_id ON public.broadcasts USING btree (created_user_id);


--
-- TOC entry 3504 (class 1259 OID 16866)
-- Name: fki_broadcasts_foreign_chat_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_foreign_chat_channel_id ON public.broadcasts USING btree (chat_channel_id);


--
-- TOC entry 3505 (class 1259 OID 16867)
-- Name: fki_broadcasts_foreign_thumbnail_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_foreign_thumbnail_document_id ON public.broadcasts USING btree (thumbnail_document_id);


--
-- TOC entry 3510 (class 1259 OID 16868)
-- Name: fki_broadcasts_members_foreign_cast_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_members_foreign_cast_id ON public.broadcasts_members USING btree (cast_id);


--
-- TOC entry 3511 (class 1259 OID 16869)
-- Name: fki_broadcasts_members_foreign_invite_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_members_foreign_invite_id ON public.broadcasts_members USING btree (invite_id);


--
-- TOC entry 3512 (class 1259 OID 16870)
-- Name: fki_broadcasts_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_members_foreign_user_id ON public.broadcasts_members USING btree (user_id);


--
-- TOC entry 3653 (class 1259 OID 24638)
-- Name: fki_calls_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_foreign_channel_id ON public.calls USING btree (channel_id);


--
-- TOC entry 3654 (class 1259 OID 24637)
-- Name: fki_calls_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_foreign_created_user_id ON public.calls USING btree (created_user_id);


--
-- TOC entry 3660 (class 1259 OID 24663)
-- Name: fki_calls_members_foreign_call_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_members_foreign_call_id ON public.calls_members USING btree (call_id);


--
-- TOC entry 3661 (class 1259 OID 24664)
-- Name: fki_calls_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_members_foreign_user_id ON public.calls_members USING btree (user_id);


--
-- TOC entry 3515 (class 1259 OID 16871)
-- Name: fki_channels_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_created_user_id ON public.channels USING btree (created_user_id);


--
-- TOC entry 3516 (class 1259 OID 16872)
-- Name: fki_channels_foreign_avatar_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_foreign_avatar_document_id ON public.channels USING btree (avatar_document_id);


--
-- TOC entry 3517 (class 1259 OID 16873)
-- Name: fki_channels_foreign_group_for_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_foreign_group_for_channel_id ON public.channels USING btree (group_for_channel_id);


--
-- TOC entry 3518 (class 1259 OID 16874)
-- Name: fki_channels_foreign_topic_for_group_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_foreign_topic_for_group_id ON public.channels USING btree (topic_for_group_id);


--
-- TOC entry 3523 (class 1259 OID 16875)
-- Name: fki_channels_members_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_members_foreign_channel_id ON public.channels_members USING btree (channel_id);


--
-- TOC entry 3524 (class 1259 OID 16876)
-- Name: fki_channels_members_foreign_invite_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_members_foreign_invite_id ON public.channels_members USING btree (invite_id);


--
-- TOC entry 3525 (class 1259 OID 16877)
-- Name: fki_channels_members_foreign_last_accessed_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_members_foreign_last_accessed_message_id ON public.channels_members USING btree (last_accessed_message_id);


--
-- TOC entry 3526 (class 1259 OID 16878)
-- Name: fki_channels_members_foreign_last_viewed_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_members_foreign_last_viewed_message_id ON public.channels_members USING btree (last_viewed_message_id);


--
-- TOC entry 3527 (class 1259 OID 16879)
-- Name: fki_channels_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_members_foreign_user_id ON public.channels_members USING btree (user_id);


--
-- TOC entry 3533 (class 1259 OID 16880)
-- Name: fki_cloud_items_foreign_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_document_id ON public.cloud_items USING btree (document_id);


--
-- TOC entry 3534 (class 1259 OID 16881)
-- Name: fki_cloud_items_foreign_owner_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_owner_user_id ON public.cloud_items USING btree (owner_user_id);


--
-- TOC entry 3535 (class 1259 OID 16882)
-- Name: fki_cloud_items_foreign_parent_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_parent_id ON public.cloud_items USING btree (parent_id);


--
-- TOC entry 3541 (class 1259 OID 16883)
-- Name: fki_cloud_share_link_members_foreign_link_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_members_foreign_link_id ON public.cloud_share_link_members USING btree (link_id);


--
-- TOC entry 3542 (class 1259 OID 16884)
-- Name: fki_cloud_share_link_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_members_foreign_user_id ON public.cloud_share_link_members USING btree (user_id);


--
-- TOC entry 3548 (class 1259 OID 16885)
-- Name: fki_cloud_share_link_saved_foreign_link_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_saved_foreign_link_id ON public.cloud_share_link_saved USING btree (link_id);


--
-- TOC entry 3549 (class 1259 OID 16886)
-- Name: fki_cloud_share_link_saved_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_saved_foreign_user_id ON public.cloud_share_link_saved USING btree (user_id);


--
-- TOC entry 3555 (class 1259 OID 16887)
-- Name: fki_cloud_share_links_foreign_item_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_links_foreign_item_id ON public.cloud_share_links USING btree (item_id);


--
-- TOC entry 3556 (class 1259 OID 16888)
-- Name: fki_cloud_share_links_foreign_owner_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_links_foreign_owner_user_id ON public.cloud_share_links USING btree (owner_user_id);


--
-- TOC entry 3560 (class 1259 OID 16889)
-- Name: fki_comments_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_created_user_id ON public.comments USING btree (created_user_id);


--
-- TOC entry 3561 (class 1259 OID 16890)
-- Name: fki_comments_foreign_reply_to_comment_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_reply_to_comment_id ON public.comments USING btree (reply_to_comment_id);


--
-- TOC entry 3562 (class 1259 OID 16891)
-- Name: fki_comments_foreign_sticker_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_sticker_document_id ON public.comments USING btree (sticker_document_id);


--
-- TOC entry 3568 (class 1259 OID 16892)
-- Name: fki_comments_members_foreign_last_viewed_comment_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_members_foreign_last_viewed_comment_id ON public.comments_members USING btree (last_viewed_comment_id);


--
-- TOC entry 3569 (class 1259 OID 16893)
-- Name: fki_comments_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_members_foreign_user_id ON public.comments_members USING btree (user_id);


--
-- TOC entry 3573 (class 1259 OID 16894)
-- Name: fki_contacts_foreign_contact_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_contacts_foreign_contact_user_id ON public.contacts USING btree (contact_user_id);


--
-- TOC entry 3574 (class 1259 OID 16895)
-- Name: fki_contacts_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_contacts_foreign_user_id ON public.contacts USING btree (user_id);


--
-- TOC entry 3577 (class 1259 OID 16896)
-- Name: fki_documents_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_documents_foreign_created_user_id ON public.documents USING btree (created_user_id);


--
-- TOC entry 3578 (class 1259 OID 16897)
-- Name: fki_documents_foreign_storage_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_documents_foreign_storage_id ON public.documents USING btree (storage_id);


--
-- TOC entry 3579 (class 1259 OID 16898)
-- Name: fki_invites_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_invites_foreign_created_user_id ON public.invites USING btree (created_user_id);


--
-- TOC entry 3593 (class 1259 OID 16899)
-- Name: fki_main_folders_channels_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_channels_foreign_channel_id ON public.main_folders_channels USING btree (channel_id);


--
-- TOC entry 3594 (class 1259 OID 16900)
-- Name: fki_main_folders_channels_foreign_folder_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_channels_foreign_folder_id ON public.main_folders_channels USING btree (folder_id);


--
-- TOC entry 3590 (class 1259 OID 16901)
-- Name: fki_main_folders_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_foreign_user_id ON public.main_folders USING btree (created_user_id);


--
-- TOC entry 3599 (class 1259 OID 16902)
-- Name: fki_meets_foreign_chat_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_chat_channel_id ON public.meets USING btree (chat_channel_id);


--
-- TOC entry 3600 (class 1259 OID 16903)
-- Name: fki_meets_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_created_user_id ON public.meets USING btree (created_user_id);


--
-- TOC entry 3601 (class 1259 OID 16904)
-- Name: fki_meets_foreign_thumbnail_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_thumbnail_document_id ON public.meets USING btree (thumbnail_document_id);


--
-- TOC entry 3604 (class 1259 OID 16905)
-- Name: fki_meets_members_foreign_invite_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_members_foreign_invite_id ON public.meets_members USING btree (invite_id);


--
-- TOC entry 3605 (class 1259 OID 16906)
-- Name: fki_meets_members_foreign_meet_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_members_foreign_meet_id ON public.meets_members USING btree (meet_id);


--
-- TOC entry 3606 (class 1259 OID 16907)
-- Name: fki_meets_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_members_foreign_user_id ON public.meets_members USING btree (user_id);


--
-- TOC entry 3618 (class 1259 OID 16908)
-- Name: fki_messages_deleted_foreign_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_deleted_foreign_message_id ON public.messages_deleted USING btree (message_id);


--
-- TOC entry 3619 (class 1259 OID 16909)
-- Name: fki_messages_deleted_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_deleted_foreign_user_id ON public.messages_deleted USING btree (user_id);


--
-- TOC entry 3611 (class 1259 OID 16910)
-- Name: fki_messages_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_channel_id ON public.messages USING btree (channel_id);


--
-- TOC entry 3612 (class 1259 OID 16911)
-- Name: fki_messages_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_created_user_id ON public.messages USING btree (created_user_id);


--
-- TOC entry 3613 (class 1259 OID 16912)
-- Name: fki_messages_foreign_forwarded_to_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_forwarded_to_message_id ON public.messages USING btree (forwarded_to_message_id);


--
-- TOC entry 3614 (class 1259 OID 16913)
-- Name: fki_messages_foreign_reply_to_mesage_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_reply_to_mesage_id ON public.messages USING btree (reply_to_message_id);


--
-- TOC entry 3615 (class 1259 OID 16914)
-- Name: fki_messages_foreign_sticker_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_sticker_document_id ON public.messages USING btree (sticker_document_id);


--
-- TOC entry 3624 (class 1259 OID 16915)
-- Name: fki_photoalbums_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_photoalbums_foreign_created_user_id ON public.photoalbums USING btree (created_user_id);


--
-- TOC entry 3631 (class 1259 OID 16916)
-- Name: fki_reactions_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_reactions_foreign_created_user_id ON public.reactions USING btree (created_user_id);


--
-- TOC entry 3639 (class 1259 OID 16917)
-- Name: fki_stickerpacks_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_stickerpacks_foreign_created_user_id ON public.stickerpaks USING btree (created_user_id);








--
-- TOC entry 3883 (class 1259 OID 24675)
-- Name: fki_stickerpaks_members_foreign_stickerpak_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_stickerpaks_members_foreign_stickerpak_id ON public.stickerpaks_members USING btree (stickerpak_id);


--
-- TOC entry 3884 (class 1259 OID 24676)
-- Name: fki_stickerpaks_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_stickerpaks_members_foreign_user_id ON public.stickerpaks_members USING btree (user_id);


--
-- TOC entry 3642 (class 1259 OID 16918)
-- Name: fki_themes_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_themes_foreign_created_user_id ON public.themes USING btree (created_user_id);

--
-- TOC entry 3895 (class 1259 OID 24731)
-- Name: fki_user_passkeys_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_user_passkeys_foreign_user_id ON public.user_passkeys USING btree (user_id);


--
-- TOC entry 3896 (class 1259 OID 24736)
-- Name: fki_user_totp_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_user_totp_foreign_user_id ON public.user_totp USING btree (user_id);



--
-- TOC entry 3645 (class 1259 OID 16919)
-- Name: fki_users_foreign_avatar_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_users_foreign_avatar_document_id ON public.users USING btree (avatar_document_id);


--
-- TOC entry 3646 (class 1259 OID 16920)
-- Name: fki_users_foreign_role_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_users_foreign_role_id ON public.users USING btree (role_id);


--
-- TOC entry 3498 (class 1259 OID 16921)
-- Name: idx_attachments_cloud_context; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_cloud_context ON public.attachments USING btree (((entity_context ->> 'type'::text)), ((entity_context ->> 'id'::text)));


--
-- TOC entry 3499 (class 1259 OID 16922)
-- Name: idx_attachments_context_type_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_context_type_id ON public.attachments USING btree (((entity_context ->> 'type'::text)), ((entity_context ->> 'id'::text)));


--
-- TOC entry 3500 (class 1259 OID 16923)
-- Name: idx_attachments_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_entity ON public.attachments USING btree (entity_id, entity_type);


--
-- TOC entry 3655 (class 1259 OID 24639)
-- Name: idx_calls_active_channel; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_active_channel ON public.calls USING btree (channel_id) WHERE ((status)::text = ANY ((ARRAY['ringing'::character varying, 'active'::character varying])::text[]));


--
-- TOC entry 3662 (class 1259 OID 24666)
-- Name: idx_calls_members_active_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_members_active_user ON public.calls_members USING btree (user_id) WHERE (left_at IS NULL);


--
-- TOC entry 3663 (class 1259 OID 24665)
-- Name: idx_calls_members_call; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_members_call ON public.calls_members USING btree (call_id);


--
-- TOC entry 3528 (class 1259 OID 16924)
-- Name: idx_channels_members_channel_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_channels_members_channel_user ON public.channels_members USING btree (channel_id, user_id);


--
-- TOC entry 3529 (class 1259 OID 16925)
-- Name: idx_channels_members_user_channel_subscribed; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_channels_members_user_channel_subscribed ON public.channels_members USING btree (user_id, channel_id, is_subscribed);


--
-- TOC entry 3536 (class 1259 OID 16926)
-- Name: idx_cloud_items_owner_parent_deleted; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_items_owner_parent_deleted ON public.cloud_items USING btree (owner_user_id, parent_id, is_deleted, item_type, id);


--
-- TOC entry 3543 (class 1259 OID 16927)
-- Name: idx_cloud_share_link_members_link_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_link_members_link_user ON public.cloud_share_link_members USING btree (link_id, user_id);


--
-- TOC entry 3550 (class 1259 OID 16928)
-- Name: idx_cloud_share_link_saved_user_link; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_link_saved_user_link ON public.cloud_share_link_saved USING btree (user_id, link_id);


--
-- TOC entry 3557 (class 1259 OID 16929)
-- Name: idx_cloud_share_links_owner_item; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_links_owner_item ON public.cloud_share_links USING btree (owner_user_id, item_id);


--
-- TOC entry 3563 (class 1259 OID 16930)
-- Name: idx_comments_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_comments_entity ON public.comments USING btree (entity_id, entity_type);


--
-- TOC entry 3570 (class 1259 OID 16931)
-- Name: idx_comments_members_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_comments_members_entity ON public.comments_members USING btree (entity_id, entity_type, user_id);


--
-- Name: idx_media_processing_queue_status; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_media_processing_queue_status ON public.media_processing_queue USING btree (status, created_at) WHERE (status IN ('pending'::character varying, 'processing'::character varying));


--
-- TOC entry 3620 (class 1259 OID 16932)
-- Name: idx_messages_deleted_message_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_messages_deleted_message_user ON public.messages_deleted USING btree (message_id, user_id);


--
-- TOC entry 3621 (class 1259 OID 16933)
-- Name: idx_messages_deleted_user_message; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_messages_deleted_user_message ON public.messages_deleted USING btree (user_id, message_id);


--
-- TOC entry 3632 (class 1259 OID 16934)
-- Name: idx_reactions_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_reactions_entity ON public.reactions USING btree (entity_id, entity_type);


--
-- TOC entry 3885 (class 1259 OID 24677)
-- Name: idx_stickerpaks_members_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_stickerpaks_members_user ON public.stickerpaks_members USING btree (user_id, subscribed_at);

--
-- TOC entry 3897 (class 1259 OID 24741)
-- Name: idx_user_passkeys_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_user_passkeys_user ON public.user_passkeys USING btree (user_id, created_at);






--
-- TOC entry 3664 (class 2606 OID 16935)
-- Name: attachments attachments_foreign_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_foreign_document_id FOREIGN KEY (document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3665 (class 2606 OID 16940)
-- Name: broadcasts broadcasts_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3666 (class 2606 OID 16945)
-- Name: broadcasts broadcasts_foreign_chat_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_foreign_chat_channel_id FOREIGN KEY (chat_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3667 (class 2606 OID 16950)
-- Name: broadcasts broadcasts_foreign_thumbnail_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_foreign_thumbnail_document_id FOREIGN KEY (thumbnail_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3668 (class 2606 OID 16955)
-- Name: broadcasts_members broadcasts_members_foreign_cast_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts_members
    ADD CONSTRAINT broadcasts_members_foreign_cast_id FOREIGN KEY (cast_id) REFERENCES public.broadcasts(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3669 (class 2606 OID 16960)
-- Name: broadcasts_members broadcasts_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts_members
    ADD CONSTRAINT broadcasts_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3717 (class 2606 OID 24632)
-- Name: calls calls_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3718 (class 2606 OID 24627)
-- Name: calls calls_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3719 (class 2606 OID 24653)
-- Name: calls_members calls_members_foreign_call_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_foreign_call_id FOREIGN KEY (call_id) REFERENCES public.calls(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3720 (class 2606 OID 24658)
-- Name: calls_members calls_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3670 (class 2606 OID 16965)
-- Name: channels channels_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3671 (class 2606 OID 16970)
-- Name: channels channels_foreign_avatar_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_avatar_document_id FOREIGN KEY (avatar_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3672 (class 2606 OID 16975)
-- Name: channels channels_foreign_group_for_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_group_for_channel_id FOREIGN KEY (group_for_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3673 (class 2606 OID 16980)
-- Name: channels channels_foreign_topic_for_group_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_topic_for_group_id FOREIGN KEY (topic_for_group_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3674 (class 2606 OID 16985)
-- Name: channels_members channels_members_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3675 (class 2606 OID 16990)
-- Name: channels_members channels_members_foreign_last_accessed_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_foreign_last_accessed_message_id FOREIGN KEY (last_accessed_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3676 (class 2606 OID 16995)
-- Name: channels_members channels_members_foreign_last_viewed_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_foreign_last_viewed_message_id FOREIGN KEY (last_viewed_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3677 (class 2606 OID 17000)
-- Name: channels_members channels_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels_members
    ADD CONSTRAINT channels_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3678 (class 2606 OID 17005)
-- Name: cloud_items cloud_items_foreign_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_document_id FOREIGN KEY (document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3679 (class 2606 OID 17010)
-- Name: cloud_items cloud_items_foreign_owner_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_owner_user_id FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3680 (class 2606 OID 17015)
-- Name: cloud_items cloud_items_foreign_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_parent_id FOREIGN KEY (parent_id) REFERENCES public.cloud_items(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3681 (class 2606 OID 17020)
-- Name: cloud_share_link_members cloud_share_link_members_foreign_link_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_foreign_link_id FOREIGN KEY (link_id) REFERENCES public.cloud_share_links(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3682 (class 2606 OID 17025)
-- Name: cloud_share_link_members cloud_share_link_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3683 (class 2606 OID 17030)
-- Name: cloud_share_link_saved cloud_share_link_saved_foreign_link_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_foreign_link_id FOREIGN KEY (link_id) REFERENCES public.cloud_share_links(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3684 (class 2606 OID 17035)
-- Name: cloud_share_link_saved cloud_share_link_saved_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3685 (class 2606 OID 17040)
-- Name: cloud_share_links cloud_share_links_foreign_item_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_foreign_item_id FOREIGN KEY (item_id) REFERENCES public.cloud_items(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3686 (class 2606 OID 17045)
-- Name: cloud_share_links cloud_share_links_foreign_owner_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_foreign_owner_user_id FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3687 (class 2606 OID 17050)
-- Name: comments comments_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3688 (class 2606 OID 17055)
-- Name: comments comments_foreign_reply_to_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_reply_to_comment_id FOREIGN KEY (reply_to_comment_id) REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3689 (class 2606 OID 17060)
-- Name: comments comments_foreign_sticker_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_sticker_document_id FOREIGN KEY (sticker_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3690 (class 2606 OID 17065)
-- Name: comments_members comments_members_foreign_last_viewed_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_foreign_last_viewed_comment_id FOREIGN KEY (last_viewed_comment_id) REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3691 (class 2606 OID 17070)
-- Name: comments_members comments_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3692 (class 2606 OID 17075)
-- Name: contacts contacts_foreign_contact_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_foreign_contact_user_id FOREIGN KEY (contact_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3693 (class 2606 OID 17080)
-- Name: contacts contacts_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3694 (class 2606 OID 17085)
-- Name: documents documents_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3695 (class 2606 OID 17090)
-- Name: documents documents_foreign_storage_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_foreign_storage_id FOREIGN KEY (storage_id) REFERENCES public._storages(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3697 (class 2606 OID 17095)
-- Name: main_folders_channels main_folders_channels_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3698 (class 2606 OID 17100)
-- Name: main_folders_channels main_folders_channels_foreign_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_foreign_folder_id FOREIGN KEY (folder_id) REFERENCES public.main_folders(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3696 (class 2606 OID 17105)
-- Name: main_folders main_folders_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders
    ADD CONSTRAINT main_folders_foreign_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3699 (class 2606 OID 17110)
-- Name: meets meets_foreign_chat_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_chat_channel_id FOREIGN KEY (chat_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3700 (class 2606 OID 17115)
-- Name: meets meets_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3701 (class 2606 OID 17120)
-- Name: meets meets_foreign_thumbnail_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_thumbnail_document_id FOREIGN KEY (thumbnail_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3702 (class 2606 OID 17125)
-- Name: meets_members meets_members_foreign_meet_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets_members
    ADD CONSTRAINT meets_members_foreign_meet_id FOREIGN KEY (meet_id) REFERENCES public.meets(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3703 (class 2606 OID 17130)
-- Name: meets_members meets_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets_members
    ADD CONSTRAINT meets_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3709 (class 2606 OID 17135)
-- Name: messages_deleted messages_deleted_foreign_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_foreign_message_id FOREIGN KEY (message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3710 (class 2606 OID 17140)
-- Name: messages_deleted messages_deleted_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3704 (class 2606 OID 17145)
-- Name: messages messages_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3705 (class 2606 OID 17150)
-- Name: messages messages_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3706 (class 2606 OID 17155)
-- Name: messages messages_foreign_forwarded_to_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_forwarded_to_message_id FOREIGN KEY (forwarded_to_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3707 (class 2606 OID 17160)
-- Name: messages messages_foreign_reply_to_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_reply_to_message_id FOREIGN KEY (reply_to_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3708 (class 2606 OID 17165)
-- Name: messages messages_foreign_sticker_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_sticker_document_id FOREIGN KEY (sticker_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3711 (class 2606 OID 17170)
-- Name: photoalbums photoalbums_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3712 (class 2606 OID 17175)
-- Name: reactions reactions_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3713 (class 2606 OID 17180)
-- Name: stickerpaks stickerpacks_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks
    ADD CONSTRAINT stickerpacks_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;








--
-- TOC entry 3889 (class 2606 OID 24681)
-- Name: stickerpaks_members stickerpaks_members_foreign_stickerpak_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks_members
    ADD CONSTRAINT stickerpaks_members_foreign_stickerpak_id FOREIGN KEY (stickerpak_id) REFERENCES public.stickerpaks(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3890 (class 2606 OID 24682)
-- Name: stickerpaks_members stickerpaks_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks_members
    ADD CONSTRAINT stickerpaks_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3714 (class 2606 OID 17185)
-- Name: themes themes_foreign_created_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_foreign_created_user_id FOREIGN KEY (created_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3898 (class 2606 OID 24746)
-- Name: user_passkeys user_passkeys_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3899 (class 2606 OID 24751)
-- Name: user_totp user_totp_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_totp
    ADD CONSTRAINT user_totp_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;



--
-- TOC entry 3715 (class 2606 OID 17190)
-- Name: users users_foreign_avatar_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_foreign_avatar_document_id FOREIGN KEY (avatar_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3716 (class 2606 OID 17195)
-- Name: users users_foreign_role_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_foreign_role_id FOREIGN KEY (role_id) REFERENCES public._user_roles(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-10-10 15:39:57 MSK

--
-- PostgreSQL database dump complete
--

\unrestrict n0GOcOUv9GKoFZT0tAEd8x826qiL17mI1bIoH7wXHNGLaEUDdi81FSOJSIxdzQ4

