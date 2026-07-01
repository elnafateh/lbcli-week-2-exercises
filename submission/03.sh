# Create a SegWit address.
# Add funds to the address.
# Return only the Address
ADDR=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "funding" "bech32")

# 2. Mine 101 blocks to that address to bypass the coinbase maturity rule
bitcoin-cli -regtest generatetoaddress 101 "$ADDR" > /dev/null
