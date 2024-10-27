all: test-parallel

flake.lock: flake.nix
	LD_LIBRARY_PATH="" nix flake update

requirements.txt: requirements.in flake.lock
	pip-compile --generate-hashes --allow-unsafe --output-file requirements.txt requirements.in

test: requirements.txt static/output.css
	tox

test-parallel: requirements.txt static/output.css
	tox --parallel

# local environment
.venv/bin/activate: requirements.txt
	test -d .venv || python3 -m venv .venv
	.venv/bin/pip install --no-deps -Ur requirements.txt
	touch .venv/bin/activate

static/output.css: static/src/input.css node_modules/.bin/tailwindcss tailwind.config.js
	npx tailwindcss -i ./static/src/input.css -o ./static/output.css

runserver: .venv/bin/activate node_modules/.bin/tailwindcss static/output.css
	.venv/bin/python manage.py runserver

migrate: .venv/bin/activate
	.venv/bin/python manage.py migrate

.PHONY: shell
shell: .venv/bin/activate
	.venv/bin/python manage.py shell

makemigrations: .venv/bin/activate
	.venv/bin/python manage.py makemigrations

node_modules/.bin/tailwindcss: package-lock.json
	npm install --no-audit
	touch node_modules/.bin/tailwindcss

package-lock.json: package.json

tailwindbuild: node_modules/.bin/tailwindcss
	npx tailwindcss -i ./static/src/input.css -o ./static/output.css

tailwindwatch: node_modules/.bin/tailwindcss
	npx tailwindcss -i ./static/src/input.css -o ./static/output.css --watch

node_modules/.bin/rustywind: package-lock.json
	npm install --no-audit
	touch node_modules/.bin/rustywind

rustywind: node_modules/.bin/tailwindcss
	npx rustywind . --write

initdb: 
	.venv/bin/python manage.py createsuperuser --noinput --username superlocal --email superlocal@localhost
	echo "Now run .venv/bin/python manage.py changepassword superlocal"

.PHONY: clean
clean:
	rm -rf .venv
	rm -rf node_modules
	rm -rf local_pg
	rm -rf static/output.css
	rm -rf .tox
	rm -rf .overmind.sock
	find . -name __pycache__ -exec rm -rf {} \;
