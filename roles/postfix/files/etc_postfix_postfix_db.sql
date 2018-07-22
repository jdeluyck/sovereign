-- If tables are not dropped, have to truncate before insert or use "insert or replace" (not postgres compatible)

DROP TABLE IF EXISTS "virtual_users";
DROP TABLE IF EXISTS "virtual_aliases";
DROP TABLE IF EXISTS "virtual_domains";

CREATE TABLE IF NOT EXISTS "virtual_domains" (
        "id" SERIAL,
        "name" TEXT NOT NULL,
        PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX name_idx ON virtual_domains (name);

CREATE TABLE IF NOT EXISTS "virtual_users" (
        "id" SERIAL,
        "domain_id" int NOT NULL,
        "password" TEXT NOT NULL,
        "email" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("id"),
        FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);


CREATE UNIQUE INDEX email_idx ON virtual_users (email);

CREATE TABLE IF NOT EXISTS "virtual_aliases" (
        "id" SERIAL,
        "domain_id" int NOT NULL,
        "source" TEXT NOT NULL,
        "destination" TEXT NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);

CREATE INDEX source_idx ON virtual_aliases (source);

