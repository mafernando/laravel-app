## A Simple Laravel App 

### Installation

Clone the repository.

Generate a Dockerfile and a docker-compose.yml and add them to the respository. 

Then run `docker-compose up` from inside the repository to deploy a Laravel/MySQL on two connected containers.

Attach to the app container:

	$ docker exec -it laravelapp_app_1 /bin/bash

And run the following to migrate and seed the database:

	$ php artisan migrate
	$ php artisan db:seed

The app should now be visible on port 80 of your docker-machine IP address.
