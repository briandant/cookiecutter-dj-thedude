# {{ cookiecutter.project_slug }}

You made it.  It's another Saturday night, another Django project.  This is *the one.*  

Get started:

```sh
make 
```

Your `.venv/` should be ready to go.  If you need to clean up and try again:

```sh
make clean 
make .venv/bin/activate 
```

## Deployment

`flyctl lauch`.  This will take you through the steps to create a Fly.io app, and configue it how you want.  These steps will include options for the database.  Your `settings.py` is ready to go, as is, for Postgres.  Fly.io will create the `DATABASE_URL` and drop it into your app secrets, along with a fresh `SECRET_KEY`.

Be sure to read the conditions about Postgres on Fly.io: <https://fly.io/docs/postgres/getting-started/what-you-should-know/>.
