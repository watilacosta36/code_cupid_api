FROM ruby:3.3.3-slim-bullseye

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential  postgresql-client git libpq-dev libvips pkg-config vim

ENV BUNDLER_VERSION=2.5.6
ENV ELASTICSEARCH_URL=http://opensearch:9200

WORKDIR /home/code_cupid
COPY Gemfile /home/code_cupid/Gemfile
COPY Gemfile.lock /home/code_cupid/Gemfile.lock

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle install

RUN chown -R $USER:$USER .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
