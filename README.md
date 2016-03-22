# Sixteen-Forty-Four (1644) Kiosk

A kiosk intended to be used on a touch screen that manages events for the 1644 Platte St. location.

## Dev setup

```bash
bin/setup # install deps and create DB
bin/rake # run tests
```

## CI/Deployment

The repo is configured to run on [CircleCI](https://circleci.com) on every
 push and deploy to [PWS](http://sixteen-forty-four.run.pivotal.io) on
 successful build. Developer access to PWS [here](https://console.run.pivotal.io).

## Configuration

The application uses Amazon S3 for content delivery (image uploads, etc.).
For image uploads and S3 access to work, you must configure the following
environment variables:

```
AWS_ACCESS_KEY_ID=my-access-key
AWS_SECRET_ACCESS_KEY=my-secret
S3_BUCKET=my-bucket-name
```