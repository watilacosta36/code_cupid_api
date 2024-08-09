FROM ruby:3.3.3-slim-bullseye

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential  postgresql-client git libpq-dev libvips pkg-config vim

ENV BUNDLER_VERSION=2.5.6
ENV ELASTICSEARCH_URL=http://opensearch:9200

WORKDIR /home/programmers_dating
COPY Gemfile /home/programmers_dating/Gemfile
COPY Gemfile.lock /home/programmers_dating/Gemfile.lock

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle install

RUN chown -R $USER:$USER .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
