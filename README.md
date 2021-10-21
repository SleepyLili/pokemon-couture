# Pokémon Couture

A work-in-progress Phoenix app for tracking clothes acquisition in Pokémon Sun & Moon. Only supports female clothes for now.

I run a public version of the site at: https://couture.pikachu.rocks/ 

Currently, you need to have an account on the site to be able to use the tracker.
Also, there is no e-mail server connected, so e-mails are not verified,
and password resets and e-mail changes have to be done by contacting the admin.

## Installation
Here is how to spin up your own Pokémon Couture Instance.
1. Make sure you have [Elixir](https://elixir-lang.org/install.html),
[Phoenix](https://hexdocs.pm/phoenix/installation.html),
and a database like [PostgreSQL](https://wiki.postgresql.org/wiki/Detailed_installation_guides) installed.
You will also need `npm`. Also make sure that you have a C compiler and `make`.
2. Clone this git repository.
3. In the repository folder, run `mix deps.get`
At this point the setup is good enough for local testing.
You can run `mix ecto setup`, then `iex -S mix phx.server` to get the server running.
Go to `localhost:4000` to see the page in action.
### Running in prod
To run the application in prod, you need to set a few environment variables, and run a few more commands.
#### Environment variables
- `MIX_ENV=prod`
- `SECRET_KEY_BASE` for your secret. You can generate one with `mix phx.gen.secret`.
- `DATABASE_URL` in the format of `ecto://USER:PASS@HOST/database` to connect to your database.
- `PORT` for your app port. (usually 4000 or 4001)
##### Optional:
- `SENTRY_DSN` for your Sentry DSN if you're planning to track errors with Sentry.
#### Preparing prod
All of those commands are assuming you set the environment variables above.
1. Run `npm install` in the `assets` subfolder, then run `npm run deploy --prefix ./assets` in the project root folder.
2. Run `mix phx.digest` in the project root folder.
3. Run `mix ecto.setup` to set up the database (and seed it).

Now you can run the server. `mix phx.server` (or `elixir --erl "-detached" -S mix phx.server` for detached mode).

You may also want to set up something like Caddy or nginx as a reverse proxy.

## License and attributions
`assets/static/images/pikachu.png` is a [pikachu icon by WEBTECHOPS LLP from the Noun Project](https://thenounproject.com/term/pokemon/2122740/), licensed as Creative Commons CCBY.
The source code is licensed under [AGPL](LICENSE.md).
## Possible future improvements
While the app is currently in a state that works, there are some improvements I would like to make for it later down the line.

Some of those are:
- Support for male clothes
- Support for the few extra items from Ultra Sun and Ultra Moon
- Check the list against a real Pokémon Sun game (I only checked with my own Pokémon Moon cartridge.)
- A version of the tracker that works without an account
  - A transfer feature that allows to copy that progress upon account creation
- Working e-mail verification
- Better look for the tracker page
  - Display clothes in a more organized manner
  - Sort clothes the same way the game does it

## Other clothing masterlists - inacuraccies
My app has adapted the following masterlists, however, when checking in the
actual Pokémon Moon game, I found several inacuraccies:

- https://samurai-gamers.com/pokemon-sun-and-moon/apparel-items-list/ is missing an entire shop.
Some pieces list wrong colors, or misattribute gender.
- https://www.serebii.net/sunmoon/customisation.shtml is incomplete.
- https://bulbapedia.bulbagarden.net/wiki/Fashion_item seems to be accurate.
