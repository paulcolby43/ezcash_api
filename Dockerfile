FROM ruby:2.7.1

# Change to the application's directory
WORKDIR /application

# Copy application code
COPY . /application

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["rails", "tud_socketing:start"]

# Install FreeTDS
RUN apt-get update
RUN apt-get install -y freetds-dev freetds-bin tdsodbc

# RUN apt-get install -y build-essential libpq-dev nodejs

RUN apt-get install vim -y --force-yes

# Install gems
RUN bundle install

# ENTRYPOINT [ "/bin/bash" ]
