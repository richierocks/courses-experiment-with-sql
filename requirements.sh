# If bash command fails, build should error out
set -e

## COPY OF INTRO TO SQL
# Get the data zip and unpack
apt-get update && apt-get install -y unzip
BASE_DIR=$(pwd)
FILMS_REPO="https://assets.datacamp.com/course/tmp_fixme_filip/films.zip"
mkdir -p courses-intro-to-sql/data
wget $FILMS_REPO
unzip films.zip -d courses-intro-to-sql/data
rm films.zip

# Load the database into postgreSQL
service postgresql start \
  && sudo -u postgres createdb -O repl films \
  && cd courses-intro-to-sql \
  && sudo -u postgres psql films < data/films/films.sql \
  && service postgresql stop

# Go back to base dir
cd /home/repl

# COPY OF POSTGRESQL
COUNTRIES_ZIP="https://s3.amazonaws.com/assets.datacamp.com/production/course_4785/datasets/countries2.zip"
LEADERS_ZIP="https://s3.amazonaws.com/assets.datacamp.com/production/course_4785/datasets/leaders2.zip"
DIAGRAMS_ZIP="https://s3.amazonaws.com/assets.datacamp.com/production/course_4785/datasets/diagrams.zip"
apt-get update && apt-get install -y unzip
mkdir -p courses-joining-data-in-postgresql/data
wget $COUNTRIES_ZIP
unzip countries2.zip -d courses-joining-data-in-postgresql/data

service postgresql start \
  && sudo -u postgres createdb -O repl countries \
  && cd courses-joining-data-in-postgresql/data \
  && sudo -u postgres psql countries < countries.sql \
  && service postgresql stop

# override installs from sql-shared
pip3 install jinja2==2.10
pip3 install git+https://github.com/datacamp/protowhat.git/@fs/refactor --upgrade --no-dependencies
pip3 install git+https://github.com/datacamp/sqlwhat.git/@fs/refactor --upgrade --no-dependencies
