# instant-subdomain-proxy

Automatic creation of HTTPS subdomain [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) using `nginx` and `certbot`.

## Prerequisite

Debian-based systems as the script uses `apt`.

## Usage

```bash
./create-proxy.sh {subdomain} {service-uri}
```

For example, let say you want to create a reverse proxy of a local service `localhost:8080` to `app1.example.com`:

```bash
./create-proxy.sh app1.example.com localhost:8080
```

## Acknowledgement

Steps inspired from [this Gist](https://gist.github.com/gmolveau/5e5b0bd2773100d85d9302d0fa96632d) written by gmolveau.