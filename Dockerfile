# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.1.10-alpine

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER Kleber Infante <corujito@gmail.com>

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/mercadinho

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

# Install essential Linux packages
RUN apk --update add --virtual build-dependencies build-base libc-dev linux-headers git && \ 
	apk --update add nodejs postgresql-dev tzdata && \
	mkdir -p $RAILS_ROOT/tmp/pids && \
    gem install bundler -v 1.14.6 --no-ri --no-rdoc && \
    bundle install --without development test && \
    apk del build-dependencies


# Create application home. App server will need the pids dir so just create everything in one shot
#RUN mkdir -p $RAILS_ROOT/tmp/pids

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
# Finish establishing our Ruby enviornment
#RUN gem install bundler --no-ri --no-rdoc && bundle install --without development test

# Copy the Rails application into place
COPY . .

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "config/containers/app_cmd.sh" ]
