This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/zeit/next.js/tree/canary/packages/create-next-app).


# KEZAYYA-123 : Decentralized File storage and sharing platform
![Recyclant](https://bafkreievjsq4glmoz4lzvwob6yfsaifpbufsnj47oz47ml4oa6dh4enhbi.ipfs.nftstorage.link/)

## Introduction
Kezayya-123 is a web3 project with the aim of helping users store files and share them in a user-friendly manner. Decentralized file storage and sharing system. This project intends to build a web3 version of google drive or dropbox for file storage and sharing. It uses the open zeppelin ERC721 standard to store file metadata ERI in an EVM-based smart contract. The smart contract is deployed on Polygon Mumbai. Polygon which is an Ethereum scaling and POS Blockchain was the best choice for deployment to reduce the cost of transactions and interaction with the blockchain.
 

## Web 3.0 technologies Used

Frontend: NextJS, postcss, tailwindcss, Theme
web3 technologies: IPFS/filecoin, Metamask wallet, Unstoppable domain, Moralis, Tableland, Valist, XMTP, ChainLink
Backend: Solidity, Node.js

Blockchain deployed to:  BitTorrent Chain (BTTC)

## Description
This project was made using several technologies. The front-end was designed using a server-side-rendering javascript tech known as NextJS. the latest version of Next was used because of how fast it was to build the project.  IPFS / Filecoin's NFT.Storage was used to store user's file on their decentralized storage. Files can be stored individually and as a folder. When Files are stored on IPFS through NFT.Storage, It is retrieved and rendered on users dashboard whenever they are logged in. They can share these files to anyone through a sharing mechansism that is easy to copy out the sharing IPFS URL.
Tableland saved user's details
Valist houses the code repository
 Fluence was also employ for P2P File Sharing through their browser ro browser Peer to peer communication technique. The whole world of Fluence was engaing as one browsed through several other case studies. Hope to implemnnbt more of fluence on future projects.
 XMTP is used for wallet to wallet messaging using the XMTP SDK

The smart contract uses ERC-721 specification to hold metadata URI, ethers.js was used to interact with the smart contract. The contract was deployed to BTTC blockchain. The project versioning was done with Vialist. The entire project demo was hosted to Vercel. 

## Live DApp hosted on

Live Dapp on Vercel: - https://kezayya123.vercel.app/

Deployed to BTTC Chain: 
  export const fileShareAddress = "0xe078fe7a93017f8e18c1c52e79632d0b94c56c26"

  http://testscan.bt.io/#/contract/0xe078fe7a93017f8e18c1c52e79632d0b94c56c26

  http://testscan.bt.io/#/contract/0xebb3113e97eeaa16dcc2febd6a1617ab731066ae

  Valist: https://app.valist.io/holyaustin/kezayya123
 
 Youtube video link: https://youtu.be/kZvxCGMPci8

## Getting Started

First, run the development server:


```
clone the repo https://github.com/holyaustin/kezayya123.git
# next is to 
npm install
# then
npm run dev
# or
yarn dev
```

Open [http://localhost:3016](http://localhost:3016) with your browser to see the result.

You can start editing the page by modifying `pages/index.js`. The page auto-updates as you edit the file.

## Connect with me and send me a mail

E-mail - holyaustin@yahoo.com

stay connected on twitter @holyaustin
