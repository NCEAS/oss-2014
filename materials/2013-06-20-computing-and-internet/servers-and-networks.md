# Computers, Servers, and Networks

## \ 

## Synthesis and Collaboration 

> * Facilitated by computing and networking

## Our goal is to:

> * Provide basic background on computer networking to lay groundwork for later work on collaboration techniques that use the Internet

# Make me a sandwich

![](images/xkcd-149-sandwich.png)

# Basic networking

> * Host computers connect via networking equipment
* Can send messages to each other over communication protocols
* Client: the host *initiating* the request
* Server: the host *responding* to a request

![](images/tcp_ports.jpg)


# Local networks

![](images/client-server-network.png)

> * All messages broadcast on the local network
    - Local hosts only "listen" for data that targets them

# Routed networks

![](images/routers_archs.gif)

> * Mechanism to connect networks together via forwarding data along routing paths


# IP Numbers and Hostnames

> * Hosts are assigned a unique IP number used for all communication and routing
    - 128.111.220.7
* Each IP Address can be used to communicate over various "ports"
    - Allows multiple applications to communicate with a host without mixing up traffic

* IP numbers can be difficult to remember, so also assign hostnames
    - Handled through the global Domain Name System (DNS)
    - Clients first look up a hostname in DNS to find the IP Number
    - isis.nceas.ucsb.edu -> 128.111.220.46
    - Then they open a connection to the IP Number


# Client-Server and the Internet

![](images/client-server.png)

# Peer to Peer networking

![](images/p2p-network.png)


# The Internet

## Global network of networks using the Internet Protocol to communicate

![](images/internet-1024x1024.png
     "http://r1.3crowd.com/blyon/opte/maps/static/1105841711.LGL.2D.1024x1024.png")


# Internet versus the Web

## What is the difference?

* Internet: Global communication network using the Internet Protocol (IP)
    - Supports many application protocols, including HTTP

* Web: Global system of interlinked hypertext documents
    - Transported over HTTP application protocol (over IP)
    - Generally accessed using web browsers that retrieve the documents

# Routing on the internet

![](images/internet-core.jpg)

> * 80 routers at the core
* dense "mantle" of routers at the periphery
    - loss of the core still leaves > 70% of internet connected peer-to-peer
    - see http://www.technologyreview.com/news/408104/mapping-the-internet/

# Internet Application Protocols

> * Web (http)
* Email (smtp)
* Secure Shell (ssh)
* Telnet (telnet)
* File Transfer Protocol (ftp)
* Network News (nntp)
* ...

# The Web

> * Global network of documents hosted on web servers around the world
* Web documents connected using hyperlinked HTML documents
* Other document types common (images, other media)

![](images/img_HTTP_request.png)

# Secure Shell

> * Used for connecting to and running shell commands on a remote host
* Tremendously simplifies remote computing
* Supported out-of-the-box on Linux and Macs

## We will use this later today:

> * ssh isis.nceas.ucsb.edu



