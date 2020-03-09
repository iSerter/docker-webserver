# WebServer Bundle
- Nginx 
- PHP 
- Node 12 LTS, +yarn 
- supervisor
- git
- aws-cli
- composer
- deployer (dep)

### Webserver Root
`/var/www/project/current/public` because I use deployer to release my apps, and it creates a symlink to `current` after working in the `project` directory.

## Pull
```
docker pull iserter/webserver
```

or

### Build & Tag
```$xslt
docker build -t iserter-webserver .
```
```$xslt
docker tag iserter-webserver iserter/webserver
```