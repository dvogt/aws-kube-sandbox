# Build Kubernetes

Build and test the Ubuntu Image locally before repeating the steps in AWS. This is completely optional as you 
* There are two images that need to be built:
   * The Kubernetes Controller
   * The Kubernetes Workers
* Running **vagrant up** will create the download the image and run **ansible** as the provisioner. 
   * This tests that Ansible will run correctly when run in the AWS environment. 
   * If there are ay


