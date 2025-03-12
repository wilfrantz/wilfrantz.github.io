FROM jekyll/jekyll:latest

WORKDIR /site

# Install build tools and nodejs
RUN apt-get update && apt-get install -y build-essential nodejs && rm -rf /var/lib/apt/lists/*

# Copy only the Gemfile and Gemfile.lock (for faster builds)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy your site files
COPY . .

# Expose the Jekyll server port
EXPOSE 4000

# Start the Jekyll server
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
