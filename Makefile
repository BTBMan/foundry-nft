-include .env

MAIN_CONTRACT := script/OurToken.s.sol:OurTokenScript
NETWORK_ARGS :=

ifeq ($(findstring local,$(network)),local)
	NETWORK_ARGS := --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -vvvv
endif

ifeq ($(findstring sepolia,$(network)),sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(REAL_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

build:; forge build

deploy:; @forge script $(MAIN_CONTRACT) $(NETWORK_ARGS)
