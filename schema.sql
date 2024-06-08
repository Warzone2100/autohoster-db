create table accounts (
  id serial primary key,
  username text not null,
  password text not null,
  email text not null,
  account_created timestamp default now(),
  last_seen timestamp default now(),
  superadmin boolean default false,
  terminated boolean default false,
  email_confirmed timestamp,
  email_confirm_code text,
  wz_confirm_code text,
  wz_recovery_code text,
  allow_host_request boolean default false,
  no_request_reason text default '0',
  bypass_ispban boolean default false,
  display_name text,
  last_request timestamp not null default now(),
  last_report timestamp not null default now()
);

create table announcements (
  id serial primary key,
  when_posted timestamp not null default now(),
  title text not null,
  content text not null,
  color text not null default 'primary'::text
);

create table identities (
  id serial primary key,
  pkey text unique,
  hash text not null unique,
  account int references accounts
);

create table bans (
  id serial primary key,
  account int references accounts(id),
  identity int references identities(id),
  time_issued timestamp not null default now(),
  time_expires timestamp,
  reason text not null default 'bonk',
  forbids_joining bool not null default true,
  forbids_chatting bool not null default false,
  forbids_playing bool not null default false
);

create table games (
  id serial primary key,
  version text not null,
  instance int not null,
  time_started timestamp default now(),
  time_ended timestamp,
  setting_scavs int not null,
  setting_alliance int not null,
  setting_power int not null,
  setting_base int not null,
  map_name text not null,
  map_hash text not null,
  mods text not null,
  deleted bool not null default false,
  hidden bool not null default false,
  debug_triggered bool not null default false,
  game_time int,
  research_log json,
  graphs json,
  display_category int
);

create table players (
  game int references games(id),
  identity int references identities(id),
  position int not null,
  team int not null,
  color int not null,
  props json
);

create table rating_categories (
  id serial primary key,
  time_starts timestamp not null default now(),
  time_ends timestamp,
  name text not null
);

create table games_rating_categories (
  game int references games(id),
  category int references rating_categories(id),
  unique(game, category)
);

create table rating (
  account int references accounts(id),
  category int references rating_categories,
  elo int not null default 1400,
);
