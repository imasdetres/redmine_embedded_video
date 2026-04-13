redmine_embedded_video
======================

Author: Jan Pilz  (see http://www.redmine.org/issues/5171)

Video player: [Video.js](https://videojs.com/) (open-source, loaded from CDN)

Installation:

- git clone into redmine to plugins directory
- rake redmine:plugins:migrate RAILS_ENV=production
- restart redmine

Usage:

* `{{video(<ATTACHMENT>|<URL>|<YOUTUBE_URL>[,<width>,<height>])}}`

For external urls just use the complete http url to the video:
* `{{video(http://youtu.be/o9aA9wCQ9co)}}`

You can set video width and height:
* `{{video(http://youtu.be/o9aA9wCQ9co,640,480)}}`

For relative scale just enter one value:
* `{{video(http://youtu.be/o9aA9wCQ9co,640)}}`

For attached videos, don't use any path in front of attachment filename:
* `{{video(demo.mp4)}}`
* `{{video(clip.webm)}}`

Supported video formats: MP4, WebM, OGG (and HLS/DASH via Video.js).
