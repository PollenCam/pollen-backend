[![Build Status](https://travis-ci.org/PollenCam/pollen-backend.svg?branch=master)](https://travis-ci.org/PollenCam/pollen-backend)

# README

Why hello there, README. I didn't see you there the past...few months.

Anyway, I should probably document stuff here.

# Environment Variables

## Production

- `DEVISE_SECRET_KEY` - set this with `$ bundle exec rake secret`

## Development

- `SPEC_NOTIFICATIONS` - this should be `true` if you're using macOS and you want audio / visual notifications for your test results
- `GENERATE_DOCS` - set to `true` if you want to regenerate the documentation at `API_DOCUMENTATION.md`. Note that the Table of Contents was made with `markdown-toc`
