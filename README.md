# Before deploy to production

1. Set real host for email configuration
    - Check the `config/environments/production.rb` file for the `config.action_mailer.default_url_options` and `config.action_mailer.asset_host` configurations.
2. If you're using Ubuntu 20.04, you need to follow these step to fix the "image variant" problems. 

    - The FFI version included with Ubuntu 20.04 in too old. So, the key is to uninstall the gem and then reinstall it with the correct flag to force it to ignore the system ffi library.

    - First uninstall the gem:
      - `gem uninstall ffi`

    - Then reinstall it with disable flag:
      - `gem install ffi -- --disable-system-libffi`

    - Now the ffi gem should use its own libffi library instead of the system library.
3. Set environment variables in production server. You can use the following command to set environment variables in production server (we don't use dotenv-rails in the production).
    - `export SECRET_KEY_BASE=your_secret_key_base`
    - `source ~/.bashrc`
    - also you should check the `RAILS_ENV` variable is set to `production` or not, by using the following command:
      - `env` or `echo $RAILS_ENV`
4. Install the `yarn` in the production server.
    - `sudo npm install -g yarn`
6. This app uses MySQL (**MariaDB**) as the database. Can not use pure MySQL, you will get error like this:
    - `Mysql2::Error: BLOB, TEXT, GEOMETRY or JSON column 'description' can't have a default value`
5. Install the MySQL client library on the server where you're deploying the app.
    - `sudo apt-get install libmariadb-dev`
    - `sudo apt-get install libmysqlclient-dev`
6. Create a MySQL user in the db server and grant all privileges to the user. So that the Rails app can access the db.
    - `SELECT user FROM mysql. user;`
    - `CREATE USER '[your_user]'@'[rails_host_server_ip]' IDENTIFIED BY '[your_password]';`
    - `GRANT ALL PRIVILEGES ON *.* TO '[your_user]'@'[rails_host_server_ip]' WITH GRANT OPTION;`
    - `FLUSH PRIVILEGES;`
7. Update the `config/database.yml` file with the production database configurations.
8. Check if the s3 bucket is configured correctly in the `config/storage.yml` file.
9. Update webhook url in the PayOS dashboard to your production server's webhook url.
    - `https://your_domain.com/vendor/payment/verify-payment`


# Development

Set up the development environment by following the steps below:

1. Command to build the redis image:
    - `docker build -t redis_image ./redis/.`
2. Command to create a network:
    - `docker network create rails`
3. Command to run the redis container:
    - `docker run --network rails --name redis_container -p 6379:6379 -d redis_image`