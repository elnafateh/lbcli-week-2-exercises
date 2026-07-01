# Create a transaction whose fee can be later updated to a higher fee if it is stuck or doesn't get mined on time

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
 raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

# 1. Parse parent transaction ID
PARENT_TXID=$(bitcoin-cli -regtest decoderawtransaction "$raw_tx" | jq -r '.txid')

# 2. Add both inputs and apply BIP-125 RBF sequencing (0xfffffffe) to them
INPUTS="[
  {\"txid\":\"$PARENT_TXID\",\"vout\":0,\"sequence\":4294967294},
  {\"txid\":\"$PARENT_TXID\",\"vout\":1,\"sequence\":4294967294}
]"

# 3. Define the destination output (20,000,000 satoshis = 0.20 BTC)
OUTPUTS="{\"2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP\":0.20}"

# 4. Create the raw transaction with RBF parameters
NEW_RAW_TX=$(bitcoin-cli -regtest createrawtransaction "$INPUTS" "$OUTPUTS")

# 5. Output only the transaction hex string
echo -n "$NEW_RAW_TX"
