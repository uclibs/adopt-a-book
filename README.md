# Adopt a book
This application will be used for the 2021 Adopt-A-Book event

## Docker
* The Docker containers for Adopt a Book currently only work in development mode with a SQLite Database.
* The SQLite Database file itself is shared using a Docker Volume from host to container.
    * So, we must run `bundle exec rails db:migrate` on the host before running starting the services using `docker-compose up` 

### Using Docker Compose
* To build and start the containerized application, run the below command, from the root directory of the repo:
```bash
docker-compose up -d --build
```
* If you want to use pre-built images, if any, run the below command:
```bash
docker-compose up -d
```
* List running Docker containers started by the `docker-compose.yml`:
```bash
docker-compose ps
```
* Inspect logs from the containers:
```bash
docker-compose logs
```
* To follow logs from the containers:
```bash
docker-compose logs -f
```  
* Run a command on the Rails App container:
```bash
docker-compose exec -u rails -T webapp <command>
```
* To run a shell in Rails App and attach to it:
```bash
docker-compose exec -u rails webapp sh
```
* To shutdown the containers started by the `docker-compose up -d` command, but keeping all the volumes(one of them containing the SQLite Database) intact, run:
```bash
docker-compose down
```
* To shutdown and delete Docker volumes and networks
```bash
docker-compose down -v
```
* To shutdown and delete everything from local pre-built images, networks to volumes:
```bash
docker-compose down --rmi all --remove-orphans -v 
```