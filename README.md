# Azure DevOps

What is DevOps?

A compound of development (Dev) and operations (Ops), DevOps is the union of people, process, and technology to continually provide value to customers.

What does DevOps mean for teams? DevOps enables formerly siloed roles—development, IT operations, quality engineering, and security—to coordinate and collaborate to produce better, more reliable products. By adopting a DevOps culture along with DevOps practices and tools, teams gain the ability to better respond to customer needs, increase confidence in the applications they build, and achieve business goals faster.

Shorter definition I like to use:
DevOps is a way to ensure **continuos, automated, uninterrupted flow of change**

## Components

![AzureDevOps Components](media/azdev-components.png)

## Resources

- [Introduction to DevOps](https://fresenius-my.sharepoint.com/:p:/g/personal/piotr_zaniewski_fmc-ag_com/Eb10-BtKgd1Hn2m8_gzaLVkBVeEOT84sEKfSHE_LFPgTjQ?e=OyOZPW)
- [Azure DevOps Documentation](https://azure.microsoft.com/en-us/overview/what-is-devops/)

## CI/CD

![CI CI Process](http://www.plantuml.com/plantuml/proxy?cache=yes&src=https://raw.githubusercontent.com/ilearnazuretoday/azure-devops/master/media/azure-ci-cd.puml&fmt=png)

## Pipelines as Code

Steps:

- create service connection to allow deployment

![Service Connection Step 1](media/service-connection.png)

![Service Connection Step 2](media/service-connection2.png)

![Service Connection Step 3](media/service-connection3.png)

> Good practice is to narrow permissions scope!

- choose trigger (can be branch, tag, etc)
- make sure to exclude files which you don't want to trigger the pipeline
- choose VM image for build agent
- perform build and deployment steps (specific to what you are deploying)
- check in the yaml file into the repository called `azure-pipelines.yaml`
- trigger a change in your code that satisfies trigger criteria and push changes to remote
- build should trigger automatically
- under the Pipelines -> Pipelines menu, you can observe pipeline logs live

![Pipeline logs](media/pipeline-run.png)

```yaml
trigger:
  branches:
    include:
      - master

  paths:
    exclude:
    # Exclude README.md from triggering content deployments
    - README.md

pool:
  vmImage: "windows-latest"

steps:
- task: DotNetCoreCLI@2
  displayName: 'Build Blazor Project'
  inputs:
    command: build
    projects: '**/*.csproj'

- task: DotNetCoreCLI@2
  displayName: 'Publish'
  inputs:
    command: publish
    arguments: '--configuration Release --output $(Build.ArtifactStagingDirectory)'
    zipAfterPublish: false

- task: PublishBuildArtifacts@1
  displayName: "Upload Artifacts"
  inputs:
    pathtoPublish: '$(Build.ArtifactStagingDirectory)'
    artifactName: 'drop'

- task: AzureFileCopy@3
  displayName: "Copy the bundle to pwa Storage Account"
  inputs:
      SourcePath: "$(Build.ArtifactStagingDirectory)/s/wwwroot"
      azureSubscription: "your-service-connection"
      Destination: "AzureBlob"
      storage: "yourblobstorage"
      ContainerName: "$web"
```

## Exercise

Change something in code in the [PWA Sample App Repo](https://github.com/Piotr1215/pwa-sample) and see pipeline trigger.

- did the page got deployed to ...

> You might need to do <kbd>Ctrl + F5</kbd> to refresh browser cache since this is PWA app

- is there new content in $web container in your storage account?

## Bonus Material

This is not part of the training, but if you are interested in learning more about PWA web technology, check out [5 Options to deploy static web sites](https://itnext.io/5-static-websites-deployment-options-d0aac1570331)
