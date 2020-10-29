echo "Enroll orderer5"

# orderer 2
# preparation
mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/ca 
cp ${PWD}/crypto-config/ordererOrganizations/example.com/ca/admin/msp/cacerts/0-0-0-0-7053.pem ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/ca/org0-ca-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/tls-ca 
cp ${PWD}/crypto-config/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/example.com/orderer5
export FABRIC_CA_CLIENT_TLS_CERTFILES=${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/ca/org0-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer5.example.com:orderer5pw@0.0.0.0:7053
sleep 5

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer5.example.com:orderer5PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer5.example.com --csr.hosts localhost
sleep 5

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/tls-msp/keystore/*_sk ${PWD}/crypto-config/ordererOrganizations/example.com/orderer5/tls-msp/keystore/key.pem
# sleep 10

# orderer 2 done