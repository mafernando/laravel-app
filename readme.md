## A Simple Laravel App 

### Installation

Clone the repository and then run `docker-compose up` to spin up a Laravel app container connected to a MySQL db container.

Attach to the app container using docker exec:

	$ docker exec -it laravelapp_app_1 /bin/bash

And run the following to migrate and seed the database:

	$ php artisan migrate
	$ php artisan db:seed
