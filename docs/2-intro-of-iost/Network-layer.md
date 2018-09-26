---
id: Network-layer
title: Network layer
sidebar_label: Network layer
---

P2P (Peer-to-Peer) Network, or Peer Network, is a decentralized structure that distributes tasks and workload among peers. In P2P Networks, connected computers are equal to one another, and each node is both a provider and a consumer of resource, service, and contents. In contrast to traditional Client-Server network models, P2P Networks has the advantages of being decentralized, scalable, attack resistant, and private. These advantages ensure the operations of the blockchain system, and are cornerstones of a free, autonomous, and decentralized blockchain.

## Design of IOST Network Layer

We aim to build a fully decentralized network topology, with fast discovery of nodes and speedy whole-net broadcasting of transactions and blocks. At the same time, we hope to limit redundancy within the network, and achieve secured data transmission among the nodes. Through research and testing, we have decided to employ the powerful [libp2p](https://github.com/libp2p/go-libp2p) library as our network layer.

### Node discovery and connectivity

The basic protocol is TCP/IP. To prevent eaves-dropping and unwanted manipulation of data, we secure the data with a TLS layer on top of TCP. To better utilize each and every TCP connection, we adopt stream-multiplexing to send and receive data, dynamically establishing multiple streams between nodes and maximizing the bandwidth.

With nodes, we use [Kademlia](https://en.wikipedia.org/wiki/Kademlia) to maintain their gateway tables. The Kademlia algorithm use the XOR value between the IDs of nodes to calculate the distance inbetween. The nodes are put into buckets based on their distances with other peers. When a node is queried, we only need to find the nearest node within the corresponding bucket. With a definite number of queries, we can guarantee the information be found for the node. Kademlia stands out with its speed and versatility.

### Data transmission

To reduce bandwidth and to speed up data transmission, we serialize all structured data with Protocol Buffer, and compress them with Snappy algorithm. During our tests, this policy reduced the size of the data by over 80%.

Broadcasting will result in redundant data transmission, and thus waste of bandwidth and processing power. Many projects prevent indefinite rebroadcasting of data by limiting the "hops" (or how many times certain data have been rebroadcast). The downside of the policy is, a definite number of rebroadcasting can't guarantee the data reach to the entire network, especially when the network is huge. The way EOS handles the problem is, the network layer logs transactions and blocks of each and every node's neighbors, and decides whether to send data to a certain node or not. This design can reduce redundant transmission to some extent, but is not elegant and adds load to storage.

The way we handle this is adopting a filter algorithm to, well, filter duplicate information. After comparing [Bloom Filter](https://en.wikipedia.org/wiki/Bloom_filter), [Cuckoo Filter](https://brilliant.org/wiki/cuckoo-filter/) and many others, we have decided to go with Bloom. We can achieve duplicate filtering of a million data packets, with only 1.7MB storage and 0.1% false negative. To further reduce redundant data transmission, we have set a special policy for blocks and big transactions: their hash will be broadcast first. The nodes can then use the hash to download missing data.

### LAN penetration

We use [UPnP](https://en.wikipedia.org/wiki/Universal_Plug_and_Play) Protocol to achieve LAN penetration. UPnP is different than other policies, such as [UDP Hole Punching](https://en.wikipedia.org/wiki/UDP_hole_punching) and [STUN](https://en.wikipedia.org/wiki/STUN); it does not require port exposure without publishing the server. That means you can use your home computer to access our network and communicate with other nodes, without having to use a cloud server.

## An Easter Egg

In the P2P network package of our code repository, there is an `/example` directory. We have created an instant messaging app with our network package. Navigate to the directory, and run `go build` to compile the binary `./example`. Now you can chat with others within the network. Have fun!
