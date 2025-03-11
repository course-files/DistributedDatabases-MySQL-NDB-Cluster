# STEP 1. Create a directory to store the configuration files and data files for the MySQL NDB Cluster
# Create the following directories:
Folder 1: .../mysql/manager-node
Folder 2: .../mysql/data-node-1
Folder 3: .../mysql/data-node-2
Folder 4: .../mysql/sql-node-1
Folder 5: .../mysql/sql-node-2

# STEP 2. Create a network to be used by the cluster
# Execute the following command to create a network called “mysql-ndb-cluster” that uses the IP addresses 172.16.60.x.

docker network create mysql-ndb-cluster --subnet=172.16.60.0/24

# STEP 3. Create the MySQL NDB Cluster Management Node
# Execute the following command to create the MySQL NDB Cluster Management node first:

docker run -d --net=mysql-ndb-cluster --hostname db-mysql-ndb-cluster-manager \
    --name=db-mysql-ndb-cluster-manager --ip=172.16.60.11 \
    -v "/$(pwd)/mysql/manager-node:/var/lib/mysql" \
    -v "/$(pwd)/mysql/my.cnf:/etc/my.cnf" \
    -v "/$(pwd)/mysql/mysql-cluster.cnf:/etc/mysql-cluster.cnf" \
    mysql/mysql-cluster:8.0.32 \
    ndb_mgmd --ndb-nodeid=1 --reload --initial

# STEP 4. Create 2 Data Nodes
# Execute the following command to create the first data node:
docker run -d --net=mysql-ndb-cluster \
    --name=db-mysql-ndb-cluster-data-node-1 --ip=172.16.60.12 \
    -v "/$(pwd)/mysql/data-node-1:/var/lib/mysql"  \
    -v "/$(pwd)/mysql/mysql-cluster.cnf:/etc/mysql-cluster.cnf" \
    mysql/mysql-cluster:8.0.32 \
    ndbd --ndb-nodeid=2 --connect-string 172.16.60.11

# Execute the following command to create the second data node:
docker run -d --net=mysql-ndb-cluster \
    --name=db-mysql-ndb-cluster-data-node-2 --ip=172.16.60.13 \
    -v "/$(pwd)/mysql/data-node-2:/var/lib/mysql" \
    -v "/$(pwd)/mysql/mysql-cluster.cnf:/etc/mysql-cluster.cnf" \
    mysql/mysql-cluster:8.0.32 \
    ndbd --ndb-nodeid=3 --connect-string 172.16.60.11

# STEP 5. Create 2 SQL Nodes
# Execute the following command to create the first SQL node:
docker run -d --net=mysql-ndb-cluster \
    --name=db-mysql-ndb-cluster-sql-node-1 --ip=172.16.60.14 \
    -e MYSQL_ROOT_PASSWORD=5trathm0re \
    -v "/$(pwd)/mysql/sql-node-1:/var/lib/mysql"  \
    -v "/$(pwd)/mysql/mysql-cluster.cnf:/etc/mysql-cluster.cnf" \
    mysql/mysql-cluster:8.0.32 \
    mysqld --ndb-nodeid=4 --ndb-connectstring 172.16.60.11

# Execute the following command to create the second SQL node:
docker run -d --net=mysql-ndb-cluster \
    --name=db-mysql-ndb-cluster-sql-node-2 --ip=172.16.60.15 \
    -e MYSQL_ROOT_PASSWORD=5trathm0re \
    -v "/$(pwd)/mysql/sql-node-2:/var/lib/mysql"  \
    -v "/$(pwd)/mysql/mysql-cluster.cnf:/etc/mysql-cluster.cnf" \
    mysql/mysql-cluster:8.0.32 \
    mysqld --ndb-nodeid=5 --ndb-connectstring 172.16.60.11