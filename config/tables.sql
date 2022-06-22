-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.users
(
    id serial NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    profile_image text NOT NULL,
    created_at timestamp without time zone DEFAULT NOW(),
    email text NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (username),
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS public.sessions
(
    id serial NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id),
    UNIQUE (token)
);

CREATE TABLE IF NOT EXISTS public.posts
(
    id serial NOT NULL,
    user_id integer NOT NULL,
    message text,
    shared_url text NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    deleted boolean NOT NULL DEFAULT false,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.hashtags
(
    id serial NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS public.posts_hashtags
(
    id serial NOT NULL,
    post_id integer NOT NULL,
    hashtag_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.likes
(
    id serial NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id),
    CONSTRAINT both_user_and_post_unique UNIQUE (user_id, post_id)
);

CREATE TABLE IF NOT EXISTS public.comments
(
    id serial NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.follows
(
    id serial NOT NULL,
    followed_id integer NOT NULL,
    follower_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.reposts
(
    id serial NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT NOW(),
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.sessions
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.posts
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.posts_hashtags
    ADD FOREIGN KEY (post_id)
    REFERENCES public.posts (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.posts_hashtags
    ADD FOREIGN KEY (hashtag_id)
    REFERENCES public.hashtags (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.likes
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.likes
    ADD FOREIGN KEY (post_id)
    REFERENCES public.posts (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.comments
    ADD FOREIGN KEY (post_id)
    REFERENCES public.posts (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.comments
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.follows
    ADD FOREIGN KEY (followed_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.follows
    ADD FOREIGN KEY (follower_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reposts
    ADD FOREIGN KEY (post_id)
    REFERENCES public.posts (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reposts
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;