Based on https://github.com/MohamedElashri/snibox-1 and https://github.com/liamdawson/snibox-sqlite

I made this image to migrate my snibox instance to an ARM based machine.
But snibox is not maintained anymore, use at your own risk. I won't provide any kind of update.

```
services:
    snibox:
        image: benjaminjonard/snibox
        container_name: snibox
        restart: unless-stopped
        volumes:
            - ./volumes/data:/app/db/database
```
