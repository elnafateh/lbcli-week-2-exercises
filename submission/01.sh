# Create a wallet with the name "btrustwallet".
RESPONSE=$(bitcoin-cli -regtest createwallet "btrustwallet" 2>/dev/null || bitcoin-cli -regtest loadwallet "btrustwallet" 2>/dev/null)

echo "$RESPONSE" | jq -r '.name'
