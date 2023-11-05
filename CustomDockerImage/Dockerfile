# Use the MySQL base image
FROM mysql:latest

LABEL description="A centralized MySQL database server initialized with the Classic Models sample database"

# Set the MySQL root password
ENV MYSQL_ROOT_PASSWORD 5trathm0re

# Copy the MySQL initialization SQL file into the container
# The MySQL base image is set to execute all the scripts in
# the location /docker-entrypoint-initdb.d/ when the
# container is being created for the first time.
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Create a volume to persist MySQL data
VOLUME /var/lib/mysql

# Expose the MySQL port 3306 for remote access
EXPOSE 3306

# Start the MySQL server
CMD ["mysqld"]

# STEP 1:
# To build the image:
# docker build -t coursefiles/db-mysql-centralized-image:1.0 .

# STEP 2:
# To create and run a container using the image:
# docker run --name db-mysql-centralized-custom -d -v "C:/Users/aomondi/Documents/Docker/db-mysql-centralized-custom/var-lib-mysql:/var/lib/mysql" -p 33006:3306 coursefiles/db-mysql-centralized-image:1.0

# OR

# docker run --name db-mysql-centralized-custom -d \
#     -v "C:/Users/aomondi/Documents/Docker/db-mysql-centralized-custom/var-lib-mysql:/var/lib/mysql" \
#     -p 33006:3306 \
#     coursefiles/db-mysql-centralized-image:1.0

# STEP 3:
# Ensure you have logged in to Docker Hub
# docker login

# Tag the image
# docker tag coursefiles/db-mysql-centralized-image:1.0 coursefiles/db-mysql-centralized-image:1.0

# Push the image
# docker push coursefiles/db-mysql-centralized-image:1.0

# Pull the image
# docker pull coursefiles/db-mysql-centralized-image:1.0

# Run the pulled image
# docker run --name db-mysql-centralized-pulled -d \
#     -p 33008:3306 \
#     coursefiles/db-mysql-centralized-image:1.0