--
-- PostgreSQL database dump
--

\restrict 51ylAEdA98J6HaOR5snhK7HFkqgw4XuZMZ23cV6aZH9oJs7jWqNPv2DWWNMBR7f

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.6 (Debian 18.6-1.pgdg13+2)

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

ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_foreign_role_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_foreign_avatar_document_id;
ALTER TABLE IF EXISTS ONLY public.user_updates DROP CONSTRAINT IF EXISTS user_updates_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.user_totp DROP CONSTRAINT IF EXISTS user_totp_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.user_passkeys DROP CONSTRAINT IF EXISTS user_passkeys_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.themes DROP CONSTRAINT IF EXISTS themes_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks DROP CONSTRAINT IF EXISTS stickerpacks_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.read_states DROP CONSTRAINT IF EXISTS read_states_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.read_states DROP CONSTRAINT IF EXISTS read_states_foreign_last_read_id;
ALTER TABLE IF EXISTS ONLY public.read_states DROP CONSTRAINT IF EXISTS read_states_foreign_last_cleared_id;
ALTER TABLE IF EXISTS ONLY public.read_states DROP CONSTRAINT IF EXISTS read_states_foreign_entity_id;
ALTER TABLE IF EXISTS ONLY public.reactions DROP CONSTRAINT IF EXISTS reactions_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_sticker_document_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_reply_to_message_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_forwarded_to_message_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_foreign_message_id;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_foreign_invite_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_thumbnail_document_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_foreign_chat_channel_id;
ALTER TABLE IF EXISTS ONLY public.main_folders DROP CONSTRAINT IF EXISTS main_folders_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_foreign_folder_id;
ALTER TABLE IF EXISTS ONLY public.main_folders_channels DROP CONSTRAINT IF EXISTS main_folders_channels_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.contacts DROP CONSTRAINT IF EXISTS contacts_foreign_contact_user_id;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.comments_members DROP CONSTRAINT IF EXISTS comments_members_foreign_last_viewed_comment_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_sticker_document_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_reply_to_comment_id;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_foreign_author_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_foreign_owner_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_links DROP CONSTRAINT IF EXISTS cloud_share_links_foreign_item_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_saved DROP CONSTRAINT IF EXISTS cloud_share_link_saved_foreign_link_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_share_link_members DROP CONSTRAINT IF EXISTS cloud_share_link_members_foreign_link_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_parent_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_owner_user_id;
ALTER TABLE IF EXISTS ONLY public.cloud_items DROP CONSTRAINT IF EXISTS cloud_items_foreign_document_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_parent_channel_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.channels DROP CONSTRAINT IF EXISTS channels_foreign_avatar_document_id;
ALTER TABLE IF EXISTS ONLY public.channel_updates DROP CONSTRAINT IF EXISTS channel_updates_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_foreign_call_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_foreign_channel_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_foreign_thumbnail_document_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_foreign_chat_channel_id;
ALTER TABLE IF EXISTS ONLY public.bots DROP CONSTRAINT IF EXISTS bots_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public.bots DROP CONSTRAINT IF EXISTS bots_foreign_owner_id;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_foreign_document_id;
ALTER TABLE IF EXISTS ONLY public._role_permissions DROP CONSTRAINT IF EXISTS _role_permissions_foreign_role_id;
ALTER TABLE IF EXISTS ONLY public._role_permissions DROP CONSTRAINT IF EXISTS _role_permissions_foreign_permission_id;
ALTER TABLE IF EXISTS ONLY public._role_assignments DROP CONSTRAINT IF EXISTS _role_assignments_foreign_user_id;
ALTER TABLE IF EXISTS ONLY public._role_assignments DROP CONSTRAINT IF EXISTS _role_assignments_foreign_role_id;
ALTER TABLE IF EXISTS ONLY public._role_assignments DROP CONSTRAINT IF EXISTS _role_assignments_foreign_channel_id;
DROP INDEX IF EXISTS public.idx_user_passkeys_user;
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
DROP INDEX IF EXISTS public.idx_calls_members_call;
DROP INDEX IF EXISTS public.idx_calls_members_active_user;
DROP INDEX IF EXISTS public.idx_calls_active_channel;
DROP INDEX IF EXISTS public.idx_attachments_entity;
DROP INDEX IF EXISTS public.idx_attachments_context_type_id;
DROP INDEX IF EXISTS public.idx_attachments_cloud_context;
DROP INDEX IF EXISTS public.fki_users_foreign_role_id;
DROP INDEX IF EXISTS public.fki_users_foreign_avatar_document_id;
DROP INDEX IF EXISTS public.fki_user_updates_created_at;
DROP INDEX IF EXISTS public.fki_user_totp_foreign_user_id;
DROP INDEX IF EXISTS public.fki_user_passkeys_foreign_user_id;
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
DROP INDEX IF EXISTS public.fki_membership_entity;
DROP INDEX IF EXISTS public.fki_meets_foreign_thumbnail_document_id;
DROP INDEX IF EXISTS public.fki_meets_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_meets_foreign_chat_channel_id;
DROP INDEX IF EXISTS public.fki_main_folders_foreign_user_id;
DROP INDEX IF EXISTS public.fki_main_folders_channels_foreign_folder_id;
DROP INDEX IF EXISTS public.fki_main_folders_channels_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_invites_foreign_created_user_id;
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
DROP INDEX IF EXISTS public.fki_channels_foreign_parent_channel_id;
DROP INDEX IF EXISTS public.fki_channels_foreign_avatar_document_id;
DROP INDEX IF EXISTS public.fki_channels_created_user_id;
DROP INDEX IF EXISTS public.fki_channel_updates_created_at;
DROP INDEX IF EXISTS public.fki_calls_members_foreign_user_id;
DROP INDEX IF EXISTS public.fki_calls_members_foreign_call_id;
DROP INDEX IF EXISTS public.fki_calls_foreign_created_user_id;
DROP INDEX IF EXISTS public.fki_calls_foreign_channel_id;
DROP INDEX IF EXISTS public.fki_broadcasts_foreign_thumbnail_document_id;
DROP INDEX IF EXISTS public.fki_broadcasts_foreign_chat_channel_id;
DROP INDEX IF EXISTS public.fki_broadcasts_created_user_id;
DROP INDEX IF EXISTS public.fki_attaches_foreign_document_id;
DROP INDEX IF EXISTS public.cloud_items_unique_folder_name;
DROP INDEX IF EXISTS public._roles_one_default_per_scope;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_primary_id;
ALTER TABLE IF EXISTS ONLY public.user_updates DROP CONSTRAINT IF EXISTS user_updates_primary_id;
ALTER TABLE IF EXISTS ONLY public.user_totp DROP CONSTRAINT IF EXISTS user_totp_primary_id;
ALTER TABLE IF EXISTS ONLY public.user_passkeys DROP CONSTRAINT IF EXISTS user_passkeys_primary_credential_id;
ALTER TABLE IF EXISTS ONLY public.themes DROP CONSTRAINT IF EXISTS themes_primary_id;
ALTER TABLE IF EXISTS ONLY public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_primary_id;
ALTER TABLE IF EXISTS ONLY public.stickerpaks DROP CONSTRAINT IF EXISTS stickerpacks_primary_id;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_unique_token;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_primary_id;
ALTER TABLE IF EXISTS ONLY public.read_states DROP CONSTRAINT IF EXISTS read_states_primary_id;
ALTER TABLE IF EXISTS ONLY public.reactions DROP CONSTRAINT IF EXISTS reactions_primary_id;
ALTER TABLE IF EXISTS ONLY public.push_notifications DROP CONSTRAINT IF EXISTS push_notifications_primary_id;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_unique_owner_id__owner_type__type;
ALTER TABLE IF EXISTS ONLY public.photoalbums DROP CONSTRAINT IF EXISTS photoalbums_primary_id;
ALTER TABLE IF EXISTS ONLY public.messages DROP CONSTRAINT IF EXISTS messages_primary_id;
ALTER TABLE IF EXISTS ONLY public.messages_deleted DROP CONSTRAINT IF EXISTS messages_deleted_primary_id;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_unique_user_entity;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_primary_id;
ALTER TABLE IF EXISTS ONLY public.meets DROP CONSTRAINT IF EXISTS meets_primary_id;
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
ALTER TABLE IF EXISTS ONLY public.channel_updates DROP CONSTRAINT IF EXISTS channel_updates_primary_id;
ALTER TABLE IF EXISTS ONLY public.calls DROP CONSTRAINT IF EXISTS calls_primary_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_unique_call_id_and_user_id;
ALTER TABLE IF EXISTS ONLY public.calls_members DROP CONSTRAINT IF EXISTS calls_members_primary_id;
ALTER TABLE IF EXISTS ONLY public.broadcasts DROP CONSTRAINT IF EXISTS broadcasts_primary_id;
ALTER TABLE IF EXISTS ONLY public.bots DROP CONSTRAINT IF EXISTS bots_unique_token;
ALTER TABLE IF EXISTS ONLY public.bots DROP CONSTRAINT IF EXISTS bots_primary_id;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_unique_document_id__entity_id__entity_type;
ALTER TABLE IF EXISTS ONLY public.attachments DROP CONSTRAINT IF EXISTS attachments_primary_id;
ALTER TABLE IF EXISTS ONLY public._roles DROP CONSTRAINT IF EXISTS _roles_unique_name_scope;
ALTER TABLE IF EXISTS ONLY public._roles DROP CONSTRAINT IF EXISTS _roles_primary_id;
ALTER TABLE IF EXISTS ONLY public._role_permissions DROP CONSTRAINT IF EXISTS _role_permissions_primary_id;
ALTER TABLE IF EXISTS ONLY public._role_assignments DROP CONSTRAINT IF EXISTS _role_assignments_unique;
ALTER TABLE IF EXISTS ONLY public._role_assignments DROP CONSTRAINT IF EXISTS _role_assignments_primary_id;
ALTER TABLE IF EXISTS ONLY public._permissions DROP CONSTRAINT IF EXISTS _permissions_unique_code;
ALTER TABLE IF EXISTS ONLY public._permissions DROP CONSTRAINT IF EXISTS _permissions_primary_id;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_updates;
DROP TABLE IF EXISTS public.user_totp;
DROP TABLE IF EXISTS public.user_passkeys;
DROP TABLE IF EXISTS public.themes;
DROP TABLE IF EXISTS public.subscriptions;
DROP TABLE IF EXISTS public.stickerpaks;
DROP TABLE IF EXISTS public.sessions;
DROP TABLE IF EXISTS public.read_states;
DROP TABLE IF EXISTS public.reactions;
DROP TABLE IF EXISTS public.push_notifications;
DROP TABLE IF EXISTS public.photoalbums;
DROP TABLE IF EXISTS public.messages_deleted;
DROP TABLE IF EXISTS public.messages;
DROP TABLE IF EXISTS public.membership;
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
DROP TABLE IF EXISTS public.channels;
DROP TABLE IF EXISTS public.channel_updates;
DROP TABLE IF EXISTS public.calls_members;
DROP TABLE IF EXISTS public.calls;
DROP TABLE IF EXISTS public.broadcasts;
DROP TABLE IF EXISTS public.bots_apps;
DROP TABLE IF EXISTS public.bots;
DROP TABLE IF EXISTS public.attachments;
DROP TABLE IF EXISTS public._roles;
DROP TABLE IF EXISTS public._role_permissions;
DROP TABLE IF EXISTS public._role_assignments;
DROP TABLE IF EXISTS public._permissions;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _permissions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._permissions (
    id uuid NOT NULL,
    code character varying NOT NULL,
    module character varying NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public._permissions OWNER TO kodme;

--
-- Name: _role_assignments; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._role_assignments (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    role_id uuid NOT NULL,
    channel_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public._role_assignments OWNER TO kodme;

--
-- Name: _role_permissions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._role_permissions (
    role_id uuid NOT NULL,
    permission_id uuid NOT NULL
);


ALTER TABLE public._role_permissions OWNER TO kodme;

--
-- Name: _roles; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public._roles (
    id uuid NOT NULL,
    name character varying NOT NULL,
    description character varying,
    scope character varying DEFAULT 'channel'::character varying NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT _roles_scope_check CHECK (((scope)::text = ANY ((ARRAY['platform'::character varying, 'channel'::character varying])::text[])))
);


ALTER TABLE public._roles OWNER TO kodme;

--
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
-- Name: bots; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.bots (
    user_id uuid NOT NULL,
    token character varying NOT NULL,
    commands jsonb,
    owner_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.bots OWNER TO kodme;

--
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
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.broadcasts (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
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
-- Name: calls; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.calls (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    channel_id uuid,
    message_id uuid,
    status character varying DEFAULT 'ringing'::character varying NOT NULL,
    started_at timestamp with time zone NOT NULL,
    accepted_at timestamp with time zone,
    ended_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.calls OWNER TO kodme;

--
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
-- Name: channel_updates; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.channel_updates (
    channel_id uuid NOT NULL,
    pts bigint NOT NULL,
    type character varying NOT NULL,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.channel_updates OWNER TO kodme;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.channels (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    name character varying(128),
    kind character varying(16) DEFAULT 'dialog'::character varying NOT NULL,
    about character varying(255),
    visibility character varying(7) DEFAULT 'public'::character varying NOT NULL,
    posting_mode character varying(8) DEFAULT 'admins'::character varying NOT NULL,
    is_commenting boolean DEFAULT false CONSTRAINT channels_commenting_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT channels_date_created_not_null NOT NULL,
    is_closed boolean DEFAULT false CONSTRAINT channels_closed_not_null NOT NULL,
    avatar_document_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT channels_deleted_not_null NOT NULL,
    last_pts bigint DEFAULT 0,
    can_forward_messages boolean DEFAULT true NOT NULL,
    parent_channel_id uuid,
    CONSTRAINT channels_kind_check CHECK (((kind)::text = ANY ((ARRAY['dialog'::character varying, 'group'::character varying, 'channel'::character varying, 'topic'::character varying, 'favorite'::character varying, 'meet_chat'::character varying, 'cast_chat'::character varying])::text[]))),
    CONSTRAINT channels_posting_mode_check CHECK (((posting_mode)::text = ANY ((ARRAY['all'::character varying, 'admins'::character varying, 'nobody'::character varying])::text[]))),
    CONSTRAINT channels_visibility_check CHECK (((visibility)::text = ANY ((ARRAY['public'::character varying, 'private'::character varying])::text[])))
);


ALTER TABLE public.channels OWNER TO kodme;

--
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
-- Name: comments; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.comments (
    id uuid NOT NULL,
    author_id uuid NOT NULL,
    text character varying(4096) NOT NULL,
    reply_to_comment_id uuid,
    created_at timestamp with time zone CONSTRAINT comments_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_deleted boolean DEFAULT false CONSTRAINT comments_deleted_not_null NOT NULL,
    sticker_document_id uuid,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    random_id uuid
);


ALTER TABLE public.comments OWNER TO kodme;

--
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
-- Name: documents; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.documents (
    id uuid NOT NULL,
    file_name character varying,
    size bigint,
    mime_type character varying,
    author_id uuid,
    created_at timestamp with time zone CONSTRAINT documents_date_created_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT documents_deleted_not_null NOT NULL,
    extname character varying,
    metadata jsonb
);


ALTER TABLE public.documents OWNER TO kodme;

--
-- Name: invites; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.invites (
    id uuid NOT NULL,
    link character varying NOT NULL,
    name character varying(64) NOT NULL,
    created_at timestamp with time zone CONSTRAINT invites_date_created_not_null NOT NULL,
    expires_at date,
    is_deleted boolean DEFAULT false CONSTRAINT invites_deleted_not_null NOT NULL,
    owner_id uuid NOT NULL,
    max_users integer DEFAULT 0 CONSTRAINT invites_max_uses_not_null NOT NULL,
    count_uses integer DEFAULT 0 NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    CONSTRAINT invites_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['channel'::character varying, 'meet'::character varying, 'broadcast'::character varying])::text[])))
);


ALTER TABLE public.invites OWNER TO kodme;

--
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
-- Name: main_folders; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.main_folders (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.main_folders OWNER TO kodme;

--
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
    document_id uuid NOT NULL,
    base_status character varying DEFAULT 'pending'::character varying NOT NULL,
    transcode_status character varying,
    attempts integer DEFAULT 0 NOT NULL,
    error_code character varying,
    error_detail text,
    payload jsonb NOT NULL,
    metadata jsonb,
    worker_id character varying,
    lease_until timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT media_processing_queue_date_created_not_null NOT NULL,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    CONSTRAINT media_processing_queue_base_status_valid CHECK (((base_status)::text = ANY ((ARRAY['pending'::character varying, 'processing'::character varying, 'done'::character varying, 'failed'::character varying])::text[]))),
    CONSTRAINT media_processing_queue_transcode_status_valid CHECK (((transcode_status)::text = ANY ((ARRAY['not_required'::character varying, 'processing'::character varying, 'done'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.media_processing_queue OWNER TO kodme;

--
-- Name: meets; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.meets (
    id uuid CONSTRAINT conferences_id_not_null NOT NULL,
    owner_id uuid NOT NULL,
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
-- Name: membership; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.membership (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    is_subscribed boolean DEFAULT false NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    banned_at timestamp with time zone,
    subscribed_at timestamp with time zone NOT NULL,
    invite_id uuid,
    CONSTRAINT membership_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['channel'::character varying, 'meet'::character varying, 'broadcast'::character varying, 'stickerpak'::character varying])::text[])))
);


ALTER TABLE public.membership OWNER TO kodme;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.messages (
    id uuid CONSTRAINT posts_id_not_null NOT NULL,
    author_id uuid,
    channel_id uuid,
    text character varying(4096),
    reply_to_message_id uuid,
    created_at timestamp with time zone CONSTRAINT posts_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_pinned boolean DEFAULT false CONSTRAINT posts_pinned_not_null NOT NULL,
    is_commenting boolean,
    sticker_document_id uuid,
    buttons jsonb,
    forwarded_to_message_id uuid,
    is_deleted boolean DEFAULT false CONSTRAINT posts_deleted_not_null NOT NULL,
    entities jsonb DEFAULT '[]'::jsonb CONSTRAINT posts_entities_not_null NOT NULL,
    action_type character varying,
    action_payload jsonb,
    random_id uuid
);


ALTER TABLE public.messages OWNER TO kodme;

--
-- Name: messages_deleted; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.messages_deleted (
    id uuid CONSTRAINT posts_deleted_id_not_null NOT NULL,
    message_id uuid CONSTRAINT posts_deleted_for_post_id_not_null NOT NULL,
    user_id uuid CONSTRAINT posts_deleted_for_user_id_not_null NOT NULL,
    deleted_at timestamp with time zone CONSTRAINT posts_deleted_date_deleted_not_null NOT NULL
);


ALTER TABLE public.messages_deleted OWNER TO kodme;

--
-- Name: photoalbums; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.photoalbums (
    id uuid NOT NULL,
    name character varying(64) NOT NULL,
    author_id uuid NOT NULL,
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
-- Name: reactions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.reactions (
    author_id uuid NOT NULL,
    reaction character varying NOT NULL,
    created_at timestamp with time zone CONSTRAINT reactions_date_created_not_null NOT NULL,
    id uuid NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL
);


ALTER TABLE public.reactions OWNER TO kodme;

--
-- Name: read_states; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.read_states (
    user_id uuid NOT NULL,
    entity_id uuid NOT NULL,
    last_read_id uuid,
    last_cleared_id uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.read_states OWNER TO kodme;

--
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
-- Name: stickerpaks; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.stickerpaks (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    name character varying(64) NOT NULL,
    created_at timestamp with time zone CONSTRAINT stickerpaks_date_created_not_null NOT NULL,
    is_deleted boolean DEFAULT false CONSTRAINT stickerpaks_deleted_not_null NOT NULL,
    about character varying(255),
    is_public boolean DEFAULT true CONSTRAINT stickerpaks_public_not_null NOT NULL
);


ALTER TABLE public.stickerpaks OWNER TO kodme;

--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.subscriptions (
    user_id uuid NOT NULL,
    entity_id uuid NOT NULL,
    entity_type character varying NOT NULL,
    mode character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT subscriptions_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['channel'::character varying, 'meet'::character varying, 'broadcast'::character varying])::text[]))),
    CONSTRAINT subscriptions_mode_check CHECK (((mode)::text = ANY ((ARRAY['all'::character varying, 'none'::character varying, 'mentions'::character varying])::text[])))
);


ALTER TABLE public.subscriptions OWNER TO kodme;

--
-- Name: themes; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.themes (
    id uuid NOT NULL,
    author_id uuid NOT NULL,
    name character varying(64) NOT NULL,
    style text NOT NULL,
    is_public boolean DEFAULT true CONSTRAINT themes_public_not_null NOT NULL,
    created_at timestamp with time zone CONSTRAINT themes_date_created_not_null NOT NULL,
    edited_at timestamp with time zone,
    is_deleted boolean DEFAULT false CONSTRAINT themes_deleted_not_null NOT NULL
);


ALTER TABLE public.themes OWNER TO kodme;

--
-- Name: user_passkeys; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.user_passkeys (
    credential_id text NOT NULL,
    user_id uuid CONSTRAINT user_passkeys_for_user_id_not_null NOT NULL,
    name character varying(64) NOT NULL,
    public_key bytea NOT NULL,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb,
    created_at timestamp with time zone CONSTRAINT user_passkeys_date_created_not_null NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE public.user_passkeys OWNER TO kodme;

--
-- Name: user_totp; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.user_totp (
    user_id uuid CONSTRAINT user_totp_for_user_id_not_null NOT NULL,
    secret character varying(64) NOT NULL,
    is_confirmed boolean DEFAULT false CONSTRAINT user_totp_confirmed_not_null NOT NULL,
    last_counter bigint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone CONSTRAINT user_totp_date_created_not_null NOT NULL,
    confirmed_at timestamp with time zone
);


ALTER TABLE public.user_totp OWNER TO kodme;

--
-- Name: user_updates; Type: TABLE; Schema: public; Owner: kodme
--

CREATE TABLE public.user_updates (
    user_id uuid NOT NULL,
    upid bigint NOT NULL,
    type character varying NOT NULL,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_updates OWNER TO kodme;

--
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
    code_confirm_attempts integer DEFAULT 0 NOT NULL,
    last_upts bigint DEFAULT 0
);


ALTER TABLE public.users OWNER TO kodme;

--
-- Name: _permissions _permissions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._permissions
    ADD CONSTRAINT _permissions_primary_id PRIMARY KEY (id);


--
-- Name: _permissions _permissions_unique_code; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._permissions
    ADD CONSTRAINT _permissions_unique_code UNIQUE (code);


--
-- Name: _role_assignments _role_assignments_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_assignments
    ADD CONSTRAINT _role_assignments_primary_id PRIMARY KEY (id);


--
-- Name: _role_assignments _role_assignments_unique; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_assignments
    ADD CONSTRAINT _role_assignments_unique UNIQUE NULLS NOT DISTINCT (user_id, role_id, channel_id);


--
-- Name: _role_permissions _role_permissions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_permissions
    ADD CONSTRAINT _role_permissions_primary_id PRIMARY KEY (role_id, permission_id);


--
-- Name: _roles _roles_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._roles
    ADD CONSTRAINT _roles_primary_id PRIMARY KEY (id);


--
-- Name: _roles _roles_unique_name_scope; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._roles
    ADD CONSTRAINT _roles_unique_name_scope UNIQUE (name, scope);


--
-- Name: attachments attachments_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_primary_id PRIMARY KEY (id);


--
-- Name: attachments attachments_unique_document_id__entity_id__entity_type; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_unique_document_id__entity_id__entity_type UNIQUE (document_id, entity_id, entity_type);


--
-- Name: bots bots_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_primary_id PRIMARY KEY (user_id);


--
-- Name: bots bots_unique_token; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_unique_token UNIQUE (token);


--
-- Name: broadcasts broadcasts_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_primary_id PRIMARY KEY (id);


--
-- Name: calls_members calls_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_primary_id PRIMARY KEY (id);


--
-- Name: calls_members calls_members_unique_call_id_and_user_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_unique_call_id_and_user_id UNIQUE (call_id, user_id);


--
-- Name: calls calls_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_primary_id PRIMARY KEY (id);


--
-- Name: channel_updates channel_updates_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channel_updates
    ADD CONSTRAINT channel_updates_primary_id PRIMARY KEY (channel_id, pts);


--
-- Name: channels channels_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_primary_id PRIMARY KEY (id);


--
-- Name: cloud_items cloud_items_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_primary_id PRIMARY KEY (id);


--
-- Name: cloud_share_link_members cloud_share_link_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_primary_id PRIMARY KEY (id);


--
-- Name: cloud_share_link_members cloud_share_link_members_unique_link_user; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_unique_link_user UNIQUE (link_id, user_id);


--
-- Name: cloud_share_link_saved cloud_share_link_saved_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_primary_id PRIMARY KEY (id);


--
-- Name: cloud_share_link_saved cloud_share_link_saved_unique_user_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_unique_user_link UNIQUE (user_id, link_id);


--
-- Name: cloud_share_links cloud_share_links_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_primary_id PRIMARY KEY (id);


--
-- Name: cloud_share_links cloud_share_links_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_unique_link UNIQUE (link);


--
-- Name: comments_members comments_members_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_primary_id PRIMARY KEY (id);


--
-- Name: comments_members comments_members_unique_user_id_and_entity; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_unique_user_id_and_entity UNIQUE (user_id, entity_id, entity_type);


--
-- Name: comments comments_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_primary_id PRIMARY KEY (id);


--
-- Name: contacts contacts_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_primary_id PRIMARY KEY (id);


--
-- Name: documents documents_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_primary_id PRIMARY KEY (id);


--
-- Name: invites invites_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_primary_id PRIMARY KEY (id);


--
-- Name: invites invites_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_unique_link UNIQUE (link);


--
-- Name: links links_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_primary_id PRIMARY KEY (id);


--
-- Name: links links_unique_entity_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_unique_entity_id UNIQUE (entity_id);


--
-- Name: links links_unique_link; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_unique_link UNIQUE (link);


--
-- Name: main_folders_channels main_folders_channels_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_primary_id PRIMARY KEY (id);


--
-- Name: main_folders_channels main_folders_channels_unique_channel_id_folder_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_unique_channel_id_folder_id UNIQUE (folder_id, channel_id);


--
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
-- Name: meets meets_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_primary_id PRIMARY KEY (id);


--
-- Name: membership membership_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_primary_id PRIMARY KEY (id);


--
-- Name: membership membership_unique_user_entity; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_unique_user_entity UNIQUE NULLS NOT DISTINCT (user_id, entity_id, entity_type);


--
-- Name: messages_deleted messages_deleted_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_primary_id PRIMARY KEY (id);


--
-- Name: messages messages_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_primary_id PRIMARY KEY (id);


--
-- Name: photoalbums photoalbums_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_primary_id PRIMARY KEY (id);


--
-- Name: photoalbums photoalbums_unique_owner_id__owner_type__type; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_unique_owner_id__owner_type__type UNIQUE (entity_type, entity_id, type);


--
-- Name: push_notifications push_notifications_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.push_notifications
    ADD CONSTRAINT push_notifications_primary_id PRIMARY KEY (id);


--
-- Name: reactions reactions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_primary_id PRIMARY KEY (id);


--
-- Name: read_states read_states_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.read_states
    ADD CONSTRAINT read_states_primary_id PRIMARY KEY (user_id, entity_id);


--
-- Name: sessions sessions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_primary_id PRIMARY KEY (id);


--
-- Name: sessions sessions_unique_token; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_unique_token UNIQUE (token);


--
-- Name: stickerpaks stickerpacks_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks
    ADD CONSTRAINT stickerpacks_primary_id PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_primary_id PRIMARY KEY (user_id, entity_id, entity_type);


--
-- Name: themes themes_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_primary_id PRIMARY KEY (id);


--
-- Name: user_passkeys user_passkeys_primary_credential_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_primary_credential_id PRIMARY KEY (credential_id);


--
-- Name: user_totp user_totp_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_totp
    ADD CONSTRAINT user_totp_primary_id PRIMARY KEY (user_id);


--
-- Name: user_updates user_updates_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_updates
    ADD CONSTRAINT user_updates_primary_id PRIMARY KEY (user_id, upid);


--
-- Name: users users_primary_id; Type: CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_primary_id PRIMARY KEY (id);


--
-- Name: _roles_one_default_per_scope; Type: INDEX; Schema: public; Owner: kodme
--

CREATE UNIQUE INDEX _roles_one_default_per_scope ON public._roles USING btree (scope) WHERE is_default;


--
-- Name: cloud_items_unique_folder_name; Type: INDEX; Schema: public; Owner: kodme
--

CREATE UNIQUE INDEX cloud_items_unique_folder_name ON public.cloud_items USING btree (owner_user_id, COALESCE(parent_id, '00000000-0000-0000-0000-000000000000'::uuid), name) WHERE (((item_type)::text = ('folder'::character varying)::text) AND (is_deleted = false));


--
-- Name: fki_attaches_foreign_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_attaches_foreign_document_id ON public.attachments USING btree (document_id);


--
-- Name: fki_broadcasts_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_created_user_id ON public.broadcasts USING btree (owner_id);


--
-- Name: fki_broadcasts_foreign_chat_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_foreign_chat_channel_id ON public.broadcasts USING btree (chat_channel_id);


--
-- Name: fki_broadcasts_foreign_thumbnail_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_broadcasts_foreign_thumbnail_document_id ON public.broadcasts USING btree (thumbnail_document_id);


--
-- Name: fki_calls_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_foreign_channel_id ON public.calls USING btree (channel_id);


--
-- Name: fki_calls_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_foreign_created_user_id ON public.calls USING btree (owner_id);


--
-- Name: fki_calls_members_foreign_call_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_members_foreign_call_id ON public.calls_members USING btree (call_id);


--
-- Name: fki_calls_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_calls_members_foreign_user_id ON public.calls_members USING btree (user_id);


--
-- Name: fki_channel_updates_created_at; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channel_updates_created_at ON public.channel_updates USING btree (created_at);


--
-- Name: fki_channels_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_created_user_id ON public.channels USING btree (owner_id);


--
-- Name: fki_channels_foreign_avatar_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_foreign_avatar_document_id ON public.channels USING btree (avatar_document_id);


--
-- Name: fki_channels_foreign_parent_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_channels_foreign_parent_channel_id ON public.channels USING btree (parent_channel_id);


--
-- Name: fki_cloud_items_foreign_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_document_id ON public.cloud_items USING btree (document_id);


--
-- Name: fki_cloud_items_foreign_owner_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_owner_user_id ON public.cloud_items USING btree (owner_user_id);


--
-- Name: fki_cloud_items_foreign_parent_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_items_foreign_parent_id ON public.cloud_items USING btree (parent_id);


--
-- Name: fki_cloud_share_link_members_foreign_link_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_members_foreign_link_id ON public.cloud_share_link_members USING btree (link_id);


--
-- Name: fki_cloud_share_link_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_members_foreign_user_id ON public.cloud_share_link_members USING btree (user_id);


--
-- Name: fki_cloud_share_link_saved_foreign_link_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_saved_foreign_link_id ON public.cloud_share_link_saved USING btree (link_id);


--
-- Name: fki_cloud_share_link_saved_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_link_saved_foreign_user_id ON public.cloud_share_link_saved USING btree (user_id);


--
-- Name: fki_cloud_share_links_foreign_item_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_links_foreign_item_id ON public.cloud_share_links USING btree (item_id);


--
-- Name: fki_cloud_share_links_foreign_owner_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_cloud_share_links_foreign_owner_user_id ON public.cloud_share_links USING btree (owner_user_id);


--
-- Name: fki_comments_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_created_user_id ON public.comments USING btree (author_id);


--
-- Name: comments_author_random_id_uk; Type: INDEX; Schema: public; Owner: kodme
--

CREATE UNIQUE INDEX comments_author_random_id_uk ON public.comments USING btree (author_id, random_id);


--
-- Name: fki_comments_foreign_reply_to_comment_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_reply_to_comment_id ON public.comments USING btree (reply_to_comment_id);


--
-- Name: fki_comments_foreign_sticker_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_foreign_sticker_document_id ON public.comments USING btree (sticker_document_id);


--
-- Name: fki_comments_members_foreign_last_viewed_comment_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_members_foreign_last_viewed_comment_id ON public.comments_members USING btree (last_viewed_comment_id);


--
-- Name: fki_comments_members_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_comments_members_foreign_user_id ON public.comments_members USING btree (user_id);


--
-- Name: fki_contacts_foreign_contact_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_contacts_foreign_contact_user_id ON public.contacts USING btree (contact_user_id);


--
-- Name: fki_contacts_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_contacts_foreign_user_id ON public.contacts USING btree (user_id);


--
-- Name: fki_documents_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_documents_foreign_created_user_id ON public.documents USING btree (author_id);


--
-- Name: fki_invites_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_invites_foreign_created_user_id ON public.invites USING btree (owner_id);


--
-- Name: fki_main_folders_channels_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_channels_foreign_channel_id ON public.main_folders_channels USING btree (channel_id);


--
-- Name: fki_main_folders_channels_foreign_folder_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_channels_foreign_folder_id ON public.main_folders_channels USING btree (folder_id);


--
-- Name: fki_main_folders_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_main_folders_foreign_user_id ON public.main_folders USING btree (owner_id);


--
-- Name: fki_meets_foreign_chat_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_chat_channel_id ON public.meets USING btree (chat_channel_id);


--
-- Name: fki_meets_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_created_user_id ON public.meets USING btree (owner_id);


--
-- Name: fki_meets_foreign_thumbnail_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_meets_foreign_thumbnail_document_id ON public.meets USING btree (thumbnail_document_id);


--
-- Name: fki_membership_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_membership_entity ON public.membership USING btree (entity_id, entity_type);


--
-- Name: fki_messages_deleted_foreign_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_deleted_foreign_message_id ON public.messages_deleted USING btree (message_id);


--
-- Name: fki_messages_deleted_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_deleted_foreign_user_id ON public.messages_deleted USING btree (user_id);


--
-- Name: fki_messages_foreign_channel_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_channel_id ON public.messages USING btree (channel_id);


--
-- Name: fki_messages_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_created_user_id ON public.messages USING btree (author_id);


--
-- Name: messages_author_random_id_uk; Type: INDEX; Schema: public; Owner: kodme
--

CREATE UNIQUE INDEX messages_author_random_id_uk ON public.messages USING btree (author_id, random_id);


--
-- Name: fki_messages_foreign_forwarded_to_message_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_forwarded_to_message_id ON public.messages USING btree (forwarded_to_message_id);


--
-- Name: fki_messages_foreign_reply_to_mesage_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_reply_to_mesage_id ON public.messages USING btree (reply_to_message_id);


--
-- Name: fki_messages_foreign_sticker_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_messages_foreign_sticker_document_id ON public.messages USING btree (sticker_document_id);


--
-- Name: fki_photoalbums_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_photoalbums_foreign_created_user_id ON public.photoalbums USING btree (author_id);


--
-- Name: fki_reactions_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_reactions_foreign_created_user_id ON public.reactions USING btree (author_id);


--
-- Name: fki_stickerpacks_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_stickerpacks_foreign_created_user_id ON public.stickerpaks USING btree (owner_id);


--
-- Name: fki_themes_foreign_created_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_themes_foreign_created_user_id ON public.themes USING btree (author_id);


--
-- Name: fki_user_passkeys_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_user_passkeys_foreign_user_id ON public.user_passkeys USING btree (user_id);


--
-- Name: fki_user_totp_foreign_user_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_user_totp_foreign_user_id ON public.user_totp USING btree (user_id);

--
-- Name: fki_user_updates_created_at; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_user_updates_created_at ON public.user_updates USING btree (created_at);


--
-- Name: fki_users_foreign_avatar_document_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_users_foreign_avatar_document_id ON public.users USING btree (avatar_document_id);


--
-- Name: fki_users_foreign_role_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX fki_users_foreign_role_id ON public.users USING btree (role_id);


--
-- Name: idx_attachments_cloud_context; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_cloud_context ON public.attachments USING btree (((entity_context ->> 'type'::text)), ((entity_context ->> 'id'::text)));


--
-- Name: idx_attachments_context_type_id; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_context_type_id ON public.attachments USING btree (((entity_context ->> 'type'::text)), ((entity_context ->> 'id'::text)));


--
-- Name: idx_attachments_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_attachments_entity ON public.attachments USING btree (entity_id, entity_type);


--
-- Name: idx_calls_active_channel; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_active_channel ON public.calls USING btree (channel_id) WHERE ((status)::text = ANY (ARRAY[('ringing'::character varying)::text, ('active'::character varying)::text]));


--
-- Name: idx_calls_members_active_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_members_active_user ON public.calls_members USING btree (user_id) WHERE (left_at IS NULL);


--
-- Name: idx_calls_members_call; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_calls_members_call ON public.calls_members USING btree (call_id);


--
-- Name: idx_cloud_items_owner_parent_deleted; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_items_owner_parent_deleted ON public.cloud_items USING btree (owner_user_id, parent_id, is_deleted, item_type, id);


--
-- Name: idx_cloud_share_link_members_link_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_link_members_link_user ON public.cloud_share_link_members USING btree (link_id, user_id);


--
-- Name: idx_cloud_share_link_saved_user_link; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_link_saved_user_link ON public.cloud_share_link_saved USING btree (user_id, link_id);


--
-- Name: idx_cloud_share_links_owner_item; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_cloud_share_links_owner_item ON public.cloud_share_links USING btree (owner_user_id, item_id);


--
-- Name: idx_comments_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_comments_entity ON public.comments USING btree (entity_id, entity_type);


--
-- Name: idx_comments_members_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_comments_members_entity ON public.comments_members USING btree (entity_id, entity_type, user_id);


--
-- Name: idx_media_processing_queue_status; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_media_processing_queue_status ON public.media_processing_queue USING btree (base_status, created_at) WHERE ((base_status)::text = ANY ((ARRAY['pending'::character varying, 'processing'::character varying])::text[]));


--
-- Name: idx_messages_deleted_message_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_messages_deleted_message_user ON public.messages_deleted USING btree (message_id, user_id);


--
-- Name: idx_messages_deleted_user_message; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_messages_deleted_user_message ON public.messages_deleted USING btree (user_id, message_id);


--
-- Name: idx_reactions_entity; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_reactions_entity ON public.reactions USING btree (entity_id, entity_type);


--
-- Name: idx_user_passkeys_user; Type: INDEX; Schema: public; Owner: kodme
--

CREATE INDEX idx_user_passkeys_user ON public.user_passkeys USING btree (user_id, created_at);


--
-- Name: _role_assignments _role_assignments_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_assignments
    ADD CONSTRAINT _role_assignments_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _role_assignments _role_assignments_foreign_role_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_assignments
    ADD CONSTRAINT _role_assignments_foreign_role_id FOREIGN KEY (role_id) REFERENCES public._roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _role_assignments _role_assignments_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_assignments
    ADD CONSTRAINT _role_assignments_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _role_permissions _role_permissions_foreign_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_permissions
    ADD CONSTRAINT _role_permissions_foreign_permission_id FOREIGN KEY (permission_id) REFERENCES public._permissions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _role_permissions _role_permissions_foreign_role_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public._role_permissions
    ADD CONSTRAINT _role_permissions_foreign_role_id FOREIGN KEY (role_id) REFERENCES public._roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attachments attachments_foreign_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_foreign_document_id FOREIGN KEY (document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: bots bots_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bots bots_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: broadcasts broadcasts_foreign_chat_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_foreign_chat_channel_id FOREIGN KEY (chat_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: broadcasts broadcasts_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: broadcasts broadcasts_foreign_thumbnail_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_foreign_thumbnail_document_id FOREIGN KEY (thumbnail_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: calls calls_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: calls calls_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT calls_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: calls_members calls_members_foreign_call_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_foreign_call_id FOREIGN KEY (call_id) REFERENCES public.calls(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: calls_members calls_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.calls_members
    ADD CONSTRAINT calls_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: channel_updates channel_updates_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channel_updates
    ADD CONSTRAINT channel_updates_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: channels channels_foreign_avatar_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_avatar_document_id FOREIGN KEY (avatar_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: channels channels_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: channels channels_foreign_parent_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_foreign_parent_channel_id FOREIGN KEY (parent_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cloud_items cloud_items_foreign_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_document_id FOREIGN KEY (document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_items cloud_items_foreign_owner_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_owner_user_id FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_items cloud_items_foreign_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_items
    ADD CONSTRAINT cloud_items_foreign_parent_id FOREIGN KEY (parent_id) REFERENCES public.cloud_items(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_link_members cloud_share_link_members_foreign_link_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_foreign_link_id FOREIGN KEY (link_id) REFERENCES public.cloud_share_links(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_link_members cloud_share_link_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_members
    ADD CONSTRAINT cloud_share_link_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_link_saved cloud_share_link_saved_foreign_link_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_foreign_link_id FOREIGN KEY (link_id) REFERENCES public.cloud_share_links(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_link_saved cloud_share_link_saved_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_link_saved
    ADD CONSTRAINT cloud_share_link_saved_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_links cloud_share_links_foreign_item_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_foreign_item_id FOREIGN KEY (item_id) REFERENCES public.cloud_items(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: cloud_share_links cloud_share_links_foreign_owner_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.cloud_share_links
    ADD CONSTRAINT cloud_share_links_foreign_owner_user_id FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: comments comments_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: comments comments_foreign_reply_to_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_reply_to_comment_id FOREIGN KEY (reply_to_comment_id) REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: comments comments_foreign_sticker_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_foreign_sticker_document_id FOREIGN KEY (sticker_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: comments_members comments_members_foreign_last_viewed_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_foreign_last_viewed_comment_id FOREIGN KEY (last_viewed_comment_id) REFERENCES public.comments(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: comments_members comments_members_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.comments_members
    ADD CONSTRAINT comments_members_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: contacts contacts_foreign_contact_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_foreign_contact_user_id FOREIGN KEY (contact_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: contacts contacts_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: documents documents_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: main_folders_channels main_folders_channels_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: main_folders_channels main_folders_channels_foreign_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders_channels
    ADD CONSTRAINT main_folders_channels_foreign_folder_id FOREIGN KEY (folder_id) REFERENCES public.main_folders(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: main_folders main_folders_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.main_folders
    ADD CONSTRAINT main_folders_foreign_user_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: meets meets_foreign_chat_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_chat_channel_id FOREIGN KEY (chat_channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: meets meets_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: meets meets_foreign_thumbnail_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.meets
    ADD CONSTRAINT meets_foreign_thumbnail_document_id FOREIGN KEY (thumbnail_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: membership membership_foreign_invite_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_foreign_invite_id FOREIGN KEY (invite_id) REFERENCES public.invites(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: membership membership_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_deleted messages_deleted_foreign_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_foreign_message_id FOREIGN KEY (message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: messages_deleted messages_deleted_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages_deleted
    ADD CONSTRAINT messages_deleted_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: messages messages_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: messages messages_foreign_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_channel_id FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: messages messages_foreign_forwarded_to_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_forwarded_to_message_id FOREIGN KEY (forwarded_to_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: messages messages_foreign_reply_to_message_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_reply_to_message_id FOREIGN KEY (reply_to_message_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: messages messages_foreign_sticker_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_foreign_sticker_document_id FOREIGN KEY (sticker_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: photoalbums photoalbums_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.photoalbums
    ADD CONSTRAINT photoalbums_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: reactions reactions_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: read_states read_states_foreign_entity_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.read_states
    ADD CONSTRAINT read_states_foreign_entity_id FOREIGN KEY (entity_id) REFERENCES public.channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: read_states read_states_foreign_last_cleared_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.read_states
    ADD CONSTRAINT read_states_foreign_last_cleared_id FOREIGN KEY (last_cleared_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: read_states read_states_foreign_last_read_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.read_states
    ADD CONSTRAINT read_states_foreign_last_read_id FOREIGN KEY (last_read_id) REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: read_states read_states_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.read_states
    ADD CONSTRAINT read_states_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stickerpaks stickerpacks_foreign_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.stickerpaks
    ADD CONSTRAINT stickerpacks_foreign_owner_id FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: subscriptions subscriptions_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: themes themes_foreign_author_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_foreign_author_id FOREIGN KEY (author_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: user_passkeys user_passkeys_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_passkeys
    ADD CONSTRAINT user_passkeys_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: user_totp user_totp_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_totp
    ADD CONSTRAINT user_totp_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: user_updates user_updates_foreign_user_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.user_updates
    ADD CONSTRAINT user_updates_foreign_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_foreign_avatar_document_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_foreign_avatar_document_id FOREIGN KEY (avatar_document_id) REFERENCES public.documents(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- Name: users users_foreign_role_id; Type: FK CONSTRAINT; Schema: public; Owner: kodme
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_foreign_role_id FOREIGN KEY (role_id) REFERENCES public._roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 51ylAEdA98J6HaOR5snhK7HFkqgw4XuZMZ23cV6aZH9oJs7jWqNPv2DWWNMBR7f


-- =============================================================================
-- Базовые данные RBAC: роли по умолчанию (пользователь, администратор, бот и
-- канальные роли), права и их назначения. Без них свежая база неработоспособна:
-- роль при регистрации и проверки прав ссылаются на эти строки.
--
-- Все вставки идемпотентны (ON CONFLICT DO NOTHING) — блок безопасно
-- повторять на уже заполненной базе.
-- =============================================================================
BEGIN;


-- Приведение имени уже засеянных стендов к канальному префиксу channel_
-- (идемпотентно: правится только строка с фиксированным id из сида)
UPDATE public._roles SET name = 'channel_member' WHERE id = '00000000-0000-7000-0000-000000000011';

-- Платформенная роль по умолчанию (назначается при регистрации)
INSERT INTO public._roles (id, name, description, scope, is_default, created_at)
VALUES
    ('00000000-0000-7000-0000-000000000001', 'user',  'Пользователь платформы по умолчанию',   'platform', true,  now()),
    ('00000000-0000-7000-0000-000000000002', 'admin', 'Администратор платформы',              'platform', false, now()),
    ('00000000-0000-7000-0000-000000000003', 'bot',   'Бот платформы: создаёт и управляет своими сущностями', 'platform', false, now())
ON CONFLICT (name, scope) DO NOTHING;

-- Канальные роли: участник по умолчанию, полный модератор и узкие
-- модераторские роли-примитивы (одно право каждая)
INSERT INTO public._roles (id, name, description, scope, is_default, created_at)
VALUES
    ('00000000-0000-7000-0000-000000000011', 'channel_member',          'Участник сущности по умолчанию',        'channel', true,  now()),
    ('00000000-0000-7000-0000-000000000013', 'channel_moderator_delete',   'Модератор: удаление чужих сообщений',  'channel', false, now()),
    ('00000000-0000-7000-0000-000000000014', 'channel_moderator_clean',    'Модератор: чистка сообщений участника','channel', false, now()),
    ('00000000-0000-7000-0000-000000000015', 'channel_moderator_post',     'Модератор: постинг в режиме админов',   'channel', false, now()),
    ('00000000-0000-7000-0000-000000000016', 'channel_moderator_restrict', 'Модератор: ограничение участников',    'channel', false, now()),
    ('00000000-0000-7000-0000-000000000017', 'channel_moderator_invite',   'Модератор: приглашение участников',    'channel', false, now()),
    ('00000000-0000-7000-0000-000000000018', 'channel_moderator_pin',      'Модератор: закрепление сообщений',     'channel', false, now())
ON CONFLICT (name, scope) DO NOTHING;

-- =============================================================================
-- 2. Базовый набор прав (модули платформы)
-- =============================================================================

INSERT INTO public._permissions (id, code, module, name, description)
VALUES
    -- Каналы и группы
    ('00000000-0000-7000-0000-000000000101', 'channels.create',    'channels', 'Создание сущностей',   'Создание каналов, групп и тем'),
    ('00000000-0000-7000-0000-000000000102', 'channels.manage',    'channels', 'Управление',           'Настройки, аватары, удаление сущности'),
    ('00000000-0000-7000-0000-000000000103', 'groups.moderate',    'groups',   'Модерация группы',     'Назначение и права модераторов'),

    -- Сообщения и участники: права модератора канала
    ('00000000-0000-7000-0000-000000000111', 'messages.delete',    'messages', 'Удаление чужих',       'Удаление сообщений других участников'),
    ('00000000-0000-7000-0000-000000000112', 'messages.clean',     'messages', 'Чистка сообщений',     'Массовая чистка сообщений участника'),
    ('00000000-0000-7000-0000-000000000113', 'messages.post',      'messages', 'Постинг в режиме админов', 'Публикация при posting_mode = admins'),
    ('00000000-0000-7000-0000-000000000121', 'members.restrict',   'members',  'Ограничение участников', 'Бан и разбан участников'),
    ('00000000-0000-7000-0000-000000000122', 'members.invite',     'members',  'Приглашение',          'Приглашение участников по ссылкам'),
    ('00000000-0000-7000-0000-000000000131', 'messages.pin',        'messages', 'Закрепление',          'Закрепление и открепление сообщений'),

    -- Трансляции
    ('00000000-0000-7000-0000-000000000141', 'streams.publish',    'streams',  'Вещание',              'Запуск и управление трансляцией'),

    -- Встречи и трансляции: создание и скоупы списков
    ('00000000-0000-7000-0000-000000000151', 'meets.create',        'meets',      'Создание конференций',     'Создание встреч с чатом'),
    ('00000000-0000-7000-0000-000000000152', 'broadcasts.create',   'broadcasts', 'Создание трансляций',      'Создание трансляций с чатом'),
    ('00000000-0000-7000-0000-000000000153', 'meets.list_all',      'meets',      'Полный список конференций',  'Список всех доступных конференций, а не только созданных собой'),
    ('00000000-0000-7000-0000-000000000154', 'broadcasts.list_all', 'broadcasts', 'Полный список трансляций',   'Список всех доступных трансляций, а не только созданных собой'),

    -- Управление сущностями (enforcement: AccessService.hasPermission)
    ('00000000-0000-7000-0000-000000000155', 'meets.manage',        'meets',      'Управление конференциями', 'Настройки, обложка, приглашения, удаление встречи'),
    ('00000000-0000-7000-0000-000000000156', 'broadcasts.manage',   'broadcasts', 'Управление трансляциями',  'Настройки, обложка, приглашения, удаление трансляции')
ON CONFLICT (code) DO NOTHING;

-- =============================================================================
-- 3. Связь роль → права
-- =============================================================================

-- Узкие модераторские роли: каждая получает своё одно право
INSERT INTO public._role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM (VALUES
    ('channel_moderator_delete',    'messages.delete'),
    ('channel_moderator_clean',     'messages.clean'),
    ('channel_moderator_post',      'messages.post'),
    ('channel_moderator_restrict',  'members.restrict'),
    ('channel_moderator_invite',    'members.invite'),
    ('channel_moderator_pin',       'messages.pin')
) AS rp(role_name, permission_code)
JOIN public._roles r ON r.name = rp.role_name AND r.scope = 'channel'
JOIN public._permissions p ON p.code = rp.permission_code
ON CONFLICT DO NOTHING;

-- Базовый срез платформы: бот, человек и админ (создание сущностей и
-- управление; админ также владеет всеми правами кросс-джойном ниже)
INSERT INTO public._role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM public._roles r
JOIN public._permissions p ON p.code IN (
    'channels.create', 'channels.manage',
    'meets.create', 'broadcasts.create',
    'meets.manage', 'broadcasts.manage',
    'streams.publish'
)
WHERE r.scope = 'platform'
  AND r.name IN ('bot', 'user', 'admin')
ON CONFLICT DO NOTHING;

-- Полные списки конференций/трансляций — только людям: боту list_all не
-- выдаётся, его списки остаются «только созданные им»
INSERT INTO public._role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM public._roles r
JOIN public._permissions p ON p.code IN ('meets.list_all', 'broadcasts.list_all')
WHERE r.scope = 'platform'
  AND r.name IN ('user', 'admin')
ON CONFLICT DO NOTHING;

-- Администратор платформы: всё
INSERT INTO public._role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM public._roles r
CROSS JOIN public._permissions p
WHERE r.name = 'admin' AND r.scope = 'platform'
ON CONFLICT DO NOTHING;

-- Участник по умолчанию: только создание своих сущностей
INSERT INTO public._role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM public._roles r
JOIN public._permissions p ON p.code = 'channels.create'
WHERE r.name = 'user' AND r.scope = 'platform'
ON CONFLICT DO NOTHING;

-- =============================================================================
-- 4. Назначения: платформенная роль по умолчанию всем пользователям
-- =============================================================================

UPDATE public.users u
SET role_id = r.id
FROM public._roles r
WHERE r.name = 'user' AND r.scope = 'platform' AND r.is_default = true
  AND u.role_id IS NULL;

COMMIT;

