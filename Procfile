web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bin/sidekiq -e $RAILS_ENV
release: bin/rails db:migrate
