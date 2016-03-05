## A Simple Laravel App 

### Installation

Clone the repository.

Next, enter the project's root directory and install the project dependencies:

    $ composer install

Next, configure your database (`config/database.php`).

	$ php artisan migrate

Next, seed the database:

	$ php artisan db:seed

Finally, fire up the PHP development server:

	$ php artisan servee
