FROM ubuntu:latest

WORKDIR /site

# Install necessary packages
RUN apt-get update && apt-get install -y build-essential nodejs ruby-full ruby-dev bundler git && rm -rf /var/lib/apt/lists/*

# Copy only the Gemfile and Gemfile.lock (for faster builds)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy your site files
COPY . .

# Expose the Jekyll server port
EXPOSE 4000

# Start the Jekyll server
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
