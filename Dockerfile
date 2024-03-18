FROM ruby:2.3
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt-get update -qq
RUN  apt-get install -y nodejs imagemagick ffmpeg wkhtmltopdf dcmtk openssl libssl-dev
RUN mkdir /docker_app
WORKDIR /docker_app
COPY Gemfile /docker_app/Gemfile
COPY Gemfile.lock /docker_app/Gemfile.lock
RUN bundle install
COPY . /docker_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]


