FROM ruby:2.2.0
RUN rm /etc/apt/sources.list
RUN apt-get update -qq

# RUN apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev \
#   libtheora-dev libtool libvorbis-dev pkg-config texi2html zlib1g-dev yasm
# RUN mkdir ~/ffmpeg_sources
# WORKDIR ~/ffmpeg_sources
# RUN wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
# RUN tar xjvf ffmpeg-snapshot.tar.bz2
# WORKDIR ffmpeg
# RUN PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
#   --prefix="$HOME/ffmpeg_build" \
#   --pkg-config-flags="--static" \
#   --extra-cflags="-I$HOME/ffmpeg_build/include" \
#   --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
#   --bindir="$HOME/bin" \
#   --enable-libass \
#   --enable-nonfree \
#   && PATH="$HOME/bin:$PATH" make && make install && make distclean && hash -r
# RUN mkdir /myapp
# WORKDIR /myapp
# ADD . /myapp
# RUN bundle install
# RUN cp ~/bin/ffmpeg /bin/ffmpeg

# RUN bundle exec rails c

RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN apt-get -y dist-upgrade
RUN apt-get -y --force-yes update && apt-get install --force-yes -y deb-multimedia-keyring 
RUN apt-get -y --force-yes install libass-dev ffmpeg
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile  
ADD Gemfile.lock /myapp/Gemfile.lock  
RUN bundle install
ADD . /myapp
# CMD foreman start
