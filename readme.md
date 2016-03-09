## A Simple Laravel App 

### Installation

Clone the repository.

Run `docker-compose up` from inside the repository to deploy a Laravel app container and a MySQL db container.

Attach to the app container using `docker exec`:

	$ docker exec -it laravelapp_app_1 /bin/bash

And run the following to migrate and seed the database:

	$ php artisan migrate
	$ php artisan db:seed
