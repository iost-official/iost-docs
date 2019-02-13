---
id: version-3.0.0-LocalServer
title: Launch Local Server
sidebar_label: Launch Local Server
original_id: LocalServer
---
There are two methods to launch local server: using docker or natively.

## Launch IOST Server Using Docker
Launching IOST server using docker is simple. It is the recommended way.    
The following command will launch a single-node native IOST blockchain server.   
You can use it for debugging and testing.   
[Docker CE 18.06 or newer](https://docs.docker.com/install) is needed(older versions are not tested).

```
docker run -it --rm -p 30000-30003:30000-30003 iostio/iost-node
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

## Launch IOST Server Natively

After finishing [building IOST](4-running-iost-node/Building-IOST.md), you can run the server.
```
iserver -f ./config/iserver.yml
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

