@minLength(3)
@maxLength(11)
param namePrefix string

param location string = resourceGroup().location


// Cuando ya hagas el deploy de tu app recuerda cambiar el targetPort a: 3000

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: '${namePrefix}containerapp'
  location: location
  properties: {
    managedEnvironmentId: conatinerAppEnvironment.id
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        allowInsecure: false
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
      registries: [
        {
          server: containerRegistry.properties.loginServer
          username: containerRegistry.listCredentials().username
          passwordSecretRef: 'container-registry-password'
        }
      ]
      secrets: [
        {
          name: 'container-registry-password'
          value: containerRegistry.listCredentials().passwords[0].value
        }
        {
          name: 'cosmosdb-connection-string'
          value: cosmos.listConnectionStrings().connectionStrings[0].connectionString
        }
      ]
    }
    template: {
      containers: [
        {
          name: '${namePrefix}containerapp'
          image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
          env: [
            {
              name: 'MONGODB_URI'
              secretRef: 'cosmosdb-connection-string'
            }
          ]
          resources: {
            cpu: json('0.5') 
            memory: '1.0Gi'
          }
        }
      ]
    }  
  }
}
