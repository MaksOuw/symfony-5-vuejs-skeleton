# Symfony 5 / VueJS docker skeleton

Dockerized Symfony 5 application stack with VueJS integrated

## Technical stack

- Symfony 5
- VueJS
- MySQL 5.7
- Adminer

## Pre-requisites

- docker >= 19.03.8
- docker-compose >= 1.25.4
- GNU make

## Project setup
### Initialization
```
make init
make build
```

### Start application
```
make up
```

### Build / rebuild assets
```
make webpack-dev
```

### Build assets for prod
```
make webpack
```

### Stop application
```
make down
```

Application URL : http://localhost:90  
Adminer : http://localhost:91 [root / root]

Edit `.env` file to change ports and MySQL root password

## Project tree
`app` : Symfony 5  
`app/assets/js` : VueJS  
`docker` : Docker  
`docker/vhosts` : Application vhosts  
`makefiles` : Makefiles / helpers (included in `Makefile`)  
`var/` : MySQL container files  
