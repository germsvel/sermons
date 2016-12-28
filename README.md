# Sermons

An application to search sermons by passage.

## Setting up dev environment

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Testing

We are tesing with ExUnit, [Hound](https://github.com/HashNuke/hound) for feature specs, and [ExMachina](https://github.com/thoughtbot/ex_machina) for factories.

For Hound, we are using phantomjs as the webdriver.

```bash
brew install phantomjs
```

And then make sure it's running,

```bash
phantomjs --wd
```

## Deploy

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
