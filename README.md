# bitcoin_app


## Install

Download and install [Bitcoin Core](http://bitcoin.org/en/download) client.

## Configure Test network

1. Find the Bitcoin Core data directory for your system.
2. Create this directory if it doesn't exist yet (should be there from when you ran the client before). On Mac OS X for example: `mkdir ~/Library/Application\ Support/Bitcoin/`
3. Create a bitcoin.conf configuration file in that directory. A minimal example might look like:

```
testnet=1
server=1
rpcuser=Ulysseys
rpcpassword=YourPassword
rpctimeout=30
rpcport=8332
```
## Run Test network
Start Bitcoin Core client.

# Run Rails application
