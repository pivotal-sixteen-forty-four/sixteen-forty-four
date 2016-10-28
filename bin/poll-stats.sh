#!/bin/bash -e

API_SECRET=$1
TMPFILE=/tmp/stats.csv
curl https://mixpanel.com/api/2.0/jql -u $API_SECRET: --data-urlencode script@bin/poll-stats.js \ | jq -r '. | map([.name, .time] | @csv) | join("\n")' > "$TMPFILE"

sqlite3 stats.db <<SQL
  CREATE TABLE IF NOT EXISTS stats (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, event TEXT, time INTEGER);
  CREATE UNIQUE INDEX IF NOT EXISTS unique_events ON stats(event, time);
SQL
gem install sqlite3
ruby -r csv -r sqlite3 -e 'db = SQLite3::Database.new("stats.db"); CSV.read("/tmp/stats.csv").each {|row| db.execute("insert into stats(event, time) VALUES (?, ?)", row[0], row[1]) rescue nil}'

