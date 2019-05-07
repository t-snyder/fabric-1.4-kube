# This script is to be run on the development machine.
# Set the os - this script is being run on linux ubuntu
os_arch=$(echo "$(uname -s)-amd64" | awk '{print tolower($0)}')

# clean up existing paths
rm -rf channel-artifacts
rm -rf crypto-config
mkdir channel-artifacts

# Generate the crypto material for the orderer and organizations defined within crypto-config-dev.yaml
../../bin/cryptogen generate --config=./crypto-config-dev.yaml

# Create the genesis block for the orderer which will have all the orgs MSPs in it.
../../bin/configtxgen -profile LocalDev -outputBlock ./channel-artifacts/genesis.block
# -channelID system

# Create the channel transaction for each channel
../../bin/configtxgen -profile GreenChannel -outputCreateChannelTx ./channel-artifacts/green.tx -channelID green
../../bin/configtxgen -profile BlueChannel  -outputCreateChannelTx ./channel-artifacts/blue.tx  -channelID blue

# Create the anchor peer configurations for each of the Org Peers
../../bin/configtxgen -profile GreenChannel -outputAnchorPeersUpdate ./channel-artifacts/green-airline-green-anchor.tx  -channelID green -asOrg green-airline
../../bin/configtxgen -profile GreenChannel -outputAnchorPeersUpdate ./channel-artifacts/green-agencies-green-anchor.tx -channelID green -asOrg green-agencies
../../bin/configtxgen -profile BlueChannel  -outputAnchorPeersUpdate ./channel-artifacts/blue-airline-blue-anchor.tx    -channelID blue  -asOrg blue-airline
../../bin/configtxgen -profile BlueChannel  -outputAnchorPeersUpdate ./channel-artifacts/blue-agencies-blue-anchor.tx   -channelID blue  -asOrg blue-agencies

../../bin/configtxgen -profile GreenChannel -outputAnchorPeersUpdate ./channel-artifacts/further-green-anchor.tx  -channelID green -asOrg further
../../bin/configtxgen -profile BlueChannel  -outputAnchorPeersUpdate ./channel-artifacts/further-blue-anchor.tx   -channelID blue  -asOrg further

echo "*** Don't forget to refresh your project fabric-gen directory ***"