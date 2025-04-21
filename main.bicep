param location string = 'centralindia'
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

module vnet1 'modules/vnet.bicep' = {
  name: 'vnet1Deployment'
  params: {
    name: 'vnet1'
    location: location
    addressPrefix: '10.0.0.0/16'
    infraSubnetPrefix: '10.0.1.0/24'
    storageSubnetPrefix: '10.0.2.0/24'
  }
}

module vnet2 'modules/vnet.bicep' = {
  name: 'vnet2Deployment'
  params: {
    name: 'vnet2'
    location: location
    addressPrefix: '10.1.0.0/16'
    infraSubnetPrefix: '10.1.1.0/24'
    storageSubnetPrefix: '10.1.2.0/24'
  }
}

resource peer1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: 'vnet1/peer1to2'
  properties: {
    remoteVirtualNetwork: {
      id: vnet2.outputs.vnetResourceId
    }
    allowVirtualNetworkAccess: true
  }
}

resource peer2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: 'vnet2/peer2to1'
  properties: {
    remoteVirtualNetwork: {
      id: vnet1.outputs.vnetResourceId
    }
    allowVirtualNetworkAccess: true
  }
}

module vm1 'modules/vm.bicep' = {
  name: 'vm1Deployment'
  params: {
    name: 'vm1'
    location: location
    subnetId: vnet1.outputs.infraSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module vm2 'modules/vm.bicep' = {
  name: 'vm2Deployment'
  params: {
    name: 'vm2'
    location: location
    subnetId: vnet2.outputs.infraSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module storage1 'modules/storage.bicep' = {
  name: 'storage1Deployment'
  params: {
    name: 'storvnet1'
    location: location
  }
}

module storage2 'modules/storage.bicep' = {
  name: 'storage2Deployment'
  params: {
    name: 'storvnet2'
    location: location
  }
}

module monitor1 'modules/monitor.bicep' = {
  name: 'monitor1'
  params: {
    resourceName: 'storvnet1'
  }
}

module monitor2 'modules/monitor.bicep' = {
  name: 'monitor2'
  params: {
    resourceName: 'storvnet2'
  }
}

