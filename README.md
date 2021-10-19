# Pokémon Couture

A work-in-progress Phoenix app for tracking clothes acquisition in Pokémon Sun & Moon.

Only supports female clothes for now, and has only been checked against a
Pokémon Moon cartridge (and a bulbapedia clothes list.)
Another check against Pokémon Sun would be useful.

I run a public version of the site at: https://couture.pikachu.rocks/

Currently, you need to have an account on the site to be able to use the tracker.
Also, there is no e-mail server connected, so e-mails are not verified,
and password resets and e-mail changes have to be done by contacting the admin.

## TODO: Installation
Here is how to spin up your own Pokémon Couture Instance.
1. Make sure you have [Elixir](https://elixir-lang.org/install.html), [Phoenix](https://hexdocs.pm/phoenix/installation.html), and a database like [PostgreSQL](https://wiki.postgresql.org/wiki/Detailed_installation_guides) installed. You will also need `npm`. Also make sure that you have a C compiler and make.
2. Clone this git repository.
3. In the repository folder, run `mix deps.get`
At this point the setup is good enough for local testing. You can run `iex -S mix phx.server` and go to `localhost:4000` to see the page in action.
For instructions on running the app in prod, read below.
### Running in prod
To run the application in prod, you need to do some additional setup. Essentially the contents of the [Phoenix deployment guide](https://hexdocs.pm/phoenix/1.5.13/deployment.html#content).
1. `export` the SECRET_KEY_BASE and DATABASE_URL bash variables. You can get a secret with `mix phx.gen.secret`.
2. Run `npm install` in the `assets` subfolder, then run `npm run deploy --prefix ./assets` in the project root folder.
3. Run `mix phx.digest` in the root folder.
4. Run the server with PORT, HOST and MIX_ENV variables set, i.e. `PORT=4001 MIX_ENV=prod HOST=couture.pikachu.rocks mix phx.server` (or `PORT=4001 MIX_ENV=prod HOST=couture.pikachu.rocks elixir --erl "-detached" -S mix phx.server`).
## License and attributions
`assets/static/images/pikachu.png` is a [pikachu icon by WEBTECHOPS LLP from the Noun Project](https://thenounproject.com/term/pokemon/2122740/), licensed as Creative Commons CCBY.

## Possible future improvements
While the app is currently in a state that works, there are some improvements I would like to make for it later down the line.

Some of those are:
- Support for male clothes
- Support for the few extra items from Ultra Sun and Ultra Moon
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
