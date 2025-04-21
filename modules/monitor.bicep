param resourceName string

// resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
//   name: resourceName
// }

// resource diagSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
//   name: 'diagSettings'
//   scope: storageAccount
//   properties: {
//     logs: [
//       {
//         category: 'StorageLogs'
//         enabled: true
//         retentionPolicy: {
//           enabled: false
//           days: 0
//         }
//       }
//     ]
//     metrics: [
//       {
//         category: 'AllMetrics'
//         enabled: true
//         retentionPolicy: {
//           enabled: false
//           days: 0
//         }
//       }
//     ]
//   }
// }
