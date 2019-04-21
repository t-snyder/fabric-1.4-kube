echo "Creating channels"
CORE_PEER_ADDRESS=peer0-further:7051 CORE_PEER_LOCALMSPID="further" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp peer channel create -o orderer-service:7050 -c green -f ./channel-artifacts/green.tx
CORE_PEER_ADDRESS=peer0-further:7051 CORE_PEER_LOCALMSPID="further" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp peer channel create -o orderer-service:7050 -c blue  -f ./channel-artifacts/blue.tx

echo "Joining Peers to Green Airline Channel"
CORE_PEER_ADDRESS=peer0-green-airline:7051  CORE_PEER_LOCALMSPID="green-airline"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-airline/users/Admin@green-airline/msp   peer channel join -b green.block
CORE_PEER_ADDRESS=peer0-green-agencies:7051 CORE_PEER_LOCALMSPID="green-agencies" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-agencies/users/Admin@green-agencies/msp peer channel join -b green.block
CORE_PEER_ADDRESS=peer0-further:7051        CORE_PEER_LOCALMSPID="further"        CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp               peer channel join -b green.block

echo "joining Peers to Blue Airline Channel"
CORE_PEER_ADDRESS=peer0-blue-airline:7051  CORE_PEER_LOCALMSPID="blue-airline"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-airline/users/Admin@blue-airline/msp   peer channel join -b blue.block
CORE_PEER_ADDRESS=peer0-blue-agencies:7051 CORE_PEER_LOCALMSPID="blue-agencies" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-agencies/users/Admin@blue-agencies/msp peer channel join -b blue.block
CORE_PEER_ADDRESS=peer0-further:7051       CORE_PEER_LOCALMSPID="further"       CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp             peer channel join -b blue.block

echo "Updating Green Airline Channel for Anchor Peers"
CORE_PEER_ADDRESS=peer0.further:7051        CORE_PEER_LOCALMSPID="further"        CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp               peer channel update -f ./channel-artifacts/further-green-anchor.tx        -c green -o orderer-service:7050
CORE_PEER_ADDRESS=peer0.green-airline:7051  CORE_PEER_LOCALMSPID="green-airline"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-airline/users/Admin@green-airline/msp   peer channel update -f ./channel-artifacts/green-airline-green-anchor.tx  -c green -o orderer-service:7050
CORE_PEER_ADDRESS=peer0.green-agencies:7051 CORE_PEER_LOCALMSPID="green-agencies" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-agencies/users/Admin@green-agencies/msp peer channel update -f ./channel-artifacts/green-agencies-green-anchor.tx -c green -o orderer-service:7050

echo "Updating Blue Airline Channel for Anchor Peers"
CORE_PEER_ADDRESS=peer0.further:7051       CORE_PEER_LOCALMSPID="further"       CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp             peer channel update -f ./channel-artifacts/further-blue-anchor.tx       -c blue -o orderer-service:7050
CORE_PEER_ADDRESS=peer0.blue-airline:7051  CORE_PEER_LOCALMSPID="blue-airline"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-airline/users/Admin@blue-airline/msp   peer channel update -f ./channel-artifacts/blue-airline-blue-anchor.tx  -c blue -o orderer-service:7050
CORE_PEER_ADDRESS=peer0.blue-agencies:7051 CORE_PEER_LOCALMSPID="blue-agencies" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-agencies/users/Admin@blue-agencies/msp peer channel update -f ./channel-artifacts/blue-agencies-blue-anchor.tx -c blue -o orderer-service:7050
