Jenkins in Docker (Arm64)

This repository contains the Dockerfile and related configuration files for setting up Jenkins CI/CD server in a Docker container on Arm64 architecture.

Requirements
Docker
Docker Compose
Usage
Clone the repository to your local machine:
shell
Copy code
$ git clone https://github.com/m-minasyan/jenkins-in-docker-arm64.git

Navigate to the repository directory:
shell
Copy code
$ cd jenkins-in-docker-arm64

Build the Docker image:
ruby
Copy code
$ docker-compose build

Start the container:
ruby
Copy code
$ docker-compose up -d

Access the Jenkins web interface at http://localhost:8080 in your web browser.
Configuration

The Jenkins configuration files are stored in the jenkins_home volume, which is defined in the docker-compose.yml file.

Updating

To update to the latest version of Jenkins, simply rebuild the Docker image:

ruby
Copy code
$ docker-compose build

Troubleshooting

If you encounter any issues with the setup, refer to the Jenkins and Docker documentation for troubleshooting guidance.
